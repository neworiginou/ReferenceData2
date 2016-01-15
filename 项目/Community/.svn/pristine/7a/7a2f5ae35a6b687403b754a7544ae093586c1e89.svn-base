//
//  HWPublishRemarkView.m
//  Community
//
//  Created by hw500027 on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：发布备注/维修等类似功能view 带有textview及添加图片
//      姓名         日期               修改内容
//     陆晓波     2015-06-12            文件创建

#import "HWPublishRemarkView.h"

@interface HWPublishRemarkView() <UITextViewDelegate,HWPublichPicViewDelegate,UIActionSheetDelegate>
{
    UILabel *_remainCountLabel;
    int _remainCount;
    NSString *_intputPlaceHolder;
}
@end

@implementation HWPublishRemarkView

- (instancetype)initWithFrame:(CGRect)frame withTextViewPlaceHolder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
        
        _intputPlaceHolder = placeholder;
        self.isNeedHeadRefresh = NO;
        isLastPage = YES;
        CGFloat height1 = [self addInputView];
        [self addPicView:height1];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)addPicView:(CGFloat)originY
{
    _picView = [[HWPublichPicView alloc] initWithSingleLineFrame:CGRectMake(0, originY, kScreenWidth, 90) withPicArray:nil];
    _picView.picViewDelegate = self;
    [self.baseTable addSubview:_picView];
}

- (void)toEditImage:(NSMutableArray *)picArray andSelectIndex:(NSInteger)index
{
    if (_publishRemarkViewDelegate && [_publishRemarkViewDelegate respondsToSelector:@selector(didSelectImageToEditWithPicArray:andSelectIndex:)])
    {
        [_publishRemarkViewDelegate didSelectImageToEditWithPicArray:picArray andSelectIndex:index];
    }
}

- (void)toSelectImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 2)
    {
        if (_publishRemarkViewDelegate && [_publishRemarkViewDelegate respondsToSelector:@selector(didSelectImageWithActionSheet:)])
        {
            [_publishRemarkViewDelegate didSelectImageWithActionSheet:buttonIndex];
        }
    }
    
}

- (CGFloat)addInputView
{
    UIView *intputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 306 / 2)];
    intputView.backgroundColor = [UIColor whiteColor];
    [self.baseTable addSubview:intputView];
    
    _textView = [UITextView newAutoLayoutView];
    _textView.delegate = self;
    _textView.text = _intputPlaceHolder;
    _textView.textColor = THEME_COLOR_TEXT;
    _textView.font = FONT(15);
    [self setTextViewPlaceHolderStyle];
    
    _textView.backgroundColor = [UIColor whiteColor];
    [intputView addSubview:_textView];
    
    [_textView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:intputView withOffset:15];
    [_textView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:intputView withOffset:15];
    [_textView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:intputView withOffset:- 15];
    [_textView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:intputView withOffset:-22];
    
    _remainCount = 200;
    _remainCountLabel = [UILabel newAutoLayoutView];
    _remainCountLabel.textAlignment = NSTextAlignmentRight;
    [intputView addSubview:_remainCountLabel];
    _remainCountLabel.textColor = THEME_COLOR_TEXT;
    _remainCountLabel.font = FONT(14);
    _remainCountLabel.text = [NSString stringWithFormat:@"%d字",_remainCount];
    [_remainCountLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:intputView withOffset:-10];
    [_remainCountLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:intputView withOffset:-10];
    
    //底部线
    UIView *bottomLine = [UIView newAutoLayoutView];
    [intputView addSubview:bottomLine];
    [bottomLine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeTop];
    [bottomLine autoSetDimension:ALDimensionHeight toSize:0.5f];
    bottomLine.backgroundColor = THEME_COLOR_LINE;
    return CGRectGetMaxY(intputView.frame);
}

- (void)toTap
{
    [self endEditing:YES];
}

- (void)setTextViewPlaceHolderStyle
{
    _textView.textColor = THEME_COLOR_TEXT;
}

- (void)setTextViewNormalStyle
{
    _textView.textColor = [UIColor blackColor];
}

#pragma mark --textViewdelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:_intputPlaceHolder])
    {
        textView.text = @"";
        [self setTextViewNormalStyle];
        _remainCount = 200;
        _remainCountLabel.text = [NSString stringWithFormat:@"%d字",_remainCount];

    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text = _intputPlaceHolder;
        [self setTextViewPlaceHolderStyle];
        _remainCount = 200;
        _remainCountLabel.text = [NSString stringWithFormat:@"%d字",_remainCount];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    NSMutableString *resultText = [textView.text mutableCopy];
//    [resultText replaceCharactersInRange:range withString:text];
//    if (resultText.length > 200 && range.length == 0)
//    {
//        return NO;
//    }
    return YES;
}

- (void)textChangeNotification:(NSNotification *)notify
{
    NSLog(@"text notifu %@",notify);
    UITextView *textView = (UITextView *)notify.object;
    NSString *toBeString = textView.text;
    //键盘输入模式（IOS7以后的方法）
    NSArray *currentArr = [UITextInputMode activeInputModes];
    UITextInputMode *currentMode = [currentArr firstObject];
    
    if ([currentMode.primaryLanguage isEqualToString:@"zh-Hans"])   //简体中文输入，包括简体拼音，健体五笔，简体手写
    {
        UITextRange *selectedRange = [textView markedTextRange];
        
        if (selectedRange == nil)
        {
            if (textView == _textView)
            {
                if (toBeString.length > 200) {
                    textView.text = [toBeString substringToIndex:200];
                }
                _remainCountLabel.text = [NSString stringWithFormat:@"%d字",_remainCount - (int)textView.text.length];
            }
        }
        else
        {
            NSLog(@"此时键盘在输入 不限制");
        }
    }
    else
    {
        if (textView == _textView)
        {
            if (toBeString.length > 200)
            {
                textView.text = [toBeString substringToIndex:200];
            }
            _remainCountLabel.text = [NSString stringWithFormat:@"%d字",_remainCount - (int)textView.text.length];
        }
    }
}

@end
