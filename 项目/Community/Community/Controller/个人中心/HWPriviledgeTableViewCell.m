//
//  HWPriviledgeTableViewCell.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWPriviledgeTableViewCell.h"
#import "HWGeneralControl.h"

#define kPriviledgeLeft 10
#define kPriviledgeTop 10

@implementation HWPriviledgeTableViewCell
@synthesize hourLabel;
@synthesize minitueLabel;
@synthesize secondLabel;
@synthesize activityTimeIV;
@synthesize getPriviledgeIV;
@synthesize getPrivilegedBtn;
@synthesize priviledgeIV;
@synthesize everyPriviledgeModel;
@synthesize delegate;
@synthesize line;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = BACKGROUND_COLOR;
        
        UIImageView *backgroundIV = [HWGeneralControl createImageView:CGRectMake(0, 0, kScreenWidth, 190 * kScreenRate) image:@""];
        UIImage *image = [UIImage imageNamed:@"sawtooth"];
        backgroundIV.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 5, 10)];
        backgroundIV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:backgroundIV];
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, [HWPriviledgeTableViewCell getCellHeight] - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
        
        float width = kScreenWidth - 2 * kPriviledgeLeft;
        priviledgeIV = [HWGeneralControl createImageView:CGRectMake(kPriviledgeLeft,
                                                                    kPriviledgeTop,
                                                                    width,
                                                                    130 * kScreenRate) image:@""];
        [self addSubview:priviledgeIV];
        priviledgeIV.backgroundColor = [UIColor clearColor];
        //创建活动倒计时View
        [self createActivityTime:priviledgeIV];
        [self getPriviledgeView:priviledgeIV];
    }
    return self;
}

