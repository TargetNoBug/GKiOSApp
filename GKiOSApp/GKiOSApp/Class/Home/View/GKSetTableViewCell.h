//
//  GKSetTableViewCell.h
//  GKiOSApp
//
//  Created by wangws1990 on 2017/5/17.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKSetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

NS_ASSUME_NONNULL_END
