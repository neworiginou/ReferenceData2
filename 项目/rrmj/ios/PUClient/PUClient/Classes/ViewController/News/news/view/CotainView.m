//
//  CotainView.m
//  PUClient
//
//  Created by RRLhy on 15/8/14.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "CotainView.h"

@implementation CotainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = RGBCOLOR(0.937, 0.937, 0.937);
        
        [self addSubview:self.syncBtn];
        
        UILabel * introLabel = [[UILabel alloc]initWithFrame:CGRectMake(MaxX(_syncBtn), 9, 160, 19)];
        introLabel.font = SYSTEMFONT(12);
        introLabel.textColor = RGBCOLOR(0.200, 0.200, 0.200);
        introLabel.text = @"评论并转发到美剧圈";
        [self addSubview:introLabel];
        
//        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(12, 35, Main_Screen_Width - 12 - 50, 33)];
//        image.image = [UIImage stretchImageWithName:@"bg_news_pop_Contents_9"];
//        [self addSubview:image];
        
        [self addSubview:self.sendBtn];
        
        [self addSubview:self.markNum];
        
        [self addSubview:self.textTf];
    }
    return self;
}

- (UIButton*)syncBtn
{
    if (!_syncBtn) {
        _syncBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_syncBtn setImage:IMAGENAME(@"btn_check-button_n") forState:UIControlStateNormal];
        [_syncBtn setImage:IMAGENAME(@"btn_check-button_h") forState:UIControlStateSelected];
        [_syncBtn setFrame:CGRectMake(4, 3, 30, 30)];
    }
    return _syncBtn;
}

- (UIButton*)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发表" forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:SYSTEMFONT(16)];
        [_sendBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [_sendBtn setFrame:CGRectMake(Main_Screen_Width - 45, 32, 40, 30)];
    }
    return _sendBtn;
}

- (UILabel*)markNum
{
    if (!_markNum) {
        _markNum = [[UILabel alloc]initWithFrame:CGRectMake(X(_sendBtn), 57, 40, 15)];
        _markNum.font = SYSTEMFONT(12);
        _markNum.textColor = RGBCOLOR(0.584, 0.584, 0.584);
        _markNum.textAlignment = NSTextAlignmentCenter;
        _markNum.text = @"140";
    }
    return _markNum;
}

- (HPGrowingTextView*)textTf
{
    if (!_textTf) {
        _textTf = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(12, 35, Main_Screen_Width - 12 - 50, 33)];
        _textTf.isScrollable = NO;
        _textTf.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        _textTf.minNumberOfLines = 1;
        _textTf.maxNumberOfLines = 4;
        // you can also set the maximum height in points with maxHeight
        // textView.maxHeight = 200.0f;
        _textTf.returnKeyType = UIReturnKeyGo; //just as an example
        _textTf.font = [UIFont systemFontOfSize:15.0f];
        _textTf.delegate = self;
        _textTf.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        _textTf.backgroundColor = [UIColor whiteColor];
        _textTf.placeholder = @"说点什么吧～";
        _textTf.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textTf.layer.borderWidth = 0.5;
    }
    return _textTf;
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
}

@end
