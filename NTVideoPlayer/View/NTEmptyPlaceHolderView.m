//
//  NTEmptyPlaceHolderView.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#define NO_WIFI_WORDS                   @"网络不太顺畅喔~"
#define NO_WIFI_IMAGE                   @"empty_order"

float const width_displayNoWifiView  = 76 ;
float const height_displayNoWifiView = 76 ;

float const width_labelshow          = 300.0 ;
float const height_labelshow         = 50.0 ;
float const fontSize_labelshow       = 16.0 ;

float const flexY_lb_bt              = 10.0 ;

float const width_bt                 = 180.0 ;
float const height_bt                = 47.0 ;
float const fontSize_bt              = 16.0 ;

#import <UIColor+YYAdd.h>
#import "NTEmptyPlaceHolderView.h"

@interface NTEmptyPlaceHolderView ()

@property (nonatomic, strong) UIImageView *nowifiImgView ;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *reloadButton ;
@property (nonatomic, copy) ReloadButtonClickBlock reloadButtonClickBlock ;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *reloadText;
@property (nonatomic, assign) BOOL needReload;
@property (nonatomic, assign) float topValue;
@property (nonatomic, assign) int lineNum;
@property (nonatomic, assign) float heightlabel;

@end

@implementation NTEmptyPlaceHolderView


- (void)showInView:(UIView *)viewWillShow {
    [viewWillShow addSubview:self] ;
}


- (void)dismiss {
    [self removeFromSuperview] ;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withContent:(NSString *)content withImage:(NSString *) imageName withHeaderTopValue:(float)topValue withlineNum:(int)lineNum withNeedReload:(BOOL)needReload withReloadText:(NSString *)reloadText reloadBlock:(ReloadButtonClickBlock)reloadBlock{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        self.content = content;
        self.imageName = imageName;
        self.needReload = needReload;
        self.reloadText = reloadText;
        self.topValue = topValue;
        self.lineNum = lineNum;
        self.reloadButtonClickBlock = reloadBlock ;
        [self setup] ;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  reloadBlock:(ReloadButtonClickBlock)reloadBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.reloadButtonClickBlock = reloadBlock ;
        [self setup] ;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews] ;
    
    int value = 0;
    
    if (!self.imageName) {
        value += height_displayNoWifiView;
    }
    else{
        value += 8;
    }
    
    if (_lineNum == 1) {
        _heightlabel = height_labelshow/2-3;
    }
    else{
        _heightlabel = height_labelshow;
    }
    
    CGRect rectWifi = CGRectZero ;
    rectWifi.size = CGSizeMake(width_displayNoWifiView, height_displayNoWifiView) ;
    rectWifi.origin.x = (self.frame.size.width - width_displayNoWifiView) / 2.0 ;
    if (self.topValue>0) {
        rectWifi.origin.y = self.topValue;
    }else{
        
        rectWifi.origin.y = (self.frame.size.height - height_displayNoWifiView - _heightlabel - flexY_lb_bt - height_bt - 18 -14-49-value) / 2 - 50;
    }
    self.nowifiImgView.frame = rectWifi ;
    
    CGRect rectLabel = CGRectZero ;
    rectLabel.origin.x = (self.frame.size.width - width_labelshow) / 2.0 ;
    rectLabel.origin.y = rectWifi.origin.y + rectWifi.size.height +25;
    rectLabel.size = CGSizeMake(width_labelshow, self.title ? _heightlabel :0) ;
    self.titleLabel.frame = rectLabel ;
    
    CGRect rectContentLabel = CGRectZero ;
    rectContentLabel.origin.x = (self.frame.size.width - (width_labelshow + (ScreenWidth>0 ? 20:0))) / 2.0 ;
    if (self.title) {
        rectContentLabel.origin.y = rectLabel.origin.y + rectLabel.size.height +15;
    }
    else{
        rectContentLabel.origin.y = rectWifi.origin.y + rectWifi.size.height + 15;
    }
    rectContentLabel.size = CGSizeMake(width_labelshow+(ScreenWidth>0 ? 20:0), self.content ? _heightlabel : 0) ;
    self.contentLabel.frame = rectContentLabel ;
    
    CGRect rectButton = CGRectZero ;
    rectButton.origin.x = (self.frame.size.width - width_bt) / 2.0 ;
    rectButton.origin.y = rectContentLabel.origin.y + rectContentLabel.size.height + flexY_lb_bt+30 ;
    rectButton.size = CGSizeMake(width_bt, height_bt) ;
    self.reloadButton.frame = rectButton ;
}

- (void)setup {
    [self configure] ;
    [self nowifiImgView] ;
    [self titleLabel] ;
    [self reloadButton] ;
}

- (void)configure {
    self.backgroundColor = [UIColor colorWithHexString:@"fafafa"] ;
}

- (UIImageView *)nowifiImgView {
    if (!_nowifiImgView) {
        _nowifiImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageName?_imageName:NO_WIFI_IMAGE]] ;
        _nowifiImgView.contentMode = UIViewContentModeBottom ;
        if (![_nowifiImgView superview]) {
            [self addSubview:_nowifiImgView] ;
        }
    }
    return _nowifiImgView ;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init] ;
        _titleLabel.numberOfLines = 0;
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.font = [UIFont normalFontOfSize:18.0 WithFontType:Normal];
        _titleLabel.textColor = [UIColor colorWithHexString:@"888888"] ;
        if (![_titleLabel superview]) {
            [self addSubview:_titleLabel] ;
        }
    }
    return _titleLabel ;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init] ;
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = self.content;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.font = [UIFont normalFontOfSize:14.0 WithFontType:Normal];
        _contentLabel.textColor = [UIColor colorWithHexString:@"b2b2b2"] ;
        if (![_contentLabel superview]) {
            [self addSubview:_contentLabel] ;
        }
    }
    return _contentLabel ;
}


- (UIButton *)reloadButton {
    if (!_reloadButton) {
        _reloadButton = [[UIButton alloc] init] ;
        [_reloadButton setTitle:self.reloadText forState:0] ;
        [_reloadButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:0] ;
        _reloadButton.titleLabel.font = [UIFont normalFontOfSize:18 WithFontType:Normal];
        _reloadButton.backgroundColor = [UIColor colorWithHexString:@"007AFF"];
        _reloadButton.layer.cornerRadius = 5.0f ;
        [_reloadButton addTarget:self action:@selector(reloadButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
        if (![_reloadButton superview]) {
            [self addSubview:_reloadButton] ;
        }
    }
    if (!_needReload) {
        _reloadButton.hidden = YES;
    }
    return _reloadButton ;
}

- (void)reloadButtonClicked {
    !self.reloadButtonClickBlock ? : self.reloadButtonClickBlock() ;
}
@end
