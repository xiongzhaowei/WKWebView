//
//  WKWebView.m
//  QihooBrowser
//
//  Created by 熊朝伟 on 2016/12/21.
//
//

#import "WKWebView.h"
#import "NSSafeAddition.h"

@interface NAME(WKWebView) () {
    uint64_t _uniqueId;
    NSMutableDictionary<NSString *, NAME(WKWebViewScriptBridgeHandler)> *_handlers;
    NSMutableDictionary<NSString *, void(^)(id result)> *_responseCallbacks;
    NSMutableSet<NSString *> *_functions;
    WKNavigationType _navigationType;
    NSMutableDictionary *_localPageInfo; // 需要从本地告诉网页的信息
    NSDictionary *_webViewPageInfo; // 从网页读取的信息
    BOOL _cacheData; // 是否是内存缓存页面，即页面加载时未执行初始化代码，直接继承上次访问的数据。
}
@end

@implementation NAME(WKWebView)

@dynamic configuration;

+ (NAME(WKWebViewConfiguration) *)configuration {
    return [[NAME(WKWebViewConfiguration) alloc] init];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if ((self = [super initWithCoder:coder])) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame configuration:[[self class] configuration]])) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    if ((self = [super initWithFrame:frame configuration:configuration])) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.navigationDelegate = nil;
    _handlers = [[NSMutableDictionary alloc] init];
    _functions = [[NSMutableSet alloc] init];
    _localPageInfo = [[NSMutableDictionary alloc] init];

    // 返回值处理函数
    [self addPrivateScriptBridgeHandler:^(NAME(WKWebView) *webView, NAME(WKWebViewScriptBridge) *scriptBridge, NSString *name, id data, void(^completion)(id result)){
        NSDictionary *params = [data safeDictionaryValue];
        NSString *responseId = [[params safeObjectForKey:@"responseId"] safeStringValue];
        id result = [params safeObjectForKey:@"result"];
        
        completion = [webView->_responseCallbacks safeObjectForKey:responseId];
        [webView->_responseCallbacks removeObjectForKey:responseId];
        if (completion) {
            completion(result);
        }
    } name:@"result"];
    
    // 页面初始化事件。
    [self addPrivateScriptBridgeHandler:^(NAME(WKWebView) *webView, NAME(WKWebViewScriptBridge) *scriptBridge, NSString *name, id data, void(^completion)(id result)){
        NSDictionary *params = [data safeDictionaryValue];
        BOOL state = [[params safeObjectForKey:@"state"] safeBoolValue];
        WKUserScriptInjectionTime injectionTime;
        if (!state) {
            // 移除所有尚未释放的handler，防止内存泄露蔓延至其它页面。
            [webView->_responseCallbacks removeAllObjects];
            // 标记页面为新初始化的页面，而不是前进后退导致的残留页面。
            webView->_cacheData = NO;
            injectionTime = WKUserScriptInjectionTimeAtDocumentStart;
        } else {
            injectionTime = WKUserScriptInjectionTimeAtDocumentEnd;
        }
        // 执行初始化脚本
        completion([webView javascript:injectionTime scriptBridgeName:scriptBridge.name]);
    } name:@"start"];
    
    // 页面刷新
    [self addPrivateScriptFunctionWithName:@"error.reload" handler:^(NAME(WKWebView) *webView, NAME(WKWebViewScriptBridge) *scriptBridge, NSString *name, id data, void (^completion)(id result)) {
        [webView reload];
    }];
    
    // 页面返回
    [self addPrivateScriptFunctionWithName:@"error.back" handler:^(NAME(WKWebView) *webView, NAME(WKWebViewScriptBridge) *scriptBridge, NSString *name, id data, void (^completion)(id result)) {
        [webView goBack];
    }];
}

