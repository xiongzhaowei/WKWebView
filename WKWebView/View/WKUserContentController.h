//
//  WKUserContentController.h
//  QihooBrowser
//
//  Created by 熊朝伟 on 2016/12/21.
//
//

#import <WebKit/WebKit.h>

@interface NAME(WKUserContentController) : WKUserContentController

- (void)addUserScriptWithSource:(NSString *)source
                  injectionTime:(WKUserScriptInjectionTime)injectionTime;
- (void)addScriptMessageHandlerWithName:(NSString *)name;

@end
