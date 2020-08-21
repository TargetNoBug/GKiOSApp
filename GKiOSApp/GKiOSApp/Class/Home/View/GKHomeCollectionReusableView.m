//
//  GKHomeCollectionReusableView.m
//  GKiOSApp
//
//  Created by wangws1990 on 2017/5/13.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import "GKHomeCollectionReusableView.h"

@implementation GKHomeCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.editorBtn.selected = NO;
    self.editorBtn.layer.masksToBounds = YES;
    self.editorBtn.layer.cornerRadius = 4;
    self.editorBtn.layer.borderWidth = 0.6;
    self.editorBtn.layer.borderColor = AppColor.CGColor;
    // Initialization code
}

@end
