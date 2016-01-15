//
//  HWSlideChoseDateView.m
//  Community
//
//  Created by hw500027 on 15/6/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWSlideChoseDateView.h"

#define PADDING             15
#define SLIDEVIEW_HEIGHT    30

@interface HWSlideChoseDateView() <UIGestureRecognizerDelegate>
{
    UIImageView *panSlideImgView;
    CGFloat eachPadding;
    CGFloat originX;
    CGFloat originXX;
    UIView *slideViewTop;
    UILabel *topLabel;
}
@end

@implementation HWSlideChoseDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 226 / 2)];
    if (self)
    {
        [self addTopLabel];
        [self configUI];
        [self addBottomLabel];
    }
    return self;
}

- (void)addTopLabel
{
    topLabel = [UILabel newAutoLayoutView];
    [self addSubview:topLabel];
    topLabel.text = @"当天";
    topLabel.font = [UIFont fontWithName:FONTNAME size:14];
    topLabel.textColor = THEME_COLOR_ORANGE;
    
    [topLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:15];
    [topLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
}

- (void)addBottomLabel
{
    UILabel *label1 = [UILabel newAutoLayoutView];
    [self addSubview:label1];
    label1.text = @"当天";
    label1.font = [UIFont fontWithName:FONTNAME size:14];
    [label1 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:- 25];
    [label1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:15];
    
    UILabel *label2 = [UILabel newAutoLayoutView];
    [self addSubview:label2];
    label2.text = @"长期访客";
    label2.font = [UIFont fontWithName:FONTNAME size:14];
    [label2 autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:- 25];
    [label2 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:- 15];
}


- (void)configUI
{
    //进度条
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(PADDING + 15, 50, self.frame.size.width - PADDING * 2 - 2 * 15, 2)];
    [self addSubview:slideView];
    slideView.backgroundColor = THEME_COLOR_LINE;
    
    slideViewTop = [[UIView alloc] initWithFrame:CGRectMake(slideView.frame.origin.x, slideView.frame.origin.y, 0, slideView.frame.size.height)];
    [self addSubview:slideViewTop];
    slideViewTop.backgroundColor = THEBUTTON_GREEN_HIGHLIGHT;
    
    //拖动按钮
    UIImage *image = [UIImage imageNamed:@"orangeDot"];
    panSlideImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    panSlideImgView.image = image;
    [self addSubview:panSlideImgView];
    panSlideImgView.center = CGPointMake(panSlideImgView.frame.size.width / 2 + PADDING, slideView.center.y);
    eachPadding = slideView.frame.size.width / 8.0f;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanSlideView:)];
    self.userInteractionEnabled = YES;
    slideView.userInteractionEnabled = YES;
    panSlideImgView.userInteractionEnabled = YES;
    [self addGestureRecognizer:pan];
}

- (void)movePanSlideView:(UIPanGestureRecognizer *)pan
{
    CGFloat moveX = [pan locationInView:pan.view.superview].x;
    
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
            
            if (moveX >= panSlideImgView.frame.size.width / 2 + PADDING && moveX <= self.frame.size.width - panSlideImgView.frame.size.width / 2 - PADDING)
            {
                panSlideImgView.center = CGPointMake(moveX, panSlideImgView.center.y);
                originX = panSlideImgView.center.x - PADDING;
                slideViewTop.frame = CGRectMake(slideViewTop.frame.origin.x, slideViewTop.frame.origin.y, originX - 15, slideViewTop.frame.size.height);
                
                originXX = panSlideImgView.origin.x;
                if (originXX < eachPadding)
                {
                    topLabel.text = @"当天";
                }
                else if (originXX >= eachPadding && originX < eachPadding * 3)
                {
                    topLabel.text = @"两天";
                }
                else if (originXX >= eachPadding * 3 && originX < eachPadding * 5)
                {
                    topLabel.text = @"三天";
                }
                else if (originXX >= eachPadding * 5 && originX < eachPadding * 7)
                {
                    topLabel.text = @"一周";
                }
                else
                {
                    topLabel.text = @"长期访客";
                }
                //移动toplabel
                [topLabel autoRemoveConstraintsAffectingView];
                if ([topLabel.text isEqual:@"长期访客"])
                {
                    [topLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:- 15];
                }
                else
                {
                    [topLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:panSlideImgView.origin.x];
                }
                [topLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
                
                if (_slideViewDelegate && [_slideViewDelegate respondsToSelector:@selector(didSelectSlideDate:)])
                {
                    [_slideViewDelegate didSelectSlideDate:topLabel.text];
                }
            }
            break;
        case UIGestureRecognizerStateEnded:
            originXX = panSlideImgView.origin.x;
            if (originXX < eachPadding)
            {
                panSlideImgView.origin = CGPointMake(PADDING, panSlideImgView.origin.y);
                topLabel.text = @"当天";
            }
            else if (originXX >= eachPadding && originX < eachPadding * 3)
            {
                panSlideImgView.origin = CGPointMake(PADDING + eachPadding * 2 - panSlideImgView.frame.size.width / 2, panSlideImgView.origin.y);
                topLabel.text = @"两天";
            }
            else if (originXX >= eachPadding * 3 && originX < eachPadding * 5)
            {
                panSlideImgView.origin = CGPointMake(PADDING + eachPadding * 4 - panSlideImgView.frame.size.width / 2, panSlideImgView.origin.y);
                topLabel.text = @"三天";
            }
            else if (originXX >= eachPadding * 5 && originX < eachPadding * 7)
            {
                panSlideImgView.origin = CGPointMake(PADDING + eachPadding * 6 - panSlideImgView.frame.size.width / 2, panSlideImgView.origin.y);
                topLabel.text = @"一周";
            }
            else
            {
                panSlideImgView.origin = CGPointMake(self.frame.size.width - PADDING - panSlideImgView.frame.size.width, panSlideImgView.origin.y);
                topLabel.text = @"长期访客";
                
            }
            slideViewTop.frame = CGRectMake(slideViewTop.frame.origin.x, slideViewTop.frame.origin.y, panSlideImgView.origin.x - 15, slideViewTop.frame.size.height);
            
            //移动toplabel
            [topLabel autoRemoveConstraintsAffectingView];
            if ([topLabel.text isEqual:@"长期访客"])
            {
                [topLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:- 15];
            }
            else
            {
                [topLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:panSlideImgView.origin.x];
            }
            [topLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:10];
            
            if (_slideViewDelegate && [_slideViewDelegate respondsToSelector:@selector(didSelectSlideDate:)])
            {
                [_slideViewDelegate didSelectSlideDate:topLabel.text];
            }
            
            break;
        case UIGestureRecognizerStateFailed:
            break;
        default:
            break;
    }
}



@end
