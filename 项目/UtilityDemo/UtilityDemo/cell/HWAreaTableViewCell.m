//
//  HWAreaTableViewCell.m
//  UtilityDemo
//
//  Created by wuxiaohong on 15/3/31.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import "HWAreaTableViewCell.h"

@interface HWAreaTableViewCell()<UITextFieldDelegate>



@end

@implementation HWAreaTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 80, 34)];
        self.titleLabel.font = [UIFont fontWithName:FONTNAME size:14];
        
        self.titleLabel.textColor = TITLE_COLOR_33;
        [self addSubview:self.titleLabel];
        
        self.unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-15-47, 16, 47, 21)];
        self.unitLabel.font = [UIFont fontWithName:FONTNAME size:14];
        self.unitLabel.textColor = TITLE_COLOR_33;
        [self addSubview:self.unitLabel];
        
        UITextField *textfield = [[UITextField alloc]init];
        
        textfield.frame = CGRectMake(80+13+5, 15, 140, 24);
        
        textfield.keyboardType = UIKeyboardTypeDecimalPad;
        
        textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _textfield = textfield;
        
        _textfield.delegate = self;
        
        [_textfield addTarget:self action:@selector(changeForValue) forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:textfield];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showCover) name:@"UIKeyboardWillShowNotification" object:nil ];
       
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideCover) name:@"UIKeyboardWillHideNotification" object:nil ];
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignKeyword) name:@"resignKeyword" object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cleanNew) name:@"cleanNew" object:nil];
    }

    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)cleanNew
{
    _textfield.text = @"";
}
- (void)changeForValue
{
    if([_textfield.placeholder containsString:@"总额"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shangdaiDaiKuanZongE" object:_textfield.text];
    }
    if([_textfield.placeholder containsString:@"单价"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shangdaiDanJia" object:_textfield.text];
    }
    if([_textfield.placeholder containsString:@"面积"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shangdaiMianJi" object:_textfield.text];
    }
    
    if([_textfield.placeholder containsString:@"公积金"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"gongJiJinDaiKuanE" object:_textfield.text];
    }
    
    if([_textfield.placeholder containsString:@"商业"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shangYeDaiKuanE" object:_textfield.text];
    }
}

- (void)showCover
{
    if(self.cover)
    {
        self.cover.hidden = NO;
    }
}
- (void)hideCover
{
    if(self.cover)
    {
        self.cover.hidden = YES;
    }
}
- (void)resignKeyword
{
    [_textfield resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
