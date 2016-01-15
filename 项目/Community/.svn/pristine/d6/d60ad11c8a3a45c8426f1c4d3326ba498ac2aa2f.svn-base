//
//  HWServiceMoreView.m
//  Community
//
//  Created by niedi on 15/6/25.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceMoreView.h"
#import "HWServiceIcon.h"
#import "HWApplicationDetailViewController.h"
#import "HWWuYeServiceVC.h"
#import "HWHomeServiceVC.h"
#import "HWShopListViewController.h"
#import "HWTreasureRuleViewController.h"
#import "HWGoodsListViewController.h"
#import "HWSaleCenterViewController.h"
#import "HWCommondityListController.h"

@interface HWServiceMoreView ()
{
    UIView *_tableHeaderView;
    
    NSArray *homePageArr;
    NSMutableArray *deleteArr;
    
    NSMutableArray *_iconModelArr0;
    NSMutableArray *_iconModelArr1;
    NSMutableArray *_iconModelArr2;
    NSMutableArray *_iconModelArr3;
    
    NSMutableArray *_iconArr0;
    NSMutableArray *_iconArr1;
    NSMutableArray *_iconArr2;
    NSMutableArray *_iconArr3;
    
    HWServiceIcon *_currentIcon;
    CGPoint _iconTouchPoint;
}
@end

@implementation HWServiceMoreView

- (instancetype)initWithFrame:(CGRect)frame homePageIconArr:(NSArray *)iconArr
{
    if (self = [super initWithFrame:frame])
    {
        [self queryListData];
        homePageArr = iconArr;
        deleteArr = [NSMutableArray array];
        
        _iconArr0 = [NSMutableArray array];
        _iconArr1 = [NSMutableArray array];
        _iconArr2 = [NSMutableArray array];
        _iconArr3 = [NSMutableArray array];
    }
    return self;
}

- (void)queryListData
{
    [self queryIconData];
}

