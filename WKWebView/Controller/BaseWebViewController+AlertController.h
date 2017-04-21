//
//  BaseWebViewController+AlertController.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/13.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController.h"

@interface NAME(BaseWebViewController) (AlertController)

/**
 由于ViewController自身无法拦截WKWebView的长按菜单事件，需要应用程序提供事件通知，当长按手势发生后，
 WKWebView会先获得UIViewController，然后viewController.view.window.rootViewController的
 方式拿到rootViewController，最后[rootViewController presentViewController: animated: completion:]，
 因此，此方法需要在[[UIApplication sharedApplication].delegate.window.rootViewController
 presentViewController: animated: completion:]中调用，否则无法实现自定义长按菜单。
 例如：
 @implementation QHNavigationController
 - (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
     if (![QihooNewsObject window:self.view.window presentViewController:viewControllerToPresent animated:flag completion:completion]) {
         [super presentViewController:viewControllerToPresent animated:flag completion:completion];
     }
 }
 @end
 
 @param window  取rootViewController.view.window
 @return 是否已拦截本次弹窗，YES表示已拦截，NO表示未拦截。
 */
+ (BOOL)window:(UIWindow *)window presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)showMenuWithAlertController:(UIAlertController *)alertController location:(CGPoint)location animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)showMenuWithAlertController:(UIAlertController *)alertController text:(NSString *)text hyperlink:(NSURL *)hyperlink image:(NSURL *)image;

@end
