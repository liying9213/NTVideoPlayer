//
//  NTHomeListTableViewCell.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NTHomeListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)reloadCellWithData:(NSDictionary *)listData;

@end
