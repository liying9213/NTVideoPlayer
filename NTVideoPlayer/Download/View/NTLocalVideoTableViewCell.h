//
//  NTLocalVideoTableViewCell.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NTLocalVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)reloadCellWithData:(NSDictionary *)listData;

@end

NS_ASSUME_NONNULL_END
