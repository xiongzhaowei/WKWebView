//
//  BaseWebViewController+WebView.m
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/25.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController+WebView.h"
#import "BaseWebViewController+Navigation.h"
#import "BaseWebViewController+UIDelegate.h"
#import <objc/runtime.h>

@implementation NAME(BaseWebViewController) (WebView)

+ (Class)webViewClass {
    return [NAME(WKWebView) class];
}

+ (__kindof WKWebView *)webViewWithFrame:(CGRect)frame {
    // WKWebViewConfiguration对象不用每次都创建新的，但不同的子类需要不同的configuration对象。
    NAME(WKWebViewConfiguration) *configuration = objc_getAssociatedObject(self, @selector(configuration));
    if (!configuration) {
        configuration = [self configuration];
        objc_setAssociatedObject(self, @selector(configuration), configuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [[[[self class] webViewClass] alloc] initWithFrame:frame configuration:configuration];
}

+ (__kindof WKWebViewConfiguration *)configuration {
    NAME(WKWebViewConfiguration) *configuration = [[[self class] webViewClass] configuration];
    // 设置浏览器私有扩展的变量名，在javascript代码与native代码交互时需要用到
    // 为避免影响前端网页脚本，尽量使用特殊变量名避免命名冲突。
    [configuration setScriptBridgeName:@"__$_webview_$__"];
    return configuration;
}

- (void)initWebView:(__kindof WKWebView *)webView {
    [self initWebView:webView containerView:nil frame:[UIScreen mainScreen].bounds];
}

- (void)initWebView:(__kindof WKWebView *)webView containerView:(UIView *)containerView {
    [self initWebView:webView containerView:containerView frame:containerView.bounds];
}

- (void)initWebView:(__kindof WKWebView *)webView containerView:(UIView *)containerView frame:(CGRect)frame {
    if (!webView) {
        webView = [[self class] webViewWithFrame:frame];
    } else if (webView.URL) {
        self.URL = webView.URL;
    }
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.scrollView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if ([webView isKindOfClass:[NAME(WKWebView) class]]) {
        [webView setScriptMessageHandler:self];
    }
    if (containerView) {
        [containerView addSubview:webView];
    }
    self.webView = webView;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)loadRequestWithURL:(NSURL *)URL {
    if (!URL) {
        return;
    }
    self.URL = URL;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}

- (void)reload {
    [self.webView reload];
}

- (void)goBack {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        //通过present方法跳转过来的返回方式--add by zhaopeng
        if(!self.navigationController){
            [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];

        }
       
    }
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

@end
