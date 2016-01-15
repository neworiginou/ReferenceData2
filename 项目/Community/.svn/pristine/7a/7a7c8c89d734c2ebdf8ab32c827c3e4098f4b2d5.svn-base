//
//  HWKaolaPurseTableViewCell.m
//  Community
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWKaolaPurseTableViewCell.h"
#import "HWKaoLaCoinInfoModel.h"
@implementation HWKaolaPurseTableViewCell
@synthesize _descriptionLabel;

#define circleViewCenterX 28

- (void)awakeFromNib {
    // Initialization code
}
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
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(_descriptionLabel.frame) + 5, 150, 15)];
        _dateLabel.font = [UIFont fontWithName:FONTNAME size:12];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:_dateLabel];
        
        
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 115, (60 - 20)/2, 100, 20)];
        _moneyLabel.textAlignment = NSTextAlignmentRight;
        _moneyLabel.font = [UIFont fontWithName:FONTNAME size:18.0f];
        _moneyLabel.textColor = THEME_COLOR_ORANGE;
        [self.contentView addSubview:_moneyLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(25, 0, 0.5, 60)];
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

- (void)addaptWithDictionary:(HWKaoLaCoinInfoModel *)kaoLaCoinInfo
{
    if ([kaoLaCoinInfo.bussinessType isEqualToString:@"1"])
    {
        _descriptionLabel.text = @"考拉币充值";
    }
    else if([kaoLaCoinInfo.bussinessType isEqualToString:@"2"])
    {
        _descriptionLabel.text = @"无底线消费";
    }
    else if([kaoLaCoinInfo.bussinessType isEqualToString:@"3"])
    {
        _descriptionLabel.text = @"流标返还";
    }
    else if ([kaoLaCoinInfo.bussinessType isEqualToString:@"4"])
    {
        _descriptionLabel.text = @"游戏推广";
    }
    if([kaoLaCoinInfo.paymentTime length]!=0)
    {
        _dateLabel.text = [Utility DateToMDMSAndToday:[Utility getTimeWithTimestamp:kaoLaCoinInfo.paymentTime WithDateFormat:@"MM月dd日 HH:mm"]];
    }
    
    if ([kaoLaCoinInfo.flowDirection isEqualToString:@"1"])
    {
        _moneyLabel.textColor = THEME_COLOR_ORANGE;
        _moneyLabel.text = [NSString stringWithFormat:@"+ %@",kaoLaCoinInfo.flowMoney];
    }
    else
    {
        _moneyLabel.textColor = THEME_COLOR_TEXT;
        _moneyLabel.text = [NSString stringWithFormat:@"- %@",kaoLaCoinInfo.flowMoney];
        
    }
    
}

- (void)setTodayValue{
    _descriptionLabel.textColor = THEME_COLOR_ORANGE;
    _moneyLabel.textColor = THEME_COLOR_ORANGE;
    _circleView.frame = CGRectMake(19, 10, 20, 20);
    
    CGPoint center =  _circleView.center;
    center.x = circleViewCenterX;
    _circleView.center = center;
    
    _circleView.layer.cornerRadius = 10;
    _circleView.backgroundColor = THEME_COLOR_ORANGE;
    UIColor *colorTemp = UIColorFromRGB(0xc3e88b);
    _circleView.layer.borderColor = colorTemp.CGColor;
    _circleView.layer.borderWidth = 2;
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
