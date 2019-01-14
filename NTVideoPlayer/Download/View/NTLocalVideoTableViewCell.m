//
//  NTLocalVideoTableViewCell.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTLocalVideoTableViewCell.h"

@implementation NTLocalVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.preferredMaxLayoutWidth = ScreenWidth - 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadCellWithData:(NSDictionary *)listData{
    
}
@end
