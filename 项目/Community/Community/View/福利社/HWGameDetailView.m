//
//  HWGameDetailView.m
//  Community
//
//  Created by niedi on 15/1/20.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：游戏详情页面View 包括游戏详情和佣金明细view
//
//  修改记录：
//      姓名          日期                      修改内容
//      聂迪          2015-1-16                 创建文件
//

#import "HWGameDetailView.h"

@implementation HWGameDetailView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame andGameId:(NSString *)gameId
{
    if (self = [super initWithFrame:frame])
    {
        self.gameId = gameId;
        self.isNeedHeadRefresh = NO;
        
        [self loadUI];                                  //UI加载
        
        [self queryDataForGameDetail];                  //请求游戏详情数据
        
    }
    return self;
}

#pragma mark - 加载UI
- (void)loadUI
{
    [self loadUpSegmentUpUI];                       //segment包括其以上的UI
    
//    _tableViewHeaderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 330)];
//    _tableViewHeaderView.backgroundColor = [UIColor clearColor];
//    self.baseTable.tableHeaderView = _tableViewHeaderView;
    
    [self loadBlowSegmentUIForGameDetail];          //segment位置以下的UI（游戏详情时）
    
    [self loadBlowSegmentUIForCommissionDetail];    //segment位置以下的UI（佣金明细时）
    _belowSegmentViewForCommission.hidden = YES;
    
    _spreadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _spreadBtn.frame = CGRectMake(0, CONTENT_HEIGHT - 45.0f, kScreenWidth, 45.0f);
    _spreadBtn.backgroundColor = THEME_COLOR_GRAY;
    [_spreadBtn setTitle:@"推广" forState:UIControlStateNormal];
    _spreadBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_BIG_SIZE];
    [_spreadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_spreadBtn addTarget:self action:@selector(pushToShareViewController) forControlEvents:UIControlEventTouchUpInside];
    [_spreadBtn setInactiveState];
    [self addSubview:_spreadBtn];
}

#pragma mark - 推广按钮点击事件
- (void)pushToShareViewController
{
#warning 绑定手机号  详情推广
    [MobClick event:@"click_spreadgame"]; //maidian_1.2.1
    if ([HWUserLogin verifyBindMobileWithPopVC:(UIViewController *)self.delegate showAlert:YES])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(pushToShareVC:)])
        {
            [self.delegate pushToShareVC:self.gameDetailModel];
        }
    }
}

