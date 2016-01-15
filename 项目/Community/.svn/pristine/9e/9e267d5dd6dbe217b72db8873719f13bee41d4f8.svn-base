//
//  HWAnnouncementViewController.m
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//  修改记录
//      李中强 2015-01-26 添加V1.2.1要求
//      李中强 2015-02-04 修改V1.2.1要求 按hwdetail

#import "HWAnnouncementViewController.h"
#import "HWNeighbourButton.h"
#import "HWCoreDataManager.h"
#import "HWMarginView.h"
#import "HWClickZanViewController.h"

@interface HWAnnouncementViewController ()

@end
#define kTransTag 999
@implementation HWAnnouncementViewController
@synthesize resourceType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //    [[IQKeyboardManager sharedManager]setEnable:NO];
    //    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    self.baseTableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    //    [[IQKeyboardManager sharedManager]setEnable:NO];
    //    [_commentTF resignFirstResponder];
    self.baseTableView.delegate = nil;
}

/**
 *	@brief	初始化方法
 *
 *	@param 	cardID 	卡片ID
 *
 *	@return	物业公告对象
 */
- (id)initWithCardInfo:(HWNeighbourItemClass *)cardInfo
{
    self = [super init];
    if (self) {
        _cardInfo = cardInfo;
        _isPush = YES;
    }
    return self;
}

- (id)initWithCardId:(NSString *)cardId{
    self = [super init];
    if (self) {
        _isPush = NO;
        _cardId = cardId;
    }
    return self;
}

- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.baseTableView.showEndFooterView = YES;
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(doBack)];
//    self.navigationItem.rightBarButtonItem = [Utility navWalletButton:self action:@selector(reportTopic)];
    self.navigationItem.titleView = [Utility navTitleView:@"物业公告"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeForNoti:) name:UITextViewTextDidChangeNotification object:nil];
    _commentAtId = nil;
    _commentAtStr = @"";
    
    self.baseTableView.frame = CGRectMake(0, 0, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 40 - 64);
    
    _commentV = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height- 45.5 - 64, kScreenWidth, 45.5)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        _commentV.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height- 45.5 - 44, kScreenWidth, 45.5);
    }
    _commentV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentV];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    lineV.backgroundColor = THEME_COLOR_LINE;
    [_commentV addSubview:lineV];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.frame = CGRectMake(kScreenWidth - 67, 8, 50, 30);
    [_commentButton setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:CGSizeMake(50, 30)] forState:UIControlStateNormal];
    [_commentButton setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:CGSizeMake(50, 30)] forState:UIControlStateHighlighted];
    [_commentButton setBackgroundColor:THEBUTTON_GREEN_NORMAL];
    [_commentButton setTitle:@"发送" forState:UIControlStateNormal];
    [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:16];
    _commentButton.userInteractionEnabled = NO;
    _commentButton.layer.cornerRadius = 5;
    _commentButton.layer.masksToBounds = YES;
    [_commentButton addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [_commentV addSubview:_commentButton];
    
    UIView *buttonLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, 45)];
    buttonLineView.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:221.0 / 255.0 blue:221.0 / 255.0 alpha:1];
    [_commentButton addSubview:buttonLineView];
    
    _commentTF = [[UITextView alloc]initWithFrame:CGRectMake(10, 8, kScreenWidth - 90, 32)];
//    _commentTF.backgroundColor = [UIColor whiteColor];
    _commentTF.font = [UIFont fontWithName:FONTNAME size:15];
    _commentTF.textColor = [UIColor lightGrayColor];
    _commentTF.text = @"发表评论";
    _commentTF.delegate = self;
    _commentTF.layer.cornerRadius = 5;
    _commentTF.layer.masksToBounds = YES;
    _commentTF.layer.borderWidth = 0.5f;
    _commentTF.layer.borderColor = THEME_COLOR_LINE.CGColor;
    [_commentV addSubview:_commentTF];
    
    _commentAtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 0, 26)];
    _commentAtLabel.backgroundColor = [UIColor clearColor];
    _commentAtLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL13];
    _commentAtLabel.textColor = THEME_COLOR_SMOKE;
    _commentAtLabel.layer.cornerRadius = 5;
    _commentAtLabel.layer.masksToBounds = YES;
    [_commentTF addSubview:_commentAtLabel];
    
    if (_isPush)
    {
        [self createHeader];
        [self queryListData];
    }else
    {
        [self queryHeader];
    }
}

