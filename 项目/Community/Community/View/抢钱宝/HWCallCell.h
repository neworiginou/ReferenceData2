//
//  HWCallCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWCallCellDelegate <NSObject>

- (void)didClickCallButton;

@end


@interface HWCallCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLab;
@property (nonatomic, strong)UIButton *callBtn;
@property (nonatomic, assign)id <HWCallCellDelegate> delegate;

@end