#pragma mark - 加载接口返回数据
- (void)loadDataForGameDetail
{
    //Game Icon
    __block UIImageView *weakImgV = _headImageV;
    [_headImageV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:self.gameDetailModel.gameInfoModel.iconMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
    }];
    
    CGRect frame = CGRectZero;
    
    //Game Detail Up The segment
    //第一行
    if (self.gameDetailModel.gameCommissionModel.commissionAmount.floatValue == 0)
    {
        _gameCommissionTitleLab.hidden = YES;
    }
    else
    {
        _gameCommissionTitleLab.hidden = NO;
        
        if ([self.gameDetailModel.gameCommissionModel.commissionCurrency isEqualToString:@"0"])
        {           //考拉币
            
            NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"有效推广可获得%d考拉币/次", self.gameDetailModel.gameCommissionModel.commissionAmount.intValue]];
            [attributeText addAttributes:@{NSForegroundColorAttributeName: THEME_COLOR_ORANGE} range:NSMakeRange(7, attributeText.length - 7)];
            _gameCommissionTitleLab.attributedText = attributeText;
        }
        else       //人民币
        {
            NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"有效推广可获得%.2f人民币/次", self.gameDetailModel.gameCommissionModel.commissionAmount.floatValue]];
            [attributeText addAttributes:@{NSForegroundColorAttributeName: THEME_COLOR_MONEY} range:NSMakeRange(7, attributeText.length - 7)];
            _gameCommissionTitleLab.attributedText = attributeText;
        }
        
        frame = _gameCommissionTitleLab.frame;
        frame.size.height = [Utility calculateStringHeight:_gameCommissionTitleLab.text font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] constrainedSize:CGSizeMake(kScreenWidth - 15 - CGRectGetMaxX(_headImageV.frame) - 10, 10000)].height;
        _gameCommissionTitleLab.frame = frame;
    }
    
    //第二行
    if (self.gameDetailModel.gameCommissionModel.proportion.floatValue == 0)
    {
        _gameCommissionSubTLab.hidden = YES;
    }
    else
    {
        _gameCommissionSubTLab.hidden = NO;
        
        NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"用户游戏内消费可以获得%.2f%%佣金", self.gameDetailModel.gameCommissionModel.proportion.floatValue * 100]];
        [attributeText addAttributes:@{NSForegroundColorAttributeName: THEME_COLOR_MONEY} range:NSMakeRange(11, attributeText.length - 13)];
        _gameCommissionSubTLab.attributedText = attributeText;
        
        frame = _gameCommissionSubTLab.frame;
        frame.size.height = [Utility calculateStringHeight:_gameCommissionSubTLab.text font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] constrainedSize:CGSizeMake(_gameCommissionTitleLab.frame.size.width, 10000)].height;
        if (_gameCommissionTitleLab.hidden == YES)
        {
            frame.origin.y = 12;
        }
        else
        {
            frame.origin.y = CGRectGetMaxY(_gameCommissionTitleLab.frame) + 3;
        }
        _gameCommissionSubTLab.frame = frame;
    }
    
    //第三行
    frame = _gameComissionEndDateLab.frame;
    if (_gameCommissionSubTLab.hidden == NO)
    {
        frame.origin.y = CGRectGetMaxY(_gameCommissionSubTLab.frame) + 3;
    }
    else if (_gameCommissionTitleLab.hidden == NO && _gameCommissionSubTLab.hidden == YES)
    {
        frame.origin.y = CGRectGetMaxY(_gameCommissionTitleLab.frame) + 3;
    }
    _gameComissionEndDateLab.frame = frame;
    _gameComissionEndDateLab.text = [NSString stringWithFormat:@"结束时间%@", [Utility getMinTimeWithTimestamp:self.gameDetailModel.gameInfoModel.popularizeEnd]];
    
    
    //Game Description 描述
    _gameDetailLab.text = self.gameDetailModel.gameInfoModel.detailDescription;
    frame = _gameDetailLab.frame;
    frame.size.height = [Utility calculateStringHeight:_gameDetailLab.text font:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedSize:CGSizeMake(kScreenWidth - 15 * 2, 10000)].height;
    _gameDetailLab.frame = frame;
    
    //Game Pic Wall 图片墙
    frame = _imgScrollView.frame;
    frame.origin.y = CGRectGetMaxY(_gameDetailLab.frame) + 9;
    _imgScrollView.frame = frame;
    _imgScrollView.contentSize = CGSizeMake((175 * kScreenRate + 10) * self.gameDetailModel.gameBigImgArr.count, 0);
    
    for (int i = 0; i < self.gameDetailModel.gameBigImgArr.count; i++)
    {
        
        HWGameBigImgModel *model = self.gameDetailModel.gameBigImgArr[i];
        
        WXImageView *imageView = [[WXImageView alloc] initWithFrame:CGRectMake(i * (175 * kScreenRate + 10), 0, 175 * kScreenRate, CGRectGetHeight(_imgScrollView.frame))];
        imageView.backgroundColor = IMAGE_DEFAULT_COLOR;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        __weak UIImageView *weakImgV = imageView;
        [imageView setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.imgMongodbKey]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
            if (error != nil)
            {
                weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
                weakImgV.backgroundColor = IMAGE_DEFAULT_COLOR;
            }
            else
            {
                weakImgV.image = image;
                weakImgV.backgroundColor = [UIColor clearColor];
            }
            
        }];
        [_imgScrollView addSubview:imageView];
    }
    
    _belowSegmentViewForGameDetail.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_imgScrollView.frame) + 10);
    
    if ([self.gameDetailModel.gameInfoModel.status isEqualToString:@"0"] || [self.gameDetailModel.gameInfoModel.status isEqualToString:@"2"])//0 2 下架或等待上架 1 已上架
    {
        [_spreadBtn setInactiveState];
        _spreadBtn.backgroundColor = THEME_COLOR_GRAY;
    }
    else
    {
        [_spreadBtn setActiveState];
        _spreadBtn.backgroundColor = THEME_COLOR_ORANGE;
    }
}

#pragma mark - 网络请求

/**
 *	@brief	游戏详情 接口
 *
 *	@return
 */
