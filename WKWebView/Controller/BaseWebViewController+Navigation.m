//
//  BaseWebViewController+Navigation.m
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/4.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController+Navigation.h"
#import "BaseWebViewController+WebView.h"

@implementation NAME(BaseWebViewController) (Navigation)

+ (NSString *)failedHTMLStringWithError:(NSError *)error {
    return [NSString stringWithFormat:@"<h1>页面加载失败！</h1><p>%@</p><h2>您可以点击<a href='about:reload'>重试</a>重新加载页面，或点击<a href='about:back'>后退</a>返回上一个页面。<h2>", error.localizedDescription];
}

- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(WKNavigationType)navigationType {
    // 根据请求内容判断是否打开页面
    NSURL *URL = request.URL;
    NSString *scheme = URL.scheme.lowercaseString;
    if ([scheme isEqualToString:@"about"]) {
        if ([URL.resourceSpecifier isEqualToString:@"blank"]) {
            return YES;
        } else if ([URL.resourceSpecifier isEqualToString:@"back"]) {
            [self goBack];
        } else if ([URL.resourceSpecifier isEqualToString:@"reload"]) {
            [self reload];
        } else {
            
        }
        return NO;
    } else if (![scheme isEqualToString:@"http"] &&
               ![scheme isEqualToString:@"https"] &&
               ![scheme isEqualToString:@"ftp"] &&
               ![scheme isEqualToString:@"file"]) {
        if ([[UIApplication sharedApplication] openURL:URL]) {
            [webView stopLoading];
            if ([self isFirstWebPage]) {
                [self goBack];
            }
        }
        return NO;
    } else if ([URL.host isEqualToString:@"itunes.apple.com"]) {
        if ([[UIApplication sharedApplication] openURL:URL]) {
            [webView stopLoading];
            if ([self isFirstWebPage]) {
                [self goBack];
            }
        }
        return NO;
    }
    // 此处可增加安全性检查代码
    return YES;
}

- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithResponse:(NSURLResponse *)response forMainFrame:(BOOL)forMainFrame {
    // 根据响应内容判断是否打开页面
    return YES;
}

- (void)webView:(WKWebView *)webView failedLoadingWithError:(NSError *)error {
    if (!error) {
        return;
    }
    if ([error.domain isEqual:@"WebKitErrorDomain"]) {
        return;
    }
    switch (error.code) {
        case 102:
        case 204:
        case kCFURLErrorCancelled:
            break;
        case NSURLErrorServerCertificateUntrusted:
            // TODO: 弹框提示
        default: {
            [self webView:webView didFailedLoadingWithURL:[error.userInfo objectForKey:NSURLErrorFailingURLErrorKey] error:error];
            break;
        }
    }
}

- (void)webView:(__kindof WKWebView *)webView didFailedLoadingWithURL:(NSURL *)URL error:(NSError *)error {
    // 默认错误页的实现，个性化的错误页通过参考此处代码，在子类中实现。
    // 经过反复尝试，在加载错误页时，为确保BackForwardList中的URL不会错乱，baseURL尽量使用当前真正的URL。
    [webView loadFailedHTMLString:[[self class] failedHTMLStringWithError:error] unreachableURL:URL];
}

- (void)webView:(__kindof WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [webView webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }
    WKNavigationActionPolicy policy = [self webView:webView shouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType] ? WKNavigationActionPolicyAllow : WKNavigationActionPolicyCancel;
    decisionHandler(policy);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    WKNavigationResponsePolicy policy = [self webView:webView shouldStartLoadWithResponse:navigationResponse.response forMainFrame:navigationResponse.forMainFrame] ? WKNavigationResponsePolicyAllow : WKNavigationResponsePolicyCancel;
    decisionHandler(policy);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    self.URL = webView.URL;
    [self setLoadingAnimationVisible:YES];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self setLoadingAnimationVisible:NO];
    [self webView:webView failedLoadingWithError:error];
}

- (void)webView:(__kindof WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    if ([webView respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [webView webView:webView didCommitNavigation:navigation];
    }
    self.firstWebPage = NO;
    [self setLoadingAnimationVisible:NO];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self setLoadingAnimationVisible:NO];
    [self webView:webView failedLoadingWithError:error];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault] ||
        [challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic] ||
        [challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPDigest]) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"身份认证" message:webView.URL.host preferredStyle:UIAlertControllerStyleAlert];
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"用户名";
        }];
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"密码";
            textField.secureTextEntry = YES;
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *userText = controller.textFields[0];
            UITextField *passText = controller.textFields[1];
            NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:userText.text password:passText.text persistence:NSURLCredentialPersistenceForSession];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        }];
        [controller addAction:okAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
        }];
        [controller addAction:cancelAction];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    } else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}

@end
