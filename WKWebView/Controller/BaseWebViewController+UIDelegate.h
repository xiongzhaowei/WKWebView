//
//  BaseWebViewController+UIDelegate.h
//  QihooNewsSDK
//
//  Created by 熊朝伟 on 2017/1/4.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "BaseWebViewController.h"

@interface NAME(BaseWebViewController) (UIDelegate)<WKUIDelegate>

- (void)presentAlertController:(UIAlertController *)alertController animated:(BOOL)animated completion:(void (^)(void))completion;

@end
