//
//  HWSearchChannelView.m
//  Community
//
//  Created by caijingpeng.haowu on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：添加话题 view 搜索框
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-01-14           创建文件
//     杨庆龙     2015-01-22           删除 删除已选话题功能
//

#import "HWSearchChannelView.h"

@implementation HWSearchChannelView
@synthesize delegate;
@synthesize curChannel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = NO;
        [self initialSearchBar];
        [self addTextAbserver];
        [self queryHotChannel];
    }
    return self;
}

- (void)setCurChannel:(HWChannelModel *)cChannel
{
    curChannel = cChannel;
//    [self initialDeleteChannel];
}

- (void)initialSearchBar
{
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _searchView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_searchView];
    
    _searchBarTF = [[HWTextField alloc] initWithFrame:CGRectMake(15, 25, kScreenWidth - 50 - 15, 30)];
    _searchBarTF.layer.borderColor = THEME_COLOR_LINE.CGColor;
    _searchBarTF.layer.borderWidth = 0.5f;
    _searchBarTF.layer.cornerRadius = 3.0f;
    _searchBarTF.layer.masksToBounds = YES;
    _searchBarTF.leftViewMode = UITextFieldViewModeAlways;
    _searchBarTF.delegate = self;
    
    UIButton *leftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftView setImage:[UIImage imageNamed:@"search_small"] forState:UIControlStateNormal];
    leftView.userInteractionEnabled = NO;
    leftView.frame = CGRectMake(0, 0, 30, 30);
    
    _searchBarTF.leftView = leftView;
    _searchBarTF.placeholder = @"搜索话题";
    _searchBarTF.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    [_searchView addSubview:_searchBarTF];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.frame = CGRectMake(kScreenWidth - 50, CGRectGetMinY(_searchBarTF.frame), 50, CGRectGetHeight(_searchBarTF.frame));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    [cancelBtn setTitleColor:THEME_COLOR_ORANGE forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelSearch:) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:cancelBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_searchView.frame) - 0.5f, CGRectGetWidth(_searchView.frame), 0.5f)];
    line.backgroundColor = THEME_COLOR_LINE;
    [_searchView addSubview:line];
    
    self.baseTable.frame = CGRectMake(0, CGRectGetMaxY(_searchView.frame), kScreenWidth, self.frame.size.height - CGRectGetHeight(_searchView.frame));
    self.baseTable.hidden = YES;
    
    
}

