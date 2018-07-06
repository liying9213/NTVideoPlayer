//
//  NTEmptyPlaceHolderView.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadButtonClickBlock)() ;

@interface NTEmptyPlaceHolderView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title  withContent:(NSString *)content withImage:(NSString *) imageName withHeaderTopValue:(float)topValue withlineNum:(int)lineNum withNeedReload:(BOOL)needReload withReloadText:(NSString *)reloadText reloadBlock:(ReloadButtonClickBlock)reloadBlock;

- (void)showInView:(UIView *)viewWillShow ;
- (void)dismiss ;

@end
