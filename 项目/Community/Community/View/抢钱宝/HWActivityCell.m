//
//  HWActivityCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-5-20.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWActivityCell.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

#define MARGIN_LEFT 15
#define MARGIN_TOP 10
#define HEAD_IMAGE_WIDTH 65
#define HEAD_IMAGE_HEIGHT 65
#define PADING 5

@implementation HWActivityCell
@synthesize headImageView,titleLabel,shareButton,delegate,subTitleLabel,rewardlMoneyLab,activityId,myShareItem;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // Initialization code
        
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_TOP, HEAD_IMAGE_WIDTH, HEAD_IMAGE_HEIGHT)];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.layer.masksToBounds = YES;
        headImageView.layer.cornerRadius = 5;
        headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:headImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame) + 10, MARGIN_TOP + 10, 145, 20)];
        titleLabel.font = [UIFont fontWithName:FONTNAME size:16];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        
        rewardlMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame) + 5, 150, 20)];
        rewardlMoneyLab.font = [UIFont fontWithName:FONTNAME size:11];
        rewardlMoneyLab.backgroundColor = [UIColor clearColor];
        rewardlMoneyLab.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:rewardlMoneyLab];
        
        shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.frame = CGRectMake(kScreenWidth - 15 - 63, (85 - 25)/2, 66, 27);
        shareButton.layer.cornerRadius = 3.0;
        shareButton.layer.borderWidth = 1;
        shareButton.layer.borderColor = UIColorFromRGB(0x6bae00).CGColor;
        shareButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:12.0f];
        [shareButton setTitleColor:UIColorFromRGB(0x6bae00) forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:shareButton];
        
        if ([Utility isNullQQAndWX])
        {
            shareButton.hidden = YES;
        }
        else
        {
            shareButton.hidden = NO;
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 85 - 0.5f, kScreenWidth, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setShareItem:(HWShareItemClass *)shareItem
{
    self.myShareItem = shareItem;
    
    __weak UIImageView *blockImgV = self.headImageView;
    [self.headImageView setImageWithURL:[NSURL URLWithString:shareItem.housePic] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
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
        }
    }];
    
    self.titleLabel.text = shareItem.activityTitle;
    
    
    NSString *string2 = shareItem.restMoney;
    
    NSMutableAttributedString *string;
    
    if ([shareItem.shareMethod isEqualToString:@"0"])
    {
        if (shareItem.started.intValue == 0)
        {
            // 活动未开始
            string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"奖励%@元,￥%@/次",shareItem.restMoney, shareItem.sharedMoney]];
            [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_GRAY_MIDDLE range:NSMakeRange(0, string.length)];
            [string addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x6bae00) range:NSMakeRange(2, [shareItem.restMoney length])];
            [string addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x6bae00) range:NSMakeRange(2 + [shareItem.restMoney length] + 3, [shareItem.sharedMoney length])];
            rewardlMoneyLab.attributedText = string;
        }
        else
        {
            
            if (shareItem.shareMethod.intValue == 0) {
                string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"奖励还剩%@元",string2]];
                [string addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_GRAY_MIDDLE range:NSMakeRange(0, string2.length)];
                [string addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x6bae00) range:NSMakeRange(4, [string2 length])];
                
            }
            
        }
        
    }
    if (shareItem.shareMethod.intValue == 1)
    {
        if (shareItem.restNum.intValue == 0) {
            string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"红包剩%@个",shareItem.restNum]];
            [string addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x6bae00) range:NSMakeRange(3,shareItem.restNum.length)];
            
        }
        else
        {
            string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"红包剩%@个,最高%@元",shareItem.restNum,shareItem.maxSharedMoney]];
            [string addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x6bae00) range:NSMakeRange(3,shareItem.restNum.length)];
            [string addAttribute:NSForegroundColorAttributeName value:(id)UIColorFromRGB(0x6bae00) range:NSMakeRange(string.length - shareItem.maxSharedMoney.length - 1, shareItem.maxSharedMoney.length)];
            
        }
        
    }
    rewardlMoneyLab.attributedText = string;
    
    
}

