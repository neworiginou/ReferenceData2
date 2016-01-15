//
//  PersonInfoTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@interface PersonInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@end

@implementation PersonInfoTableViewCell

- (id)init
{
    id object = loadObjectFromNib(@"PersonInfoTableViewCell", [PersonInfoTableViewCell class], self);
    if (object)
    {
        self = (PersonInfoTableViewCell *)object;
    }
    else
    {
        self = [self init];
    }
    self.backgroundColor = THEME_COLOR_CELLCOLOR;
    self.frame = CGRectMake(0, 0, kScreenWidth, 50);
    self.arrowImage.frame = CGRectMake(CGRectGetWidth(self.frame) - 10 -7, (CGRectGetHeight(self.frame) - 8)/2, 5, 5);
    return self;
}

-(void)addLine:(float)orignHeigt isHide:(BOOL)flag
{
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, orignHeigt, kScreenWidth, 0.5)];
    lineView.backgroundColor = THEME_COLOR_LINE;
    lineView.hidden = flag;
    [self addSubview:lineView];
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
