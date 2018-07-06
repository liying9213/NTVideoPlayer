//
//  UIFont+NTRuntime.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "UIFont+NTRuntime.h"
#import <objc/runtime.h>

@implementation UIFont (NTRuntime)

+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFontWithName:size:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(fontWithName:size:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
}

+ (UIFont *)adjustFontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    UIFont *newFont = nil;
    newFont = [UIFont adjustFontWithName:fontName size:fontSize+(ScreenWidth > 375 ? 1 : ScreenWidth > 320 ? 0 : -1)];
    return newFont;
}

@end
