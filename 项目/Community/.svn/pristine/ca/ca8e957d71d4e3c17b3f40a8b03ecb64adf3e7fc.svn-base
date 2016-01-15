//
//  HWFeedBackViewController.m
//  Community
//
//  Created by zhangxun on 14-9-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWFeedBackViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "UMFeedbackTableViewCellLeft.h"
#import "UMFeedbackTableViewCellRight.h"
#import "UMContactViewController.h"

#define TOP_MARGIN 20.0f
#define kNavigationBar_ToolBarBackGroundColor  [UIColor colorWithRed:0.149020 green:0.149020 blue:0.149020 alpha:1.0]
#define kContactViewBackgroundColor  [UIColor colorWithRed:0.078 green:0.584 blue:0.97 alpha:1.0]

static UITapGestureRecognizer *tapRecognizer;
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"nav_btn_bg"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@interface HWFeedBackViewController ()
@property(nonatomic, copy) NSString *mContactInfo;
@end

@implementation HWFeedBackViewController
@synthesize mTextField = _mTextField, mTableView = _mTableView, mToolBar = _mToolBar, mFeedbackData = _mFeedbackData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setupTableView {
    _tableViewTopMargin = self.navigationController.navigationBar.frame.size.height;
    
    BOOL contactViewHide = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UMFB_ShowContactView"] boolValue];
    
    if (!contactViewHide) {
        _tableViewTopMargin = 88.0f;
        UILabel *title = (UILabel *) [self.mContactView viewWithTag:11];
        title.text = @"我的联系方式";
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"UMFB_ShowContactView"];
    } else {
        _tableViewTopMargin = 0;
        [self.mContactView removeFromSuperview];
    }
    
    self.mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    UIView *view = [[UIView alloc]init];
    self.mTableView.tableFooterView = view;
    self.mTableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.mTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - self.mToolBar.frame.size.height);
}

