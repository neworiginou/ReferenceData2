//
//  HWInviteCustomRecordDetailView.m
//  Community
//
//  Created by niedi on 15/6/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomRecordDetailView.h"
#import "QRCodeGenerator.h"
#import "HWAlertSlideChoseDateView.h"
#import "MTCustomActionSheet.h"
#import "AppDelegate.h"
#import "WXApi.h"

@interface HWInviteCustomRecordDetailView ()<MTCustomActionSheetDelegate>
{
    HWInviteCustomRecordModel *_model;
}
@end

@implementation HWInviteCustomRecordDetailView

- (instancetype)initWithFrame:(CGRect)frame withModel:(HWInviteCustomRecordModel *)model
{
    if (self = [super initWithFrame:frame])
    {
        self.isNeedHeadRefresh = NO;
        _model = model;
        [self loadUI];
    }
    return self;
}

- (void)buttomBtnClick
{
    if ([_model.isPast isEqualToString:@"1"] && ![_model.dateCount isEqualToString:@"-1"])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(reExtendWithModel:)])
        {
            [self.delegate reExtendWithModel:_model];
        }
    }
    else
    {
        NSMutableArray *arrImage = [[NSMutableArray alloc] init];
        NSMutableArray *arrName = [[NSMutableArray alloc] init];
        if ([Utility isInstalledWX])
        {
            [arrImage addObject:@"share_weixinfriend161"];
            [arrName addObject:@"微信好友"];
        }
        
        if ([Utility isInstalledQQ])
        {
            [arrImage addObject:@"share_qq161"];
            [arrName addObject:@"QQ"];
        }
        
        MTCustomActionSheet *actionSheet = [[MTCustomActionSheet alloc] initWithFrame:CGRectZero andImageArr:arrImage nameArray:arrName orientation:0];
        actionSheet.delegate = self;
        AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [actionSheet showInView:appDel.window];
    }
}

- (void)actionSheet:(MTCustomActionSheet *)actionSheet didClickButtonByIndex:(int)index
{
    if (index == 0)
    {
        [self shareToWeiXinFriend];
    }
    else
    {
        [self shareToQQFriend];
    }
}

- (void)shareToWeiXinFriend
{
    if (![WXApi isWXAppInstalled])
    {
        return;
    }
    
    NSArray *zxArr = [_model.zxing componentsSeparatedByString:@","];
    NSString *codeStr = [zxArr lastObject];
    NSString *villageStr = [zxArr pObjectAtIndex:3];
    NSString *tvIdStr = [zxArr pObjectAtIndex:2];
    NSString *shareUrl = [NSString stringWithFormat:@"%@?visitorId=%@&villageId=%@&code=%@", KShareInviteCustomUrl, tvIdStr, villageStr, codeStr];
    NSString *shareContent = [NSString stringWithFormat:@"有效期内至门卫处扫码即可入内！"];
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"邀请您%@来%@小区串门！", [self getDateStr], _model.villageName];
    [UMSocialData defaultData].urlResource.url = shareUrl;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:shareContent image:[UIImage imageNamed:@"Icon"] location:nil urlResource:nil presentedController:self.fatherVC completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" inView:self];
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" inView:self];
        }
    }];
}

- (void)shareToQQFriend
{
    if (![Utility isInstalledQQ])
    {
        return;
    }
    
    NSArray *zxArr = [_model.zxing componentsSeparatedByString:@","];
    NSString *codeStr = [zxArr lastObject];
    NSString *villageStr = [zxArr pObjectAtIndex:3];
    NSString *tvIdStr = [zxArr pObjectAtIndex:2];
    NSString *shareUrl = [NSString stringWithFormat:@"%@?visitorId=%@&villageId=%@&code=%@", KShareInviteCustomUrl, tvIdStr, villageStr, codeStr];
    NSString *shareContent = [NSString stringWithFormat:@"有效期内至门卫处扫码即可入内！"];
    
    [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
    [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"邀请您%@来%@小区串门！", [self getDateStr], _model.villageName];
    [UMSocialData defaultData].extConfig.qqData.shareText = shareContent;
    [UMSocialData defaultData].extConfig.qqData.shareImage = UIImageJPEGRepresentation([UIImage imageNamed:@"Icon"], 0.1f);
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQQ] content:shareContent image:nil location:nil urlResource:nil presentedController:self.fatherVC completion:^(UMSocialResponseEntity *response) {
        
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            [Utility showToastWithMessage:@"分享成功" inView:self];
            
        }
        else
        {
            [Utility showToastWithMessage:@"分享失败" inView:self];
        }
    }];
}

