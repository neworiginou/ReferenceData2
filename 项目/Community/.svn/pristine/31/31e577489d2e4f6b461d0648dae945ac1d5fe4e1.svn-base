//
//  PersonInfoHeadView.m
//  Community
//
//  Created by gusheng on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPersonInfoHeadView.h"
#import "AppDelegate.h"

@implementation HWPersonInfoHeadView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if ([Utility isGuestLogin])
        {
            [self initViewForGuest];
        }
        else
        {
            [self initialView];
        }
    }
    return self;
}

- (void)initViewForGuest
{
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:self.bounds];
    backImgV.image = [UIImage imageNamed:@""];
    backImgV.backgroundColor = THEME_COLOR_ORANGE;
    [self addSubview:backImgV];
    
    DLable *titleLab = [DLable LabTxt:@"您还没有登录哦~" txtFont:TF15 txtColor:THEME_COLOR_White frameX:0 y:10 w:kScreenWidth h:40.0f];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    
    DButton *loginBtn = [DButton btnTxt:@"马上登录" txtFont:TF16 frameX:(kScreenWidth - 94) / 2.0f y:50.0f w:94 h:30 target:self action:@selector(loginBtnClick)];
    [loginBtn setRadius:3.5f];
    loginBtn.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.25];
    [self addSubview:loginBtn];
}

- (void)loginBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickLoginBtn)])
    {
        [self.delegate didClickLoginBtn];
    }
}

- (void)initialView
{
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:self.bounds];
    backImgV.image = [UIImage imageNamed:@""];
    backImgV.backgroundColor = THEME_COLOR_ORANGE;
    [self addSubview:backImgV];
    
    headPlaceHolderImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    headPlaceHolderImgV.layer.cornerRadius = 60 / 2.0f;
    headPlaceHolderImgV.layer.masksToBounds = YES;
    headPlaceHolderImgV.image = [UIImage imageNamed:@"个人中心－图标1"];
    headPlaceHolderImgV.center = CGPointMake(60 / 2.0f + 20, self.frame.size.height / 2.0f);
    [self addSubview:headPlaceHolderImgV];
    
    headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    headImgV.layer.cornerRadius = 56 / 2.0f;
    headImgV.layer.masksToBounds = YES;
    headImgV.center = headPlaceHolderImgV.center;
    [self addSubview:headImgV];
    
    UIImage *genderImg = [UIImage imageNamed:@"icon_personal-center_7"];
    genderPlaceHolderImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, genderImg.size.width, genderImg.size.height)];
    genderPlaceHolderImgV.center = CGPointMake(CGRectGetMaxX(headPlaceHolderImgV.frame) - 8, headPlaceHolderImgV.origin.y + 11);
    [self addSubview:genderPlaceHolderImgV];
    
    nicknameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headPlaceHolderImgV.frame) + 10,
                                                                     CGRectGetMidY(headPlaceHolderImgV.frame) - 20,
                                                                     self.frame.size.width - (CGRectGetMaxX(headPlaceHolderImgV.frame) + 30) - 15,
                                                                     18)];
    nicknameLab.backgroundColor = [UIColor clearColor];
    nicknameLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    nicknameLab.textColor = [UIColor whiteColor];
    [self addSubview:nicknameLab];

//    UIImage *villageImg = [UIImage imageNamed:@"icon_16_08"];
//    villageImgV = [[UIImageView alloc] initWithFrame:CGRectMake(nicknameLab.origin.x, CGRectGetMaxY(nicknameLab.frame) + 7, villageImg.size.width, villageImg.size.height)];
//    villageImgV.image = villageImg;
//    [self addSubview:villageImgV];
    
    villageLabel = [[UILabel alloc] initWithFrame:CGRectMake(nicknameLab.origin.x, CGRectGetMaxY(nicknameLab.frame) + 7, nicknameLab.frame.size.width, 15)];
    villageLabel.backgroundColor = [UIColor clearColor];
    villageLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    villageLabel.textColor = [UIColor whiteColor];
    [self addSubview:villageLabel];
    
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.frame = self.bounds;
    [coverBtn addTarget:self action:@selector(clickPersonView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:coverBtn];
    
    [self refreshPersonInfo];
}

- (void)setHeadCenterY:(CGFloat)centerY
{
    headPlaceHolderImgV.center = CGPointMake(headPlaceHolderImgV.center.x, centerY);
    headImgV.center = CGPointMake(headImgV.center.x, centerY);
    nicknameLab.center = CGPointMake(nicknameLab.center.x, centerY - nicknameLab.frame.size.height / 2 - 3);
    genderPlaceHolderImgV.center = CGPointMake(CGRectGetMaxX(headPlaceHolderImgV.frame) - 8, headPlaceHolderImgV.origin.y + 11);
//    villageImgV.frame = CGRectMake(nicknameLab.origin.x, CGRectGetMaxY(nicknameLab.frame) + 7, villageImgV.size.width, villageImgV.size.height);
    villageLabel.frame = CGRectMake(nicknameLab.origin.x, CGRectGetMaxY(nicknameLab.frame) + 7, nicknameLab.frame.size.width, 15);
}

- (void)refreshPersonInfo
{
    HWUserLogin *userLogin = [HWUserLogin currentUserLogin];
    
    __weak UIImageView *weakHeadImgV = headImgV;
    
    [headImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:userLogin.avatar]] placeholderImage:[UIImage imageNamed:@"head_placeholder"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error)
        {
            weakHeadImgV.image = [UIImage imageNamed:@"head_placeholder"];
        }
        else
        {
            weakHeadImgV.image = image;
        }
    }];
    
    if ([userLogin.gender isEqual:@"1"])
    {
        genderPlaceHolderImgV.image = [UIImage imageNamed:@"icon_personal-center_8"];
    }
    else if ([userLogin.gender isEqual:@"2"])
    {
        genderPlaceHolderImgV.image = [UIImage imageNamed:@"icon_personal-center_7"];
    }
    else
    {
        genderPlaceHolderImgV.image = nil;
    }
    
    nicknameLab.text = userLogin.nickname;
    villageLabel.text = userLogin.villageName;

}

/**
 *	@brief	编辑头像
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)clickPersonView:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickEditHead)])
    {
        [delegate didClickEditHead];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