//创建活动倒计时的view
- (void)createActivityTime:(UIImageView *)priviledgeIVTemp
{
    activityTimeIV = [HWGeneralControl createView:CGRectMake(CGRectGetMinX(priviledgeIVTemp.frame),
                                                             CGRectGetMaxY(priviledgeIVTemp.frame),
                                                             CGRectGetWidth(priviledgeIVTemp.frame),
                                                             190 * kScreenRate - CGRectGetMaxY(priviledgeIVTemp.frame))];
    activityTimeIV.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:activityTimeIV];
    
    UIImageView *timeTipIV = [HWGeneralControl createImageView:CGRectMake(0.2 * kScreenWidth, (CGRectGetHeight(activityTimeIV.frame) - 16) / 2.0f, 16, 16) image:@"countdown_green"];
    [activityTimeIV addSubview: timeTipIV];
    timeTipIV.backgroundColor = [UIColor clearColor];
    
    UILabel *timeTipLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(timeTipIV.frame) + 5,
                                                                     (CGRectGetHeight(activityTimeIV.frame) - 16) / 2.0f,
                                                                     83,
                                                                     16)
                                                     font:THEME_FONT_SMALL13
                                             textAligment:NSTextAlignmentLeft
                                               labelColor:[UIColor blackColor]];
    timeTipLabel.text = @"距离开始还有";
    [activityTimeIV addSubview:timeTipLabel];
    
    hourLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(timeTipLabel.frame) + 3,
                                                         (CGRectGetHeight(activityTimeIV.frame) - 16) / 2.0f,
                                                         20,
                                                         16)
                                         font:THEME_FONT_SUPERSMALL
                                 textAligment:NSTextAlignmentCenter
                                   labelColor:THEME_COLOR_RED];
    hourLabel.backgroundColor = [UIColor clearColor];
    
    [activityTimeIV addSubview:hourLabel];
    
    UILabel *hourMaoHaoLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(hourLabel.frame),
                                                                        (CGRectGetHeight(activityTimeIV.frame) - 15) / 2.0f,
                                                                        15,
                                                                        15)
                                                        font:THEME_FONT_SMALL13
                                                textAligment:NSTextAlignmentCenter
                                                  labelColor:[UIColor blackColor]];
    hourMaoHaoLabel.text = @":";
    [activityTimeIV addSubview:hourMaoHaoLabel];
    
    minitueLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(hourMaoHaoLabel.frame),
                                                            (CGRectGetHeight(activityTimeIV.frame) - 16) / 2.0f,
                                                            16,
                                                            16)
                                            font:THEME_FONT_SUPERSMALL
                                    textAligment:NSTextAlignmentCenter
                                      labelColor:THEME_COLOR_RED];
    minitueLabel.backgroundColor = [UIColor clearColor];
    [activityTimeIV addSubview:minitueLabel];
    
    UILabel *minitueMaoHaoLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(minitueLabel.frame),
                                                                           (CGRectGetHeight(activityTimeIV.frame) - 15) / 2.0f,
                                                                           15,
                                                                           15)
                                                           font:THEME_FONT_SMALL13
                                                   textAligment:NSTextAlignmentCenter
                                                     labelColor:[UIColor blackColor]];
    minitueMaoHaoLabel.text = @":";
    [activityTimeIV addSubview:minitueMaoHaoLabel];
    
    secondLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(minitueMaoHaoLabel.frame),
                                                           (CGRectGetHeight(activityTimeIV.frame) - 16) / 2.0f,
                                                           16,
                                                           16)
                                           font:THEME_FONT_SUPERSMALL
                                   textAligment:NSTextAlignmentCenter
                                     labelColor:THEME_COLOR_RED];
    secondLabel.backgroundColor = [UIColor clearColor];
    [activityTimeIV addSubview:secondLabel];
}
//创建领取优惠劵视图
- (void)getPriviledgeView:(UIImageView *)priviledgeIVTemp
{
    getPriviledgeIV = [HWGeneralControl createView:CGRectMake(CGRectGetMinX(priviledgeIVTemp.frame),
                                                              CGRectGetMaxY(priviledgeIVTemp.frame),
                                                              CGRectGetWidth(priviledgeIVTemp.frame),
                                                              190 * kScreenRate - CGRectGetMaxY(priviledgeIVTemp.frame))];
    getPriviledgeIV.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:getPriviledgeIV];
    
    getPrivilegedBtn = [HWGeneralControl createButton:CGRectMake(CGRectGetWidth(getPriviledgeIV.frame) / 2.0f - 80 / 2.0f,
                                                                 (CGRectGetHeight(activityTimeIV.frame) - 25) / 2.0f,
                                                                 80,
                                                                 25)
                                                 font:THEME_FONT_SMALL13
                                     buttonTitleColor:[UIColor whiteColor]
                                             imageStr:@""
                                            backImage:@""
                                                title:@""];
    getPrivilegedBtn.backgroundColor = UIColorFromRGB(0xd94349);
    [getPriviledgeIV addSubview:getPrivilegedBtn];
    [getPrivilegedBtn addTarget:self action:@selector(getPrivileged:) forControlEvents:UIControlEventTouchUpInside];
    getPrivilegedBtn.layer.cornerRadius = CGRectGetHeight(getPrivilegedBtn.frame) / 2.0f;
    getPrivilegedBtn.layer.masksToBounds = YES;
    
}

- (void)setPriviledgeValue:(HWPriviledgeModel *)model
{
    everyPriviledgeModel = model;
    
    //start
    NSURL *avatarUrl =[NSURL URLWithString:[Utility imageDownloadUrl:model.priviledgeImageUrl]];
    __weak UIImageView *blockImgV = self.priviledgeIV;
    
    
    [self.priviledgeIV setImageWithURL:avatarUrl placeholderImage:nil options:SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
//            NSLog(@"model.timeStr === %@",model.timeStr);

        }
        
    }];
    
    
}

//获取优惠劵
- (void)getPrivileged:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickGetPriviledge:)])
    {
        [delegate didClickGetPriviledge:self.everyPriviledgeModel];
    }
}

