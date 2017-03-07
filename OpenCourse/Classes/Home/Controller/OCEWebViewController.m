//
//  OCEWebViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/6/8.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEWebViewController.h"
// m
#import "OCECourse.h"

@interface OCEWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) UIBarButtonItem *shareItem;

@end

@implementation OCEWebViewController

#pragma mark - life cycle
- (void)loadView {
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:_course.pageUrl]]];
}

#pragma mark - UI
- (void)setupUI {
    [self setupNavBar];
    [self setupWebView];
}

- (void)setupNavBar {
    self.navigationItem.title = _course.title;
    self.navigationItem.leftBarButtonItem = self.closeItem;
    self.navigationItem.rightBarButtonItem = self.shareItem;
}

- (void)setupWebView {
    /// 将 '浏览'View 向上延伸一段距离，为了隐藏广告
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-45, 0, 0, 0);
    self.webView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - actions
- (void)closeBtnDidClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareBtnDidClicked {
    AYLLog(@"%@", @"shareBtnDidClicked");
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /// 注入 JS ，去除广告
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('appdown-footer')[0].remove();document.getElementsByClassName('appdown-header')[0].remove()"];
}

#pragma mark - getters and setters
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIBarButtonItem *)closeItem {
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(closeBtnDidClicked)];
    }
    return _closeItem;
}

- (UIBarButtonItem *)shareItem {
    if (!_shareItem) {
        _shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtnDidClicked)];
    }
    return _shareItem;
}

@end
