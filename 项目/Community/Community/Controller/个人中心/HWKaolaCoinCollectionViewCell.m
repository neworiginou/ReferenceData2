//
//  HWKaolaCoinCollectionViewCell.m
//  TestOne
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWKaolaCoinCollectionViewCell.h"

@implementation HWKaolaCoinCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = CGRectMake(0, 0, (kScreenWidth-4*30)/3, 100);
        UIImageView *bgImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BookShelfCell"]];
        bgImageView.frame = CGRectMake(0, 0,(kScreenWidth-4*30)/3,100);
        [self.contentView addSubview:bgImageView];
        
        self.collectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, (kScreenWidth-4*30)/3, (kScreenWidth-4*30)/3)];
        self.collectImageView.layer.cornerRadius = (kScreenWidth-4*30)/3/2.0;
        self.collectImageView.layer.masksToBounds = YES;
        self.collectImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.collectImageView];
        
        self.collectContent = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectImageView.frame)+15, (kScreenWidth-4*30)/3,15)];
        self.collectContent.textColor = THEME_COLOR_MONEY;
        self.collectContent.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.collectContent];
    }
    return self;
}

@end