- (void)setupEGORefreshTableHeaderView {
    if (_refreshHeaderView == nil) {
        
        UMEGORefreshTableHeaderView *view = [[UMEGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.mTableView.bounds.size.height, self.mTableView.frame.size.width, self.mTableView.bounds.size.height)];
        view.delegate = (id <UMEGORefreshTableHeaderDelegate>) self;
        [self.mTableView addSubview:view];
        _refreshHeaderView = view;
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)setupToolbar
{

    self.navigationItem.rightBarButtonItem = [Utility navButton:self title:@"提交" action:@selector(sendFeedback:)];
    self.mToolBar.tintColor = UIColorFromRGB(0xe4e4e4);
    self.mToolBar.frame = CGRectMake(0, self.view.bounds.size.height - 74 - 15, kScreenWidth, 74 + 15);
    self.mToolBar.backgroundColor = UIColorFromRGB(0xe4e4e4);
    
    [self setupTextField];
    
    _suggestButton = [[HWSuggestTypeButton alloc]initWithFrame:CGRectMake(0, 0, 90, 45)];
    [_suggestButton setTitle:@"建议"];
    [_suggestButton addTarget:self action:@selector(doChangeType:)];
    [self.mToolBar addSubview:_suggestButton];
    
    _bugButton =[[HWSuggestTypeButton alloc]initWithFrame:CGRectMake(90, 0, 90, 45)];
    [_bugButton setTitle:@"Bug"];
    [_bugButton addTarget:self action:@selector(doChangeType:)];
    [self.mToolBar addSubview:_bugButton];
}

/**
 *	@brief	更改建议类型
 *
 *	@param 	btn 	点击的按钮
 *
 *	@return	N/A
 */
- (void)doChangeType:(UITapGestureRecognizer *)ges
{
    HWSuggestTypeButton *btn = (HWSuggestTypeButton *)ges.view;
    if ([btn isEqual:_suggestButton]) {
        [_bugButton setUnsel];
        if (btn.hasSelected) {
            [btn setUnsel];
            _suggestType = @"普通";
        }else{
            [btn setSel];
            _suggestType = @"建议";
        }
    }else{
        [_suggestButton setUnsel];
        if (btn.hasSelected) {
            [btn setUnsel];
            _suggestType = @"普通";
        }else{
            [btn setSel];
            _suggestType = @"Bug";
        }
    }
}

- (void)setupTextField
{
    _mTextField = [[UITextField alloc] initWithFrame:CGRectMake(6, 7 + 45, kScreenWidth - 12, 30.0f)];
    _mTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _mTextField.backgroundColor = [UIColor whiteColor];
    _mTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _mTextField.textAlignment = NSTextAlignmentLeft;
    _mTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _mTextField.borderStyle = UITextBorderStyleNone;
    _mTextField.font = [UIFont systemFontOfSize:14.0f];
    _mTextField.placeholder = @"请输入您的问题	";
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _mTextField.leftView = paddingView;
    _mTextField.leftViewMode = UITextFieldViewModeAlways;
    _mTextField.delegate = (id <UITextFieldDelegate>) self;
    [self.mToolBar addSubview:_mTextField];
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [MobClick event:@"get_focus_input"];
    return YES;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    UMContactViewController *contactViewController = [[UMContactViewController alloc] initWithNibName:@"UMContactViewController" bundle:nil];
    
    contactViewController.delegate = (id <UMContactViewControllerDelegate>) self;
    [self.navigationController pushViewController:contactViewController animated:YES];
    if ([self.mContactInfo length]) {
        contactViewController.textView.text = self.mContactInfo;
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_refreshHeaderView egoRefreshScrollViewShowLoadingManual:self.mTableView];
    [_refreshHeaderView egoRefreshScrollViewDataSourceStartManualLoading:self.mTableView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _suggestType = @"普通";
    self.view.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont fontWithName:FONTNAME size:19] forKey:UITextAttributeFont]];
    self.navigationItem.titleView = [Utility navTitleView:@"建议反馈"];
    
    [self.navigationController.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(kScreenWidth, (IOS7 ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar addSubview:lineV];
    [self setBackButton];
    [self setBackgroundColor];
    [self setupTableView];
    [self setupEGORefreshTableHeaderView];
    [self setupToolbar];
    [self setFeedbackClient];
    [self updateTableView:nil];
    [self handleKeyboard];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleSingleTap:)];
    [self.mContactView addGestureRecognizer:singleFingerTap];
    _shouldScrollToBottom = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)textViewDidChange:(UITextView *)textView
{
    [textView scrollRangeToVisible:NSMakeRange(textView.text.length, 1)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

- (void)setFeedbackClient {
    _mFeedbackData = [[NSArray alloc] init];
    feedbackClient = [UMFeedback sharedInstance];
    if ([self.appkey isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NO Umeng kUmengAppkey"
                                                        message:@"Please define UMENG_APPKEY macro!"
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    [feedbackClient setAppkey:self.appkey delegate:(id <UMFeedbackDataDelegate>) self];
    
    //    从缓存取topicAndReplies
    self.mFeedbackData = feedbackClient.topicAndReplies;
}

- (void)setBackgroundColor {
    //    self.mTableView.backgroundColor = [Utility ];
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBG"] forBarMetrics:UIBarMetricsDefault];
    //    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0){
    //        self.navigationController.navigationBar.barTintColor =  UIColorFromRGB(0xe4e4e4);
    //    }
    //    else{
    //        self.navigationController.navigationBar.tintColor = [Utility navCustomColor];
    //    }
    
    //    if ([self.mToolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
    //        UIImage *image = [self imageWithColor:kNavigationBar_ToolBarBackGroundColor];
    //        [self.mToolBar setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    //    } else {
    //        self.mToolBar.barStyle = UIBarStyleBlack;
    //    }
    //    self.mContactView.backgroundColor = kContactViewBackgroundColor;
}

- (void)setBackButton {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    [backBtn addTarget:self action:@selector(backToPrevious) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backToPrevious)];
    
//    backBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [backBtn setImage:[[UIImage imageNamed:@"album_back_default"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateNormal];
    [backBtn setImage:[[UIImage imageNamed:@"album_back_highlight"] stretchableImageWithLeftCapWidth:13 topCapHeight:0] forState:UIControlStateHighlighted];
    
    backBtn.frame = CGRectMake(0, 0, 24, 24);
    backBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5f, 320, 0.5f)];
//    line.backgroundColor = [Utility customBorderColor];
    [self.navigationController.navigationBar addSubview:line];
    
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self.mTextField resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         CGRect toolbarFrame = self.mToolBar.frame;
                         toolbarFrame.origin.y = self.view.bounds.size.height - keyboardHeight - toolbarFrame.size.height;
                         self.mToolBar.frame = toolbarFrame;
                         
                         CGRect tableViewFrame = self.mTableView.frame;
                         tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - keyboardHeight - self.mToolBar.frame.size.height + 45;
                         self.mTableView.frame = tableViewFrame;
                     }
                     completion:^(BOOL finished) {
                         if (_shouldScrollToBottom) {
                             [self scrollToBottom];
                         }
                     }
     ];
    
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect toolbarFrame = self.mToolBar.frame;
    toolbarFrame.origin.y = self.view.bounds.size.height - toolbarFrame.size.height;
    self.mToolBar.frame = toolbarFrame;
    
    CGRect tableViewFrame = self.mTableView.frame;
    tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - self.mToolBar.frame.size.height + 45;
    self.mTableView.frame = tableViewFrame;
    
    [UIView commitAnimations];
    
    [self.view removeGestureRecognizer:tapRecognizer];
}