- (void)reportTopic{
    [MobClick event:@"click_more"];
    _reportId = _cardInfo.cardID;
    _reportType = @"0";
    [self doReport];
}

- (void)doReport{
    UIActionSheet *act = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"举报", nil];
    act.delegate = self;
    [act showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [param setPObject:_reportId forKey:@"commentId"];
        [param setPObject:_reportType forKey:@"type"];
        
        [manager POST:kReport parameters:param queue:nil success:^(id responObject) {
            [Utility showToastWithMessage:@"举报成功" inView:self.view];
        } failure:^(NSString *code, NSString *error) {
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
}

- (void)queryHeader
{
    NSDictionary *dict = @{@"key": [HWUserLogin currentUserLogin].key,@"topicId":_cardId};
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourDetailHead parameters:dict queue:nil success:^(id responObject) {
        _cardInfo = [[HWNeighbourItemClass alloc]init];
        [_cardInfo fillObjectWithDictionary:[responObject dictionaryObjectForKey:@"data"]];
        [self createHeader];
        NSDictionary *commentDic = [NSDictionary dictionaryWithObject:_cardInfo.commentCount forKey:@"commentCount"];
        if (resourceType == detailResourceNeighbour)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HWCommontNotification object:nil userInfo:commentDic];
        }
        else if (resourceType == detailResourceChannel)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HWChannelCommontNotification object:nil userInfo:commentDic];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:kRefreshNeighbour object:nil];
        [self queryListData];
    } failure:^(NSString *code, NSString *error) {
        
    }];
}

