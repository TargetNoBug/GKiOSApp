//
//  GKNewItemAdCell.h
//  GKiOSApp
//
//  Created by wangws1990 on 2019/5/23.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "GKNewItemBaseCell.h"
#import "SDCycleScrollView.h"
#import "GKVideoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GKNewItemAdCell : GKNewItemBaseCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) SDCycleScrollView *carouselView;
@end

@interface GKVideoHotCell : GKNewItemAdCell
@property (strong, nonatomic) GKVideoHotModel *hotModel;
@end

NS_ASSUME_NONNULL_END
