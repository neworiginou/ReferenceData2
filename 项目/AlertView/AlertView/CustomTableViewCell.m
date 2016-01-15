//
//  CustomTableViewCell.m
//  AlertView
//
//  Created by lizhongqiang on 15/7/7.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "CustomTableViewCell.h"

#define kSpaceY (1.8f)

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textColor = [UIColor colorWithRed:159/255.f green:160/255.f blue:161/255.f alpha:1.0];
        
        _titleLabel.font = [UIFont systemFontOfSize:12.5];
        
        [self.contentView addSubview:_titleLabel];
//-------------------------------------------
        _descLabel = [[UILabel alloc]init];
        
        _descLabel.textColor = [UIColor blackColor];
        
        _descLabel.font = [UIFont systemFontOfSize:13.8];
        
        [self.contentView addSubview:_descLabel];
        
    }
    return self;
}
- (void)setSpaceX:(CGFloat)spaceX
{
    _spaceX = spaceX;
    
    _titleLabel.frame = CGRectMake(spaceX, kSpaceY, 155/2.f, 64/2.f);
    
    _descLabel.frame = CGRectMake(spaceX + _titleLabel.frame.size.width + 35/2.f, kSpaceY - 2.f, 120, _titleLabel.frame.size.height);
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