- (void)createHeader
{
    if ([_cardInfo.isShowReport isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    _headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kCardHeight + kBottomHeight + kIntervalHeight)];
    _headerV.backgroundColor = [UIColor whiteColor];
    
    float height = 0.0;
    
    if (IOS7)
    {
        CGRect rect = [_cardInfo.content boundingRectWithSize:CGSizeMake(kScreenWidth - 15 * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        height = rect.size.height;
    }
    else
    {
        CGSize size = [_cardInfo.content sizeWithFont:[UIFont fontWithName:FONTNAME size:14] constrainedToSize:CGSizeMake(kScreenWidth - 15 * 2, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        height = size.height;
    }
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, height)];
    [_headerV addSubview:textLabel];
    textLabel.numberOfLines = 0;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = _cardInfo.content;
    textLabel.font = [UIFont fontWithName:FONTNAME size:14.0];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_headerV addSubview:textLabel];
    
    height += 20;
    height += 95;
    
    _headerV.frame = CGRectMake(0, 0, kScreenWidth, height);
    
    HWMarginView *marginV = [[HWMarginView alloc] initWithFrame:CGRectMake(0, _headerV.frame.size.height - 95, kScreenWidth, 10.0f)];
    [_headerV addSubview:marginV];
    
    if (!praise) {
        praise = [[HWPraiseView alloc] initWithFrame:CGRectMake(0, _headerV.frame.size.height - 85, kScreenWidth, 85)];
    }
    
    [praise setBackgroundColor:[UIColor whiteColor]];
    praise.item = _cardInfo;
    praise.detailType = resourceType;
    if ([_cardInfo.viewRange isEqualToString:@"2"])
    {
        praise.siftLabel.text = @"全国";
        praise.siftLabel.hidden = NO;
        praise.selectBtn.hidden = NO;
        praise.siftArrowImg.hidden = NO;
    }
    else if ([_cardInfo.viewRange isEqualToString:@"1"])
    {
        praise.siftLabel.text = @"同城";
        praise.siftLabel.hidden = NO;
        praise.selectBtn.hidden = NO;
        praise.siftArrowImg.hidden = NO;
    }
    else
    {
        praise.siftLabel.text = @"附近";
        praise.siftLabel.hidden = YES;
        praise.selectBtn.hidden = YES;
        praise.siftArrowImg.hidden = YES;
    }
    selectViewRangeStr = @"0";
    praise.delegate = self;
    [_headerV addSubview:praise];
    
    self.baseTableView.tableHeaderView = _headerV;
}

#pragma mark - HWPraiseViewDelegate
- (void)praiseBefore
{
    [self queryHeader];
}

/**
 *	@brief	添加筛选视图
 *
 *	@return
 */
- (void)siftClick
{
    NSArray *arrayRange;
    if ([_cardInfo.viewRange isEqualToString:@"2"])
    {
        arrayRange = @[@"全国",@"同城",@"附近"];
    }
    else if ([_cardInfo.viewRange isEqualToString:@"1"])
    {
        arrayRange = @[@"同城",@"附近"];
    }
    float headHeight = _headerV.frame.size.height;
    float tableScrollHeight = self.baseTableView.contentOffset.y;
    
    if (IPHONE4) {
        if (headHeight > CONTENT_HEIGHT - 135) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 165)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
    }
    else if (IPHONE5)
    {
        if (headHeight > CONTENT_HEIGHT - 135) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 156)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
    }
    else if (IPHONE6)
    {
        if (headHeight > CONTENT_HEIGHT - 135) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 180)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
    }
    else if (IPHONE6PLUS)
    {
        
        if (headHeight > CONTENT_HEIGHT - 180) {
            if (headHeight - tableScrollHeight < CONTENT_HEIGHT - 200)
            {
                [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
            else
            {
                [self canMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
            }
        }
        else
        {
            [self unMoveWithTableHeight:tableScrollHeight tableHeadHeight:headHeight siftArray:arrayRange];
        }
        
    }
    
    praise.siftArrowImg.transform = CGAffineTransformRotate(praise.siftArrowImg.transform, M_PI);
}

- (void)canMoveWithTableHeight:(float)tableScrollHeight tableHeadHeight:(float)headHeight siftArray:(NSArray *)arrayRange
{
    float height = 0;
    if (IPHONE6PLUS || IPHONE6)
    {
        height = 100;
    }
    else if (IPHONE5)
    {
        height = 140;
    }
    else if (IPHONE4)
    {
        height = 130;
    }
    [self.baseTableView setContentOffset:CGPointMake(0, tableScrollHeight + height) animated:YES];
    HWCustomSiftView *siftView = [[HWCustomSiftView alloc] initWithTitle:arrayRange andBtnFrame:CGRectMake(kScreenWidth - 85, (headHeight - tableScrollHeight - height - 40) / kScreenRate, 70, 30)];
    siftView.delegate = self;
    __block HWPraiseView *blockPraise = praise;
    [siftView setSelectedInfo:^(NSString *title) {
        NSLog(@"title = %@",title);
        blockPraise.siftLabel.text = title;
        selectViewRangeStr = title;
        blockPraise.siftArrowImg.transform = CGAffineTransformRotate(blockPraise.siftArrowImg.transform, M_PI);
        _currentPage = 0;
        [self queryListData];
    }];
    [self.view.window addSubview:siftView];
}

- (void)unMoveWithTableHeight:(float)tableScrollHeight tableHeadHeight:(float)headHeight siftArray:(NSArray *)arrayRange
{
    HWCustomSiftView *siftView = [[HWCustomSiftView alloc] initWithTitle:arrayRange andBtnFrame:CGRectMake(kScreenWidth - 85, (headHeight - tableScrollHeight - 40) / kScreenRate, 70, 30)];
    siftView.delegate = self;
    //        [siftView setBackImageView:nil];
    __block HWPraiseView *blockPraise = praise;
    [siftView setSelectedInfo:^(NSString *title) {
        NSLog(@"title = %@",title);
        blockPraise.siftLabel.text = title;
        selectViewRangeStr = title;
        blockPraise.siftArrowImg.transform = CGAffineTransformRotate(blockPraise.siftArrowImg.transform, M_PI);
        _currentPage = 0;
        [self queryListData];
    }];
    [self.view.window addSubview:siftView];
}

- (void)arrowClick
{
    [MobClick event:@"click_zantongderen"]; //maidian_1.2.1 MYP add
    
    //    //测试用
    //    HWRentsIntentionVC *rents = [[HWRentsIntentionVC alloc] init];
    //    [self.navigationController pushViewController:rents animated:YES];
    
    HWClickZanViewController *praiseVC = [[HWClickZanViewController alloc] init];
    praiseVC.topicId = _cardInfo.cardID;
    [self.navigationController pushViewController:praiseVC animated:YES];
}

#pragma mark - siftview delegate
- (void)hideSiftView
{
    praise.siftArrowImg.transform = CGAffineTransformRotate(praise.siftArrowImg.transform, M_PI);
}

- (void)beginEdit{
    [MobClick event:@"click_comment"];
    [_commentTF becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWNeighbourDetailListItemClass *detailClass = [dataList pObjectAtIndex:indexPath.row];
    return [HWNeighbourDetailCell getCellHeight:detailClass];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HWNeighbourDetailListItemClass *detailClass = [dataList pObjectAtIndex:indexPath.row];
    HWNeighbourDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if ([[HWUserLogin currentUserLogin].userId isEqualToString:detailClass.userId])
            cell = [[HWNeighbourDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier containingTableView:self.baseTableView leftUtilityButtons:nil rightUtilityButtons:[self rightButtonsDelete]];
        else
            cell = [[HWNeighbourDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier containingTableView:self.baseTableView leftUtilityButtons:nil rightUtilityButtons:[self rightButtonsReport]];
    }
    
//    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
//    [cell addGestureRecognizer:longPressGes];
    
    cell.delegate = self;
    [cell rebuildWithInfo:detailClass];
    [cell setCellHeight:[HWNeighbourDetailCell getCellHeight:detailClass]];
    
    if (indexPath.row == dataList.count - 1) {
        [cell setFinalLine];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell hideUtilityButtonsAnimated:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_pinglunliebiaodianduidian"]; //maidian_1.2.1
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HWNeighbourDetailListItemClass *detailClass = [dataList pObjectAtIndex:indexPath.row];
    
    [_commentTF becomeFirstResponder];
    [self.baseTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    if (![detailClass.userId isEqualToString:[HWUserLogin currentUserLogin].userId])
    {
        NSString *oldString = [[NSString alloc] init];
        if (_commentTF.text.length > _commentAtStr.length)
        {
            oldString = [[_commentTF.text substringFromIndex:_commentAtStr.length] substringToIndex:_commentTF.text.length - _commentAtStr.length];
        }
        
        _commentAtLabel.text = nil;
        _commentAtLabel.text = [NSString stringWithFormat:@"@%@ ",detailClass.nickName];
        CGSize size = [Utility calculateStringWidth:_commentAtLabel.text font:_commentAtLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 26)];
        _commentAtLabel.frame = CGRectMake(5, 3, size.width, 26);
        
        CGSize sizeEmpty = [Utility calculateStringWidth:@" " font:_commentAtLabel.font constrainedSize:CGSizeMake(CGFLOAT_MAX, 26)];
        NSUInteger num = size.width / sizeEmpty.width;
        NSMutableString *string = [[NSMutableString alloc] init];
        for (int i = 0; i < num; i ++)
        {
            [string appendString:@" "];
        }
        //    NSLog(@"string = %@  length = %d",string,string.length);
        _commentTF.text = [NSString stringWithFormat:@"%@%@",string,oldString];
        _commentAtStr = string;
        _commentAtId = detailClass.userId;
    }
}

#pragma mark - swtablecell
- (NSArray *)rightButtonsDelete
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

- (NSArray *)rightButtonsReport
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:UIColorFromRGB(0x858585) title:@"举报"];
    return rightUtilityButtons;
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    [MobClick event:@"click_zuohuapinglun"]; //maidian_1.2.1
    //根据index和datalist判断出是删除还是举报
    //index  按钮的第几个   cell
    NSIndexPath *cellIndexPath = [self.baseTableView indexPathForCell:cell];
    currentCellIndexPath = cellIndexPath;
    
    HWNeighbourDetailListItemClass *detailClass = [dataList pObjectAtIndex:cellIndexPath.row];
    if ([[HWUserLogin currentUserLogin].userId isEqualToString:detailClass.userId])
    {
        replyIdDelete = detailClass.replyId;
        
        //删除
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 9876;
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
    else
    {
        reportReplyId = detailClass.replyId;
        //举报
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确认举报?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 9875;
        [alert performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 9998 && buttonIndex == 1)
    {
        [Utility showMBProgress:self.view message:@"删除中..."];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:replyIdDelete forKey:@"replyId"];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [manager POST:kDeleteReply parameters:param queue:nil success:^(id responese) {
            [Utility hideMBProgress:self.view];
            [self queryListData];
            _cardInfo.commentCount = [NSString stringWithFormat:@"%d",[_cardInfo.commentCount intValue] - 1];
            praise.commentLabel.text = [NSString stringWithFormat:@"%@条评论",_cardInfo.commentCount];
            NSDictionary *commentDic = [NSDictionary dictionaryWithObject:_cardInfo.commentCount forKey:@"commentCount"];
            if (resourceType == detailResourceNeighbour)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:HWCommontNotification object:nil userInfo:commentDic];
            }
            else if (resourceType == detailResourceChannel)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:HWChannelCommontNotification object:nil userInfo:commentDic];
            }
            
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    else if (alertView.tag == 9999 && buttonIndex == 1)
    {
        [Utility showMBProgress:self.view message:@"正在举报..."];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [param setPObject:reportReplyId forKey:@"commentId"];
        [param setPObject:@"1" forKey:@"type"];
        
        [manager POST:kReport parameters:param queue:nil success:^(id responese) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:@"举报成功" inView:self.view];
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
    
    //评论删除 举报
    if (alertView.tag == 9876)
    {
        if (buttonIndex == 1)
        {
            [Utility showMBProgress:self.view message:@"删除中..."];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:replyIdDelete forKey:@"replyId"];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [manager POST:kDeleteReply parameters:param queue:nil success:^(id responese) {
                [Utility hideMBProgress:self.view];
                [self queryListData];
                _cardInfo.commentCount = [NSString stringWithFormat:@"%d",[_cardInfo.commentCount intValue] - 1];
                praise.commentLabel.text = [NSString stringWithFormat:@"%@条评论",_cardInfo.commentCount];
                NSDictionary *commentDic = [NSDictionary dictionaryWithObject:_cardInfo.commentCount forKey:@"commentCount"];
                if (resourceType == detailResourceNeighbour)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:HWCommontNotification object:nil userInfo:commentDic];
                }
                else if (resourceType == detailResourceChannel)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:HWChannelCommontNotification object:nil userInfo:commentDic];
                }
                
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
            }];
        }
        HWNeighbourDetailCell *cell = (HWNeighbourDetailCell *)[self.baseTableView cellForRowAtIndexPath:currentCellIndexPath];
        [cell hideUtilityButtonsAnimated:YES];
    }
    else if (alertView.tag == 9875)
    {
        if (buttonIndex == 1)
        {
            [Utility showMBProgress:self.view message:@"正在举报..."];
            HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
            [param setPObject:reportReplyId forKey:@"commentId"];
            [param setPObject:@"1" forKey:@"type"];
            
            [manager POST:kReport parameters:param queue:nil success:^(id responese) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:@"举报成功" inView:self.view];
            } failure:^(NSString *code, NSString *error) {
                [Utility hideMBProgress:self.view];
                [Utility showToastWithMessage:error inView:self.view];
            }];
        }
        HWNeighbourDetailCell *cell = (HWNeighbourDetailCell *)[self.baseTableView cellForRowAtIndexPath:currentCellIndexPath];
        [cell hideUtilityButtonsAnimated:YES];
    }
    
}
#pragma mark -
- (void)longPress:(UILongPressGestureRecognizer *)recognizer{
    
    [MobClick event:@"longpress_comment"];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.view];
        NSIndexPath *indexPath = [self.baseTableView indexPathForRowAtPoint:location];
        _longPressIndex = indexPath;
        UITableViewCell *cell = [self.baseTableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(doCopy:)];
        UIMenuItem *itReport = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(startReport:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:itCopy];
        [array addObject:itReport];
        [menu setMenuItems:array];
        [menu setTargetRect:recognizer.view.frame inView:baseTableView];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(doCopy:) || action == @selector(startReport:)) {
        return _isAllowCopy;
    }
    return NO;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

