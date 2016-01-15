//
//  HWPropertyServerCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-2.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPropertyServerCell.h"
#import "HWServiceBaseDataClass.h"

@implementation HWPropertyServerCell
@synthesize imgPhoto;
@synthesize labTitle;
@synthesize proService;
@synthesize bigBtn;
@synthesize indexPath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        imgPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 66, 66)];
//        [imgPhoto setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:imgPhoto];
        
        labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 90, 20)];
        [labTitle setBackgroundColor:[UIColor clearColor]];
        [labTitle setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [labTitle setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:labTitle];
        
        bigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bigBtn.backgroundColor = [UIColor clearColor];
//        bigBtn.showsTouchWhenHighlighted = YES;
        bigBtn.frame = CGRectMake(10, 0, 66, 66);
        [self.contentView addSubview:bigBtn];
    }
    return self;
}


-(void)setProService:(HWPropertyServiceClass *)pro
{
    proService = pro;
    labTitle.text = proService.serviceName;
    
    HWServiceData *service = [HWServiceData getServiceData];

    NSString *strIconMongodbUrl;
    for (int i = 0; i < service.arrServiceBase.count; i ++)
    {
        HWServiceBaseDataClass *base = service.arrServiceBase[i];
        if ([proService.serviceId isEqualToString:base.dictId])
        {
            strIconMongodbUrl = base.iconMongodbUrl;
            break;
        }
    }
    NSString *strImageName;
    if ([proService.serviceId isEqualToString:@"301"])
    {
        strImageName = @"order";
    }
    else if ([proService.serviceId isEqualToString:@"302"])
    {
        strImageName = @"rents";
    }
    else if ([proService.serviceId isEqualToString:@"303"])
    {
        strImageName = @"word";
    }
    
    [bigBtn setBackgroundImage:[UIImage imageNamed:strImageName] forState:UIControlStateNormal];
    
//    NSString *strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,strIconMongodbUrl,[HWUserLogin currentUserLogin].key];
//    
//    __weak UIButton *blockBtn = bigBtn;
//    [bigBtn.imageView setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:strImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        if (!error) {
//            [blockBtn setBackgroundImage:image forState:UIControlStateNormal];
//        }
//        else
//        {
//            [blockBtn setBackgroundImage:[UIImage imageNamed:strImageName] forState:UIControlStateNormal];
//        }
//    }];
    
//    __weak UIImageView *blockImage = imgPhoto;
//    [imgPhoto setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:strImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        if (!error) {
//            blockImage.image = image;
//        }
//    }];
    
}


@end
