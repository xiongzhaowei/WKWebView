//
//  WKWebViewConfiguration.m
//  QihooBrowser
//
//  Created by 熊朝伟 on 2016/12/21.
//
//

#import "WKWebViewConfiguration.h"
#import "WKWebViewScriptBridge.h"
#import "WKUserContentController.h"

@interface NAME(WKWebViewConfiguration) ()

@property (nonatomic, weak) NAME(WKWebViewScriptBridge) *scriptBridge;

@end

@implementation NAME(WKWebViewConfiguration)

@dynamic userContentController;

- (instancetype)init {
    if ((self = [super init])) {
        self.userContentController = [[NAME(WKUserContentController) alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    __typeof(self) result = [super copyWithZone:zone];
    result.scriptBridge = self.scriptBridge;
    return result;
}

- (NSString *)scriptBridgeName {
    return _scriptBridge.name;
}

- (void)setScriptBridgeName:(NSString *)name {
    if (_scriptBridge) {
        [self.userContentController removeScriptMessageHandlerForName:_scriptBridge.name];
    }
    _scriptBridge = [self.userContentController addScriptBridgeWithName:name];
}

- (void)addScriptMessageHandlerWithName:(NSString *)name {
    [self.userContentController addScriptMessageHandlerWithName:name];
}

@end
