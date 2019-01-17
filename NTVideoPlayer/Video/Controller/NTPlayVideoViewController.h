//
//  NTPlayVideoViewController.h
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/16.
//  Copyright © 2019 liying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WMPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface NTPlayVideoViewController : UIViewController

@property (nonatomic, copy)NSString *videoPath;
@property (nonatomic, retain)WMPlayerModel *playerModel;
@property (nonatomic, strong)WMPlayer  *wmPlayer;

@end

NS_ASSUME_NONNULL_END