- (void)initialDeleteChannel
{
    if (self.curChannel.channelId.length != 0 && _deleteButton == nil)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, CGRectGetMaxY(_searchView.frame), kScreenWidth, 45.0f)];
        [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GRAY_NORMAL andSize:CGSizeMake(kScreenWidth, 45.0f)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GRAY_HIGHLIGHT andSize:CGSizeMake(kScreenWidth, 45.0f)] forState:UIControlStateHighlighted];
        [btn setTitle:@"删除已选话题" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
        [btn addTarget:self action:@selector(toDeleteChannel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        _deleteButton = btn;
        
        self.baseTable.frame = CGRectMake(0,
                                          CGRectGetMaxY(btn.frame),
                                          kScreenWidth,
                                          self.frame.size.height - CGRectGetHeight(_searchView.frame) - CGRectGetHeight(btn.frame));
    }
}

#pragma mark -
#pragma mark        Private Method

/**
 *	@brief	删除已选话题
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)toDeleteChannel:(id)sender
{
    __weak HWSearchChannelView *weakSelf = self;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            [weakSelf deleteCurrentChannel];
        }
    }];
}

- (void)deleteCurrentChannel
{
    [UIView animateWithDuration:0.6f animations:^{
        
        _deleteButton.alpha = 0.0f;
        self.baseTable.frame = CGRectMake(0, CGRectGetMaxY(_searchView.frame), kScreenWidth, self.frame.size.height - CGRectGetHeight(_searchView.frame));
        
    } completion:^(BOOL finished) {
        
        [_deleteButton removeFromSuperview];
        _deleteButton = nil;
    }];
    
    if (delegate && [delegate respondsToSelector:@selector(didDeleteCurrentChannel)])
    {
        [delegate didDeleteCurrentChannel];
    }
    
}

/**
 *	@brief	取消搜索按钮
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)cancelSearch:(id)sender
{
    [MobClick event:@"click_dianjiquxiaoshousuo"]; //maidian_1.2.1
//    self.baseTable.hidden = YES;
//    [self showEmptyView:@"sdfasfasf"];
//    return;
    if (delegate && [delegate respondsToSelector:@selector(searchChannelViewCancelSearch)])
    {
        [delegate searchChannelViewCancelSearch];
    }
}

/**
 *	@brief	创建话题
 *
 *	@param 	sender
 *
 *	@return
 */
- (void)createChannel:(id)sender
{
    [MobClick event:@"click_chuangjianpingdaochuangjian"]; //maidian_1.2.1
    /*
     接口URL:hw-sq-app-web/channel/simpleAdd.do
     描述:发布主题时简单创建话题
     name;话题名称
     userId:用户Id
     villageId:小区ID
     key:用户KEY
     出参:
     { "status": "1", "data":"
     {"chanelId:话题ID"}
     ", "detail": "请求数据成功!", "key": "ad5d8829-fa15-44db-87be-00acecf67ee5" }
     */
    if (_searchBarTF.text.length == 0)
    {
        [Utility showToastWithMessage:@"请输入话题内容" inView:self];
        return;
    }
    if ([Utility stringContainsEmoji:_searchBarTF.text])
    {
        [Utility showToastWithMessage:@"爱卿，话题不能包含表情符号哦~" inView:self];
        return;
    }
    
    //话题字数限制
    if ([Utility calculateTextLength:_searchBarTF.text] > 11)
    {
        [Utility showToastWithMessage:@"话题名称最多11个字" inView:self];
        return;
    }
    
    [Utility showMBProgress:self message:@"创建中"];
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_searchBarTF.text forKey:@"name"];
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [param setPObject:[HWUserLogin currentUserLogin].villageId forKey:@"villageId"];
    
    [manager POST:kCreateChannel parameters:param queue:nil success:^(id responese) {
        
        [Utility hideMBProgress:self];
        if (delegate && [delegate respondsToSelector:@selector(didCreateChannel:)])
        {
            NSDictionary *resultDic = [responese dictionaryObjectForKey:@"data"];
            
            HWChannelModel *model = [[HWChannelModel alloc] init];
            model.channelName = [resultDic stringObjectForKey:@"channelName"];
            model.channelId = [resultDic stringObjectForKey:@"channelId"];
            [delegate didCreateChannel:model];
        }
        
    } failure:^(NSString *code, NSString *error) {
        [Utility hideMBProgress:self];
        [Utility showToastWithMessage:error inView:self];
    }];
}

/**
 *	@brief	在键盘frame 变化时 刷新table frame
 *
 *	@param 	height 	<#height description#>
 *
 *	@return	<#return value description#>
 */
- (void)reloadTableFrame:(CGFloat)height
{
    CGRect frame = self.baseTable.frame;
    frame.size.height = self.frame.size.height - CGRectGetHeight(_searchView.frame) - height;
    self.baseTable.frame = frame;
}

/**
 *	@brief	重写父类 showEmptyView 在view上添加按钮
 *
 *	@param 	message 	显示信息
 *
 *	@return
 */
- (void)showEmptyView:(NSString *)message
{
    if ([self viewWithTag:1111])
    {
        [[self viewWithTag:1111] removeFromSuperview];
    }
    
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, (CONTENT_HEIGHT - 216 - 90) / 2.0f + (IPHONE4 ? 30 : 0), kScreenWidth, 90)];
    emptyView.backgroundColor = [UIColor clearColor];
    emptyView.tag = 1111;
    [self addSubview:emptyView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    [emptyView addSubview:label];
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [createBtn setTitle:@"创建此话题" forState:UIControlStateNormal];
    createBtn.frame = CGRectMake(15, 45.0f, emptyView.frame.size.width - 30, 45.0f);
    [createBtn setButtonOrangeStyle];
    [createBtn addTarget:self action:@selector(createChannel:) forControlEvents:UIControlEventTouchUpInside];
    [emptyView addSubview:createBtn];
    
}

/**
 *	@brief	当数据为空时  点击 事件 此时 收起键盘
 *
 *	@return
 */
- (void)queryListData
{
    [_searchBarTF resignFirstResponder];
}

/**
 *	@brief	请求 热门话题
 *
 *	@return
 */
