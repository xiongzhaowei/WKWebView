//
//  WKWebViewConfiguration.h
//  QihooBrowser
//
//  Created by 熊朝伟 on 2016/12/21.
//
//

#import "WKUserContentController.h"

@interface NAME(WKWebViewConfiguration) : WKWebViewConfiguration

@property (nonatomic, strong) NAME(WKUserContentController) *userContentController;
@property (nonatomic, strong) NSString *scriptBridgeName;

- (void)addScriptMessageHandlerWithName:(NSString *)name;

@end
