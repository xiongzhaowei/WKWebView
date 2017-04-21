//
//  WKWebViewScriptBridge.m
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/3.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "WKWebViewScriptBridge.h"
#import "WKWebViewScriptBridge+Javascript.h"
#import "WKWebView.h"
#import "NSSafeAddition.h"

@interface NAME(WKWebView) ()

- (void)webView:(NAME(WKWebView) *)webView
   scriptBridge:(NAME(WKWebViewScriptBridge) *)scriptBridge
         method:(NSString *)method
     parameters:(id)parameters
     completion:(void(^)(id result))completion;

@end

@implementation NAME(WKWebViewScriptBridge)

- (instancetype)initWithName:(NSString *)name userContentController:(WKUserContentController *)userContentController {
    if ((self = [super init])) {
        _name = name;
        [self initialize:userContentController];
    }
    return self;
}

- (void)initialize:(WKUserContentController *)userContentController {
    WKUserScriptInjectionTime times[] = {
        WKUserScriptInjectionTimeAtDocumentStart,
        WKUserScriptInjectionTimeAtDocumentEnd
    };
    for (int i = 0, count = sizeof(times)/sizeof(times[0]); i < count; ++i) {
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:[self javascript:times[i]] injectionTime:times[i] forMainFrameOnly:YES];
        [userContentController addUserScript:userScript];
    }
    [userContentController addScriptMessageHandler:self name:self.name];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:self.name]) {
        NAME(WKWebView) *webView = (NAME(WKWebView) *)message.webView;
        if (![webView isKindOfClass:[NAME(WKWebView) class]]) {
            return;
        }
        NSDictionary *data = [message.body safeDictionaryValue];
        if (!data) {
            return;
        }
        NSString *method = [[data safeObjectForKey:@"method"] safeStringValue];
        NSString *responseId = [[data safeObjectForKey:@"responseId"] safeStringValue];
        id params = [data safeObjectForKey:@"params"];
        void(^completion)(id result);
        if (responseId && responseId.length) {
            completion = ^(id result) {
                NSString *script = [NSString stringWithFormat:@"window.%@.dispatchHandlerResponse(%@)", self.name, [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@{ @"responseId": responseId, @"responseData": result } options:0 error:nil] encoding:NSUTF8StringEncoding]];
                [webView evaluateJavaScript:script completionHandler:nil];
            };
        } else {
            completion = ^(id result) {};
        }
        [webView webView:webView scriptBridge:self method:method parameters:params completion:completion];
    }
}

@end

@implementation NAME(WKUserContentController) (WKWebViewScriptBridge)

- (NAME(WKWebViewScriptBridge) *)addScriptBridgeWithName:(NSString *)name {
    return [[NAME(WKWebViewScriptBridge) alloc] initWithName:name userContentController:self];
}

@end
