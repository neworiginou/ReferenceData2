//
//  SilverCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/3.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Silver;
@interface SilverCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *silverNum;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

+ (NSString *)cellID;

+ (SilverCell *)silverCellAtIndex:(NSInteger)index;

- (SilverCell *)cellWithSilver:(Silver*)silver;

@end
