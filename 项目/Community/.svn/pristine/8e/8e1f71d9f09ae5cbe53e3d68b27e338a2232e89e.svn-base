//
//  HWWeChatOldConfirmBindView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/14.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：老用户 确认关联 微信账号
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//
//

#import "HWWeChatOldConfirmBindView.h"

@implementation HWWeChatOldConfirmBindView
@synthesize weChatAccount;
@synthesize accountStr;
@synthesize passwordStr;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)initialView
{
    self.isNeedHeadRefresh = NO;
    [self initialHeaderView];
    [self initialFooterView];
}

#pragma mark -
#pragma mark    Initial View

- (void)initialHeaderView
{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 165)];
    _headerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableHeaderView = _headerView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, kScreenWidth, 25)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    label.text = @"你已有考拉账号，输入登录密码进行关联";
    [_headerView addSubview:label];
    
    [self initialBindView];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
//                                                            CGRectGetMaxY(_headerView.frame) - 0.5f,
//                                                            kScreenWidth,
//                                                            0.5f)];
//    line.backgroundColor = THEME_COLOR_LINE;
//    [_headerView addSubview:line];
}

/**
 *	@brief	hhii
 *
 *	@return
 */
- (void)initialFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    footerView.backgroundColor = [UIColor clearColor];
    self.baseTable.tableFooterView = footerView;
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0,
//                                                            0,
//                                                            kScreenWidth,
//                                                            0.5f)];
//    line.backgroundColor = THEME_COLOR_LINE;
//    [footerView addSubview:line];
    
    UIButton *bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bindBtn.frame = CGRectMake(15, 20.0f, kScreenWidth - 30.0f, 45.0f);
    [bindBtn setButtonOrangeStyle];
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(toBind:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:bindBtn];
}

- (void)initialBindView
{
    //  ********
    
    _logoLeftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f - 110, 60, 60, 60)];
    _logoLeftImgV.backgroundColor = [UIColor clearColor];
    _logoLeftImgV.layer.cornerRadius = 15.0f;
    _logoLeftImgV.layer.masksToBounds = YES;
    [_headerView addSubview:_logoLeftImgV];
    
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_logoLeftImgV.frame), CGRectGetMaxY(_logoLeftImgV.frame), CGRectGetWidth(_logoLeftImgV.frame), 27.5f)];
    _leftLabel.backgroundColor = [UIColor clearColor];
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    _leftLabel.textColor = THEME_COLOR_TEXT;
    _leftLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_headerView addSubview:_leftLabel];
    
    //  *********
    
    _logoRightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0f + 50, 60, 60, 60)];
    _logoRightImgV.backgroundColor = [UIColor clearColor];
    _logoRightImgV.layer.cornerRadius = 15.0f;
    _logoRightImgV.layer.masksToBounds = YES;
    [_headerView addSubview:_logoRightImgV];
    
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_logoRightImgV.frame), CGRectGetMaxY(_logoRightImgV.frame), CGRectGetWidth(_logoRightImgV.frame), 27.5f)];
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.textAlignment = NSTextAlignmentCenter;
    _rightLabel.textColor = THEME_COLOR_TEXT;
    _rightLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [_headerView addSubview:_rightLabel];
    
    
    //  ****** 绑定图标
    
    UIImageView *centerImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 11)];
    centerImgV.center = CGPointMake(CGRectGetMidX(_headerView.frame), CGRectGetMidY(_logoLeftImgV.frame));
    centerImgV.image = [UIImage imageNamed:@"associate_icon"];
    [_headerView addSubview:centerImgV];
    
    __weak UIImageView *weakLeftImgV = _logoLeftImgV;
    
    [_logoLeftImgV setImageWithURL:[NSURL URLWithString:weChatAccount.headIconUrl] placeholderImage:[UIImage imageNamed:@"associate_weixin"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakLeftImgV.image = [UIImage imageNamed:@"associate_weixin"];
        }
        else
        {
            weakLeftImgV.image = image;
        }
        
    }];
    
    _leftLabel.text = weChatAccount.userName;
    
    __weak UIImageView *weakRightImgV = _logoRightImgV;
    [_logoRightImgV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:[HWUserLogin currentUserLogin].avatar]] placeholderImage:[UIImage imageNamed:@"associate_kaola"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil)
        {
            weakRightImgV.image = [UIImage imageNamed:@"associate_kaola"];
        }
        else
        {
            weakRightImgV.image = image;
        }
        
    }];
    _rightLabel.text = [HWUserLogin currentUserLogin].nickname;
    
}