#pragma mark - icon 操作处理
- (void)commitIconChange
{
    /*URL:/hw-sq-app-web/authenticateUserHome/updateIcon.do
     入参：
     key
     villageId
     icons ----------name,name
     jsonString ----------name,iconMongoKey,linkUrl,type/name,iconMongoKey,linkUrl,type
     出参：*/
    
    HWServiceIconModel *model = [homePageArr pObjectAtIndex:0];
    NSMutableString *nameStr = [NSMutableString stringWithFormat:@"%@", model.name];
    NSMutableString *jsonStr = [NSMutableString stringWithFormat:@"%@,%@,%@,%@", model.name, model.iconMongoKey, model.linkUrl, model.modelType];
    for (int i = 1; i < homePageArr.count - 1; i++)
    {
        HWServiceIconModel *model = [homePageArr pObjectAtIndex:i];
        [nameStr appendFormat:@",%@", model.name];
        [jsonStr appendFormat:@"$%@,%@,%@,%@", model.name, model.iconMongoKey, model.linkUrl, model.modelType];
    }
    
    for (int i = 0; i < deleteArr.count; i++)
    {
        HWServiceIconModel *model = [deleteArr pObjectAtIndex:i];
        [nameStr appendFormat:@",%@", model.name];
        [jsonStr appendFormat:@"$%@,%@,%@,%@", model.name, model.iconMongoKey, model.linkUrl, model.modelType];
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    [param setPObject:nameStr forKey:@"icons"];
    [param setPObject:jsonStr forKey:@"jsonString"];
    [param setPObject:@"1.7.0" forKey:@"wyiconversion"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KServiceIconUpdate parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         
         [Utility showToastWithMessage:@"已经添加到首页" inView:self];
         [self deleteIconAnimation];
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"homePageRefreshIcon" object:nil];
         
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [deleteArr removeLastObject];
         
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)pushVCByIconModel:(HWServiceIconModel *)model
{
    NSString *linkUrl = [model.linkUrl lowercaseString];
    NSArray *strArr = [linkUrl componentsSeparatedByString:@":"];
    
    NSString *headStr = [strArr pObjectAtIndex:0];
    if ([headStr isEqualToString:@"kaola"])
    {
        // 应用内跳转
        NSString *secStr = [strArr pObjectAtIndex:1];
        if ([secStr isEqualToString:@"wyfw"]) //物业相关
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"jiaofei"])//缴费 KaoLa:WYFW:JIAOFEI
            {
                [self pushVCByClassStr:@"HWWuYePayVC"];
            }
            else if ([thirdStr isEqualToString:@"tousuzhongxin"])//投诉 KaoLa:WYFW:TOUSUZHONGXIN
            {
                [self pushVCByClassStr:@"HWPerpotyComplaintVC"];
            }
            else if ([thirdStr isEqualToString:@"gongwubaoxiu"])//报修 KaoLa:WYFW:GONGWUBAOXIU
            {
                [self pushVCByClassStr:@"HWPublicRepairVC"];
            }
            else if ([thirdStr isEqualToString:@"fangkeyaoqing"])//访客 KaoLa:WYFW:FANGKEYAOQING
            {
                [self pushVCByClassStr:@"HWInviteCustomVC"];
            }
            else if ([thirdStr isEqualToString:@"kuaididaishou"])//邮局 KaoLa:WYFW:KUAIDIDAISHOU
            {
                [self pushVCByClassStr:@"HWPostOfficeVC"];
            }
        }
        else if ([secStr isEqualToString:@"wysm"])//Kaola:WYSM:BAOJIEFUWU:{3}
        {
            NSString *detailStr = [strArr pObjectAtIndex:3];
            
            if ([detailStr rangeOfString:@"{"].location != NSNotFound && [detailStr hasSuffix:@"}"])
            {
                if (detailStr.length < 3)
                {
                    NSLog(@"id 不能为空");
                }
                else
                {
                    [self pushVCForShangMenFuWu:model serviceId:[detailStr substringWithRange:NSMakeRange(1, detailStr.length - 2)]];
                }
            }
        }
        else if ([secStr isEqualToString:@"daydaybuy"])//kaola:daydaybuy:index 天天团
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            
            if ([thirdStr isEqualToString:@"index"])
            {
                [self pushToTianTianTuan];
            }
        }
        else if ([secStr isEqualToString:@"xt"])//KaoLa:XT:CHAOSHI 超市
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            
            if ([thirdStr isEqualToString:@"chaoshi"])
            {
                HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController alloc] init];
                appDetailVC.navigationItem.titleView = [Utility navTitleView:model.name];
                appDetailVC.appUrl = model.linkUrl;
                [self pushVC:appDetailVC];
            }
            else if ([thirdStr isEqualToString:@"wuye"])    //物业首页 KaoLa:XT:WUYE
            {
                HWWuYeServiceVC *svc = [[HWWuYeServiceVC alloc] init];
                svc.isCompany = YES;
                svc.homePageIconArr = homePageArr;
                [self pushVC:svc];
            }
        }
        else if ([secStr isEqualToString:@"yy"])//KaoLa:YY:WUDIXIAN
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"wudixian"])//无底线-- KaoLa:YY:WUDIXIAN
            {
                [self pushCutApplication];
            }
            else if ([thirdStr isEqualToString:@"zushouzhongxin"])//租售中心-- KaoLa:YY:ZUSHOUZHONGXIN
            {
                [self pushSaleCenter];
            }
        }
        else if ([secStr isEqualToString:@"cut"])
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"index"])
            {
                [self pushCutApplication];//kaola:cut:index
            }
        }
        else if ([secStr isEqualToString:@"salecenter"])
        {
            NSString *thirdStr = [strArr pObjectAtIndex:2];
            if ([thirdStr isEqualToString:@"index"])
            {
                [self pushSaleCenter];
            }
        }
        else if ([secStr isEqualToString:@"zb"])//KaoLa:ZBFW:CANTING:{206}
        {
            NSString *detailStr = [strArr pObjectAtIndex:3];
            
            if ([detailStr hasPrefix:@"{"] && [detailStr hasSuffix:@"}"])
            {
                if (detailStr.length < 3)
                {
                    NSLog(@"id 不能为空");
                }
                else
                {
                    /*餐厅--KaoLa:ZBFW:CANTING
                     家政--Kaola:ZBFW:JIAZHENG:206
                     水果--Kaola:ZBFW:SHUIGUO:204
                     洗衣--Kaola:ZBFW:XIYI:205
                     开锁换锁--Kaola:ZBFW:KAISUOHUANSUO:207
                     快递--Kaola:ZBFW:KUAIDI:208
                     收废品--Kaola:ZBFW:SHOUFEIPIN:209
                     管道疏通--Kaola:ZBFW:GUANDAOSHUTONG:210
                     洗车--Kaola:ZBFW:XICHE:212
                     送水--Kaola:ZBFW:SONGSHUI:215
                     美容护理--Kaola:ZBFW:MEIRONGHULI:216
                     家电维修--Kaola:ZBFW:JIADIANWEIXIU:217
                     婴幼儿--Kaola:ZBFW:YINGYOUER:229
                     休闲小吃
                     五金
                     银行
                     运动健身
                     */
                    
                    NSString *typeId = [detailStr substringWithRange:NSMakeRange(1, detailStr.length - 2)];
                    [self pushForShop:typeId shopName:model.name];
                }
            }
        }
    }
    else
    {
        if ([linkUrl isEqualToString:@"www.kaola.mobi/koala/h5/tuangou/description"])
        {
            [self pushToTianTianTuan];
        }
        else
        {
            // web页面
            HWApplicationDetailViewController *appDetailVC = [[HWApplicationDetailViewController alloc] init];
            appDetailVC.navigationItem.titleView = [Utility navTitleView:model.name];
            appDetailVC.appUrl = model.linkUrl;
            [self pushVC:appDetailVC];
        }
    }
}

