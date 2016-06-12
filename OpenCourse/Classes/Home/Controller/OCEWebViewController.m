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

@interface OCEWebViewController ()

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
    
    self.navigationItem.title = _course.title;
    
    self.navigationItem.leftBarButtonItem = self.closeItem;
    
    self.navigationItem.rightBarButtonItem = self.shareItem;
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:_course.pageUrl]]];
}

#pragma mark - event response
- (void)closeBtnDidClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareBtnDidClicked {
    AYLLog(@"%@", @"shareBtnDidClicked");
}

#pragma mark - getters and setters
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
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
