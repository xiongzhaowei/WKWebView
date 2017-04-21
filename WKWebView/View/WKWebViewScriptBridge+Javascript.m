//
//  WKWebViewScriptBridge+Javascript.m
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/3.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "WKWebViewScriptBridge+Javascript.h"

@implementation NAME(WKWebViewScriptBridge) (Javascript)

- (NSString *)javascript:(WKUserScriptInjectionTime)injectionTime {
#define JAVASCRIPT_TEXT(script) #script
    static NSString *scriptForBegan = @JAVASCRIPT_TEXT((function() {
        if (window.${BRIDGE}) {
            return;
        }
        window.${BRIDGE} = {
            handlers: {},
            callHandler: callNativeHandler,
            callScriptHandler: callScriptHandler,
            dispatchHandlerResponse: dispatchHandlerResponse,
            getHTMLElementAtPoint: Qihoo_GetHTMLElementAtPoint,
            createNamespace: createNamespace
        };
        var responseCallbacks = {};
        var uniqueId = 1;
        
        function callNativeHandler(handlerName, data, responseCallback) {
            if (arguments.length == 2 && typeof data == 'function') {
                responseCallback = data;
                data = null;
            }
            var message = { method: handlerName, params: data };
            if (responseCallback) {
                var callbackId = 'cb_'+(uniqueId++)+'_'+new Date().getTime();
                responseCallbacks[callbackId] = responseCallback;
                message['responseId'] = callbackId;
            }
            window.webkit.messageHandlers.${BRIDGE}.postMessage(message);
        }
        
        function callScriptHandler(handlerName, data, responseId) {
            if (arguments.length == 2 && typeof data == 'function') {
                responseCallback = data;
                data = null;
            }
            var handler = window.${BRIDGE}.handlers[handlerName];
            if (typeof handler == 'function') {
                handler(data, function(result) {
                    if (typeof responseId == 'string') {
                        window.webkit.messageHandlers.${BRIDGE}.postMessage({
                            method: '${BRIDGE}.result',
                            params: { result: result, responseId: responseId }
                        }); // 从Objective-C调用的。
                    } else if (typeof responseId == 'function') {
                        responseId(result); // 从javascript调用的。
                    }
                });
            }
        }
        
        function dispatchHandlerResponse(message) {
            responseCallback = responseCallbacks[message.responseId];
            if (!responseCallback) {
                return;
            }
            responseCallback(message.responseData);
            delete responseCallbacks[message.responseId];
        }
        
        function createNamespace(name){
            var names = name.split('.');
            var namespace;
            for (var i = 0, count = names.length - 1; i < count; i++) {
                if (i == 0) {
                    namespace = names[0];
                } else {
                    namespace += '.' + names[i];
                }
                if (typeof window.eval(namespace) == 'undefined') {
                    window.eval(namespace + '={}');
                }
            }
        }
        
        function Qihoo_GetHTMLElementAtPoint(x,y) {
            var e = document.elementFromPoint(x,y);
            var tagName = e.tagName;
            var src = e.src;
            while (e) {
                if (e.tagName) {
                    if((e.tagName == "BODY") || (e.tagName == "body") || (e.tagName == "HTML") || (e.tagName == "html")) {
                        return {tagName: tagName, src: src};
                    } else if((e.tagName == "A") || (e.tagName == "a")) {
                        var href = e.href;
                        var text = e.text;
                        var str = "newtab:";
                        if (href.indexOf(str) == 0) {
                            href = unescape(href.substring(str.length));
                        }
                        return {text: text, href: href, tagName: tagName, src: src};
                    }
                    e = e.parentNode;
                } else {
                    break;
                }
            }
            return {tagName: tagName, src: src};
        }
        
        callNativeHandler('${BRIDGE}.start', { state: false }, window.eval);
    })(););
    static NSString *scriptForEnded = @JAVASCRIPT_TEXT(
        window.${BRIDGE}.callHandler('${BRIDGE}.start', { state: true }, window.eval);
    );
#undef JAVASCRIPT_TEXT
    switch (injectionTime) {
        case WKUserScriptInjectionTimeAtDocumentStart:
            return [scriptForBegan stringByReplacingOccurrencesOfString:@"${BRIDGE}" withString:self.name];
        case WKUserScriptInjectionTimeAtDocumentEnd:
            return [scriptForEnded stringByReplacingOccurrencesOfString:@"${BRIDGE}" withString:self.name];
        default:
            return @"";
    }
}

@end
