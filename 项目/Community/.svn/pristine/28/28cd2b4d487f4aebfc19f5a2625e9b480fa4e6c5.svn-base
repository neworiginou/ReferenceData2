//
//  HWGoodsListCell.m
//  Community
//
//  Created by lizhongqiang on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWGoodsListCell.h"
#import "HWCountDownCustomView.h"
#import "HWAlertModel.h"
#import "AppDelegate.h"

@implementation HWGoodsListCell
@synthesize name;
@synthesize tipBtn;
@synthesize clockLabel;
@synthesize priceLabel;
@synthesize priceImage;
@synthesize shicahngjia;
@synthesize bgImage;
@synthesize bgView;
@synthesize grayView;
@synthesize countDownLabel;
@synthesize remainMs;
@synthesize status;
@synthesize alphaView;
@synthesize timeImage;
@synthesize goodsListModel;
@synthesize timeList;
@synthesize countDownImage;
@synthesize RMB;
@synthesize clockTimeImg;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:235.0/255.0 alpha:1.0f]];
//        [self.contentView setBackgroundColor:THEME_COLOR_GRAY_HEADBACK];
        [self.contentView setBackgroundColor:BACKGROUND_COLOR];
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 200 * kScreenRate)];
        [self.bgView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.bgView];
        
        self.bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 134 * kScreenRate)];
        [self.bgImage setBackgroundColor:[UIColor clearColor]];
        [self.bgImage setBackgroundColor:THEBUTTON_GRAY_HIGHLIGHT];
        [self.bgView addSubview:self.bgImage];
        
        self.timeList = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 96.5f - 20, (134 - 5 - 18.5f) * kScreenRate, 96.5f, 18.5f)];
        [self.timeList setBackgroundColor:[UIColor clearColor]];
        [self.timeList setImage:[UIImage imageNamed:@"listtime17"]];
        [self.bgView addSubview:self.timeList];
        
        self.countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 130, 19)];
        [self.countDownLabel setBackgroundColor:[UIColor clearColor]];
        [self.countDownLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13]];
        [self.countDownLabel setTextColor:[UIColor whiteColor]];
        [self.countDownLabel setTextAlignment:NSTextAlignmentRight];
        [self.timeList addSubview:self.countDownLabel];
        
        self.countDownImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 12.5)];
        [self.countDownImage setImage:[UIImage imageNamed:@"time2"]];
        [self.timeList addSubview:self.countDownImage];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 * kScreenRate + self.bgImage.frame.size.height, kScreenWidth - 2 * 10, 21)];
        [self.name setBackgroundColor:[UIColor clearColor]];
        [self.name setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE]];
        [self.name setTextColor:THEME_COLOR_SMOKE];
        [self.bgView addSubview:self.name];
        
        self.RMB = [[UILabel alloc] initWithFrame:CGRectMake(7, 27 * kScreenRate + self.bgImage.frame.size.height + 4 *kScreenRate, 60, 30)];
        [self.RMB setBackgroundColor:[UIColor clearColor]];
        [self.RMB setFont:[UIFont fontWithName:FONTNAME size:20]];
        [self.RMB setText:@"￥"];
        [self.RMB sizeToFit];
        [self.RMB setTextColor:THE_COLOR_RED];
        [self.bgView addSubview:self.RMB];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(7 + self.RMB.frame.size.width, 27 * kScreenRate + self.bgImage.frame.size.height, 200, 30)];
        [self.priceLabel setBackgroundColor:[UIColor clearColor]];
        [self.priceLabel setFont:[UIFont fontWithName:FONTNAME size:20]];
        [self.priceLabel setTextColor:THE_COLOR_RED];
        [self.bgView addSubview:self.priceLabel];
        
        self.priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 130 * kScreenRate, 31, 12)];
        [self.priceImage setBackgroundColor:[UIColor clearColor]];
        [self.priceImage setImage:[UIImage imageNamed:@"price"]];
        [self.bgView addSubview:self.priceImage];
        
        self.shicahngjia = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 31, 12)];
        [self.shicahngjia setBackgroundColor:[UIColor clearColor]];
        [self.shicahngjia setText:@"市场价"];
        [self.shicahngjia setTextColor:[UIColor whiteColor]];
        [self.shicahngjia setFont:[UIFont fontWithName:FONTNAME size:9]];
        [self.priceImage addSubview:self.shicahngjia];
        
#pragma mark - 未开始活动
        self.grayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 200 * kScreenRate)];
        [self.grayView setBackgroundColor:[UIColor clearColor]];
        [self.grayView setUserInteractionEnabled:YES];
        [self.grayView setImage:[UIImage imageNamed:@"cutgray"]];
        [self.grayView setHidden:YES];
        [self.bgView addSubview:self.grayView];
        
        UIImage *clockImg = [UIImage imageNamed:@"naozhong"];
        self.timeImage = [UIImageView newAutoLayoutView];
        [self.grayView addSubview:self.timeImage];
        self.timeImage.image = clockImg;
        [self.timeImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.bgView];
        [self.timeImage autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.bgView];
        [self.timeImage autoSetDimensionsToSize:CGSizeMake(floor(clockImg.size.width), floor(clockImg.size.height))];
        self.timeImage.hidden = YES;
        
        self.clockTimeImg = [[UIImageView alloc] initWithFrame:CGRectMake(100, 60 * kScreenRate, 19, 18)];
        [self.clockTimeImg setImage:[UIImage imageNamed:@"time3"]];
        [self.clockTimeImg setBackgroundColor:[UIColor clearColor]];
        [self.grayView addSubview:self.clockTimeImg];

        self.clockLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 * kScreenRate, kScreenWidth - 20, 21)];
        [self.clockLabel setBackgroundColor:[UIColor clearColor]];
        [self.clockLabel setTextAlignment:NSTextAlignmentCenter];
        [self.clockLabel setTextColor:[UIColor whiteColor]];
        [self.clockLabel setFont:[UIFont fontWithName:FONTNAME size:20]];
