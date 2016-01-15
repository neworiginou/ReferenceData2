//
//  NotificationTableViewCell.h
//  Community
//
//  Created by gusheng on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NotificationTableViewCell;

@protocol NotificationTableViewCellDelegate <NSObject>

- (void)notifyCell:(NotificationTableViewCell *)cell switchValueChange:(BOOL)value;

@end

@interface NotificationTableViewCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UISwitch *selectBtn;
@property(nonatomic,strong)IBOutlet UILabel *tipONOrOffLabel;
@property (nonatomic, assign) id<NotificationTableViewCellDelegate> delegate;

-(void)addLine:(float)orignHeigt isHide:(BOOL)flag;
- (IBAction)toggleSwitch:(id)sender;


@end