- (void)queryDataForGameDetail
{
    /*接口描述：根据游戏id查询游戏详细信息
     接口url：hw-game-app-web/game/queryGameInfo.do
     入参：gameId 游戏id（必填）
     出参：
     {"status":"1","data":{"gameInfo":
     {"gameId":1,"gameName":"地狱边境","iconMongodbKey":"3423424sdfsfgfdg","typeDescription":"描述1","detailDescription":"详细描述1","publicityLanguage":"下载页宣传语1","versionDescription":"下载版本描述1","downLoadUrl":null,"appNumber":"10010","channelNumber":"KALA","popularizeStart":null,"popularizeEnd":null,"isTop":1,"bannerMongodbKey":"2313sdfs32sg","status":1,"startCount":10,"creater":null,"createTime":null,"modifier":null,"modifyTime":null,"version":null,"disabled":0}
     ,"gameAttachmentList":[],"gameCommissionList":[
     {"commissionId":1,"gameId":1,"commissionType":0,"billingMethods":0,"commissionAmount":0.8000,"commissionCurrency":1,"proportion":null,"creater":null,"createTime":null,"modifier":null,"modifyTime":null,"version":null,"disabled":0}
     ,
     {"commissionId":2,"gameId":1,"commissionType":1,"billingMethods":1,"commissionAmount":null,"commissionCurrency":1,"proportion":1.5,"creater":null,"createTime":null,"modifier":null,"modifyTime":null,"version":null,"disabled":0}
     ]},"detail":"请求数据成功!","key":null}*/
    
    [Utility showMBProgress:self message:@"加载中"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager gameManager];
    
    [param setObject:self.gameId forKey:@"gameId"];
    
    [manager POST:KYouXiDetail parameters:param queue:nil success:^(id responese) {
        
        [Utility hideMBProgress:self];
        
        NSLog(@"%@",responese);
        
        NSDictionary * dic = [responese dictionaryObjectForKey:@"data"];
        
        self.gameDetailModel = [[HWGameDetailModel alloc] initWithDict:dic];
        
        [self delegateSetTitleView:self.gameDetailModel.gameInfoModel.gameName];
        
        [self loadDataForGameDetail];                   //加载数据
        
    } failure:^(NSString *code, NSString *error) {
        
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
    
}

#pragma mark - segment Delegate
/**
 *	@brief	HWCustomSegmentControl Delegate
 *
 *	@param 	sControl
 *	@param 	index
 *
 *	@return
 */
- (void)segmentControl:(HWCustomSegmentControl *)sControl didSelectSegmentIndex:(int)index
{
    if (index == 0)
    {
        [MobClick event:@"click_gameintroduction"]; //maidian_1.2.1
        [self delegateSetTitleView:self.gameDetailModel.gameInfoModel.gameName];
        _belowSegmentViewForCommission.hidden = YES;
        _belowSegmentViewForGameDetail.hidden = NO;
        _spreadBtn.hidden = NO;
    }
    else
    {
        [MobClick event:@"click_commission"]; //maidian_1.2.1
        [self delegateSetTitleView:@"佣金详情"];
        _belowSegmentViewForCommission.hidden = NO;
        _belowSegmentViewForGameDetail.hidden = YES;
        _spreadBtn.hidden = YES;
    }
}

#pragma mark - VC 设置 NavigationTitleView 方法（调用代理）
- (void)delegateSetTitleView:(NSString *)titleStr
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setNavTitleView:)])
    {
        
        [self.delegate setNavTitleView:titleStr];
    }
}

#pragma mark - UI
/**
 *	@brief	加载segment之上及segment的UI
 *
 *	@return
 */
