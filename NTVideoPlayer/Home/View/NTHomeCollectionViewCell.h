//
//  NTHomeCollectionViewCell.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/15.
//  Copyright © 2019 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NTHomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

- (void)reloadCellWithData:(NSDictionary *)listData;

@end

NS_ASSUME_NONNULL_END
