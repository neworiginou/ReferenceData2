//
//  HWPersonalHomePageView.m
//  Community
//
//  Created by niedi on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：邻里圈 个人主页View
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪        2015-04-15                 创建文件
//


#import "HWPersonalHomePageView.h"

@implementation HWPersonalHomePageView

- (instancetype)initWithFrame:(CGRect)frame userId:(NSString *)userId
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        _TaTitleArr = @[@"Ta的主题", @"Ta的话题"];
        _WoTitleArr = @[@"Wo的主题", @"Wo的话题"];
        _TitleImgArr = @[@"taTheme", @"taTopic"];
        self.userId = userId;
        self.isNeedHeadRefresh = NO;
        [self initUI];
        [self queryListData];
    }
    return self;
}

- (void)initUI
{
    _backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    CGPoint center = _backImgV.center;
    center.y = (CONTENT_HEIGHT - 50) / 2.0f;
    _backImgV.center = center;
    _backImgV.image = [UIImage imageNamed:@"bgg"];
    _backImgV.backgroundColor = [UIColor clearColor];
    [self addSubview:_backImgV];
    
    CGFloat width = _backImgV.frame.size.width * 0.305f;
    
    _headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    _headerImg.center = center;
    _headerImg.layer.cornerRadius = width / 2.0f;
    _headerImg.layer.masksToBounds = YES;
    [self addSubview:_headerImg];
    
    [self addSubview:[Utility drawLineWithFrame:CGRectMake(0, CONTENT_HEIGHT - 50.5f, kScreenWidth, 0.5f)]];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *buttomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buttomBtn.frame = CGRectMake((kScreenWidth / 2.0f + 1) * i, CONTENT_HEIGHT - 50, kScreenWidth / 2.0f, 50);
        [buttomBtn setBackgroundImage:[UIImage imageNamed:@"bg_personal_bottom"] forState:UIControlStateNormal];
        buttomBtn.imageView.frame = CGRectMake(buttomBtn.imageView.frame.origin.x, buttomBtn.imageView.frame.origin.y, 17, 17);
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(buttomBtn.frame.size.width / 2.0f - 50, 17, 17, 17)];
        img.image = [UIImage imageNamed:_TitleImgArr[i]];
        [buttomBtn addSubview:img];
        
        if ([self.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
        {
            [buttomBtn setTitle:_WoTitleArr[i] forState:UIControlStateNormal];
        }
        else
        {
            [buttomBtn setTitle:_TaTitleArr[i] forState:UIControlStateNormal];
        }
        [buttomBtn setTitleColor:THEME_COLOR_SMOKE forState:UIControlStateNormal];
        buttomBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
        buttomBtn.tag = 1101 + i;
        [buttomBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttomBtn];
    }
    [self addSubview:[Utility drawLineWithFrame:CGRectMake(kScreenWidth / 2.0f, CONTENT_HEIGHT - 50, 1.0f, 50)]];
}

- (void)buttonClick:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(personalHomePageClickIndex:)])
    {
        [self.delegate personalHomePageClickIndex:btn.tag - 1101];
    }
}

- (void)queryListData
{
    /*    接口：hw-sq-app-web/me/userIndex.do
     参数：userId=1012402012411 要查看的用户userId
     key=bb007a04-0c5d-4060-b678-7014b4469c86
     出参：
     {
     'status': '1',
     'data':
     { 'userId': 1012402012411, 'nickName': 'gg1', 'hobby': '爱喝酒，爱电影，爱星座的考拉', 'mongodbKey': '54c62fe1e4b0fc38bffeba6a', 'hobbyList': [ '爱喝酒', '爱电影', '爱星座的考拉' ] },
     'detail': '请求数据成功!',
     'key': 'bb007a04-0c5d-4060-b678-7014b4469c86'
     }*/
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:self.userId forKey:@"userId"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kPersonalHomePage parameters:param queue:nil success:^(id responese)
     {
         NSDictionary *dict = [responese objectForKey:@"data"];
         self.baseListArr = [NSMutableArray arrayWithArray:[[[dict arrayObjectForKey:@"hobbyList"] pObjectAtIndex:0] componentsSeparatedByString:@","]];
         NSString *third = [self.baseListArr pObjectAtIndex:2];
         if (self.baseListArr.count == 3 && [third rangeOfString:@"的考拉"].location != NSNotFound)
         {
             third = [third substringToIndex:third.length - 3];
             [self.baseListArr replaceObjectAtIndex:2 withObject:third];
         }
         _headerMongodbKey = [dict stringObjectForKey:@"mongodbKey"];
         if (self.delegate && [self.delegate respondsToSelector:@selector(personalHomePageVcChangeTitle:)])
         {
             NSString *navTitle = [dict stringObjectForKey:@"nickName"];
             if (navTitle.length == 0)
             {
                 navTitle = @"无名的考拉";
             }
             if ([self.userId isEqualToString:@"1"])
             {
                 navTitle = @"考拉君";
             }
             [self.delegate personalHomePageVcChangeTitle:navTitle];
         }
         isLastPage = YES;
         [self loadData];
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
}

- (void)loadData
{
    NSURL *imageUrl = [NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:_headerMongodbKey]];
    __weak UIImageView *blockImgV = _headerImg;
    [_headerImg setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"head_placeholder"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            {
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    
    NSArray *distance = @[@(0.47f), @(0.71f), @(1.05f)];
    NSArray *angle = @[@(-M_PI_4), @(M_PI_4 * 3), @(M_PI_4 * 5)];
    NSArray *pointImgStrArr = @[@"黄点", @"粉点", @"绿点"];
    NSArray *backImgStrArr = @[@"黄色", @"粉色", @"绿色"];
    
    for (int i = 0; i < self.baseListArr.count; i++)
    {
        CGPoint center = _backImgV.center;
        CGFloat length = [distance[i] floatValue] *_backImgV.width / 2.0f;
        CGFloat x;
        CGFloat y;
        if (i == 0)
        {
            x = center.x + length * cos([angle[i] floatValue]);
            y = center.y + length * sin([angle[i] floatValue]);
        }
        else if (i == 1)
        {
            x = center.x + length * cos([angle[i] floatValue]);
            y = center.y + length * sin([angle[i] floatValue]);
        }
        else if (i == 2)
        {
            x = center.x + length * cos([angle[i] floatValue]);
            y = center.y + length * sin([angle[i] floatValue]);
        }
        HWSignView *signView = [[HWSignView alloc] initWithTitle:[self.baseListArr pObjectAtIndex:i] pointImgName:pointImgStrArr[i] signBackImg:backImgStrArr[i]];
        signView.frame = CGRectMake(x, y, signView.frame.size.width, signView.frame.size.height);
        [self addSubview:signView];
    }
}

@end
