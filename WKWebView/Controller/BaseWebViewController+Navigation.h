//
//  BaseWebViewController+Navigation.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/4.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController.h"

@interface NAME(BaseWebViewController) (Navigation)<WKNavigationDelegate>

- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType;
- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithResponse:(NSURLResponse *)response forMainFrame:(BOOL)forMainFrame;
- (void)webView:(WKWebView *)webView didFailedLoadingWithURL:(NSURL *)URL error:(NSError *)error;

// 返回自定义错误页，error为出错原因。
+ (NSString *)failedHTMLStringWithError:(NSError *)error;

@end
