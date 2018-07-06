//
//  NSString+NTSize.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NTSize)

- (CGFloat)getTheSizeWidthWithFont:(UIFont*)font WithHeight:(float)height;

- (CGFloat)getTheSizeHeightWithFont:(UIFont*)font WithWidth:(float)width;

@end
