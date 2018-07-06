//
//  UIViewController+NTNavigation.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "UIViewController+NTNavigation.h"
#import "UIFont+NTNormalFont.h"
#import "NSString+NTSize.h"
#import <UIColor+YYAdd.h>

@implementation UIViewController (NTNavigation)

@dynamic navTitle;

- (void)setNavTitle:(NSString *)navTitle{
    [self setNavTitle:navTitle withColor:@"333333"];
}

- (void)setNavTitle:(NSString *)navTitle withColor:(NSString *)hexColor{
    if (navTitle && navTitle.length>0) {
        float width = [navTitle getTheSizeWidthWithFont:[UIFont normalFontOfSize:17.0 WithFontType:Normal] WithHeight:44];
        if (width>160) {
            width = 160;
        }
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
        
        titleLabel.text = navTitle;
        
        titleLabel.textColor = [UIColor colorWithHexString:hexColor];
        
        titleLabel.font = [UIFont normalFontOfSize:18.0 WithFontType:Medium];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.navigationItem.titleView = titleLabel;
    }
}

- (UIButton *)setNavLeftItemTitle:(NSString *)title ImageName:(NSString *)imageName WithAction:(NSString *)action{
    
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spacerItem.width = -10;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (title && imageName) {
        btn.frame =CGRectMake(0, 0, 86+(ScreenWidth > 375 ? 10 : 5), 44);
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont normalFontOfSize:14.0 WithFontType:Normal];
        
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,10,0,0)];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [btn setImage:[UIImage imageNamed:imageName]  forState:UIControlStateNormal];
    }
    else if(!title && imageName){
        btn.frame =CGRectMake(0, 0, 44, 44);
        
        btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,5 * ScreenWidth /375.0,0,0)];
        
        [btn setImage:[UIImage imageNamed:imageName]  forState:UIControlStateNormal];
    }
    else if(title && !imageName){
        btn.frame =CGRectMake(0, 0, 84, 44);
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont normalFontOfSize:15.0 WithFontType:Normal];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
    [btn addTarget: self action: NSSelectorFromString(action) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItems =  @[spacerItem,item];
    
    return btn;
}


- (UIButton *)setNavRightItemTitle:(NSString *)title ImageName:(NSString *) imageName WithAction:(NSString *)action{
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spacerItem.width = -10;
    
    UIButton* button = [self setRigtItemTitle:title ImageName:imageName WithAction:action];
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItems =  @[spacerItem,item];
    
    return button;
}

- (UIButton *)setNavRightItems:(NSArray *)items{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    UIButton * rightButton;
    int i = 0;
    for (NSDictionary *item in items) {
        UIButton * button = [self setRigtItemTitle:item[@"title"] ImageName:item[@"image"] WithAction:item[@"action"]];
        button.frame = CGRectMake(i*40+5, 0, 40, 44);
        button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [view addSubview:button];
        if (i == 0) {
            rightButton = button;
        }
        i++;
    };
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.rightBarButtonItems =  @[item];
    
    return rightButton;
}

- (UIButton *)setRigtItemTitle:(NSString *)title ImageName:(NSString *) imageName WithAction:(NSString *)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (title && imageName) {
        btn.frame =CGRectMake(0, 0, 94, 44);
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont normalFontOfSize:15.0 WithFontType:Normal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        [btn setImage:[UIImage imageNamed:imageName]  forState:UIControlStateNormal];
    }
    else if(!title && imageName){
        btn.frame =CGRectMake(0, 0, 44, 44);
        btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,5 *ScreenWidth /375.0)];
        [btn setImage:[UIImage imageNamed:imageName]  forState:UIControlStateNormal];
    }
    else if(title && !imageName){
        
        float width ;
        if (self.navigationItem.titleView) {
            width = ([[UIScreen mainScreen] bounds].size.width - CGRectGetWidth(self.navigationItem.titleView.frame))/2-16;
        }
        else
            width = 84;
        btn.frame =CGRectMake(0, 0, width, 44);
        
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont normalFontOfSize:15.0 WithFontType:Normal];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
    }
    
    [btn addTarget: self action: NSSelectorFromString(action) forControlEvents: UIControlEventTouchUpInside];
    
    return btn;
}

- (void)setNavBottomLine{
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    if (navBarHairlineImageView) {
        //        navBarHairlineImageView.hidden = YES;
        UIImageView *navLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(navBarHairlineImageView.bounds), 0.6)];
        navLine.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        [navBarHairlineImageView addSubview:navLine];
    }
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


@end
