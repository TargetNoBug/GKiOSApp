//
//  GKNewItemViewController.m
//  GKiOSApp
//
//  Created by wangws1990 on 2017/5/16.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import "GKNewItemViewController.h"
#import "GKNewDetailController.h"
#import "GKNewItemTableViewCell.h"
#import "GKNewItemAdCell.h"
#import "GKNewItemImageCell.h"
#import "GKNewItemTraCell.h"
#import "GKNewModel.h"
#import "GKNewPhotoModel.h"
@interface GKNewItemViewController()
@property (strong, nonatomic) NSMutableArray *listData;
@end
@implementation GKNewItemViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.listData = @[].mutableCopy;
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATRefreshDefault];


}
- (void)vtm_prepareForReuse{
    if (!self.reachable) {
        [self.listData removeAllObjects];
        [self.tableView reloadData];
    }
}
- (void)setCategoryId:(NSString *)categoryId{
    _categoryId = categoryId;
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    [self refreshData:1];
}
- (void)refreshData:(NSInteger)page{
    [GKHomeNetManager newHot:self.categoryId page:page success:^(id  _Nonnull object) {
        if (page == RefreshPageStart) {
            [self.listData removeAllObjects];
        }
        NSArray *datas = [NSArray modelArrayWithClass:GKNewModel.class json:object[self.categoryId]];
        if (datas) {
            [self.listData addObjectsFromArray:datas];
        }
        [self.tableView reloadData];
        [self endRefresh:datas.count >=RefreshPageSize];
    } failure:^(NSString * _Nonnull error) {
        [self endRefreshFailure];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GKNewModel *model = self.listData[indexPath.row];
    switch (model.states) {
        case GKNewsImgexType:
        {
            GKNewItemImageCell *cell =  [GKNewItemImageCell cellForTableView:tableView indexPath:indexPath];
            cell.model = self.listData[indexPath.row];
            return cell;
        }break;
        case GKNewsAdvertise:
        {
            GKNewItemAdCell *cell =  [GKNewItemAdCell cellForTableView:tableView indexPath:indexPath];
            cell.model = self.listData[indexPath.row];
            return cell;
        }break;
        case GKNewsImgextra:
        {
            GKNewItemTraCell *cell =  [GKNewItemTraCell cellForTableView:tableView indexPath:indexPath];
            cell.model = self.listData[indexPath.row];
            return cell;
        }break;
        default:
        {
            GKNewItemTableViewCell *cell =  [GKNewItemTableViewCell cellForTableView:tableView indexPath:indexPath];
            cell.model = self.listData[indexPath.row];
            return cell;
        }break;
    }
    UITableViewCell *cell =  [UITableViewCell cellForTableView:tableView indexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"UITableViewCell : %@",@(indexPath.row + 1)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GKNewModel *model = self.listData[indexPath.row];
    switch (model.states) {
        case GKNewsAdvertise:
        {
            [GKHomeNetManager apiPhotoSet:model.photosetID success:^(id  _Nonnull object) {
                GKNewPhotoModel *model = [GKNewPhotoModel modelWithJSON:object];
                ATBrowserController *vc = [ATBrowserController vcWithDatas:model.photos selectIndex:0];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            } failure:^(NSString * _Nonnull error) {
                [MBProgressHUD showMessage:error];
            }];
        }break;
        default:
        {
            GKNewDetailController *vc = [GKNewDetailController vcWithModel:model];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
    }
    NSLog(@"%@ %@",model.title,model.digest);
}
@end
