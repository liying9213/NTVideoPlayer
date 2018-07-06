//
//  NTHomeViewController.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NTHomeViewController.h"
#import "NTHomeListTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <UITableView+CYLTableViewPlaceHolder.h>
#import "NTEmptyPlaceHolderView.h"
#import "NTWarnViewManager.h"
#import <extobjc.h>

@interface NTHomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listArray;

@end

@implementation NTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetNavView];
    [self resetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - resetView
- (void)resetNavView{
    
}

- (void)resetView{
    [self.tableView registerNib:[UINib nibWithNibName:@"NTHomeListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NTHomeListTableViewCell"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView cyl_reloadData];
            
        });
    });
}

#pragma mark - getData

- (void)getData{
    
}

#pragma mark - tableViewDeleGate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView
                      fd_heightForCellWithIdentifier:@"NTHomeListTableViewCell"
                      cacheByIndexPath:indexPath
                      configuration:^(id cell) {
                          [(NTHomeListTableViewCell *)cell reloadCellWithData:self.listArray[indexPath.section]];
                      }];
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15.0f;
    }
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellStr = @"NTHomeListTableViewCell";
    NTHomeListTableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (_cell == nil) {
        _cell = [[[NSBundle mainBundle] loadNibNamed:cellStr owner:self options:nil] lastObject];
        _cell.backgroundColor = [UIColor clearColor];
    }
    [_cell reloadCellWithData:self.listArray[indexPath.section]];
    return _cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - userAction
- (void)showInputView{
    [NTWarnViewManager shoWWarnWithCancle:@"取消" withSure:@"确定" withCancleAction:^{
        
    } withSureAction:^(NSString *content) {
        
    }];
}

#pragma mark CYLTableViewPlaceHolderDelegate
- (UIView *)makePlaceHolderView{
    __block UIView * emptyView ;
    @weakify(self)
    emptyView = [[NTEmptyPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0) withTitle:nil withContent:@"暂无数据" withImage:@"empty" withHeaderTopValue:0 withlineNum:1 withNeedReload:YES withReloadText:@"添加" reloadBlock:^{
        @strongify(self)
        [self showInputView];
    }];
    return emptyView;
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}

- (BOOL)removePlaceHolderView{
    return YES;
}

@end
