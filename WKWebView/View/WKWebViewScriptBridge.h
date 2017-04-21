//
//  WKWebViewScriptBridge.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/3.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "WKUserContentController.h"

@class NAME(WKWebView);

@interface NAME(WKWebViewScriptBridge) : NSObject<WKScriptMessageHandler>
@property (nonatomic, readonly) NSString *name;
@end

@interface NAME(WKUserContentController) (WKWebViewScriptBridge)
- (NAME(WKWebViewScriptBridge) *)addScriptBridgeWithName:(NSString *)name;
@end

typedef void(^NAME(WKWebViewScriptBridgeHandler))(NAME(WKWebView) *webView, NAME(WKWebViewScriptBridge) *scriptBridge, NSString *name, id data, void(^completion)(id result));
