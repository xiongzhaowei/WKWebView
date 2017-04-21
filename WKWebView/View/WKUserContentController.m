//
//  WKUserContentController.m
//  QihooBrowser
//
//  Created by 熊朝伟 on 2016/12/21.
//
//

#import "WKUserContentController.h"
#import "WKWebView.h"

@interface NAME(WKUserContentScriptMessageHandler) : NSObject<WKScriptMessageHandler>
@end

@implementation NAME(WKUserContentScriptMessageHandler)
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.webView isKindOfClass:[NAME(WKWebView) class]]) {
        NAME(WKWebView) *webView = (NAME(WKWebView) *)message.webView;
        [webView.scriptMessageHandler userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end

@interface NAME(WKUserContentController) () {
    id<WKScriptMessageHandler> _scriptMessageHandler;
}
@end

@implementation NAME(WKUserContentController)

- (void)addUserScriptWithSource:(NSString *)source injectionTime:(WKUserScriptInjectionTime)injectionTime {
    [self addUserScript:[[WKUserScript alloc] initWithSource:source injectionTime:injectionTime forMainFrameOnly:YES]];
}

- (void)addScriptMessageHandlerWithName:(NSString *)name {
    if (!_scriptMessageHandler) {
        _scriptMessageHandler = [[NAME(WKUserContentScriptMessageHandler) alloc] init];
    }
    [super addScriptMessageHandler:_scriptMessageHandler name:name];
}

@end
