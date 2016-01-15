//
//  HWServiceEvaluateVC.m
//  Community
//
//  Created by niedi on 15/6/24.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceEvaluateVC.h"

@interface HWServiceEvaluateVC () <UITextViewDelegate, UIScrollViewDelegate>
{
    UITextView *txtV;
    NSString *_quality;
    NSString *_manner;
    NSString *_delay;
    
    DButton *evaluateBtn;
}
@end

@implementation HWServiceEvaluateVC

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if (self.pushType == pushEvaluateTypeWYPayEvlaute || self.pushType == pushEvaluateTypeListPayEvlaute || self.pushType == pushEvaluateTypeDetailPayEvlaute)
    {
        MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
        navigation.canDragBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    MLNavigationController *navigation = (MLNavigationController *)self.navigationController;
    navigation.canDragBack = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"服务评价"];
    
    [self loadUI];
}

- (void)backMethod
{
    if (self.pushType == pushEvaluateTypeList || self.pushType == pushEvaluateTypeDetail)
    {
        [super backMethod];
    }
    else if (self.pushType == pushEvaluateTypeWYPayEvlaute)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else if (self.pushType == pushEvaluateTypeListPayEvlaute)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else if (self.pushType == pushEvaluateTypeDetailPayEvlaute)
    {
        NSArray *vcArr = self.navigationController.viewControllers;
        UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
        [self.navigationController popToViewController:lastScdVC animated:YES];
    }
    else if (self.pushType == pushEvaluateTypeWYPayCheckEvlaute)
    {
        [super backMethod];
    }
    else
    {
        [super backMethod];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSMutableString *resultText = [textView.text mutableCopy];
    [resultText replaceCharactersInRange:range withString:text];
    if (resultText.length > 200 && range.length == 0)
    {
        return NO;
    }
    return YES;
}

- (void)loadUI
{
    UIScrollView *mainScroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CONTENT_HEIGHT)];
    mainScroView.contentSize = CGSizeMake(kScreenWidth, CONTENT_HEIGHT + 1);
    mainScroView.backgroundColor = [UIColor clearColor];
    mainScroView.delegate = self;
    [self.view addSubview:mainScroView];
    
    DView *topBackView = [DView viewFrameX:0 y:10.0f w:kScreenWidth h:305.0f];
    topBackView.backgroundColor = [UIColor whiteColor];
    [Utility topLine:topBackView];
    [Utility bottomLine:topBackView];
    [mainScroView addSubview:topBackView];
    
    DLable *topLab = [DLable LabTxt:@"评价" txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:15 w:100 h:15.0f];
    [topBackView addSubview:topLab];
    
    DView *txtBackView = [DView viewFrameX:72 y:15 w:kScreenWidth - 72 - 15 h:138.0f];
    txtBackView.backgroundColor = [UIColor colorWithRed:250.0f / 255.0f green:250.0f / 255.0f blue:250.0f / 255.0f alpha:1.0f];
    txtBackView.layer.borderColor = THEME_COLOR_LINE.CGColor;
    txtBackView.layer.borderWidth = 0.5f;
    [topBackView addSubview:txtBackView];
    
    txtV = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, txtBackView.frame.size.width, txtBackView.frame.size.height)];
    txtV.delegate = self;
    txtV.backgroundColor = [UIColor clearColor];
    [txtBackView addSubview:txtV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
    [self.view addGestureRecognizer:tap];
    
    NSArray *leftTitleArr = @[@"服务质量", @"服务态度", @"准时程度"];
    for (int i = 0; i < 3; i++)
    {
        DLable *leftLab = [DLable LabTxt:leftTitleArr[i] txtFont:TF15 txtColor:THEME_COLOR_SMOKE frameX:15 y:CGRectGetMaxY(txtBackView.frame) + 15 + 45 * i w:100 h:25];
        [topBackView addSubview:leftLab];
        
        DView *xxBlackBackV = [DView viewFrameX:100 y:CGRectGetMaxY(txtBackView.frame) + 15 + 45 * i w:182 h:40];
//        xxBlackBackV.backgroundColor = THEME_COLOR_LINE;
        xxBlackBackV.tag = 1111 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [xxBlackBackV addGestureRecognizer:tap];
        [topBackView addSubview:xxBlackBackV];
        
        DImageV *xxBlack = [DImageV imagV:@"star4" frameX:0 y:0 w:182 h:25];
        [xxBlackBackV addSubview:xxBlack];
        
        DView *xxBackv = [DView viewFrameX:100 y:CGRectGetMaxY(txtBackView.frame) + 15 + 45 * i w:0 h:25];
        xxBackv.tag = 2222 + i;
        xxBackv.clipsToBounds = YES;
        xxBackv.userInteractionEnabled = NO;
        [topBackView addSubview:xxBackv];
        
        DImageV *xxImg = [DImageV imagV:@"star3" frameX:0 y:0 w:182 h:25];
        [xxBackv addSubview:xxImg];
    }
    
    if (_hasComment == NO)
    {
        evaluateBtn = [DButton btnTxt:@"发表评价" txtFont:TF18 frameX:15 y:CGRectGetMaxY(topBackView.frame) + 20 w:kScreenWidth - 2 * 15 h:45.0f target:self action:@selector(evaluateBtnClick)];
        [evaluateBtn setStyle:DBtnStyleDisabled];
        [evaluateBtn setRadiuStyle];
        [mainScroView addSubview:evaluateBtn];
    }
    else
    {
        self.view.userInteractionEnabled = NO;
        [Utility hideMBProgress:self.view];
        [Utility showMBProgress:self.view message:@"请求数据"];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setPObject:_currentOrderId forKey:@"orderId"];
        [dic setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        [manager POST:kQueryServeOrderEvaluate parameters:dic queue:nil success:^(id responese) {
            [Utility hideMBProgress:self.view];
//            [Utility showToastWithMessage:@"请求成功" inView:self.view];
            //填充数据 显示评价详情
            [self reloadEvaluateData:[responese dictionaryObjectForKey:@"data"]];
            
        } failure:^(NSString *code, NSString *error) {
            [Utility hideMBProgress:self.view];
            [Utility showToastWithMessage:error inView:self.view];
        }];
    }
}