//已弃用
- (void)commitEdit:(NSString *)selectDate
{
    /*URL:/hw-sq-app-web/visitor/modifyVisitor.do
     入参：
     key
     visitorId 访客信息id
     date 延迟天数 1 2 3 7 -1
     出参：
     /访客手机/
     private String visitorMobile ;
     /访问小区/
     private String villageName ;
     /开始日期/
     private String visitorDate ;
     /有效天数/
     private String dateCount;
     /二维码/
     private String zxing;
     /访客名字/
     private String visitorName;
     /访客关系/
     private String relationship;
     /预约来访 – 0没有到访 1有到访/
     private String isVisit;
     /是否过期 — 0显示绿色 1显示灰色/
     private String isPast;
     /是否无效 ---- 0有效邀请 1无效邀请/
     private String isValid;
     /访客表id/
     private Long tvId;
     /按钮状态 ---------0显示 1显示/
     private String buttonStatus;
     /大于6个长期访客 ------ 0显示 1不显示/
     private String SixConunt;*/
    
    [Utility showMBProgress:self message:LOADING_TEXT];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_model.tvId forKey:@"visitorId"];
    [param setPObject:[self getValidity:selectDate] forKey:@"date"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KInviteCustomYanChang parameters:param queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self];
         
         NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
         _model = [[HWInviteCustomRecordModel alloc] initWithDict:dict];
         [self loadUI];
         
         [Utility showToastWithMessage:@"有效期延长成功" inView:self];
         
         [self doneLoadingTableViewData];
     }
          failure:^(NSString *code, NSString *error)
     {
         [Utility hideMBProgress:self];
         [Utility showToastWithMessage:error inView:self];
         [self doneLoadingTableViewData];
     }];
    
}

- (NSString *)getValidity:(NSString *)dayLengthStr
{
    if ([dayLengthStr isEqualToString:@"当天"])
    {
        return @"1";
    }
    else if ([dayLengthStr isEqualToString:@"两天"])
    {
        return @"2";
    }
    else if ([dayLengthStr isEqualToString:@"三天"])
    {
        return @"3";
    }
    else if ([dayLengthStr isEqualToString:@"一周"])
    {
        return @"7";
    }
    else if ([dayLengthStr isEqualToString:@"长期访客"])
    {
        return @"-1";
    }
    return @"";
}

