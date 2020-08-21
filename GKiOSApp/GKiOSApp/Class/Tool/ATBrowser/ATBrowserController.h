//
//  BrowserController.h
//  GKiOSApp
//
//  Created by wangws1990 on 2017/5/23.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATBrowserModel.h"
#import "ATBrowserProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ATBrowserController : BaseViewController

+ (instancetype)vcWithDatas:(NSArray *)listData selectIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
