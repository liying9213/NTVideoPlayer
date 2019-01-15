//
//  NTHomeViewController.m
//  NTVideoPlayer
//
//  Created by 李莹 on 2018/7/6.
//  Copyright © 2018年 liying. All rights reserved.
//

#import "NTHomeViewController.h"
#import "NTHomeCollectionViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import <UITableView+CYLTableViewPlaceHolder.h>
#import "UIViewController+NTNavigation.h"
#import "NTLocalVideoViewController.h"
#import "NTEmptyPlaceHolderView.h"
#import "NTWebViewController.h"
#import "NTWarnViewManager.h"
#import "NTLocalDataManage.h"
#import <extobjc.h>

@interface NTHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *listArray;

@end

@implementation NTHomeViewController

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

- (void)getData{
    self.listArray = [NTLocalDataManage getHomeData];
    [self.collectionView reloadData];
}

#pragma mark - resetView
- (void)resetNavView{
    [self setNavRightItemTitle:nil ImageName:@"download" WithAction:@"downloadAction"];
}

- (void)resetView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"NTHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NTHomeCollectionViewCell"];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.headerReferenceSize = CGSizeMake(ScreenWidth, 57);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark CollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NTHomeCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"NTHomeCollectionViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NTHomeCollectionViewCell" owner:nil options:nil][0];
    }
    [cell reloadCellWithData:self.listArray[indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self webViewWith:self.listArray[indexPath.row][@"url"] withTitle:self.listArray[indexPath.row][@"title"]];
}

#pragma mark FlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenWidth - 60)/2, (ScreenWidth - 60)/4);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 10, 20);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

- (void)webViewWith:(NSString *)path withTitle:(NSString *)title{
    NTWebViewController *viewController = [[NTWebViewController alloc] init];
    viewController.urlPath = path;
    viewController.navTitle = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)downloadAction{
    NTLocalVideoViewController *viewController = [[NTLocalVideoViewController alloc] init];
    viewController.navTitle = @"已下载";
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