- (void)reloadEvaluateData:(NSDictionary *)dataDic
{
    txtV.userInteractionEnabled = NO;
    txtV.text = [dataDic stringObjectForKey:@"content"];
    
    NSArray *widthArray = @[@0,@36,@76,@115,@154,@180];
    for (UIScrollView *objScrollView in [self.view subviews])
    {
        for (DView *dView in [objScrollView subviews])
        {
            for (UIView *objView in [dView subviews])
            {
                if (objView.tag == 2222 && [objView isKindOfClass:[UIView class]])
                {
                    CGRect frame = objView.frame;
                    CGFloat offsetWidth = [widthArray[[[dataDic stringObjectForKey:@"quality"] integerValue]] integerValue];
                    frame.size.width = offsetWidth;
                    objView.frame = frame;
                }
                else if (objView.tag == 2223 && [objView isKindOfClass:[UIView class]])
                {
                    CGRect frame = objView.frame;
                    CGFloat offsetWidth = [widthArray[[[dataDic stringObjectForKey:@"manner"] integerValue]] integerValue];
                    frame.size.width = offsetWidth;
                    objView.frame = frame;
                }
                else if (objView.tag == 2224 && [objView isKindOfClass:[UIView class]])
                {
                    CGRect frame = objView.frame;
                    CGFloat offsetWidth = [widthArray[[[dataDic stringObjectForKey:@"delay"] integerValue]] integerValue];
                    frame.size.width = offsetWidth;
                    objView.frame = frame;
                }
            }
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIView *backV = tap.view;
    NSInteger tag = backV.tag - 1111;
    CGFloat pointX = [tap locationInView:backV].x;
    UIView *xxV = (UIView *)[self.view viewWithTag:2222 + tag];
    CGRect frame = xxV.frame;
    
    if (pointX < 36)
    {
        [self evaluateStarLevel:1 tag:tag];
        frame.size.width = 36;
    }
    else if (pointX < 76)
    {
        [self evaluateStarLevel:2 tag:tag];
        frame.size.width = 76;
    }
    else if (pointX < 115)
    {
        [self evaluateStarLevel:3 tag:tag];
        frame.size.width = 115;
    }
    else if (pointX < 154)
    {
        [self evaluateStarLevel:4 tag:tag];
        frame.size.width = 154;
    }
    else
    {
        [self evaluateStarLevel:5 tag:tag];
        frame.size.width = 180;
    }
    xxV.frame = frame;
}

- (void)evaluateStarLevel:(NSInteger)level tag:(NSInteger)tag
{
    [self.view endEditing:YES];
    
    if (tag == 0)
    {
        //服务质量
        _quality = [NSString stringWithFormat:@"%ld",(long)level];
    }
    else if (tag == 1)
    {
        //服务态度
        _manner = [NSString stringWithFormat:@"%ld",(long)level];
    }
    else
    {
        //准时程度
        _delay = [NSString stringWithFormat:@"%ld",(long)level];
    }
    
    if (_quality.length == 0 || _manner.length == 0 || _delay.length == 0)
    {
        [evaluateBtn setStyle:DBtnStyleDisabled];
    }
    else
    {
        [evaluateBtn setStyle:DBtnStyleMain];
    }
}

- (void)evaluateBtnClick
{
    [self.view endEditing:YES];
    
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:_currentOrderId forKey:@"orderId"];
    [dict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    [dict setPObject:txtV.text forKey:@"content"];
    [dict setPObject:_quality forKey:@"quality"];//服务质量
    [dict setPObject:_manner forKey:@"manner"];//服务态度
    [dict setPObject:_delay forKey:@"delay"];//上门速度
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kEvaluateServeOrder parameters:dict queue:nil success:^(id responese)
     {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:@"评价成功" inView:self.view];
         
         if (self.pushType == pushEvaluateTypeList || self.pushType == pushEvaluateTypeDetail)
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
         else if (self.pushType == pushEvaluateTypeWYPayEvlaute)
         {
             NSArray *vcArr = self.navigationController.viewControllers;
             UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
             [self.navigationController popToViewController:lastScdVC animated:YES];
         }
         else if (self.pushType == pushEvaluateTypeWYPayCheckEvlaute)
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
         else if (self.pushType == pushEvaluateTypeListPayEvlaute)
         {
             NSArray *vcArr = self.navigationController.viewControllers;
             UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
             [self.navigationController popToViewController:lastScdVC animated:YES];
         }
         else if (self.pushType == pushEvaluateTypeDetailPayEvlaute)
         {
             NSArray *vcArr = self.navigationController.viewControllers;
             UIViewController *lastScdVC = [vcArr pObjectAtIndex:vcArr.count - 4];
             [self.navigationController popToViewController:lastScdVC animated:YES];
         }
         else
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
         
     } failure:^(NSString *code, NSString *error) {
         [Utility hideMBProgress:self.view];
         [Utility showToastWithMessage:error inView:self.view];
     }];
}

- (void)toTap
{
    [self.view endEditing:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
