//
//  HWLocationTableViewCell.m
//  Community
//
//  Created by gusheng on 14-9-13.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWLocationTableViewCell.h"

#define MARGIN_LEFT 15
#define MARGIN_TOP  15
#define CELL_HEIGHT 70

@implementation HWLocationTableViewCell
@synthesize titleLab;
@synthesize subTitleLab;
@synthesize distanceLab;
@synthesize selectBtn;
@synthesize locationImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, kScreenWidth - 100.0f, 20)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.font = [UIFont systemFontOfSize:15.0f];
        titleLab.textColor = UIColorFromRGB(0x333333);
        [self.contentView addSubview:titleLab];
        
        subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT+13, CGRectGetMaxY(titleLab.frame), kScreenWidth - 100.0f, 20)];
        subTitleLab.backgroundColor = [UIColor clearColor];
        subTitleLab.font = [UIFont systemFontOfSize:13.0f];
        subTitleLab.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:subTitleLab];
        
        
        locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MARGIN_LEFT, CGRectGetMaxY(titleLab.frame)+6, 8, 10)];
        locationImageView.image = [UIImage imageNamed:@"周边小区－图标1"];
        locationImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:locationImageView];
        
        distanceLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 85, (CELL_HEIGHT - 20) / 2.0f+5, 55, 20)];
        distanceLab.textColor = THEME_COLOR_TEXT;
        distanceLab.font = [UIFont systemFontOfSize:13.0f];
        distanceLab.backgroundColor = [UIColor clearColor];
        distanceLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:distanceLab];
        
        selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.backgroundColor = [UIColor clearColor];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"周边小区－图标2"] forState:UIControlStateNormal];
        selectBtn.frame = CGRectMake(CGRectGetMaxX(distanceLab.frame) + 5, (CELL_HEIGHT - 24) / 2.0f+8, 10, 10);
        [selectBtn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
    }
    
    return self;
}

- (void)doSelect:(id)sender
{
//    if (delegate && [delegate respondsToSelector:@selector(communityCell:didSelectItem:)])
//    {
//        if (![selectBtn imageForState:UIControlStateNormal])
//        {
//            [selectBtn setImage:[UIImage imageNamed:@"persionCheck"] forState:UIControlStateNormal];
//            [delegate communityCell:self didSelectItem:YES];
//        }
//        else
//        {
//            [selectBtn setImage:nil forState:UIControlStateNormal];
//            [delegate communityCell:self didSelectItem:NO];
//        }
//    }
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
