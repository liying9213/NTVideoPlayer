//
//  UIFont+NTNormalFont.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FontType) {
    Normal,
    Medium,
    Light,
    Bold,
};

@interface UIFont (NTNormalFont)

+ (UIFont *)normalFontOfSize:(CGFloat)fontSize WithFontType:(FontType)fontType;

@end
