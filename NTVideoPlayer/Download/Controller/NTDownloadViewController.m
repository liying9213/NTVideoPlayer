//
//  NTDownloadViewController.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2019/1/14.
//  Copyright © 2019 liying. All rights reserved.
//

#import "NTDownloadViewController.h"
#import "NTDownloadTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <UITableView+CYLTableViewPlaceHolder.h>
#import "UIViewController+NTNavigation.h"
#import "NTEmptyPlaceHolderView.h"
#import "NTWarnViewManager.h"
#import <extobjc.h>

@interface NTDownloadViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listArray;

@end

@implementation NTDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetNavView];
    [self resetView];
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - resetView
- (void)resetNavView{
    [self setNavLeftItemTitle:nil ImageName:@"backIon" WithAction:@"backAction"];
    [self setNavRightItemTitle:nil ImageName:@"download" WithAction:@"downloadAction"];
}

- (void)resetView{
    [self.tableView registerNib:[UINib nibWithNibName:@"NTDownloadTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NTDownloadTableViewCell"];
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
                      fd_heightForCellWithIdentifier:@"NTDownloadTableViewCell"
                      cacheByIndexPath:indexPath
                      configuration:^(id cell) {
                          [(NTDownloadTableViewCell *)cell reloadCellWithData:self.listArray[indexPath.section]];
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
    static NSString * cellStr = @"NTDownloadTableViewCell";
    NTDownloadTableViewCell * _cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
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

- (void)download{
    [NTWarnViewManager shoWWarnWithCancle:@"取消" withSure:@"确定" withCancleAction:^{
    } withSureAction:^(NSString *content) {
        [self parseAction:content];
    }];
}

- (void)parseAction:(NSString *)path{
    [NTWarnViewManager shoWParseWarnWithPath:path withCancleAction:^{
    } withPlayAction:^(NSString *content) {
    } withDownLoadAction:^(NSString *content) {
    }];
}

#pragma mark CYLTableViewPlaceHolderDelegate
- (UIView *)makePlaceHolderView{
    __block UIView * emptyView ;
    emptyView = [[NTEmptyPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0) withTitle:nil withContent:@"暂无数据" withImage:@"empty" withHeaderTopValue:0 withlineNum:1 withNeedReload:NO withReloadText:@"" reloadBlock:^{
    }];
    return emptyView;
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}

- (BOOL)removePlaceHolderView{
    return YES;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
