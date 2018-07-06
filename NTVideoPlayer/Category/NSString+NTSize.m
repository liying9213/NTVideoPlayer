//
//  NSString+NTSize.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NSString+NTSize.h"

@implementation NSString (NTSize)

- (CGFloat)getTheSizeWidthWithFont:(UIFont*)font WithHeight:(float)height{
    if (!self||[self isEqualToString:@""])
    {
        return 0;
    }
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                nil];
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    return [self getTheSizeWidthWithHeight:height withAttributedString:attributedString];
}

- (CGFloat)getTheSizeHeightWithFont:(UIFont*)font WithWidth:(float)width{
    if (!self||[self isEqualToString:@""])
    {
        return 0;
    }
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                nil];
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    return [self getTheSizeHeightWithWidth:width withAttributedString:attributedString];
}

- (CGFloat)getTheSizeWidthWithHeight:(float)height withAttributedString:(NSAttributedString *)attributedString{
    if (!attributedString)
    {
        return 0;
    }
    CGRect paragraphRect =
    [attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                   options:(NSStringDrawingUsesLineFragmentOrigin)
                                   context:nil];
    return paragraphRect.size.width;
}


- (CGFloat)getTheSizeHeightWithWidth:(float)width withAttributedString:(NSAttributedString *)attributedString{
    if (!attributedString)
    {
        return 0;
    }
    CGRect paragraphRect =
    [attributedString boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                   options:(NSStringDrawingUsesLineFragmentOrigin)
                                   context:nil];
    return paragraphRect.size.height;
}

@end
