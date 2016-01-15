//
//  HWServerTypeCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-5.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServerTypeCell.h"

@implementation HWServerTypeCell
{
    UIButton *btnImage;                     //按钮大图
  
    UILabel *labelName;                     //问题名字
    UIImageView *typeImage;                 //问题图片
}

@synthesize section;
@synthesize row;
@synthesize baseService;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        typeImage.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:typeImage];
        
        labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 60, 21)];
        [labelName setBackgroundColor:[UIColor clearColor]];
        [labelName setTextColor:THEME_COLOR_SMOKE];
        [labelName setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [labelName setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:labelName];
        
    }
    return self;
}


- (void)setBaseService:(HWServiceBaseDataClass *)base
{
    baseService = base;
    labelName.text = baseService.dictCodeText;
    NSString *strUrl = [Utility imageDownloadUrl:base.iconMongodbUrl];
    __weak UIImageView *imgBlock = typeImage;
    [typeImage setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"other"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            imgBlock.image = [UIImage imageNamed:@"other"];
        }
        else
        {
            imgBlock.image = image;
        }
    }];
}


@end
