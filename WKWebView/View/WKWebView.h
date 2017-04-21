//
//  WKWebView.h
//  QihooBrowser
//
//  Created by 熊朝伟 on 2016/12/21.
//
//

#import "WKWebViewConfiguration.h"
#import "WKWebViewScriptBridge.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NAME(WKScriptMessageHandler) <WKScriptMessageHandler>
@optional
- (NSString *)webView:(__kindof WKWebView *)webView
           javascript:(WKUserScriptInjectionTime)injectionTime
     scriptBridgeName:(NSString *)scriptBridgeName;
@end

@interface NAME(WKWebView) : WKWebView

@property (nonatomic, readonly, copy) NAME(WKWebViewConfiguration) *configuration;
@property (nonatomic, readonly, copy) NSString *scriptBridgeName;
@property (nonatomic, weak) __kindof id<NAME(WKScriptMessageHandler)> scriptMessageHandler;

+ (NAME(WKWebViewConfiguration) *)configuration;
- (void)initialize;
- (nullable WKNavigation *)loadFailedHTMLString:(NSString *)string unreachableURL:(nullable NSURL *)unreachableURL;

- (void)callHandler:(NSString *)name parameters:(id)parameters completion:(nullable void(^)(id responseObject))completion;

// 注册javascript接口
- (void)addScriptBridgeHandler:(NAME(WKWebViewScriptBridgeHandler))handler name:(NSString *)name;
- (void)removeScriptBridgeHandlerWithName:(NSString *)name;

// 直接生成javascript函数，函数形参不能为function，需刷新页面后生效
// 示例：[webView addJavascriptFunctionWithName:@"window.console.log" handler:handler];
// <script>window.console.log();</script>
// <script>window.console.log('hello world!');</script>
// <script>window.console.log(true, 123/* 形参列表 */, function(result) {/* 处理返回值 */});</script>
- (void)addJavascriptFunctionWithName:(NSString *)name handler:(NAME(WKWebViewScriptBridgeHandler))handler;
- (void)removeJavascriptFunctionWithName:(NSString *)name;

// 通知，需要在ViewController中实现navigationDelegate并转发给webView，否则webView会工作不正常
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;

@end

NS_ASSUME_NONNULL_END
