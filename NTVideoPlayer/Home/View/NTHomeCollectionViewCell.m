//
//  NTHomeCollectionViewCell.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/15.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTHomeCollectionViewCell.h"
#import <UIColor+YYAdd.h>

@implementation NTHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)reloadCellWithData:(NSDictionary *)listData{
    self.titleLabel.text = listData[@"title"];
    self.backgroundColor = [UIColor colorWithHexString:listData[@"color"]];
    
    self.layer.cornerRadius = 8;
    self.contentView.layer.cornerRadius = 8.0f;
    self.contentView.layer.borderWidth = 0;
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.maskLayer.frame = self.layer.bounds;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.layer.bounds];
//    [path appendPath:[UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:8]];
//    self.maskLayer.path = path.CGPath;
//}
//
//- (CAShapeLayer *)maskLayer{
//    if (!_maskLayer) {
//        _maskLayer = [CAShapeLayer new];
//        _maskLayer.fillColor = [UIColor whiteColor].CGColor;
//        _maskLayer.borderColor = [UIColor clearColor].CGColor;
//        _maskLayer.fillRule = kCAFillRuleEvenOdd;
//        _maskLayer.borderWidth = 0;
//        _maskLayer.cornerRadius = 8;
//        _maskLayer.masksToBounds = YES;
//        [self.contentView.layer addSublayer:_maskLayer];
//    }
//    return _maskLayer;
//}

@end
