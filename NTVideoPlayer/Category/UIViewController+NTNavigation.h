//
//  UIViewController+NTNavigation.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NTNavigation)

@property (nonatomic, strong) NSString *navTitle;

- (void)setNavTitle:(NSString *)navTitle withColor:(NSString *)hexColor;

- (UIButton *)setNavLeftItemTitle:(NSString *)title ImageName:(NSString *)imageName WithAction:(NSString *)action;

- (UIButton *)setNavRightItemTitle:(NSString *)title ImageName:(NSString *)imageName WithAction:(NSString *)action;

- (UIButton *)setNavRightItems:(NSArray *)items;

- (void)setNavBottomLine;

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;


@end
