//
//  HWDoubleLabelCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-29.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDoubleLabelCell : UITableViewCell

@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *rightLabel;

- (void)frameToFit;



@end
