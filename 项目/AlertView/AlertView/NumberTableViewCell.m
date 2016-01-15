//
//  NumberTableViewCell.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "NumberTableViewCell.h"

@implementation NumberTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _numberLabel = [[UILabel alloc]init];
        
        _moneyLabel = [[UILabel alloc]init];
        
        _timeLabel = [[UILabel alloc]init];
        
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        _numberLabel.font = [UIFont systemFontOfSize:12.8];
        
        _moneyLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _numberLabel.textColor = [UIColor colorWithRed:161/255.f green:162/255.f blue:163/255.f alpha:1.0];
        
        _moneyLabel.textColor = [UIColor blackColor];
        
        _timeLabel.textColor = _numberLabel.textColor;
        
        [self.contentView addSubview:_numberLabel];
        
        [self.contentView addSubview:_moneyLabel];
        
        [self.contentView addSubview:_timeLabel];
//        
//        _numberLabel.backgroundColor = [UIColor redColor];
//        
//        _moneyLabel.backgroundColor = [UIColor blueColor];
//        
//        _timeLabel.backgroundColor = [UIColor purpleColor];
    }
    return self;
}
- (void)setSpaceX:(CGFloat)spaceX
{
    _spaceX = spaceX;
    
    CGFloat x = spaceX;
    
    _numberLabel.frame = CGRectMake(x, 0, 162/2.f, 15);
    
    x += _numberLabel.frame.size.width;
    
    _moneyLabel.frame = CGRectMake(x, 0, 205/2.f, _numberLabel.frame.size.height);
    
    x += _moneyLabel.frame.size.width;
    
    _timeLabel.frame = CGRectMake(x, 0, 224/2.f, _numberLabel.frame.size.height);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
