//
//  BaseWebViewController.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/4.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface NAME(BaseWebViewController) : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic) BOOL fullScreen;
@property (nonatomic, getter=isFirstWebPage) BOOL firstWebPage;
// 显示或隐藏加载动画。
- (void)setLoadingAnimationVisible:(BOOL)visible;

// WKWebView加载动画开始、结束的时机，用于子类覆盖，不要直接调用。
- (void)startLoadingAnimation;
- (void)finishLoadingAnimation;

@end

RENAME_CLASS(BaseWebViewController);
