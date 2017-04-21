//
//  BaseWebViewController+AlertController.m
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/13.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController+AlertController.h"
#import "BaseWebViewController+WebView.h"
#import "NSSafeAddition.h"

@implementation NAME(BaseWebViewController) (AlertController)

+ (BOOL)window:(UIWindow *)window presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    if ([viewController isMemberOfClass:[UIAlertController class]]) {
        return NO;
    }
    if (![viewController isKindOfClass:[UIAlertController class]]) {
        return NO;
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGPoint center = CGPointMake(size.width / 2, size.height / 2);
    WKWebView *webView = nil;
    
    for (UIView *view = [window hitTest:center withEvent:nil]; view; view = view.superview) {
        if ([view isKindOfClass:[WKWebView class]]) {
            webView = (WKWebView *)view;
        }
    }
    if (!webView) {
        return NO;
    }
    
    UIViewController *originViewController = nil;
    
    for (UIView *next = [webView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            originViewController = (UIViewController *)nextResponder;
            break;
        }
    }
    
    if ([originViewController isKindOfClass:[self class]]) {
        // 遍历所有subview查找正在工作的长按手势，找出长按坐标。
        UIGestureRecognizer *recognizer = nil;
        NSMutableArray *subviews = [NSMutableArray arrayWithObject:webView];
        for (NSUInteger i = 0; i < subviews.count; ++i) {
            UIView *view = view = [subviews objectAtIndex:i];
            for (UIGestureRecognizer *gestureRecognizer in view.gestureRecognizers) {
                // 不是长按的手势，即使命中也忽略
                if (![gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
                    continue;
                }
                // 手势状态必须位命中的某状态，实测基本都是 UIGestureRecognizerStateChanged
                if (gestureRecognizer.state != UIGestureRecognizerStatePossible &&
                    gestureRecognizer.state != UIGestureRecognizerStateCancelled &&
                    gestureRecognizer.state != UIGestureRecognizerStateFailed) {
                    recognizer = gestureRecognizer;
                    goto EXIT_FOR; // 跳出双重循环，根据一般编程规范，此处允许使用goto语句。
                }
            }
            [subviews addObjectsFromArray:view.subviews];
        }
    EXIT_FOR:
        // 非递归方式遍历，会产生很多数组元素，释放资源
        [subviews removeAllObjects];
        subviews = nil;
        if (recognizer) {
            CGPoint location = [recognizer locationInView:webView];
            [(__typeof([self alloc]))originViewController showMenuWithAlertController:(UIAlertController *)viewController location:location animated:animated completion:completion];
            return YES;
        }
    }
    
    return NO;
}

- (void)showMenuWithAlertController:(UIAlertController *)alertController location:(CGPoint)location animated:(BOOL)animated completion:(void (^)(void))completion {
    __weak __typeof(self) weakSelf = self;
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"window.%@.getHTMLElementAtPoint(%f,%f);", [self.webView scriptBridgeName], location.x, location.y] completionHandler:^(NSDictionary *result, NSError *error) {
        if (![result isKindOfClass:[NSDictionary class]]) {
            return;
        }
        NSString *text = [[result safeObjectForKey:@"text"] safeStringValue];
        NSString *href = [[result safeObjectForKey:@"href"] safeStringValue];
        NSString *tagName = [[result safeObjectForKey:@"tagName"] safeStringValue];
        
        NSURL *URL = [NSURL URLWithString:alertController.title];
        if (!URL) {
            URL = [NSURL URLWithString:href];
        }
        NSURL *imageURL = nil;
        
        if ([tagName compare:@"IMG"] == NSOrderedSame) {
            imageURL = [NSURL URLWithString:[[result safeObjectForKey:@"src"] safeStringValue] ?: @""];
        }
        [weakSelf showMenuWithAlertController:alertController text:text hyperlink:URL image:imageURL];
    }];
}

- (void)showMenuWithAlertController:(UIAlertController *)alertController text:(NSString *)text hyperlink:(NSURL *)hyperlink image:(NSURL *)image {
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
