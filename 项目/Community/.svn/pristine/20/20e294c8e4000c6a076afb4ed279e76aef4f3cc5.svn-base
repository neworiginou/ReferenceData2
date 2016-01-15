//
//  HWGameNameView.m
//  KaoLaSpread
//
//  Created by weiyuanlin on 15/1/13.
//  Copyright (c) 2015年 hw. All rights reserved.
//  功能描述：个人游戏推广页面View
//  修改记录
//      李中强 2015-01-17 添加头注释 相关人员补齐注释
//      魏远林 2015-01-13 创建文件
//      魏远林 2015-01-19 规范代码，接口调试

#import "HWGameNameView.h"
#import "QRCodeGenerator.h"

@implementation HWGameNameView
{
    HWGameNameModel *_currentModel;
}
@synthesize littleImgView;
@synthesize titleLabel;
@synthesize qrCodeImgView;
@synthesize urlLabel;

- (id)initWithGameId:(NSString *)gameId appkey:(NSString *)appkey code:(NSString *)code
{
    self = [super init];
    if (self)
    {
        
        self.gameId = gameId;
        self.appkey = appkey;
        self.code = code;
        [self initiaGameNameView];
        [self getSingleSpreadData];
        
    }
    return self;
}


/**
 *	@brief	initia视图
 *
 *	@return	N/A
 */
- (void)initiaGameNameView
{
    littleImgView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 171.0f) / 2.0f - 27.0f , 22.0f, 71.0f, 45.0f)];
    littleImgView.image = [UIImage imageNamed:@"game_kaola1"];
    littleImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:littleImgView];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"找小伙伴们一起玩游戏吧";
    titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    CGSize titleSize;
    if (IOS7)
    {
        titleSize = [titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size;
    }
    else
    {
        titleSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21) lineBreakMode:NSLineBreakByCharWrapping];
    }
    titleLabel.frame = CGRectMake( CGRectGetMaxX(littleImgView.frame) + 12.0f, 35.0f, titleSize.width, 17.0f);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:THEME_COLOR_GRAY_MIDDLE];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel sizeToFit];
    [self addSubview:titleLabel];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 171.0f) / 2.0f, 67.0f, 171.0f, 171.0f)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    qrCodeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 151.0f, 151.0f)];
    qrCodeImgView.backgroundColor = IMAGE_DEFAULT_COLOR;
    qrCodeImgView.contentMode = UIViewContentModeScaleAspectFit;
    [backgroundView addSubview:qrCodeImgView];
    
}

/**
 *	@brief	个人游戏推广页 数据请求
 *
 *
 *	@return	N/A
 */
- (void)getSingleSpreadData
{
    /*
     接口名称：推广游戏--单个游戏分享
     接口URL：hw-game-app-web/quickmark/queryQuickMarkAndUrl.do
     入参：
     popularizeUserId(必填，推广员ID)，
     gameId(必填，游戏ID)，
     appkey(必填，)，
     code(必填，) 例：?popularizeUserId=77&gameId=2&appkey=10010&code=KALA
     */
    
    [Utility showMBProgress:self message:@"加载中"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"popularizeUserId"];
    [param setPObject:self.gameId forKey:@"gameId"];
    [param setPObject:self.appkey forKey:@"appkey"];
    [param setPObject:self.code forKey:@"code"];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    [manager POST:kSingleGameSpread parameters:param queue:nil success:^(id responese) {
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = [responese dictionaryObjectForKey:@"data"];
        NSArray *contentArr = [dataDic arrayObjectForKey:@"content"];
         NSDictionary *detailDic = [contentArr pObjectAtIndex:0];
        _currentModel = [[HWGameNameModel alloc]initWithDictionary:detailDic];
        
        __weak UIImageView *weakQRImgV = qrCodeImgView;
        [qrCodeImgView setImageWithURL:[NSURL URLWithString:_currentModel.dimensionalCode] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error != nil)
            {
                weakQRImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
            }
            else
            {
                weakQRImgV.image = image;
            }
            
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(getModelValue:)])
        {
            [self.delegate getModelValue:_currentModel];
        }
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

@end