- (void)setCoolTime:(NSInteger)time
{
    
    NSInteger freezeTime = [myShareItem.freezeRemainMillis integerValue] / 1000.0f;
    NSInteger remaindTime = freezeTime - time;
    if (delegate && [delegate respondsToSelector:@selector(remaindTime:)])
    {
        [delegate remaindTime:remaindTime];
    }
    
    NSInteger hour = remaindTime / 60 / 60;
    NSInteger minute = remaindTime / 60 % 60;
    NSInteger second = (remaindTime) % 60;
    if (myShareItem.started.intValue == 0)
    {
#warning 倒计时
        if (remaindTime > 0)
        {
            // 活动未开始
            [shareButton setFreezeStyle];
            NSInteger secInt = 0;
            
            secInt = remaindTime / 60;
            
            NSString *str;
            str = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour, minute, second];
            [self.shareButton setTitle:str forState:UIControlStateNormal];
            self.shareButton.userInteractionEnabled = NO;
        }
        else
        {
            [shareButton setNonFreezeStyle];
            NSString *str = [NSString stringWithFormat:@"￥%@分享", [self handleNumber:myShareItem.sharedMoney]];
            [self.shareButton setTitle:str forState:UIControlStateNormal];
            self.shareButton.userInteractionEnabled = YES;
        }
        
    }
    else if (myShareItem.sharedMoney.floatValue > 0 &&
             (myShareItem.restMoney.floatValue - myShareItem.sharedMoney.floatValue) >= 0 && myShareItem.shareMethod.intValue == 0)
    {
        if (myShareItem.shareState.integerValue == 1)
        {
            if (remaindTime > 0)
            {
                [shareButton setFreezeStyle];
                NSInteger secInt = 0;
                
                secInt = remaindTime / 60;
                NSString *str;
                str = [NSString stringWithFormat:@"%02d:%02d:%02d",hour, minute, second];
                [self.shareButton setTitle:str forState:UIControlStateNormal];
                self.shareButton.userInteractionEnabled = NO;
            }
            else
            {
                [shareButton setNonFreezeStyle];
                NSString *str = [NSString stringWithFormat:@"￥%@分享", [self handleNumber:myShareItem.sharedMoney]];
                [self.shareButton setTitle:str forState:UIControlStateNormal];
                self.shareButton.userInteractionEnabled = YES;
            }
            
        }
        else
        {
            [shareButton setNonFreezeStyle];
            [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
            self.shareButton.userInteractionEnabled = YES;
            
        }
        
        
    }
    
    else if (myShareItem.shareMethod.intValue == 1)
    {
        if (myShareItem.shareState.intValue == 1)
        {
            if (remaindTime > 0)
            {
                [shareButton setFreezeStyle];
                NSInteger secInt = 0;
                
                secInt = remaindTime / 60;
                NSString *str;
                str = [NSString stringWithFormat:@"%02d:%02d:%02d",hour, minute, second];
                [self.shareButton setTitle:str forState:UIControlStateNormal];
                self.shareButton.userInteractionEnabled = NO;
            }
            else
            {
                [shareButton setNonFreezeStyle];
                if (myShareItem.restNum.intValue == 0 || myShareItem.restNum.length == 0)
                {
                    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
                    
                }
                else
                {
                    [self.shareButton setTitle:@"神秘红包" forState:UIControlStateNormal];
                }
                self.shareButton.userInteractionEnabled = YES;
            }
            
        }
        else
        {
            [shareButton setNonFreezeStyle];
            [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
            self.shareButton.userInteractionEnabled = YES;
            
        }
        
    }
    
    else
    {
        [shareButton setNonFreezeStyle];
        if (myShareItem.shareMethod.intValue == 0) {
            [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
            
        }
        if (myShareItem.shareMethod.intValue == 1) {
            if ([myShareItem.restNum isEqualToString:@"0"] || myShareItem.restNum.length == 0 || myShareItem.restNum == nil) {
                [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
            }
            else
            {
                [self.shareButton setTitle:@"神秘红包" forState:UIControlStateNormal];
                
            }
        }
        self.shareButton.userInteractionEnabled = YES;
    }
    
}

- (NSString *)handleNumber:(NSString *)string
{
    NSString *finalMoney = nil;
    if (string.intValue / 10000)
    {
        if (string.intValue % 10000 > 0)
        {
            finalMoney = [NSString stringWithFormat:@"%.1f万",string.floatValue/10000.0f];
        }
        else
        {
            finalMoney = [NSString stringWithFormat:@"%d万",string.intValue/10000];
        }
        
    }
    else if (string.intValue / 1000)
    {
        if (string.intValue % 1000 > 0)
        {
            finalMoney = [NSString stringWithFormat:@"%.1f千",string.floatValue/1000.0f];
        }
        else
        {
            finalMoney = [NSString stringWithFormat:@"%d千",string.intValue/1000];
        }
    }
    else
    {
        finalMoney = string;
    }
    return finalMoney;
}

- (void)clickShare:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickShareButtonWithCell:)])
    {
        [delegate didClickShareButtonWithCell:self];
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
