//
//  OCEMeViewController.m
//  OpenCourse
//
//  Created by Oneself on 16/7/19.
//  Copyright © 2016年 CCUT. All rights reserved.
//

#import "OCEMeViewController.h"
#import "OCEOfflineCacheViewController.h"

@interface OCEMeViewController ()

@end

@implementation OCEMeViewController

- (instancetype)init {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    OCEMeViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"meViewController"];

    return controller;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[OCEOfflineCacheViewController alloc] init] animated:YES];
}

@end