#pragma mark -

////***** 本页面复制+举报 +删除*****
- (void)doCopy:(id)sender{
    [MobClick event:@"click_copy"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:((HWNeighbourDetailListItemClass *)(dataList[_longPressIndex.row])).content];
    [Utility showToastWithMessage:@"已复制" inView:self.view];
}

- (void)startReport:(id)sender{
    [MobClick event:@"click_expose_comment"];
    _reportId = ((HWNeighbourDetailListItemClass *)(dataList[_longPressIndex.row])).replyId;
    _reportType = @"1";
    [self doReport];
}

////***** 本页面复制+举报 *****

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"发表评论"]) {
        textView.text = nil;
    }
    _isAllowCopy = NO;
    textView.textColor = [UIColor blackColor];
    [MobClick event:@"get_focus_comment"];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    _isAllowCopy = YES;
    if (textView.text.length == 0) {
        textView.text = @"发表评论";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *string = [textView.text mutableCopy];
    [string replaceCharactersInRange:range withString:text];
    
    if (string.length > _commentAtStr.length)
    {
        [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
        _commentButton.userInteractionEnabled = YES;
    }
    else
    {
        [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
        _commentButton.userInteractionEnabled = NO;
    }
    
    //当即将要删@人时
    _commentAtLabel.backgroundColor = [UIColor clearColor];
    if (string.length == _commentAtStr.length - 1)
    {
        _commentAtLabel.textColor = THEME_COLOR_ORANGE;
        _commentAtLabel.backgroundColor = RANDGreen;
    }
    else
    {
        _commentAtLabel.textColor = THEME_COLOR_SMOKE;
    }
    
    if (_commentAtStr.length > 0)
    {
        if (string.length < _commentAtStr.length - 1)
        {
            _commentAtLabel.text = @"";
            _commentTF.text = @"";
            _commentAtStr = @"";
            _commentAtId = nil;
        }
    }
    
    if (string.length > 200 + _commentAtStr.length)
    {
        return NO;
    }
    return YES;
}

#pragma mark - textfield通知
- (void)textViewChangeForNoti:(NSNotification *)noti
{
    _commentButton.userInteractionEnabled = YES;
    [_commentButton setTitleColor:THEME_COLOR_CELLCOLOR forState:UIControlStateNormal];
    
    UITextView *textView = (UITextView *)noti.object;
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        if (textView.text.length > 200 + _commentAtStr.length)
        {
            textView.text = [textView.text substringToIndex:200 + _commentAtStr.length];
            //            _commentTF.text = [textView.text substringFromIndex:20 + _commentAtStr.length];
        }
    }
}

/**
 *	@brief	键盘弹出通知响应方法
 *
 *	@param 	noti 	接收到得弹出键盘通知
 *
 *	@return	N/A
 */
- (void)keyboardShow:(NSNotification *)noti
{
    float interval = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    float height = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;
    [UIView animateWithDuration:interval animations:^{
        baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height - _commentV.frame.size.height);
        _commentV.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _commentV.frame.size.height - height - 64, kScreenWidth, _commentV.frame.size.height);
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
            _commentV.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _commentV.frame.size.height - height - 44,kScreenWidth, _commentV.frame.size.height);
        }