- (void)callHandler:(NSString *)name parameters:(id)parameters completion:(void(^)(id responseObject))completion {
    name = [name stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    name = [name stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    name = [name stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
    name = [name stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    name = [name stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    name = [name stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    name = [name stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    name = [name stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    
    NSString *callbackId = nil;
    if (completion) {
        callbackId = [NSString stringWithFormat:@"objc_cb_%llu", ++_uniqueId];
        _responseCallbacks[callbackId] = [completion copy];
    }
    NSString *script = [NSString stringWithFormat:@"window.webkit.%@.callScriptHandler('%@', %@, '%@')", self.scriptBridgeName, name, [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil] encoding:NSUTF8StringEncoding], callbackId ?: @""];
    
    [self evaluateJavaScript:script completionHandler:nil];
}

- (WKNavigation *)loadFailedHTMLString:(NSString *)string unreachableURL:(NSURL *)unreachableURL {
    if (_navigationType != WKNavigationTypeBackForward) {
        [_localPageInfo setObject:@YES forKey:@"isNotInBackForwardList"];
    }
    if (unreachableURL) {
        [_localPageInfo setObject:[unreachableURL absoluteString] forKey:@"unreachableURL"];
    }
    return [super loadHTMLString:string baseURL:self.URL];
}

- (NSString *)scriptBridgeName {
    return [self.configuration.scriptBridgeName copy];
}

- (BOOL)isNotInBackForwardList {
    return [[_webViewPageInfo safeObjectForKey:@"isNotInBackForwardList"] safeBoolValue];
}

- (BOOL)canGoBack {
    if (self.isNotInBackForwardList) {
        return self.backForwardList.currentItem != nil;
    }
    return [super canGoBack];
}

- (WKNavigation *)goBack {
    if (self.isNotInBackForwardList && self.backForwardList.currentItem) {
        return [super goToBackForwardListItem:self.backForwardList.currentItem];
    } else {
        return [super goBack];
    }
}

- (WKNavigation *)reload {
    NSString *unreachableURL = [_webViewPageInfo safeObjectForKey:@"unreachableURL"];
    if (unreachableURL && [unreachableURL isKindOfClass:[NSString class]]) {
        NSURL *URL = [NSURL URLWithString:unreachableURL];
        if (URL) {
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
            [request setValue:[self.URL absoluteString] forHTTPHeaderField:@"Referer"];
            return [self loadRequest:request];
        }
    }
    return [super reload];
}

- (NSString *)javascript:(WKUserScriptInjectionTime)injectionTime
        scriptBridgeName:(NSString *)scriptBridgeName {
    NSMutableString *script = [[NSMutableString alloc] initWithString:@"(function(){"];
    if (WKUserScriptInjectionTimeAtDocumentStart == injectionTime) {
        for (NSString *name in _functions) {
            [script appendFormat:@"window.%@.createNamespace('%@'); %@ = function() {var args = [], callback = null;for (var i = 0; i < arguments.length; i++) {var value = arguments[i];if (typeof value == 'function') {callback = value;break;} else {args.push(value);}}window.%@.callHandler('%@', args, callback);};", scriptBridgeName, name, name, scriptBridgeName, name];
        }
    }
    if ([self.scriptMessageHandler respondsToSelector:@selector(webView:javascript:scriptBridgeName:)]) {
        NSString *javascript = [self.scriptMessageHandler webView:self javascript:injectionTime scriptBridgeName:scriptBridgeName];
        if (javascript) {
            [script appendString:javascript];
        }
    }
    [script appendString:@"})();"];
    return [NSString stringWithString:script];
}

- (void)adblockWithSelectors:(NSArray *)selectors completion:(void(^)(NSUInteger))completion {
    if (selectors && [selectors count] > 0) {
        NSString *script = [NSString stringWithFormat:@"(function(s){function q(s){try{var e=document.querySelectorAll(s);for(var i=0,c=e.length;i<c;++i){e[i].style.setProperty('display','none','important');}return c;}catch(e){return 0;}};var r=0;for(var i=0,c=s.length;i<c;++i){if(q(s[i])){++r;}}return r;})(%@);", [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:selectors options:0 error:nil] encoding:NSUTF8StringEncoding]];
        [self evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
            if (!completion) {
                return;
            }
            if ([result isKindOfClass:[NSNumber class]]) {
                completion([result unsignedIntegerValue]);
            }
        }];
    }
}

- (void)addJavascriptFunctionWithName:(NSString *)name handler:(NAME(WKWebViewScriptBridgeHandler))handler {
    // 直接添加javascript函数而无需在html端写js代码。
    [self addScriptBridgeHandler:handler name:name];
    [_functions addObject:name];
}

- (void)removeJavascriptFunctionWithName:(NSString *)name {
    [self removeScriptBridgeHandlerWithName:name];
    [_functions removeObject:name];
}

- (void)addPrivateScriptFunctionWithName:(NSString *)name handler:(NAME(WKWebViewScriptBridgeHandler))handler {
    // 私有方法在前面加上前缀，防止和用户注册方法重名。
    NSString *handlerName = [NSString stringWithFormat:@"window.%@.%@", self.scriptBridgeName, name];
    [self addJavascriptFunctionWithName:handlerName handler:handler];
}

- (void)addPrivateScriptBridgeHandler:(NAME(WKWebViewScriptBridgeHandler))handler name:(NSString *)name {
    // 私有方法在前面加上前缀，防止和用户注册方法重名。
    NSString *handlerName = [NSString stringWithFormat:@"%@.%@", self.scriptBridgeName, name];
    [_handlers setObject:handler forKey:handlerName];
}

- (void)addScriptBridgeHandler:(NAME(WKWebViewScriptBridgeHandler))handler name:(NSString *)name {
    [_handlers setObject:handler forKey:name];
}

- (void)removeScriptBridgeHandlerWithName:(NSString *)name {
    [_handlers removeObjectForKey:name];
}

- (void)webView:(NAME(WKWebView) *)webView
   scriptBridge:(NAME(WKWebViewScriptBridge) *)scriptBridge
         method:(NSString *)method
     parameters:(id)parameters
     completion:(void(^)(id result))completion {
    NAME(WKWebViewScriptBridgeHandler) handler = [_handlers safeObjectForKey:method];
    if (handler) {
        handler(webView, scriptBridge, method, parameters, completion);
    }
}

#pragma mark - WKNavigationDelegate
// id<WKNavigationDelegate>的实现，注意以下方法并不会自动调用，需要在ViewController中手动调用。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    _cacheData = YES;
    _navigationType = navigationAction.navigationType;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    if ([_localPageInfo count]) {
        NSString *json = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:_localPageInfo options:0 error:nil] encoding:NSUTF8StringEncoding];
        _webViewPageInfo = [_localPageInfo copy];
        [_localPageInfo removeAllObjects];
        [self evaluateJavaScript:[NSString stringWithFormat:@"window.%@.pageInfo = %@;", self.scriptBridgeName, json] completionHandler:nil];
    } else {
        NSString *script = [NSString stringWithFormat:@"window.%@.pageInfo", self.scriptBridgeName];
        [self evaluateJavaScript:script completionHandler:^(id result, NSError *error) {
            _webViewPageInfo = [result safeDictionaryValue];
            if (_cacheData && self.isNotInBackForwardList && self.backForwardList.currentItem) {
                [super goToBackForwardListItem:self.backForwardList.currentItem];
            }
        }];
    }
}

@end
