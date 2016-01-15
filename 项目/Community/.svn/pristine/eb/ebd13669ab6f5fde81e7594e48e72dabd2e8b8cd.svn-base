//
//  HWCommunityCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCommunityCell.h"

#define MARGIN_LEFT 15
#define MARGIN_TOP  15
#define CELL_HEIGHT 70

@implementation HWCommunityCell
@synthesize titleLab;
@synthesize subTitleLab;
@synthesize distanceLab;
@synthesize selectBtn;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, kScreenWidth - 100.0f, 20)];
        titleLab.backgroundColor = [UIColor clearColor];
        titleLab.font = [UIFont systemFontOfSize:15.0];
        titleLab.textColor = UIColorFromRGB(0x333333);
        [self.contentView addSubview:titleLab];
        
        subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, CGRectGetMaxY(titleLab.frame), kScreenWidth - 100.0f, 20)];
        subTitleLab.backgroundColor = [UIColor clearColor];
        subTitleLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
        subTitleLab.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:subTitleLab];
        
        distanceLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100, (CELL_HEIGHT - 20) / 2.0f, 55, 20)];
        distanceLab.textColor = THEME_COLOR_TEXT;
        distanceLab.font = [UIFont fontWithName:FONTNAME size:14.0f];
        distanceLab.backgroundColor = [UIColor clearColor];
        distanceLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:distanceLab];
        
        selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.backgroundColor = [UIColor clearColor];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"persionuncheck"] forState:UIControlStateNormal];
        selectBtn.frame = CGRectMake(CGRectGetMaxX(distanceLab.frame) + 5, (CELL_HEIGHT - 24) / 2.0f, 24, 24);
//        [selectBtn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectBtn];
        
        selectBtn.userInteractionEnabled = NO;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, kScreenWidth, CELL_HEIGHT);
        [btn addTarget:self action:@selector(doSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CELL_HEIGHT - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
    }
    
    return self;
}


- (void)doSelect:(id)sender
{
    BOOL flag;
    if (![selectBtn imageForState:UIControlStateNormal])
        {
            [selectBtn setImage:[UIImage imageNamed:@"actived_checkbox"] forState:UIControlStateNormal];
            flag = YES;
        }
        else
        {
            [selectBtn setImage:nil forState:UIControlStateNormal];
            flag = NO;
        }

    if (_selecCommunity) {
        _selecCommunity(flag);
    }
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
