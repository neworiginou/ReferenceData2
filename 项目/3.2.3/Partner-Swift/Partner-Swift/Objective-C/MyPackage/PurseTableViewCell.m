//
//  PurseTableViewCell.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "PurseTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Define-OC.h"
#import "Partner_Swift-Swift.h"

@implementation PurseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 14, 150, 15)];
        _dateLabel.font = [UIFont fontWithName:FONTNAME size:12];
        _dateLabel.backgroundColor = [UIColor clearColor];
//        _dateLabel.textColor = [UIColor redColor];
        _dateLabel.textColor = TITLE_COLOR_99;
//        _dateLabel.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:_dateLabel];
        
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, CGRectGetMaxY(_dateLabel.frame) + 5, 150, 15)];
        _descriptionLabel.textColor = TITLE_COLOR_33;
//        _descriptionLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.font = [UIFont fontWithName:FONTNAME size:14];
        [self.contentView addSubview:_descriptionLabel];
        
//        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, (60 - 20)/2, 100, 20)];
//        _moneyLabel.textAlignment = NSTextAlignmentRight;
//        _moneyLabel.font = [UIFont fontWithName:FONTNAME size:20.0f];
        //MYP add v3.2修改UI
        _moneyLabel = [UILabel newAutoLayoutView];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = [UIFont fontWithName:FONTNAME size:20.0f];
        [self.contentView addSubview:_moneyLabel];
        [_moneyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView];
        [_moneyLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView];
        [_moneyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-15];
        [_moneyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_dateLabel withOffset:15];
        
//        _moneyLabel.textColor = THEME_COLOR_ORANGE;
        [self.contentView addSubview:_moneyLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59.5, kScreenWidth - 15, 0.5)];
        _lineView.backgroundColor = CD_LineColor;
        [self.contentView addSubview:_lineView];
    }
    return self;
}

- (void)addaptWithDictionary:(NSDictionary *)dictionary
{
    _descriptionLabel.text = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"type"]];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy"];
//    if ([[formatter stringFromDate:[NSDate date]] isEqualToString:[dictionary stringObjectForKey:@"date"]]) {
//        _dateLabel.text = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"time"]];
//    }else{
//        _dateLabel.text = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"date"]];
//    }
    
    _dateLabel.text = [NSString stringWithFormat:@"%@年%@",[dictionary stringObjectForKey:@"date"],[dictionary stringObjectForKey:@"time"]];
    
    NSString *direct = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"direct"]];
    if ([direct isEqualToString:@"in"])
    {
//        _moneyLabel.textColor = THEME_COLOR_ORANGE;
        _moneyLabel.textColor = [UIColor orangeColor];
        _moneyLabel.text = [NSString stringWithFormat:@"+ %@",[Utility conversionThousandth:[dictionary stringObjectForKey:@"money"]]];
        
    }
    else
    {
//        _moneyLabel.textColor = THEME_COLOR_TEXT;
        _moneyLabel.textColor = TITLE_COLOR_66;
        _moneyLabel.text = [NSString stringWithFormat:@"- %@",[Utility conversionThousandth:[dictionary stringObjectForKey:@"money"]]];
        
    }
    
}

- (void)setTodayValue{
    _descriptionLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:46.0/255.0 blue:0 alpha:1];
    _moneyLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:46.0/255.0 blue:0 alpha:1];
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
