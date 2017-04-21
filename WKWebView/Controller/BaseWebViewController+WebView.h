//
//  BaseWebViewController+WebView.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/25.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//
// 尽量不要在.h文件中引入此文件，避免头文件被BaseWebViewController.m引入。
// 文件用于声明必须公开但又不能在framework中公开的方法和属性。

#import "BaseWebViewController.h"
#import "WKWebView.h"

@interface NAME(BaseWebViewController) ()
@property (nonatomic, strong) __kindof WKWebView *webView;
@end

@interface NAME(BaseWebViewController) (WebView)<NAME(WKScriptMessageHandler)>

// 项目中用到的WKWebView对象
+ (Class)webViewClass;
+ (__kindof WKWebView *)webViewWithFrame:(CGRect)frame;
+ (__kindof WKWebViewConfiguration *)configuration;

// 初始化webview对象，如WKWebView需从外面传进来，webview非空，否则webview为空。
// containerView为包含webview的容器。
- (void)initWebView:(/* nullable */__kindof WKWebView *)webView;
- (void)initWebView:(/* nullable */__kindof WKWebView *)webView
      containerView:(UIView *)containerView;
- (void)initWebView:(/* nullable */__kindof WKWebView *)webView
      containerView:(UIView *)containerView
              frame:(CGRect)frame;

- (void)loadRequestWithURL:(NSURL *)URL;
- (void)reload;

// 注意：此处的goBack不仅仅包含普通的后退，也包括页面关闭操作，子类应该重载此方法，判断当满足如下条件时，做出额外的处理：当canGoBack属性为NO时，或者当firstWebPage为YES时。
// 简单的说，就是goBack和close都在此方法中处理而没有分开，以后再优化。
- (void)goBack;

@end
