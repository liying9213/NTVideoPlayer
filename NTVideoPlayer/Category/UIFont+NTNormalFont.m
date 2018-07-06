//
//  UIFont+NTNormalFont.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "UIFont+NTNormalFont.h"

@implementation UIFont (NTNormalFont)
/*
 苹方-简 常规体
 font-family: PingFangSC-Regular, sans-serif;
 苹方-简 极细体
 font-family: PingFangSC-Ultralight, sans-serif;
 苹方-简 细体
 font-family: PingFangSC-Light, sans-serif;
 苹方-简 纤细体
 font-family: PingFangSC-Thin, sans-serif;
 苹方-简 中黑体
 font-family: PingFangSC-Medium, sans-serif;
 苹方-简 中粗体
 font-family: PingFangSC-Semibold, sans-serif;
 */
+ (UIFont *)normalFontOfSize:(CGFloat)fontSize WithFontType:(FontType)fontType{
    UIFont *font ;
    if ([UIDevice currentDevice].systemVersion.doubleValue>=9.0) {
        switch (fontType) {
            case Normal:
            {
                font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
            }
                break;
            case Medium:
            {
                font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
            }
                break;
            case Light:
            {
                font = [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
            }
                break;
            case Bold:
            {
                font = [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
            }
                break;
                
            default:
                break;
        }
    }
    else{
        switch (fontType) {
            case Normal: case Light:
            {
                font = [UIFont systemFontOfSize:fontSize];
            }
                break;
            case Medium: case Bold:
            {
                font = [UIFont boldSystemFontOfSize:fontSize];
            }
                break;
            default:
                break;
        }
        
    }
    return font;
}


@end