- (void)loadUpSegmentUpUI
{
    _segmentAndUpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140)];
    _segmentAndUpView.backgroundColor = [UIColor clearColor];
    [self addSubview:_segmentAndUpView];
    
    _headImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 144/2, 144/2)];
    _headImageV.backgroundColor = IMAGE_DEFAULT_COLOR;
    _headImageV.contentMode = UIViewContentModeScaleAspectFit;
    _headImageV.layer.cornerRadius = 6.0f;
    _headImageV.layer.masksToBounds = YES;
    [_segmentAndUpView addSubview:_headImageV];
    
    _gameCommissionTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageV.frame) + 10, 12, kScreenWidth - 15 -(CGRectGetMaxX(_headImageV.frame)) - 10, 20)];
    _gameCommissionTitleLab.backgroundColor = [UIColor clearColor];
    _gameCommissionTitleLab.textColor = THEME_COLOR_TEXT;
    _gameCommissionTitleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_segmentAndUpView addSubview:_gameCommissionTitleLab];
    
    _gameCommissionSubTLab =  [[UILabel alloc]initWithFrame:CGRectMake(_gameCommissionTitleLab.frame.origin.x, CGRectGetMaxY(_gameCommissionTitleLab.frame) + 3, _gameCommissionTitleLab.frame.size.width, 20)];
    _gameCommissionSubTLab.backgroundColor = [UIColor clearColor];
    _gameCommissionSubTLab.textColor = THEME_COLOR_TEXT;
    _gameCommissionSubTLab.numberOfLines = 0;
    _gameCommissionSubTLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_segmentAndUpView addSubview:_gameCommissionSubTLab];
    
    _gameComissionEndDateLab = [[UILabel alloc]initWithFrame:CGRectMake(_gameCommissionTitleLab.frame.origin.x, CGRectGetMaxY(_gameCommissionSubTLab.frame) + 3, _gameCommissionTitleLab.frame.size.width, 20)];
    _gameComissionEndDateLab.backgroundColor = [UIColor clearColor];
    _gameComissionEndDateLab.textColor = THEME_COLOR_TEXT;
    _gameComissionEndDateLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_segmentAndUpView addSubview:_gameComissionEndDateLab];
    
    for (int i = 0; i < 2; i++)
    {
        UILabel *lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + i * 99.5, kScreenWidth, 0.5)];
        lineLab.backgroundColor = THEME_COLOR_LINE;
        [_segmentAndUpView addSubview:lineLab];
    }
    
    UIView *whitBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 41)];
    whitBackgroundView.backgroundColor = [UIColor whiteColor];
    [_segmentAndUpView addSubview:whitBackgroundView];
    
    _segmentControl = [[HWCustomSegmentControl alloc]initWithTitles:[NSArray arrayWithObjects:@"游戏详情",@"佣金明细", nil] fram: CGRectMake(15, 10, kScreenWidth - 15 * 2, 30)];
    _segmentControl.selectedIndex = 0;
    _segmentControl.delegate = self;
    [whitBackgroundView addSubview:_segmentControl];
}

/**
 *	@brief	加载游戏详情时segmentView 之下的UI
 *
 *	@return
 */
- (void)loadBlowSegmentUIForGameDetail
{
    _belowSegmentViewForGameDetail = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, kScreenWidth, CONTENT_HEIGHT - 140 - 45)];
    _belowSegmentViewForGameDetail.showsVerticalScrollIndicator = NO;
    _belowSegmentViewForGameDetail.backgroundColor = [UIColor whiteColor];
    [self addSubview:_belowSegmentViewForGameDetail];
    
    UILabel *miaoShuLab = [[UILabel alloc]initWithFrame:CGRectMake(15,10, 60, 20)];
    miaoShuLab.backgroundColor = [UIColor clearColor];
    miaoShuLab.textColor = THEME_COLOR_SMOKE;
    miaoShuLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALLTITLE];
    miaoShuLab.text = @"描述";
    [_belowSegmentViewForGameDetail addSubview:miaoShuLab];
    
    _gameDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(18, CGRectGetMaxY(miaoShuLab.frame) + 5, kScreenWidth - 15 * 2, 20)];
    _gameDetailLab.backgroundColor = [UIColor clearColor];
    _gameDetailLab.textColor = THEME_COLOR_TEXT;
    _gameDetailLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _gameDetailLab.numberOfLines = 0;
    [_belowSegmentViewForGameDetail addSubview:_gameDetailLab];
    
    float h1 = CONTENT_HEIGHT - 140 - 45 - CGRectGetMaxY(_gameDetailLab.frame) - 10;
    float h2 = 175 / 2.0f * 3.0f * kScreenRate;
    CGFloat height = h1 > h2 ? h1 : h2;
    _imgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_gameDetailLab.frame) + 10, kScreenWidth - 15, height)];
    _imgScrollView.backgroundColor = [UIColor clearColor];
    [_belowSegmentViewForGameDetail addSubview:_imgScrollView];
    
    _belowSegmentViewForGameDetail.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_imgScrollView.frame) + 10);
}

/**
 *	@brief	加载每日佣金时 segmentView 之下的UI
 *
 *	@return
 */
- (void)loadBlowSegmentUIForCommissionDetail
{
    
    _belowSegmentViewForCommission = [[HWCommissionDetailView alloc] initWithFrame:CGRectMake(0, 140, kScreenWidth, CONTENT_HEIGHT - 140) andGameId:self.gameId];
    [self addSubview:_belowSegmentViewForCommission];
}

@end
