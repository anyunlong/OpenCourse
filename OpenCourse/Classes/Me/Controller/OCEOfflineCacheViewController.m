//
//  OCEOfflineCacheViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/7/19.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEOfflineCacheViewController.h"
#import "OCECacheCell.h"

@interface OCEOfflineCacheViewController ()

@end

@implementation OCEOfflineCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OCECacheCell *cacheCell = [OCECacheCell cellWithTableView:tableView];
    
    return cacheCell;
}

@end
