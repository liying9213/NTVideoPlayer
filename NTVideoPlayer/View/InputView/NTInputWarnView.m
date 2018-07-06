//
//  NTInputWarnView.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NTInputWarnView.h"

@interface NTInputWarnView ()

@property (weak, nonatomic) IBOutlet UIView *warnView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@end

@implementation NTInputWarnView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.font = [UIFont normalFontOfSize:14 WithFontType:Normal];
    self.cancleButton.titleLabel.font = [UIFont normalFontOfSize:16 WithFontType:Normal];
    self.sureButton.titleLabel.font = [UIFont normalFontOfSize:16 WithFontType:Normal];
    self.warnView.layer.masksToBounds = YES;
    self.warnView.layer.cornerRadius = 4.0f;
}

- (void)resetViewWithCancle:(NSString *)cancle withSure:(NSString *)sure withCancleAction:(void (^)(void))cancleAction  withSureAction:(void (^)(NSString *content))sureAction{
    [self.cancleButton setTitle:cancle forState:UIControlStateNormal];
    [self.sureButton setTitle:sure forState:UIControlStateNormal];
    self.cancleAction = cancleAction;
    self.sureAction = sureAction;
}

- (IBAction)cancleAction:(id)sender {
    [self.textView resignFirstResponder];
    !self.cancleAction ? : self.cancleAction();
}

- (IBAction)sureAction:(id)sender {
    [self.textView resignFirstResponder];
    !self.sureAction ? : self.sureAction(self.textView.text);
}

@end