//        UIFont *font = [UIFont boldSystemFontOfSize:20];
//        font.fontName = @"Helvetica Neue LT Pro";
        
        [self.grayView addSubview:self.clockLabel];
        
        self.tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tipBtn setFrame:CGRectMake((kScreenWidth - 180 - 20) / 2, 105 * kScreenRate, 180, 38)];
        [self.tipBtn setTitle:@"设置开始提醒" forState:UIControlStateNormal];
        [self.tipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.tipBtn.titleLabel setFont:[UIFont fontWithName:FONTNAME size:18]];
        self.tipBtn.layer.cornerRadius = 19;
        self.tipBtn.layer.masksToBounds = YES;
        self.tipBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.tipBtn.layer.borderWidth = 1.0f;
        [self.tipBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.grayView addSubview:tipBtn];

    }
    return self;
}

- (void)setCellWithModel:(HWGoodsListModel *)model
{
    self.goodsListModel = model;
    self.status = model.status;
    self.remainMs = model.remainMs;
    
    self.name.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",model.marketPrice];
    CGSize priceSize = [Utility calculateStringWidth:self.priceLabel.text font:self.priceLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 20)];
    self.priceImage.frame = CGRectMake(self.priceLabel.frame.origin.x + priceSize.width + 5, self.priceLabel.frame.origin.y + 10, 31, 12);
    
    __block UIImageView *imgView = self.bgImage;
    [self.bgImage setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.bigImg]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (!error) {
            [imgView setImage:image];
        }
    }];
    
    //0未开始，1 进行中，2流标，3已开奖,4活动结束
    if ([model.status isEqualToString:@"1"])
    {
        self.grayView.hidden = YES;
        self.timeList.hidden = NO;
        self.countDownImage.hidden = NO;
    }
    else
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.grayView.hidden = NO;
        self.timeList.hidden = YES;
        self.countDownImage.hidden = YES;
    }
    
    //是否存在闹钟
    if ([HWUserLogin isExistAlertByGoodsId:model.productId] == YES)
    {
        self.timeImage.hidden = NO;
        if ([model.status isEqual: @"1"])
        {
            self.timeImage.hidden = YES;
        }
    }
    else
    {
        self.timeImage.hidden = YES;
    }
}



- (void)tipBtnClick:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(setClockWithModel:)])
    {
        [delegate setClockWithModel:self.goodsListModel];
    }
    
//    HWCountDownCustomView * countView = [[HWCountDownCustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT + 64) WithType:@"开始"];
//    [countView show];
//    
//    __weak HWGoodsListCell *weakSelf = self;
//    countView.sureBtnBlock = ^(NSInteger time)
//    {
////        weakSelf.isSetAwake = haveSetAwake;
//        
////        self.goodsListModel.remainMs = @"10000"; // 测试数据 10 秒后
//        
//        
//        if (time == 0)
//        {
//            [HWCoreDataManager removeAlertItmeByGoodsId:self.goodsListModel.productId];
//        }
//       
//        long long alertTime = ABS(self.goodsListModel.remainMs.longLongValue) / 1000.0f - time;
//        if (alertTime <= 0)
//        {
//            AppDelegate *appDel = SHARED_APP_DELEGATE;
//            [Utility showToastWithMessage:[NSString stringWithFormat:@"还有%.0f分钟就开始了", ceilf(self.goodsListModel.remainMs.longLongValue / 60000.0f)] inView:appDel.window];
//            return;
//        }
//        
//        long long alertTimeStamp = [[NSDate date] timeIntervalSince1970] + alertTime;
//        
//        HWAlertModel *model = [[HWAlertModel alloc] init];
//        model.goodsId = self.goodsListModel.productId;
//        model.alertTime = [NSString stringWithFormat:@"%lld", alertTimeStamp];
//        [[HWUserLogin currentUserLogin] saveUserAlertTime:model];
//        
//        NSLog(@"倒计时%ld",(long)time);
//        UIApplication *app = [UIApplication sharedApplication];
//        
//        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
//        {
//            [app registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
//        }
//        
////        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
//        UILocalNotification * noti = [[UILocalNotification alloc]init];
//        if (noti)
//        {
//            noti.fireDate = [NSDate dateWithTimeIntervalSince1970:alertTimeStamp];
//            noti.timeZone = [NSTimeZone defaultTimeZone];
//            noti.soundName = UILocalNotificationDefaultSoundName;
//            noti.alertBody = [NSString stringWithFormat:@"%@ 开始砍价了",self.goodsListModel.productName];
//            NSDictionary * infoDic = [NSDictionary dictionaryWithObject:self.goodsListModel.productId forKey:@"goodsId"];
//            noti.userInfo = infoDic;
//            [app scheduleLocalNotification:noti];
//            [HWCoreDataManager removeAlertItmeByGoodsId:self.goodsListModel.productId];
//        }
//        
//        [weakSelf setNeedsUpdateConstraints];
//    };
}

@end
