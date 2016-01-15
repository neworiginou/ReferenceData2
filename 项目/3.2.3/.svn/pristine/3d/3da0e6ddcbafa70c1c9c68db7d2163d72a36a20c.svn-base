//
//  HWSearchViewModel.m
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14-11-20.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//
//  功能描述：显示我的动态首页
//  修改记录：
//	姓名     日期         修改内容
//  陆晓波   2015-02-25   文件创建
//  陆晓波   2015-03-02   添加点击键盘search按钮代理，实现代理判断修改

#import "HWSearchViewModel.h"
#import "Define-OC.h"

@implementation HWSearchViewModel
{
    UIButton *cancelBtn;
    UIView *searchBar;
}
@synthesize delegate;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performTime) object:nil];
    titleStr = nil;
}

- (id)initWithDelegate:(id)myDelegate type:(NSString *)atype;
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,44)];
    if (self)
    {
        delegate = myDelegate;
        self.type = atype;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lianXiangCiShuRu) name:UITextFieldTextDidChangeNotification object:nil];
        [self setupSearchBar];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.frame.size.height);
    self.searchTF.frame = CGRectMake(15, (self.frame.size.height - 30) / 2.0f, CGRectGetWidth(self.frame) - 30, 44 - 14);
    cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.searchTF.frame) + CGRectGetWidth(self.frame) - CGRectGetMaxX(self.searchTF.frame), CGRectGetMinY(self.searchTF.frame), CGRectGetWidth(searchBar.frame) - CGRectGetMaxX(self.searchTF.frame), CGRectGetHeight(self.searchTF.frame));
}

- (void)setupSearchBar
{
    searchBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
    searchBar.backgroundColor = CD_BackGroundColor;
    [self addSubview:searchBar];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 7, CGRectGetWidth(self.frame) - 30, 44 - 14)];
    self.searchTF.backgroundColor = [UIColor whiteColor];
    self.searchTF.layer.cornerRadius = 3.0f;
    self.searchTF.layer.borderColor = CD_LineColor.CGColor;
    self.searchTF.layer.borderWidth = 0.5f;
    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
    self.searchTF.placeholder = @"请输入搜索内容";
    self.searchTF.textColor = TITLE_COLOR_33;
    self.searchTF.returnKeyType = UIReturnKeySearch;
    self.searchTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.searchTF.font = [UIFont fontWithName:FONTNAME size:TITLE_FUBIAOTI_SIZE];
    self.searchTF.delegate = self;
    if ([self.type isEqualToString:@"1"])
    {
        self.searchTF.placeholder = @"请输入城市名称或首字母查询";
 
    }
    UIView *leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11.5, 11.5)];
    imgV.image = [UIImage imageNamed:@"search"];
    imgV.center = CGPointMake(CGRectGetWidth(leftV.frame) / 2.0f, CGRectGetHeight(leftV.frame) / 2.0f);
    [leftV addSubview:imgV];
    
    self.searchTF.leftView = leftV;
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [searchBar addSubview:self.searchTF];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_ZHENGWEN_SIZE];
    [cancelBtn setTitleColor:CD_MainColor forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.searchTF.frame) + CGRectGetWidth(self.frame) - CGRectGetMaxX(self.searchTF.frame), CGRectGetMinY(self.searchTF.frame), CGRectGetWidth(searchBar.frame) - CGRectGetMaxX(self.searchTF.frame), CGRectGetHeight(self.searchTF.frame));
    [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
    [searchBar addSubview:cancelBtn];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.searchTF becomeFirstResponder];
    [self showCancelBtn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didBeginEditing)])
    {
        [self.delegate didBeginEditing];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performTime) object:nil];
//    NSMutableString *text = [textField.text mutableCopy];
//    [text replaceCharactersInRange:range withString:string];
//    titleStr = text;
//    [self performSelector:@selector(performTime) withObject:nil afterDelay:0.5];
    
//    NSLog(@"是不是我想输入的内容呀：%@",text);
    return YES;
}

-(void)performTime
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedSearchTitle:)])
    {
        [self.delegate didSelectedSearchTitle:titleStr];
    }
}

- (void)lianXiangCiShuRu
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(performTime) object:nil];
    titleStr = self.searchTF.text;
    [self performSelector:@selector(performTime) withObject:nil afterDelay:0.5];
}

-(void)showCancelBtn
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.searchTF.frame = CGRectMake(self.searchTF.frame.origin.x, self.searchTF.frame.origin.y, CGRectGetWidth(self.frame) - 15 - 55, 44 - 14);
        cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.searchTF.frame), CGRectGetMinY(self.searchTF.frame), CGRectGetWidth(self.frame) - CGRectGetMaxX(self.searchTF.frame), CGRectGetHeight(self.searchTF.frame));
    }];
}

-(void)hideCancelBtn
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.searchTF.frame = CGRectMake(self.searchTF.frame.origin.x, self.searchTF.frame.origin.y, CGRectGetWidth(self.frame) - 30, 44 - 14);
        cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.searchTF.frame) + CGRectGetWidth(self.frame) - CGRectGetMaxX(self.searchTF.frame), cancelBtn.frame.origin.y, cancelBtn.frame.size.width, cancelBtn.frame.size.height);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 //计划列表搜索
    titleStr  = textField.text;
    //[self hideCancelBtn];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(didSelectedSearchBtn)])
    {
        [self.delegate didSelectedSearchBtn];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)doCancel:(id)sender
{
    titleStr = @"";
    self.searchTF.text = @"";
    [self hideCancelBtn];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEndEditing)])
    {
        [self.delegate didEndEditing];
    }
    [self.searchTF resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