- (void)setCoolTime:(int)time
{
    int freezeTime = ([everyPriviledgeModel.remainMsStr integerValue]) / 1000;
    
    int remaindTime = freezeTime - time;
    if (remaindTime >= 0)
    {
        int hour = remaindTime / 60 / 60;
        int minute = remaindTime / 60 % 60;
        int second = (remaindTime) % 60;
        secondLabel.text = [NSString stringWithFormat:@"%02d", (remaindTime) % 60];
        hourLabel.text = [NSString stringWithFormat:@"%02d", remaindTime / 60 / 60];
        minitueLabel.text = [NSString stringWithFormat:@"%02d", remaindTime / 60 % 60];
        if(second == 0 && minute == 0 && hour == 0)
        {
            activityTimeIV.hidden = YES;
            getPrivilegedBtn.hidden = NO;
            self.getPriviledgeIV.hidden = NO;
            [getPrivilegedBtn setTitle:@"立即领券" forState:UIControlStateNormal];
        }
        else
        {
            activityTimeIV.hidden = NO;
            getPrivilegedBtn.hidden = YES;
            self.getPriviledgeIV.hidden = YES;
        }
    }
    else
    {
        if ([everyPriviledgeModel.priviledgeType intValue] == 1) // 未开始
        {
            //倒计时结束
            activityTimeIV.hidden = YES;
            getPrivilegedBtn.hidden = NO;
            self.getPriviledgeIV.hidden = NO;
            [getPrivilegedBtn setTitle:@"立即领券" forState:UIControlStateNormal];
        }
        else if ([everyPriviledgeModel.priviledgeType intValue] == 2)
        {
            getPrivilegedBtn.hidden = NO;
            [getPrivilegedBtn setTitle:@"立即领券" forState:UIControlStateNormal];
            getPrivilegedBtn.backgroundColor = UIColorFromRGB(0xd94349);
            self.activityTimeIV.hidden = YES;
            self.getPriviledgeIV.hidden = NO;
        }
        else if ([everyPriviledgeModel.priviledgeType intValue] == 3)
        {
            getPrivilegedBtn.hidden = NO;
            [self.getPrivilegedBtn setTitle:@"已领完" forState:UIControlStateNormal];
            getPrivilegedBtn.backgroundColor = UIColorFromRGB(0x727272);
            self.activityTimeIV.hidden = YES;
            self.getPriviledgeIV.hidden = NO;
        }
        else
        {
            getPrivilegedBtn.hidden = NO;
            [getPrivilegedBtn setTitle:@"已下线" forState:UIControlStateNormal];
            getPrivilegedBtn.backgroundColor = UIColorFromRGB(0xd94349);
            self.activityTimeIV.hidden = YES;
            self.getPriviledgeIV.hidden = NO;
        }
    }
    
    
    
    /*
    if ([everyPriviledgeModel.priviledgeType intValue] == 1)
    {
        if ([secondLabel.text isEqualToString:@"00"] &&
            [minitueLabel.text isEqualToString:@"00"] &&
            [hourLabel.text isEqualToString:@"00"])
        {
            activityTimeIV.hidden = YES;
            getPrivilegedBtn.hidden = NO;
            self.getPriviledgeIV.hidden = NO;
            [getPrivilegedBtn setTitle:@"立即领券" forState:UIControlStateNormal];
        }
        else if([secondLabel.text length] == 0 &&
                [hourLabel.text length] == 0 &&
                [minitueLabel.text length] == 0)
        {
            activityTimeIV.hidden = YES;
            getPrivilegedBtn.hidden = NO;
            self.getPriviledgeIV.hidden = NO;
            [getPrivilegedBtn setTitle:@"立即领券" forState:UIControlStateNormal];
        }
        else
        {
            activityTimeIV.hidden = NO;
            getPrivilegedBtn.hidden = YES;
            self.getPriviledgeIV.hidden = YES;
        }

    }
    */
}

+ (CGFloat)getCellHeight
{
    return 200 * kScreenRate;
}

@end
