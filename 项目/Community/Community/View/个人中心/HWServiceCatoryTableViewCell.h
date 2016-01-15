//
//  HWServiceCatoryTableViewCell.h
//  Community
//
//  Created by gusheng on 14-9-15.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWServiceCatoryTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UIImageView *avatarImageView;
-(void)addLine:(float)orignHeigt isHide:(BOOL)flag;
@end
