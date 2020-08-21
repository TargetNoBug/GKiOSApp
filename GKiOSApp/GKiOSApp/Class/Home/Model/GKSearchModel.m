//
//  GKSearchModel.m
//  GKiOSApp
//
//  Created by wangws1990 on 2017/5/15.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import "GKSearchModel.h"

@implementation GKSearchModel
+ (instancetype)vcWithUserId:(NSString *)userId searchKey:(NSString *)searchKey state:(GKSearchState)state{
    GKSearchModel *vc = [[[self class] alloc] init];
    vc.userId = userId;
    vc.searchKey = searchKey;
    vc.searchState = state;
    return vc;
}
@end

@implementation GKSearchResultModel

@end