- (void)loadUI
{
    DView *tableHeaderV = [DView viewFrameX:0 y:0 w:kScreenWidth h:480.0f];
    
    DView *topBackView = [DView viewFrameX:15 y:10 w:kScreenWidth - 2 * 15 h:335];
    topBackView.backgroundColor = THEME_COLOR_White;
    [topBackView setRadius:3.5f];
    topBackView.layer.borderWidth = 0.5f;
    topBackView.layer.borderColor = THEME_COLOR_LINE.CGColor;
    [tableHeaderV addSubview:topBackView];
    
    DImageV *rightTopImgV = [DImageV imagV:[self getRightTopImg:_model.dateCount type:_model.isPast] frameX:kScreenWidth - 2 * 15 - 65.0f y:0 w:65.0f h:65.0f];
    [topBackView addSubview:rightTopImgV];
    
    DLable *nameLab = [DLable LabTxt:_model.visitorName txtFont:TF16 txtColor:THEME_COLOR_SMOKE frameX:0 y:20.0f w:kScreenWidth - 2 * 15 h:16.0f];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:nameLab];
    
    NSString *detailStr = @"";
    if ([_model.dateCount isEqualToString:@"-1"])
    {
        detailStr = [NSString stringWithFormat:@"%@通行证", _model.villageName];
    }
    else
    {
        detailStr = [NSString stringWithFormat:@"拟于%@访问%@小区", [self getDateStr], _model.villageName];
    }
    DLable *detailLab = [DLable LabTxt:detailStr txtFont:TF14 txtColor:THEME_COLOR_TEXT frameX:0 y:CGRectGetMaxY(nameLab.frame) + 15 w:kScreenWidth - 2 * 15 h:13.0f];
    detailLab.textAlignment = NSTextAlignmentCenter;
    [topBackView addSubview:detailLab];
    
    DImageV *QRCodeImgV = [DImageV imagV:@"" frameX:(kScreenWidth - 210) / 2.0f y:CGRectGetMaxY(detailLab.frame) + 32 w:210 h:210];
    QRCodeImgV.backgroundColor = [UIColor whiteColor];
    QRCodeImgV.layer.borderColor = THEME_COLOR_LINE.CGColor;
    QRCodeImgV.layer.borderWidth = 0.5f;
    QRCodeImgV.image = [QRCodeGenerator qrImageForString:_model.zxing imageSize:QRCodeImgV.bounds.size.width];
    [topBackView addSubview:QRCodeImgV];
    
    DView *buttomView = [DView viewFrameX:15 y:CGRectGetMaxY(topBackView.frame)+ 19.2f w:kScreenWidth - 2 * 15 h:105];
    buttomView.backgroundColor = THEME_COLOR_White;
    [buttomView setRadius:3.5f];
    buttomView.layer.borderWidth = 0.5f;
    buttomView.layer.borderColor = THEME_COLOR_LINE.CGColor;
    [tableHeaderV addSubview:buttomView];
    
    NSString *btnTitle = @"";
    DLable *infoLab;
    if ([_model.isPast isEqualToString:@"1"] && ![_model.dateCount isEqualToString:@"-1"])
    {
        btnTitle = @"再次邀请";
        NSString *infoStr = @"访客通行证已过期，是否重新邀请？";
        infoLab = [DLable LabTxt:infoStr txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:0 y:10 w:kScreenWidth - 2 * 15 h:18.0f];
        infoLab.textAlignment = NSTextAlignmentCenter;
        [buttomView addSubview:infoLab];
        
        DButton *buttomBtn = [DButton btnTxt:btnTitle txtFont:TF18 frameX:15 y:CGRectGetMaxY(infoLab.frame) + 17 w:kScreenWidth - 2 * 15 - 2 * 15 h:45.0f target:self action:@selector(buttomBtnClick)];
        [buttomBtn setStyle:DBtnStyleMain];
        [buttomBtn setRadius:3.5f];
        [buttomView addSubview:buttomBtn];
    }
    else
    {
        btnTitle = @"分享二维码";
        DButton *buttomBtn = [DButton btnTxt:btnTitle txtFont:TF18 frameX:15 y:20.0f w:kScreenWidth - 2 * 15 - 2 * 15 h:45.0f target:self action:@selector(buttomBtnClick)];
        [buttomBtn setStyle:DBtnStyleMain];
        [buttomBtn setRadius:3.5f];
        [buttomView addSubview:buttomBtn];
    }
    
    DImageV *midImgV = [DImageV imagV:@"bg_16_03" frameX:15 y:CGRectGetMaxY(topBackView.frame) - 1.4f w:kScreenWidth - 2 * 15 h:22.0f];
    [tableHeaderV addSubview:midImgV];
    
    self.baseTable.tableHeaderView = tableHeaderV;
}

- (NSString *)getRightTopImg:(NSString *)dateStr type:(NSString *)isPastStr
{
    BOOL isPast = NO;
    if ([isPastStr isEqualToString:@"0"])
    {
        isPast = NO;
    }
    else
    {
        isPast = YES;
    }
    NSString *imgNameStr = @"";
    if ([dateStr isEqualToString:@"1"])
    {
        if (isPast)
        {
            imgNameStr = @"day_01-_2";
        }
        else
        {
            imgNameStr = @"day_01";
        }
    }
    else if ([dateStr isEqualToString:@"2"])
    {
        if (isPast)
        {
            imgNameStr = @"day_02_2";
        }
        else
        {
            imgNameStr = @"day_02";
        }
    }
    else if ([dateStr isEqualToString:@"3"])
    {
        if (isPast)
        {
            imgNameStr = @"day_03-_2";
        }
        else
        {
            imgNameStr = @"day_03";
        }
    }
    else if ([dateStr isEqualToString:@"7"])
    {
        if (isPast)
        {
            imgNameStr = @"day_04_2";
        }
        else
        {
            imgNameStr = @"day_04";
        }
    }
    else if ([dateStr isEqualToString:@"-1"])
    {
        imgNameStr = @"day_05";
    }
    return imgNameStr;
}

- (NSString *)getDateStr
{
    NSString *dateStr;
    if (_model.visitorDate.length == 19)
    {
        dateStr = [_model.visitorDate substringToIndex:10];
    }
    else
    {
        dateStr = _model.visitorDate;
    }
    return dateStr;
}

@end
