//
//  InformationView.m
//  PUClient
//
//  Created by RRLhy on 15/7/30.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "InformationView.h"
#import "RRMJTool.h"
@implementation InformationView
{
    UIImageView * backImage;
    UserHeaderView * iconImg;
    UILabel * nickLab;
    UILabel * comfirmInfoLabel;
    UILabel * seriesLabel;
    
    UILabel * loginLabel;
    UILabel * rrmjLabel;
    
    UIImageView * levelImage;
    UIImageView * sexImage;
    NSArray * colorArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backImage];
        [self settingColor];
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login)];
        iconImg = [[UserHeaderView alloc]initWithFrame:CGRectMake((WIDTH(self) - 80)/2, 64, 80, 80)];
        iconImg.type = User_Vip;
        [self addSubview:iconImg];
        [iconImg addGestureRecognizer:gesture];
        
        nickLab = [[UILabel alloc]initWithFrame:CGRectMake(0, MaxY(iconImg)+3, frame.size.width, 20)];
        nickLab.font = SYSTEMFONT(17);
        nickLab.text = @"伦敦的雨淋湿巴黎";
        nickLab.textAlignment = NSTextAlignmentCenter;
        nickLab.textColor = [UIColor whiteColor];
        [self addSubview:nickLab];
        
        comfirmInfoLabel = [[UILabel alloc]init];
        comfirmInfoLabel.font = SYSTEMFONT(12);
        comfirmInfoLabel.text = @"字幕组翻译大大";
        comfirmInfoLabel.textAlignment = NSTextAlignmentCenter;
        comfirmInfoLabel.textColor = [UIColor whiteColor];
        [self addSubview:comfirmInfoLabel];
        
        seriesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT(self) - 25, frame.size.width, 20)];
        seriesLabel.font = SYSTEMFONT(12);
        seriesLabel.text = @"翻译剧集  《破产姐妹》《纸牌屋》《绿箭侠》";
        seriesLabel.textColor = [UIColor whiteColor];
        seriesLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:seriesLabel];
        
        levelImage = [[UIImageView alloc]init];
        [self addSubview:levelImage];
        
        sexImage = [[UIImageView alloc]init];
        [self addSubview:sexImage];
        
        loginLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MaxY(iconImg) + 10, frame.size.width, 18)];
        loginLabel.font = SYSTEMFONT(18);
        loginLabel.text = @"立即登陆";
        loginLabel.textAlignment = NSTextAlignmentCenter;
        loginLabel.textColor = [UIColor whiteColor];
        [self addSubview:loginLabel];
        
        rrmjLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MaxY(loginLabel) + 10, frame.size.width, 16)];
        rrmjLabel.font = SYSTEMFONT(14);
        rrmjLabel.text = @"中国最大的美剧社区";
        rrmjLabel.textAlignment = NSTextAlignmentCenter;
        rrmjLabel.textColor = [UIColor whiteColor];
        [self addSubview:rrmjLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor) name:@"changeColor" object:nil];
        
    }
    return self;
}

- (void)changeColor
{
    [self settingColor];
}

- (void)settingColor
{
    colorArray = @[RGBCOLOR(0.020, 0.745, 1.000),
                   RGBCOLOR(0.133, 0.133, 0.133),
                   RGBCOLOR(0.941, 0.188, 0.506),
                   RGBCOLOR(0.624, 0.377, 0.753),
                   RGBCOLOR(0.314, 0.153, 0.643),
                   RGBCOLOR(0.149, 0.416, 0.620),
                   RGBCOLOR(0.373, 0.620, 0.627),
                   RGBCOLOR(0.180, 0.522, 0.373),
                   RGBCOLOR(0.467, 0.584, 0.341),
                   RGBCOLOR(0.576, 0.424, 0.353),
                   RGBCOLOR(0.659, 0.580, 0.427),
                   RGBCOLOR(0.573, 0.565, 0.545)];
    NSInteger index = [[[NSUserDefaults standardUserDefaults] objectForKey:ColorIndex] integerValue];
    backImage.backgroundColor = colorArray[index];
}

- (void)reloadinformation:(RrmjUser *)user
{
    iconImg.userUrl = user.headImgUrl;
    iconImg.type = User_General;
    [nickLab setText:user.nickName];
    [comfirmInfoLabel setText:@"一级菜鸟"];

    float width = [@"一级菜鸟" widthWithFont:SYSTEMFONT(12) height:12];
    float space = (Main_Screen_Width - width - 33 - 6)/2;
    comfirmInfoLabel.frame = CGRectMake(space, MaxY(nickLab) + 5, width, 12);
    
    levelImage.frame = CGRectMake(MaxX(comfirmInfoLabel) + 2, Y(comfirmInfoLabel), 24, 11);
    sexImage.frame = CGRectMake(MaxX(levelImage) + 4, Y(comfirmInfoLabel), 9, 10);
    
    if (user.token) {
        
        loginLabel.hidden = YES;
        rrmjLabel.hidden = YES;
        levelImage.image = [RRMJTool levelImageWith:user.level];
        sexImage.image = [RRMJTool sexImageWith:user.sex];
        
        if (user.sign.length > 0) {
            [seriesLabel setText:user.sign];
        }else{
            [seriesLabel setText:@"无个性，NO签名"];
        }
        
    }else{
        
        loginLabel.hidden = NO;
        rrmjLabel.hidden = NO;
        levelImage.image = nil;
        sexImage.image = nil;
        seriesLabel.text = nil;
        comfirmInfoLabel.text = nil;
    }
}

- (void)login
{
    if ([UserInfoConfig sharedUserInfoConfig].userInfo.token) {
        
        
        
    }else{
        
        [self.controller performSegueWithIdentifier:@"login" sender:self];
    }
}

@end