//        _commentTF.frame = CGRectMake(_commentTF.frame.origin.x, _commentTF.frame.origin.y, kScreenWidth - 10 - 45.5, 45);
        if (!_coverView) {
            _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height - _commentV.frame.size.height - 10)];
            [self.view addSubview:_coverView];
            [self.view bringSubviewToFront:_coverView];
            UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(resignResponder:)];
            panges.delegate = self;
            [_coverView addGestureRecognizer:panges];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder:)];
            tap.delegate = self;
            [_coverView addGestureRecognizer:tap];
        }
        _coverView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - height - _commentV.frame.size.height - 10);
    } completion:^(BOOL finished) {
//        [baseTableView setContentOffset:CGPointMake(0, (baseTableView.contentSize.height - baseTableView.bounds.size.height) < 0 ? 0 :(baseTableView.contentSize.height - baseTableView.bounds.size.height)) animated:YES];
    }];
}

- (void)resignResponder:(UIPanGestureRecognizer *)panges{
    [_coverView removeFromSuperview];
    _coverView = nil;
    [_commentTF resignFirstResponder];
}


/**
 *	@brief	键盘回收响应方法
 *
 *	@param 	noti 	接收到得回收键盘通知
 *
 *	@return	N/A
 */

- (void)keyboardHide:(NSNotification *)noti
{
    [_coverView removeFromSuperview];
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue] animations:^{
        baseTableView.frame = CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT - _commentV.frame.size.height);
        _commentV.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _commentV.frame.size.height - 64, kScreenWidth, 45.5);
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
            _commentV.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - _commentV.frame.size.height - 44, kScreenWidth, 45.5);
        }