//普通类型（不需要参数）
- (void)pushVCByClassStr:(NSString *)classStr
{
    if (classStr.length  != 0)
    {
        Class clss = NSClassFromString(classStr);
        if (clss)
        {
            if ([classStr isEqualToString:@"HWInviteCustomVC"])
            {
                if ([HWUserLogin verifyBindMobileWithPopVC:self.fatherVC showAlert:YES])
                {
                    HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                    if ([HWUserLogin verifyIsLoginWithPresentVC:self.fatherVC toViewController:vc])
                    {
                        [self pushVC:vc];
                    }
                }
            }
            else if ([classStr isEqualToString:@"HWPublicRepairVC"])
            {
                if ([HWUserLogin verifyBindMobileWithPopVC:self.fatherVC showAlert:YES])
                {
                    HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                    if ([HWUserLogin verifyIsLoginWithPresentVC:self.fatherVC toViewController:vc])
                    {
                        [self pushVC:vc];
                    }
                }
            }
            else if ([classStr isEqualToString:@"HWPerpotyComplaintVC"])
            {
                if ([HWUserLogin verifyBindMobileWithPopVC:self.fatherVC showAlert:YES])
                {
                    HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                    if ([HWUserLogin verifyIsLoginWithPresentVC:self.fatherVC toViewController:vc])
                    {
                        [self pushVC:vc];
                    }
                }
            }
            else if ([classStr isEqualToString:@"HWPostOfficeVC"])
            {
                if ([HWUserLogin verifyBindMobileWithPopVC:self.fatherVC showAlert:YES])
                {
                    HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                    if ([HWUserLogin verifyIsLoginWithPresentVC:self.fatherVC toViewController:vc])
                    {
                        [self pushVC:vc];
                    }
                }
            }
            else if ([clss isSubclassOfClass:[HWBaseViewController class]])
            {
                HWBaseViewController *vc = [(HWBaseViewController *)[clss alloc] init];
                [self pushVC:vc];
            }
        }
    }
}

//上门服务类型
- (void)pushVCForShangMenFuWu:(HWServiceIconModel *)model serviceId:(NSString *)serviceId
{
    if ([HWUserLogin verifyBindMobileWithPopVC:self.fatherVC showAlert:YES])
    {
        HWHomeServiceVC *hvc = [[HWHomeServiceVC alloc] init];
        hvc.navTitleStr = model.name;
        hvc.serviceId = serviceId;
        if ([HWUserLogin verifyIsLoginWithPresentVC:self.fatherVC toViewController:hvc])
        {
            [self pushVC:hvc];
        }
    }
}

