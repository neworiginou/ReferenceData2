//
//  HWDetailYouhuiCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-22.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMoreButtonCell.h"

#define MARGIN_LEFT 15
#define MARGIN_TOP 10
#define IMAGE_WIDTH 50 
#define IMAGE_HEIGHT 50
#define GAP 15

@implementation HWMoreButtonCell
@synthesize moreBtn,delegate,titleLabel,arrowImgV;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"bg_cheng" ofType:@"jpg"];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, 30)];
        titleLabel.backgroundColor = UIColorFromRGB(0xebebeb);
        titleLabel.font = [UIFont fontWithName:FONTNAME size:14.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        
        arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        arrowImgV.center = CGPointMake(CGRectGetMidX(titleLabel.frame) + 45, CGRectGetMidY(titleLabel.frame));
        [self.contentView addSubview:arrowImgV];
        
        
        moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [moreBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
//        [moreBtn setTitle:@"更多户型" forState:UIControlStateNormal];
//        [moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        moreBtn.frame = CGRectMake(15, 14, kScreenWidth - 30, 52);
        [moreBtn addTarget:self action:@selector(doMore:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBtn];
    }
    return self;
}

- (void)doMore:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickMoreButton)]) {
        [delegate didClickMoreButton];
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
