//
//  CalculatorTableViewCell.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/4/7.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "CalculatorTableViewCell.h"

@implementation CalculatorTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
       if (self)
    {
        self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(80, 0, 80, 40)];
        self.textFiled.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        [self addSubview:self.textFiled];
       
       
    }
     return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