- (void)backToPrevious
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendFeedback:(id)sender {
    [MobClick event:@"click_send_feedback"];
    [Utility showMBProgress:self.view.window message:@"提交中..."];
    if ([self.mTextField.text length]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:self.mTextField.text forKey:@"content"];
        
        if ([self.mContactInfo length]) {
            [dictionary setObject:[NSDictionary dictionaryWithObjectsAndKeys:self.mContactInfo, @"plain", nil] forKey:@"contact"];
        }
        [dictionary setObject:@[_suggestType] forKey:@"tags"];
        
        [feedbackClient post:dictionary];
        [self.mTextField resignFirstResponder];
        _shouldScrollToBottom = YES;
    }
    [Utility hideMBProgress:self.view.window];
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_mFeedbackData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *content = [[feedbackClient.topicAndReplies objectAtIndex:(NSUInteger) indexPath.row] objectForKey:@"content"];
    CGSize labelSize = [content sizeWithFont:[UIFont systemFontOfSize:15.0f]
                           constrainedToSize:CGSizeMake(226.0f, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];
    return labelSize.height + 20 + TOP_MARGIN + 6.5 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *L_CellIdentifier = @"L_UMFBTableViewCell";
    static NSString *R_CellIdentifier = @"R_UMFBTableViewCell";
    
    NSDictionary *data = [self.mFeedbackData objectAtIndex:(NSUInteger) indexPath.row];
    
    if ([[data valueForKey:@"type"] isEqualToString:@"dev_reply"]) {
        UMFeedbackTableViewCellLeft *cell = (UMFeedbackTableViewCellLeft *) [tableView dequeueReusableCellWithIdentifier:L_CellIdentifier];
        if (cell == nil) {
            cell = [[UMFeedbackTableViewCellLeft alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:L_CellIdentifier];
        }
        
        cell.textLabel.text = [data valueForKey:@"content"];
        
        cell.timestampLabel.text = [data valueForKey:@"datetime"];
        
        return cell;
    }
    else {
        
        UMFeedbackTableViewCellRight *cell = (UMFeedbackTableViewCellRight *) [tableView dequeueReusableCellWithIdentifier:R_CellIdentifier];
        if (cell == nil) {
            cell = [[UMFeedbackTableViewCellRight alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:R_CellIdentifier];
        }
        
        cell.textLabel.text = [data valueForKey:@"content"];
        cell.timestampLabel.text = [data valueForKey:@"datetime"];
        
        return cell;
        
    }
}

#pragma mark ContactViewController delegate method

- (void)updateContactInfo:(UMContactViewController *)controller contactInfo:(NSString *)info {
    if ([info length]) {
        self.mContactInfo = info;
        [self.mContactView removeFromSuperview];
//        UILabel *title = (UILabel *) [self.mContactView viewWithTag:11];
//        title.text = [NSString stringWithFormat:@"%@ : %@", @"我的联系方式", info];
    }
}

#pragma mark Umeng Feedback delegate

- (void)updateTableView:(NSError *)error {
    if ([self.mFeedbackData count]) {
        [self.mTableView reloadData];
//        [self.mTableView setContentOffset:CGPointMake(0, self.mTableView.contentSize.height -self.mTableView.bounds.size.height) animated:YES];
        [self.mTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_mFeedbackData.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)updateTextField:(NSError *)error {
    if (!error) {
        self.mTextField.text = @"";
        [feedbackClient get];
    }
}

- (void)getFinishedWithError:(NSError *)error {
    if (!error) {
        [self updateTableView:error];
    }
    
    if (_shouldScrollToBottom) {
        [self scrollToBottom];
    }
    
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}

- (void)postFinishedWithError:(NSError *)error {
    //    UIAlertView *alertView;
    //    if (!error)
    //    {
    //        alertView = [[UIAlertView alloc] initWithTitle:@"感谢您的反馈!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    }
    //    else
    //    {
    //        alertView = [[UIAlertView alloc] initWithTitle:@"发送失败!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    }
    //
    //    [alertView show];
    
    [self updateTextField:error];
}

- (void)doneLoadingTableViewData {
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mTableView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollToBottom {
    if ([self.mTableView numberOfRowsInSection:0] > 1) {
        int lastRowNumber = [self.mTableView numberOfRowsInSection:0] - 1;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.mTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)reloadTableViewDataSource {
    _reloading = YES;
    [feedbackClient get];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(UMEGORefreshTableHeaderView *)view {
    _shouldScrollToBottom = NO;
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(UMEGORefreshTableHeaderView *)view {
    return _reloading; // should return if data source model is reloading
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(UMEGORefreshTableHeaderView *)view {
    return [NSDate date]; // should return date data source was last changed
}

#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)dealloc{
    
    feedbackClient.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
