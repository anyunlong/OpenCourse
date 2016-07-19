//
//  OCEPlayerToolBar.h
//  OpenCourse
//
//  Created by Oneself on 16/7/9.
//  Copyright © 2016年 CCUT. All rights reserved.
//

@class OCEPlayerToolBar;

@protocol OCEPlayerToolBarDelegate <NSObject>

@optional
- (void)onClickDownloadButtonInPlayerToolBar:(OCEPlayerToolBar *)playerToolBar;

@end

@interface OCEPlayerToolBar : UIView

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) id<OCEPlayerToolBarDelegate> delegate;

@end
