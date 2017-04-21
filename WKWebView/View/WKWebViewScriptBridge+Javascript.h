//
//  WKWebViewScriptBridge+Javascript.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/3.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "WKWebViewScriptBridge.h"

@interface NAME(WKWebViewScriptBridge) (Javascript)
- (NSString *)javascript:(WKUserScriptInjectionTime)injectionTime;
@end