- (void)queryHotChannel
{
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    [manager POST:kHotChannel parameters:param queue:nil success:^(id responese) {
        
        NSArray *resultDic = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        
        self.hotList = [NSMutableArray array];
        for (int i = 0; i < resultDic.count; i++)
        {
            HWChannelModel *cModel = [[HWChannelModel alloc] initWithChannel:[resultDic pObjectAtIndex:i]];
            [self.hotList addObject:cModel];
        }
        
        // 防止在搜索结果出来后 才请求到热门列表 覆盖搜索结果
        if (self.baseListArr.count == 0)
        {
            self.baseListArr = self.hotList;
            self.baseTable.hidden = NO;
            [self.baseTable reloadData];
        }
        
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)querySearchList
{
    /*
     接口URL:hw-sq-app-web/channel/search.do
     描述:
     入参:
     name:查询名称
     size：查询的条数，最大30条
     key:用户KEY
     */
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_searchBarTF.text forKey:@"name"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    
    [manager POST:kSearchList parameters:param queue:nil success:^(id responese) {
        
        NSArray *resultDic = [[responese dictionaryObjectForKey:@"data"] arrayObjectForKey:@"content"];
        
        self.baseListArr = [NSMutableArray array];
        for (int i = 0; i < resultDic.count; i++)
        {
            HWChannelModel *cModel = [[HWChannelModel alloc] initWithChannel:[resultDic pObjectAtIndex:i]];
            [self.baseListArr addObject:cModel];
        }
        
        // 防止在搜索结果出来后 才请求到热门列表 覆盖搜索结果
        if (self.baseListArr.count == 0)
        {
            if (_searchBarTF.text.length == 0)
            {
                self.baseTable.hidden = NO;
                [self hideEmptyView];
                return;
            }

            self.baseTable.hidden = YES;
            NSLog(@"_searchBarTF === %@",_searchBarTF.text);
            [self showEmptyView:[NSString stringWithFormat:@"未找到“%@”话题", _searchBarTF.text]];
        }
        else
        {
            self.baseTable.hidden = NO;
            [self hideEmptyView];
            
        }
        
        [self.baseTable reloadData];
        
    } failure:^(NSString *code, NSString *error) {
        [Utility showToastWithMessage:error inView:self];
    }];
}

#pragma mark -      
#pragma mark        UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
     NSLog(@"textField ==== %@",textField.text);
    
    return YES;
}

#pragma mark -
#pragma mark        UITableView Delegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    HWBaseTableViewCell *cell = (HWBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //改为以下的方法
    if (cell == nil)
    {
        cell = [[HWBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45.0f - 0.5f, tableView.frame.size.width, 0.5f)];
        line.backgroundColor = THEME_COLOR_LINE;
        [cell.contentView addSubview:line];
    }
    
    HWChannelModel *channel = [self.baseListArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = channel.channelName;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    cell.textLabel.textColor = THEME_COLOR_SMOKE;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_remenpingdaochuanjian"]; //maidian_1.2.1
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (delegate && [delegate respondsToSelector:@selector(searchChannelResult:)])
    {
        HWChannelModel *channel = [self.baseListArr objectAtIndex:indexPath.row];
        [delegate searchChannelResult:channel];
    }
}

#pragma mark -
#pragma mark        Keyboard Notification

- (void)addTextAbserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeTextAbserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)addKeyboardAbserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [_searchBarTF becomeFirstResponder];
}

- (void)removeKeyboardAbserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [self reloadTableFrame:keyboardSize.height];
}

- (void)keyboardWasHidden:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [self reloadTableFrame:keyboardSize.height];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [self reloadTableFrame:keyboardSize.height];
}

- (void)textDidChangeNotification:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[HWTextField class]])
    {
//        HWTextField *textField = notification.object;
//        NSLog(@"%@,%@", _searchBarTF.text, textField.text);
        
        if ([Utility stringContainsEmoji:_searchBarTF.text])
        {
            [Utility showToastWithMessage:@"爱卿，话题不能包含表情符号哦~" inView:self];
            return;
        }
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(querySearchList) object:nil];
        if (_searchBarTF.text.length == 0)
        {
            self.baseTable.hidden = NO;
            [self hideEmptyView];
            self.baseListArr = self.hotList;
            [self.baseTable reloadData];
        }
        else
        {
            
            [self performSelector:@selector(querySearchList) withObject:nil afterDelay:0.6f];
        }
    }
    
}
   
- (void)dealloc
{
    [self removeTextAbserver];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
