//
//  ViewController.m
//  browser
//
//  Created by 熊朝伟 on 2017/4/21.
//  Copyright © 2017年 熊朝伟. All rights reserved.
//

#import "ViewController.h"
#import "BaseWebViewController+WebView.h"

@interface ViewController ()

@end

// 几处建议修改的地方：
// 1. BaseWebViewController的基类改成自己的公共基类
// 2. [NSURL URLWithString:]替换为支持中文域名并且过滤特殊字符的的URL解析。
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initWebView:nil containerView:self.view];
    [self loadRequestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
