//
//  HWGeneralTableViewCell.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/31.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWGeneralTableViewCell.h"

@implementation HWGeneralTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 39.5, kScreenWidth - 10, 0.5)];
        [ self.lineImage setBackgroundColor:UIColorFromRGB(0xbfbfbf)];
        [self addSubview: self.lineImage];
        
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 9, 14, 11)];
        self.imgV.image = [UIImage imageNamed:@"gou"];
        self.accessoryView = self.imgV;
        

    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
  }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