#pragma mark -
#pragma mark    Button Action Method

- (void)toBind:(id)sender
{
    /*
     接口名称：/hw-sq-app-web/weixin/bindWeixin.do
     输入参数：
     userId： 社区用户ID
     openid： 普通用户的标识，对当前开发者帐号唯一
     unionid： 用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
     nickname： 普通用户昵称
     sex： 普通用户性别，1为男性，2为女性
     headimgurl：用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可 选，0代表640*640正方形头像），用户没有头像时该项为空
     location： 微信用户所在位置
     输出参数：
     成功：（与社区登录接口返回信息相同）
     {
     status: "1",
     data:
     { userId: "1000167741407", residentId: "2001179", telephoneNum: "18221398089", nickname: "小太阳", gender: "1", favorite: "爱睡觉，爱看书，爱电影的考拉", avatarUrl: "file/downloadByKey.do?mKey=54ab5d0e9000efa7b6f3aa07", isGag: 0, key: "ad5d8829-fa15-44db-87be-00acecf67ee5", cityId: "310100", cityName: "上海市", villageId: "2", villageName: "驰翰别墅", villageAddress: "巨鹿路405", tenementId: "1015475489", shopId: "509133", isReceiveMsg: "1", isRecevieWy: "1", isRecevieShop: "1", isVoiceOn: "1", isShakeOn: "1", openid: "o6_bmasdasdsad6_2sgVt7hMZOPfL654321" }
     */
    
    [MobClick event:@"click_wechatlogin_inputpassword_notify"];
    
    [Utility showMBProgress:self message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setPObject:self.accountStr forKey:@"mobileNumber"];
    [dict setPObject:self.passwordStr forKey:@"password"];
    [dict setPObject:@"0" forKey:@"isNewUser"];
    [dict setPObject:self.weChatAccount.openId forKey:@"openid"];
    [dict setPObject:self.weChatAccount.unionId forKey:@"unionid"];
    [dict setPObject:self.weChatAccount.userName forKey:@"nickname"];
    [dict setPObject:self.weChatAccount.gender forKey:@"sex"];
    [dict setPObject:self.weChatAccount.headIconUrl forKey:@"headimgurl"];
    [dict setPObject:self.weChatAccount.location forKey:@"location"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [manager POST:kBindWeChat parameters:dict queue:nil success:^(id responseObject){
        //保存key [dict objectForK872588ey:@"key"];
        
        /*
         data =     {
         avatarUrl = "<null>";
         cityId = "<null>";
         cityName = "<null>";
         favorite = "<null>";
         gender = "<null>";
         isGag = "<null>";
         isReceiveMsg = "<null>";
         isRecevieShop = "<null>";
         isRecevieWy = "<null>";
         isShakeOn = "<null>";
         isVoiceOn = "<null>";
         key = "a0b4225a-ee0a-4607-a880-b924e76fad4b";
         nickname = "<null>";
         openid = "oNhYGj53r6W-GOCCQBI2H7D9Pq44";
         residentId = "<null>";
         shopId = "<null>";
         telephoneNum = 18618151325;
         tenementId = "<null>";
         userId = 1000937210766;
         villageAddress = "<null>";
         villageId = "<null>";
         villageName = "<null>";
         };
         */
        
        [Utility hideMBProgress:self];
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        
        if (delegate && [delegate respondsToSelector:@selector(didConfirmBindWeChatByUserInfo:)])
        {
            [delegate didConfirmBindWeChatByUserInfo:dataDic];
        }
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
        NSLog(@"error");
    }];
    
}

#pragma mark -
#pragma mark    UITableView Delegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    HWBaseTableViewCell *cell = (HWBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //改为以下的方法
    if (cell == nil)
    {
        cell = [[HWBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _passwordTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 0, 160, 45)];
    _passwordTF.placeholder = @"输入登录密码";
    _passwordTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    _passwordTF.textColor = THEME_COLOR_SMOKE;
    _passwordTF.delegate = self;
    _passwordTF.returnKeyType = UIReturnKeyDone;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.secureTextEntry = YES;
    [cell.contentView addSubview:_passwordTF];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