//天天团
- (void)pushToTianTianTuan
{
    HWCommondityListController *controller = [[HWCommondityListController alloc] init];
    [self pushVC:controller];
}

//周边小店类型
- (void)pushForShop:(NSString *)typeId shopName:(NSString *)shopName
{
    HWShopListViewController *shopListVC = [[HWShopListViewController alloc] init];
    shopListVC.typeId = typeId;
    shopListVC.shopName = shopName;
    [self pushVC:shopListVC];
}

- (void)pushCutApplication
{
    [MobClick event:@"click_bargain"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *agreeFlag = [userDefaults objectForKey:kAgreeProtocol];
    if (agreeFlag == nil || [agreeFlag isEqualToString:@"0"])
    {
        HWTreasureRuleViewController *treasureRuleVC = [[HWTreasureRuleViewController alloc] init];
        treasureRuleVC.isAgree = YES;
        [self pushVC:treasureRuleVC];
    }
    else
    {
        //        HWBargainGoodsController *barganCtrl = [[HWBargainGoodsController alloc]init];
        //        [self.navigationController pushViewController:barganCtrl animated:YES];
        
        //        HWTreasureViewController *treasureVC = [[HWTreasureViewController alloc] init];
        //        [self.navigationController pushViewController:treasureVC animated:YES];
        HWGoodsListViewController *goods = [[HWGoodsListViewController alloc] init];
        [self pushVC:goods];
    }
}

// 租售中心
- (void)pushSaleCenter
{
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [manager POST:kSaleCenter parameters:param queue:nil success:^(id responese) {
        //        NSLog(@"%@",responese);
        [Utility hideMBProgress:self];
        NSDictionary *dict = [responese dictionaryObjectForKey:@"data"];
        NSString *strToken = [dict stringObjectForKey:@"accessToken"];
        HWSaleCenterViewController *saleVC = [[HWSaleCenterViewController alloc] init];
        saleVC.strUrl = strToken;
        [self pushVC:saleVC];
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@",error);
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

#pragma mark - icon请求 及 初始化
- (void)queryIconData
{
    /*URL:/hw-sq-app-web/authenticateUserHome/moreIcon.do
     入参：
     key
     villageId
     出参：
     /icon名字/
     private String name;
     /icon图标/
     private String iconMongoKey;
     /link_url/
     private String linkUrl;
     /更多 4 大类/
     private String type;*/
    
    _iconModelArr0 = [NSMutableArray array];
    _iconModelArr1 = [NSMutableArray array];
    _iconModelArr2 = [NSMutableArray array];
    _iconModelArr3 = [NSMutableArray array];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    [param setPObject:@"1.7.0" forKey:@"wyiconversion"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:KServiceMoreIcon parameters:param queue:nil success:^(id responese)
     {
         NSLog(@"responese ========================= %@",responese);
         isLastPage = YES;
         
         NSArray *arr = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
         for (NSDictionary *tmpDict in arr)
         {
             HWServiceIconModel *model = [[HWServiceIconModel alloc] initWithDict:tmpDict];
             if ([model.modelType isEqualToString:@"1"])
             {
                 [_iconModelArr0 addObject:model];
             }
             else if ([model.modelType isEqualToString:@"2"])
             {
                 [_iconModelArr1 addObject:model];
             }
             else if ([model.modelType isEqualToString:@"3"])
             {
                 [_iconModelArr2 addObject:model];
             }
             else if ([model.modelType isEqualToString:@"4"])
             {
                 [_iconModelArr3 addObject:model];
             }
         }
         
         [self loadUI];
         
         [self.baseTable reloadData];
         [self doneLoadingTableViewData];
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
         [Utility showToastWithMessage:error inView:self];
     }];
}

- (void)loadUI
{
    [_tableHeaderView removeFromSuperview];
    _tableHeaderView = nil;
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    
    NSMutableArray *iconModelArrArr = [NSMutableArray array];
    if (_iconModelArr0.count != 0)
    {
        [iconModelArrArr addObject:_iconModelArr0];
    }
    if (_iconModelArr1.count != 0)
    {
        [iconModelArrArr addObject:_iconModelArr1];
    }
    if (_iconModelArr2.count != 0)
    {
        [iconModelArrArr addObject:_iconModelArr2];
    }
    if (_iconModelArr3.count != 0)
    {
        [iconModelArrArr addObject:_iconModelArr3];
    }
    
    for (NSArray *tmpArr in iconModelArrArr)
    {
        if (tmpArr.count != 0)
        {
            [self initWithIconBackViewWithArr:tmpArr];
        }
    }
    
    self.baseTable.tableHeaderView = _tableHeaderView;
}

- (void)initWithIconBackViewWithArr:(NSArray *)iconModelArr
{
    DView *iconBackview = [DView viewFrameX:0 y:CGRectGetMaxY(_tableHeaderView.frame) w:kScreenWidth h:(kScreenWidth / 3.0f) * ((iconModelArr.count % 3 != 0 ? 1 : 0) + iconModelArr.count / 3) + 30.0f];
    
    DView *whiteV = [DView viewFrameX:0 y:30.0f w:kScreenWidth h:(kScreenWidth / 3.0f) * ((iconModelArr.count % 3 != 0 ? 1 : 0) + iconModelArr.count / 3)];
    whiteV.backgroundColor = [UIColor whiteColor];
    [iconBackview addSubview:whiteV];
    
    DLable *titleLab = [DLable LabTxt:@"" txtFont:TF15 txtColor:THEME_COLOR_TEXT frameX:15 y:0 w:kScreenWidth - 2 * 15 h:30.0f];
    [iconBackview addSubview:titleLab];
    
    if (iconModelArr == _iconModelArr0)
    {
        titleLab.text = @"物业服务";
    }
    else if (iconModelArr == _iconModelArr1)
    {
        titleLab.text = @"上门服务";
    }
    else if (iconModelArr == _iconModelArr2)
    {
        titleLab.text = @"周边黄页";
    }
    else if (iconModelArr == _iconModelArr3)
    {
        titleLab.text = @"其它";
    }
    
    _tableHeaderView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_tableHeaderView.frame) + CGRectGetHeight(iconBackview.frame));
    [_tableHeaderView addSubview:iconBackview];
    
    [self initWithIconWithArr:iconModelArr backV:iconBackview];
}

- (void)initWithIconWithArr:(NSArray *)iconModelArr backV:(UIView *)iconBackview
{
    NSMutableArray *tmpIconArr;
    if (iconModelArr == _iconModelArr0)
    {
        tmpIconArr = _iconArr0;
    }
    else if (iconModelArr == _iconModelArr1)
    {
        tmpIconArr = _iconArr1;
    }
    else if (iconModelArr == _iconModelArr2)
    {
        tmpIconArr = _iconArr2;
    }
    else if (iconModelArr == _iconModelArr3)
    {
        tmpIconArr = _iconArr3;
    }
    
    CGFloat width = (kScreenWidth / 3.0f - 0.5f);
    CGFloat height = width;
    NSInteger rowNum = (iconModelArr.count % 3 != 0 ? 1 : 0) + iconModelArr.count / 3;
    
    for (int i = 0; i < iconModelArr.count; i++)
    {
        if (i == 0)
        {
            for (int j = 0; j < 2; j++)
            {
                UIImageView *line = [DImageV imagV:nil frameX:width * (j + 1) + j % 3 * 0.5f y:30.0f w:0.5f h:(height + 0.5f) * rowNum];
                line.backgroundColor = THEME_COLOR_LINE;
                [iconBackview addSubview:line];
                
                UIImageView *line2 = [DImageV imagV:nil frameX:0 y:30.0f + height * j + (j - 1) * 0.5f w:kScreenWidth h:0.5f];
                line2.backgroundColor = THEME_COLOR_LINE;
                [iconBackview addSubview:line2];
            }
        }
        else if (i % 3 == 0)
        {
            UIImageView *line3 = [DImageV imagV:nil frameX:0 y:30.0f + height * (i / 3 + 1) + 0.5 * (i / 3) w:kScreenWidth h:0.5f];
            line3.backgroundColor = THEME_COLOR_LINE;
            [iconBackview addSubview:line3];
        }
        
        HWServiceIconModel *model = [iconModelArr pObjectAtIndex:i];
        HWServiceIcon *icon = [[HWServiceIcon alloc] initWithFrame:CGRectMake(width * (i % 3) + i % 3 * 0.5f, 30.0f + height * (i / 3) + (i / 3) * 0.5f, width, height) model:model isDelImg:NO];
        icon.iconModelArr = iconModelArr;
        icon.iconArr = tmpIconArr;
        [icon addTarget:self action:@selector(tapAction:) forIconEvents:IconTap];
        [icon addTarget:self action:@selector(iconLongPressBegain:) forIconEvents:IconLongPressBegain];
        [icon addTarget:self action:@selector(iconLongPressEnd:) forIconEvents:IconLongPressEnd];
        [icon addTarget:self action:@selector(IconPanChange:) forIconEvents:IconPanChange];
        [icon addTarget:self action:@selector(iconPanEnd:) forIconEvents:IconPanEnd];
        [icon addTarget:self action:@selector(iconDelBtnClick:) forIconEvents:iconDel];
        [iconBackview addSubview:icon];
        
        [tmpIconArr addObject:icon];
    }
}

#pragma mark - icon 操作事件
- (CGPoint)getTargetCenter:(NSInteger)index iconBackV:(UIView *)backV
{
    CGFloat width = (kScreenWidth / 3.0f - 0.5f);
    CGFloat x = (index % 3 + 0.5f) * width + index % 3 * 0.5f;
    CGFloat y = 30.0f + (index / 3 + 0.5f) * width + index / 3 * 0.5f;
    return CGPointMake(x, y);
}

- (void)iconLongPressBegain:(UILongPressGestureRecognizer *)press
{
    //    NSLog(@"iconLongPressBegain");
    
    HWServiceIcon *icon = (HWServiceIcon *)press.view;
    _iconTouchPoint = [press locationInView:icon];
    if (_currentIcon != icon)
    {
        [_currentIcon hideDelBtnAnimation];
        _currentIcon = icon;
    }
    
    [icon.superview bringSubviewToFront:_currentIcon];
    
    CGPoint begainPoint = CGPointMake(_currentIcon.center.x, _currentIcon.center.y);
    [_currentIcon longPressBegainAction:begainPoint];
    
    self.baseTable.scrollEnabled = NO;
}

- (void)iconLongPressEnd:(UILongPressGestureRecognizer *)press
{
    //    NSLog(@"iconLongPressEnd");
    NSInteger targetIndex = [self getTargetIndex];
    HWServiceIcon *icon = (HWServiceIcon *)press.view;
    if (targetIndex != -1)
    {
        NSLog(@"icon.frame) %@", NSStringFromCGRect(icon.frame));
        CGPoint endPoint = [self getTargetCenter:targetIndex iconBackV:icon.superview];
        [_currentIcon longPressEndAction:endPoint];
    }
    else
    {
        CGPoint endPoint = [self getTargetCenter:[icon.iconModelArr indexOfObject:_currentIcon.model] iconBackV:icon.superview];
        [_currentIcon longPressEndAction:endPoint];
    }
    
    self.baseTable.scrollEnabled = YES;
}

- (void)IconPanChange:(UIPanGestureRecognizer *)pan
{
    
}

- (void)reloadViewAndIconArr:(NSInteger)lastIndex targetIndex:(NSInteger)targetIndex iconModelArr:(NSMutableArray *)iconModelArr iconArr:(NSMutableArray *)iconArr
{
    if (lastIndex < targetIndex)
    {
        NSLog(@"下移");
        for (int i = (int)lastIndex + 1; i <= targetIndex; i++)
        {
            HWServiceIcon *icon = [iconArr pObjectAtIndex:i];
            HWServiceIcon *tmpIcon = [iconArr pObjectAtIndex:i - 1];
            
            [UIView animateWithDuration:0.2 animations:^{
                icon.center = [self getTargetCenter:i - 1 iconBackV:icon.superview];
                
            } completion:^(BOOL finished) {
                
            }];
            
            [iconArr replaceObjectAtIndex:i-1 withObject:icon];
            [iconArr replaceObjectAtIndex:i withObject:tmpIcon];
            [iconModelArr replaceObjectAtIndex:i-1 withObject:icon.model];
            [iconModelArr replaceObjectAtIndex:i withObject:tmpIcon.model];
        }
    }
    else
    {
        NSLog(@"上移");
        for (int i = (int)lastIndex - 1; i >= targetIndex; i--)
        {
            HWServiceIcon *icon = [iconArr pObjectAtIndex:i];
            HWServiceIcon *tmpIcon = [iconArr pObjectAtIndex:i + 1];
            
            [UIView animateWithDuration:0.2 animations:^{
                icon.center = [self getTargetCenter:i + 1 iconBackV:icon.superview];
                
            } completion:^(BOOL finished) {
                
            }];
            
            [iconArr replaceObjectAtIndex:i + 1 withObject:icon];
            [iconArr replaceObjectAtIndex:i withObject:tmpIcon];
            [iconModelArr replaceObjectAtIndex:i + 1 withObject:icon.model];
            [iconModelArr replaceObjectAtIndex:i withObject:tmpIcon.model];
        }
    }
}

- (void)iconPanEnd:(UIPanGestureRecognizer *)pan
{
    
}

- (void)iconDelBtnClick:(HWServiceIcon *)icon
{
    NSLog(@"iconDelBtnClick");
    
    if (deleteArr.count + homePageArr.count >= 9)
    {
        [Utility showToastWithMessage:@"首页没有位置了" inView:self];
        [icon hideDelBtnAnimation];
        _currentIcon = nil;
        return;
    }
    
    [deleteArr addObject:icon.model];
    
    [self commitIconChange];
}

- (void)deleteIconAnimation
{
    NSMutableArray *iconModelArr = (NSMutableArray *)_currentIcon.iconModelArr;
    NSMutableArray *iconArr = (NSMutableArray *)_currentIcon.iconArr;
    
    NSInteger lastIndex = [iconModelArr indexOfObject:_currentIcon.model];
    NSInteger targetIndex = iconModelArr.count -1;
    
    [UIView animateWithDuration:0.3 animations:^{
        _currentIcon.alpha = 0.3;
        _currentIcon.transform = CGAffineTransformScale(_currentIcon.transform, 0.3, 0.3);
    } completion:^(BOOL finished) {
        _currentIcon.alpha = 0.0f;
        [_currentIcon removeFromSuperview];
        [self reloadViewAndIconArr:lastIndex targetIndex:targetIndex iconModelArr:iconModelArr iconArr:iconArr];
        [iconModelArr removeObject:_currentIcon.model];
        [iconArr removeObject:_currentIcon];
        if (iconModelArr.count % 3 == 0)
        {
            [self loadUI];
        }
        _currentIcon = nil;
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    HWServiceIcon *icon = (HWServiceIcon *)tap.view;
    if (_currentIcon.isDelBtnShow)
    {
        NSLog(@"tap hideDelBtnAnimation");
        [_currentIcon hideDelBtnAnimation];
    }
    else
    {
        [self pushVCByIconModel:icon.model];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    [_currentIcon hideDelBtnAnimation];
}

- (NSInteger)getTargetIndex
{
    int width = kScreenWidth / 3.0f;
    
    int currentx = _currentIcon.center.x;
    int currenty = _currentIcon.center.y - 0;
    
    if (currentx < 0 || currentx > kScreenWidth || currenty < CGRectGetMinY(_currentIcon.superview.frame) || currenty > CGRectGetMaxY(_currentIcon.superview.frame))
    {
        return -1;
    }
    
    NSInteger TargetIndex = (currentx / width) + 3 * (currenty / width);
    return TargetIndex;
}


#pragma mark - 其它
- (void)pushVC:(UIViewController *)VC
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushVC:)])
    {
        [self.delegate pushVC:VC];
    }
}

@end
