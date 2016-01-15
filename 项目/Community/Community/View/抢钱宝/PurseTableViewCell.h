//
//  PurseTableViewCell.h
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurseTableViewCell : UITableViewCell
{
    UILabel *_descriptionLabel;
    UILabel *_dateLabel;
    UILabel *_moneyLabel;
    
    UIView *_lineView;
    UIView *_circleView;
}
- (void)addaptWithDictionary:(NSDictionary *)dictionary;
- (void)setTodayValue;
- (void)setFirstLine;
- (void)setFinalLine;
- (void)setNormalLine;
@property(nonatomic,strong)UILabel *_descriptionLabel;
@end
