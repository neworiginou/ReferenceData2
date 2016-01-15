//
//  PurseTableViewCell.m
//  HaoWu_4.0
//
//  Created by zhangxun on 14-5-24.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "PurseTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#define circleViewCenterX 28

@implementation PurseTableViewCell
@synthesize _descriptionLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 14, 150, 15)];
        _descriptionLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.font = [UIFont fontWithName:FONTNAME size:14];
        [self.contentView addSubview:_descriptionLabel];
        
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(53, CGRectGetMaxY(_descriptionLabel.frame) + 5, 150, 15)];
        _dateLabel.font = [UIFont fontWithName:FONTNAME size:12];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:_dateLabel];
        
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 115, (60 - 20)/2, 100, 20)];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = [UIFont fontWithName:FONTNAME size:18.0f];
        _moneyLabel.textColor = THEME_COLOR_MONEY;
        [self.contentView addSubview:_moneyLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 59.5, kScreenWidth - 15, 0.5)];
        _lineView.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:_lineView];
        
        _circleView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, 10, 10)];
        _circleView.layer.cornerRadius  = 5;
        _circleView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_circleView];
        
        UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(55, 61.5, kScreenWidth - 55 - 15, 0.5)];
        sepView.backgroundColor = UIColorFromRGB(0xd5d5d5);
        sepView.alpha = 0.5;
        [self.contentView addSubview:sepView];
        
        
    }
    return self;
}

- (void)addaptWithDictionary:(NSDictionary *)dictionary{
    _descriptionLabel.text = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"type"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    if ([[formatter stringFromDate:[NSDate date]] isEqualToString:[dictionary stringObjectForKey:@"date"]]) {
        _dateLabel.text = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"time"]];
    }else{
        _dateLabel.text = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"date"]];
    }
    
    NSString *direct = [NSString stringWithFormat:@"%@",[dictionary stringObjectForKey:@"direct"]];
    if ([direct isEqualToString:@"in"])
    {
        _moneyLabel.textColor = THEME_COLOR_MONEY;
        _moneyLabel.text = [NSString stringWithFormat:@"+ %@",[dictionary stringObjectForKey:@"money"]];
        
    }
    else
    {
        _moneyLabel.textColor = THEME_COLOR_TEXT;
        _moneyLabel.text = [NSString stringWithFormat:@"- %@",[dictionary stringObjectForKey:@"money"]];
        
    }
    
}

//- (void)setTodayValue{
//    _descriptionLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:46.0/255.0 blue:0 alpha:1];
//    _moneyLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:46.0/255.0 blue:0 alpha:1];
//}

- (void)setTodayValue{
    _descriptionLabel.textColor = THEME_COLOR_MONEY;
    _moneyLabel.textColor = THEME_COLOR_MONEY;
    _circleView.frame = CGRectMake(19, 10, 20, 20);
    
    CGPoint center =  _circleView.center;
    center.x = circleViewCenterX;
    _circleView.center = center;
    
    _circleView.layer.cornerRadius = 10;
    _circleView.backgroundColor = THEME_COLOR_MONEY;
    UIColor *colorTemp = UIColorFromRGB(0xfdb27f);
    _circleView.layer.borderColor = colorTemp.CGColor;
    _circleView.layer.borderWidth = 2;
//    _circleView.hidden = YES;
}
- (void)setFirstLine{
    _lineView.frame = CGRectMake(circleViewCenterX, _circleView.frame.origin.y + 20, 1, 42); 
}

- (void)setFinalLine{
    _lineView.frame = CGRectMake(circleViewCenterX, 0, 1, 17);
}

- (void)setNormalLine{
    _dateLabel.textColor = [UIColor grayColor];
    _moneyLabel.textColor = [UIColor grayColor];
    _lineView.frame = CGRectMake(circleViewCenterX, 0, 1, 64);
    _circleView.frame = CGRectMake(20, 15, 10, 10);
    CGPoint center =  _circleView.center;
    center.x = circleViewCenterX;
    _circleView.center = center;
    _circleView.layer.cornerRadius  = 5;
    _circleView.layer.borderWidth = 0;
    _circleView.backgroundColor = THEME_COLOR_LINE;
    
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