//        _commentTF.frame = CGRectMake(_commentTF.frame.origin.x, _commentTF.frame.origin.y, kScreenWidth - 10, 45);
    }];
}


/**
 *	@brief	发送评论内容
 *
 *	@return	N/A
 */
- (void)sendComment
{
    [MobClick event:@"click_send_comment"];
    
    //剔除加的空格
    NSString *strComment = _commentTF.text;
    NSString *currentString = [[NSString alloc] init];
    //@人时 _commentTF里加的有对应长度的空格
    if (_commentTF.text.length > _commentAtStr.length)
    {
        //目的 截取从@人之后的长度
        currentString = [_commentTF.text substringFromIndex:_commentAtStr.length];
    }
    
    //产品要求 多个空格只保留一个 多个换行只保留一个
    //去掉重复的空格
    NSArray *arrayHaveEmpty = [currentString componentsSeparatedByString:@"  "];
    NSString *strHaveEmpty = [[NSString alloc] init];
    BOOL isEmpty = NO;
    for (int i = 0; i < arrayHaveEmpty.count; i ++)
    {
        if ([arrayHaveEmpty[i] isEqualToString:@""])
        {
            if (!isEmpty && i!=0) {
                //前一个不是空 加一个空格
                strHaveEmpty = [NSString stringWithFormat:@"%@%@",strHaveEmpty,@" "];
            }
            
            isEmpty = YES;
        }
        else
        {
            //上次是空格 这次不是空格了
            if (isEmpty) {
                strHaveEmpty = [NSString stringWithFormat:@"%@%@",strHaveEmpty,@" "];
            }
            strHaveEmpty = [NSString stringWithFormat:@"%@%@",strHaveEmpty,arrayHaveEmpty[i]];
        }
    }
    strHaveEmpty = [strHaveEmpty stringByReplacingOccurrencesOfString:@"  " withString:@" "];//去掉空格后
    
    //去掉多余换行
    NSArray *arrayHaveLine = [strHaveEmpty componentsSeparatedByString:@"\n\n"];
    NSString *strHaveLine = [[NSString alloc] init];
    BOOL isLine = NO;
    for (int i = 0; i < arrayHaveLine.count; i ++)
    {
        if ([arrayHaveLine[i] isEqualToString:@""]) {
            if (!isLine && i != 0) {
                strHaveLine = [NSString stringWithFormat:@"%@%@",strHaveLine,@"\n"];
            }
            isLine = YES;
        }
        else
        {
            if (isLine) {
                strHaveLine = [NSString stringWithFormat:@"%@%@",strHaveLine,@"\n"];
            }
            strHaveLine = [NSString stringWithFormat:@"%@%@",strHaveLine,arrayHaveLine[i]];
        }
    }
    strHaveLine = [strHaveLine stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];//去掉了多余的空格和换行
    
    
    NSString *publishStr = strHaveLine;
    
    if ([publishStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0)
    {
        [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
        _commentTF.text = strComment;
        return;
    }
    
    if ([publishStr length] == 0) {
        [Utility showToastWithMessage:@"写点内容再发吧~" inView:self.view];
        _commentTF.text = strComment;
        return;
    }
    
    
    [_commentTF resignFirstResponder];
    //cardId，key，comment（都为必填），atSendUserId（发送@人id，可为空），atReceiveUserId（接收@人id），topicUserId（主题作者用户id）,channelId(话题id)
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:_cardInfo.cardID forKey:@"cardId"];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:publishStr forKey:@"comment"];
    //    [param setPObject:@"0" forKey:@"isAnonymous"];  //是否匿名 0不匿名 1匿名
    [param setPObject:[HWUserLogin currentUserLogin].userId forKey:@"atSendUserId"];    //发送@人id，可为空
    if (_commentAtId != nil)
        [param setPObject:_commentAtId forKey:@"atReceiveUserId"];                      //被@人id
    
    [param setPObject:_cardInfo.userId forKey:@"topicUserId"];                          //主题作者的用户ID
    //    [param setPObject:@"" forKey:@"channelId"];                                       //频道ID
    
    [Utility showMBProgress:self.view message:LOADING_TEXT];
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kCreateReply parameters:param queue:nil success:^(id responObject)
     {
         [Utility hideMBProgress:self.view];
         if ([[[responObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"status"] isEqualToString:@"1"]) {
             [Utility showToastWithMessage:[[responObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"returnInfo"] inView:self.view];
             return ;
         }
         _commentTF.text = nil;
         _commentAtLabel.text = nil;
         _currentPage = 0;
         _cardInfo.commentCount = [NSString stringWithFormat:@"%d",_cardInfo.commentCount.intValue + 1];
         [self queryHeader];
         
         
         self.baseTableView.tableHeaderView.userInteractionEnabled = YES;
     } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

/**
 *	@brief	请求列表数据
 *
 *	@return	N/A
 */
- (void)queryListData
{
    if (!self.dataList) {
        self.dataList = [NSMutableArray array];
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [param setPObject:_cardInfo.cardID forKey:@"topicId"];
    [param setPObject:@(kPageCount) forKey:@"size"];
    [param setPObject:@(_currentPage) forKey:@"page"];
    if ([selectViewRangeStr isEqualToString:@"全国"])
        [param setPObject:@"0" forKey:@"showLevel"];
    else if ([selectViewRangeStr isEqualToString:@"同城"])
        [param setPObject:@"1" forKey:@"showLevel"];
    else if ([selectViewRangeStr isEqualToString:@"附近"])
        [param setPObject:@"2" forKey:@"showLevel"];
    else
        [param setPObject:@"0" forKey:@"showLevel"];
    
    __block HWPraiseView *blockPraise = praise;
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kNeighbourDetailList parameters:param queue:nil success:^(id responObject)
     {
         NSString *total = [[responObject dictionaryObjectForKey:@"data"] stringObjectForKey:@"totalElements"]; //评论总数
         blockPraise.commentLabel.text = [NSString stringWithFormat:@"%@条评论",total];
         NSArray *array = [[responObject dictionaryObjectForKey:@"data"]arrayObjectForKey:@"content"];
         if (array.count < kPageCount)
         {
             isLastPage = YES;
         }
         else
         {
             isLastPage = NO;
         }
         
         if (_currentPage == 0)
         {
             [dataList removeAllObjects];
         }
         for (int i = 0; i < array.count; i++)
         {
             HWNeighbourDetailListItemClass *listClass = [[HWNeighbourDetailListItemClass alloc]init];
             [listClass fillWithDictionary:array[i]];
             listClass.topicUserId = _cardInfo.userId;
             [dataList addObject:listClass];
         }
         
         [baseTableView reloadData];
         
         [self doneLoadingTableViewData];
         
         _headerV.userInteractionEnabled = YES;
         blockPraise.userInteractionEnabled = YES;
         blockPraise.praiseBtn.userInteractionEnabled = YES;
         self.baseTableView.tableHeaderView.userInteractionEnabled = YES;
         
         
     } failure:^(NSString *code, NSString *error) {
         [self doneLoadingTableViewData];
     }];
    
    
//    [self.baseTableView reloadData];
}

#pragma mark - HWNeighbourDetailCellDelegate
- (void)pasteSucceed{
    [Utility showToastWithMessage:@"已复制" inView:self.view];
}

- (void)reportWithReplyId:(NSString *)replyId
{
    _reportId = replyId;
    _reportType = @"1";
    [self doReport];
}
#pragma mark -
#pragma mark Audio Method


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
