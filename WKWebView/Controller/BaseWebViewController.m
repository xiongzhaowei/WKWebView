//
//  BaseWebViewController.m
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/4.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController.h"
#import "WKWebView.h"

typedef NS_ENUM(NSUInteger, NAME(WKWebViewLoadingAnimationState)) {
    NAME(WKWebViewLoadingAnimationStopped),
    NAME(WKWebViewLoadingAnimationStarted),
    NAME(WKWebViewLoadingAnimationStopping),
};

@interface NAME(BaseWebViewController) () {
    NAME(WKWebView) *_webView;
    NAME(WKWebViewLoadingAnimationState) _loadingAnimationState;
    NSDate *_loadingAnimationStartTime;
}
@property (nonatomic, strong) __kindof WKWebView *webView;

@end

@implementation NAME(BaseWebViewController)

@synthesize webView = _webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstWebPage = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.webView.scrollView.delegate = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)_startLoadingAnimation {
    if (NAME(WKWebViewLoadingAnimationStopping) == _loadingAnimationState) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishLoadingAnimation) object:nil];
        _loadingAnimationState = NAME(WKWebViewLoadingAnimationStarted);
    }
    if (_loadingAnimationState == NAME(WKWebViewLoadingAnimationStarted)) {
        return;
    }
    [self startLoadingAnimation];
}

- (void)_finishLoadingAnimation {
    static NSTimeInterval loadingAnimationDuration = 0.35;
    if (_loadingAnimationState == NAME(WKWebViewLoadingAnimationStopped)) {
        return;
    } else if (_loadingAnimationState == NAME(WKWebViewLoadingAnimationStopping)) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishLoadingAnimation) object:nil];
        _loadingAnimationState = NAME(WKWebViewLoadingAnimationStarted);
    }
    NSTimeInterval duration = -[_loadingAnimationStartTime timeIntervalSinceNow];
    if (duration < loadingAnimationDuration) {
        [self performSelector:@selector(finishLoadingAnimation) withObject:nil afterDelay:loadingAnimationDuration - duration];
        _loadingAnimationState = NAME(WKWebViewLoadingAnimationStopping);
    } else {
        [self finishLoadingAnimation];
    }
}

- (void)setLoadingAnimationVisible:(BOOL)visible {
    if (visible) {
        [self _startLoadingAnimation];
    } else {
        [self _finishLoadingAnimation];
    }
}

- (void)startLoadingAnimation {
    _loadingAnimationStartTime = [NSDate date];
    _loadingAnimationState = NAME(WKWebViewLoadingAnimationStarted);
}

- (void)finishLoadingAnimation {
    _loadingAnimationState = NAME(WKWebViewLoadingAnimationStopped);
    _loadingAnimationStartTime = nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
