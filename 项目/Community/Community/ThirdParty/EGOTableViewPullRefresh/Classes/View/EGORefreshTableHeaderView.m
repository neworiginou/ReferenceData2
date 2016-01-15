//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"

#define CENTER_X (kScreenWidth / 2.0f - 75.0f + 25)

@interface EGORefreshTableHeaderView (Private)

@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame arrowImageName:(NSString *)arrow textColor:(UIColor *)textColor  {
    if((self = [super initWithFrame:frame])) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        self.backgroundColor = BACKGROUND_COLOR;
        
        UIView *puppleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 2)];
        puppleView.backgroundColor = THEME_COLOR_ORANGE;
        puppleView.layer.cornerRadius = 1.0f;
        puppleView.layer.masksToBounds = YES;
        [self addSubview:puppleView];
        [puppleView release];
        _puppleView = puppleView;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(CENTER_X - 25, self.frame.size.height - 50 - 5, 50, 50)];
        imgV.image = [UIImage imageNamed:@"refresh1"];
        imgV.alpha = 0;
        
        imgV.animationImages = [NSArray arrayWithObjects:
                                [UIImage imageNamed:@"refresh1"],
                                [UIImage imageNamed:@"refresh2"],
                                [UIImage imageNamed:@"refresh3"], nil];
        imgV.animationDuration = 0.4f;
        imgV.animationRepeatCount = 0;
        [self addSubview:imgV];
        [imgV release];
        _colaImgV = imgV;
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_colaImgV.frame), frame.size.height - 30.0f, 135.0f, 20.0f)];
//        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        label.font = [UIFont systemFontOfSize:13.0f];
//        label.textColor = textColor;
//        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:label];
//        _lastUpdatedLabel=label;
//        [label release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_colaImgV.frame), self.frame.size.height - 25 - 5 - 10, 100.0f, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        label.textColor = textColor;
//        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _statusLabel=label;
        [label release];
        
        
        
		[self setState:EGOOPullRefreshNormal];
		
    }
	
    return self;
	
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame arrowImageName:@"blueArrow" textColor:THEME_COLOR_TEXT];
}

#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceLastUpdated:)]) {
		
//		NSDate *date = [_delegate egoRefreshTableDataSourceLastUpdated:self];
//		
//		[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
//		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
//		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//        [dateFormatter setDateFormat:@"yy/MM/dd"];
        
//		_lastUpdatedLabel.text = [NSString stringWithFormat:@"最近更新: %@", [dateFormatter stringFromDate:date]];
//		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
//		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
//		_lastUpdatedLabel.text = nil;
		
	}
    
}

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			_statusLabel.text = @"释放更新数据";
//			[CATransaction begin];
//			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
//			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
			
//			if (_state == EGOOPullRefreshPulling) {
//				[CATransaction begin];
//				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//				_arrowImage.transform = CATransform3DIdentity;
//				[CATransaction commit];
//			}
//			
			_statusLabel.text = @"下拉刷新";
//			[_activityView stopAnimating];
//			[CATransaction begin];
//			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//			_arrowImage.hidden = NO;
//			_arrowImage.transform = CATransform3DIdentity;
//			[CATransaction commit];
//			
//			[self refreshLastUpdatedDate];

            
            
            
            
			break;
		case EGOOPullRefreshLoading:
			
			_statusLabel.text = @"加载中...";
//			[_activityView startAnimating];
//			[CATransaction begin];
//			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//			_arrowImage.hidden = YES;
//			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    //	NSLog(@"egoRefreshScrollViewDidScroll scrollView.contentOffset.y= %f", scrollView.contentOffset.y);
	if (_state == EGOOPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading)
        {
			[self setState:EGOOPullRefreshNormal];
		}
        else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading)
        {
			[self setState:EGOOPullRefreshPulling];
            
            if (_colaImgV.alpha != 1)
            {
                CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
                CATransform3D transform = CATransform3DMakeScale(0.5f * 20, 0.5 * 20.0f, 1.0);  //x,y,z放大缩小倍数
                NSValue *value = [NSValue valueWithCATransform3D:transform];
                [theAnimation setToValue:value];
                
                transform = CATransform3DMakeScale(0.5f * 20, 65.0f * 0.5f, 1.0);
                
                value = [NSValue valueWithCATransform3D:transform];
                [theAnimation setFromValue:value];
                //            [theAnimation setAutoreverses:YES];  //原路返回的动画一遍
                [theAnimation setDuration:0.2f];
                [theAnimation setRepeatCount:1];
                theAnimation.removedOnCompletion = YES;
                theAnimation.fillMode = kCAFillModeForwards;
                [_puppleView.layer addAnimation:theAnimation forKey:nil];
                
                CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
                [yAnimation setFromValue:[NSNumber numberWithFloat:0]];
                [yAnimation setToValue:[NSNumber numberWithFloat:20]];
                [yAnimation setDuration:0.2f];
                [yAnimation setRepeatCount:1];
                yAnimation.delegate = self;
                yAnimation.removedOnCompletion = YES;
                yAnimation.fillMode = kCAFillModeForwards;
                [_puppleView.layer addAnimation:yAnimation forKey:nil];
            }
            
		}
        else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y > -65.0f && !_loading)
        {
            float height = MIN(ABS(scrollView.contentOffset.y), 65);
            if (height <= 20 && height > 1)
            {
                CGRect frame = _puppleView.frame;
                frame.origin.y = self.frame.size.height - height;
                frame.origin.x = CENTER_X - height / 2.0f;
//                frame.size.width = height;
//                frame.size.height = height;
                _puppleView.frame = frame;
//                _puppleView.layer.cornerRadius = frame.size.width / 2.0f;
                
                _puppleView.transform = CGAffineTransformMakeScale(0.5f * height, 0.5f * height);
                
                NSLog(@"%@",_puppleView);
                
            }
            else if (height <= 65 && height > 20)
            {
                CGRect frame = _puppleView.frame;
                frame.origin.y = self.frame.size.height - height;
                frame.origin.x = CENTER_X - 10.0f;
//                frame.size.width = 20;
//                frame.size.height = height;
//                frame.origin.y = self.frame.size.height - height;
                _puppleView.frame = frame;
//                _puppleView.layer.cornerRadius = frame.size.width / 2.0f;
                
                _puppleView.transform = CGAffineTransformMakeScale(0.5f * 20, height * 0.5f);
                
            }
        }
        
        
		if (scrollView.contentInset.top != 0)
        {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}

//	NSLog(@"_state %d",_state);
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    //NSLog(@"egoRefreshScrollViewDidEndDragging scrollView.contentOffset.y= %f", scrollView.contentOffset.y);
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableDidTriggerRefresh:EGORefreshHeader];
		}
		
		[self setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
        
        if (_colaImgV.alpha != 1)
        {
            CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
            CATransform3D transform = CATransform3DMakeScale(0.5f * 20, 0.5 * 20.0f, 1.0);  //x,y,z放大缩小倍数
            NSValue *value = [NSValue valueWithCATransform3D:transform];
            [theAnimation setToValue:value];
            
            transform = CATransform3DMakeScale(0.5f * 20, 65.0f * 0.5f, 1.0);
            
            value = [NSValue valueWithCATransform3D:transform];
            [theAnimation setFromValue:value];
            //            [theAnimation setAutoreverses:YES];  //原路返回的动画一遍
            [theAnimation setDuration:0.2f];
            [theAnimation setRepeatCount:1];
            theAnimation.removedOnCompletion = YES;
            theAnimation.fillMode = kCAFillModeForwards;
            [_puppleView.layer addAnimation:theAnimation forKey:nil];
            
            CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            [yAnimation setFromValue:[NSNumber numberWithFloat:0]];
            [yAnimation setToValue:[NSNumber numberWithFloat:20]];
            [yAnimation setDuration:0.2f];
            [yAnimation setRepeatCount:1];
            yAnimation.delegate = self;
            yAnimation.removedOnCompletion = YES;
            yAnimation.fillMode = kCAFillModeForwards;
            [_puppleView.layer addAnimation:yAnimation forKey:nil];
        }
		
	}
	
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    
    [_colaImgV stopAnimating];
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    _colaImgV.alpha = 0;
    _puppleView.alpha = 1;
//    _colaImgV.hidden = YES;
//    _puppleView.hidden = NO;
	[UIView commitAnimations];
	
	[self setState:EGOOPullRefreshNormal];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"%d",flag);
    _puppleView.alpha = 0;
//    _puppleView.frame = CGRectMake(0, 0, 2, 2);
    _colaImgV.alpha = 1;
    [_colaImgV startAnimating];
    
    NSArray *keyTimes = [NSArray arrayWithObjects:
                         [NSNumber numberWithFloat:0],
                         [NSNumber numberWithFloat:0.15],
                         [NSNumber numberWithFloat:0.3],
                         [NSNumber numberWithFloat:0.65],
                         [NSNumber numberWithFloat:1]
                         , nil];
    float duration = 0.6;
    
    
    CAKeyframeAnimation *keyFrameAmt = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    keyFrameAmt.keyTimes = keyTimes;
    keyFrameAmt.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.4],
                          [NSNumber numberWithFloat:1.3],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:1.2],
                          [NSNumber numberWithFloat:1.0]
//                          [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)],
//                          [NSValue valueWithCGPoint:CGPointMake(1, 1.3)],
//                          [NSValue valueWithCGPoint:CGPointMake(0.6, 1)],
//                          [NSValue valueWithCGPoint:CGPointMake(1, 1)]
//                          [NSValue valueWithCGSize:CGSizeMake(0.4, 0.4)],
//                          [NSValue valueWithCGSize:CGSizeMake(1, 1.3)],
//                          [NSValue valueWithCGSize:CGSizeMake(0.6, 1)],
//                          [NSValue valueWithCGSize:CGSizeMake(1, 1)]
                          , nil];
    keyFrameAmt.duration = duration;
    keyFrameAmt.autoreverses = NO;
    [_colaImgV.layer addAnimation:keyFrameAmt forKey:nil];
//
    CAKeyframeAnimation *keyFrameAmt1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    keyFrameAmt1.keyTimes = keyTimes;
    keyFrameAmt1.values = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.4],
                           [NSNumber numberWithFloat:1.0],
                           [NSNumber numberWithFloat:1.4],
                           [NSNumber numberWithFloat:1.0],
                           [NSNumber numberWithFloat:1.0]
                          //                          [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)],
                          //                          [NSValue valueWithCGPoint:CGPointMake(1, 1.3)],
                          //                          [NSValue valueWithCGPoint:CGPointMake(0.6, 1)],
                          //                          [NSValue valueWithCGPoint:CGPointMake(1, 1)]
                          //                          [NSValue valueWithCGSize:CGSizeMake(0.4, 0.4)],
                          //                          [NSValue valueWithCGSize:CGSizeMake(1, 1.3)],
                          //                          [NSValue valueWithCGSize:CGSizeMake(0.6, 1)],
                          //                          [NSValue valueWithCGSize:CGSizeMake(1, 1)]
                          , nil];
    keyFrameAmt1.duration = duration;
    keyFrameAmt1.autoreverses = NO;
    [_colaImgV.layer addAnimation:keyFrameAmt1 forKey:nil];
    
    CAKeyframeAnimation *keyFrameAmt2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    keyFrameAmt2.keyTimes = keyTimes;
    keyFrameAmt2.values = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:20.0],
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.0]
                           //                          [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)],
                           //                          [NSValue valueWithCGPoint:CGPointMake(1, 1.3)],
                           //                          [NSValue valueWithCGPoint:CGPointMake(0.6, 1)],
                           //                          [NSValue valueWithCGPoint:CGPointMake(1, 1)]
                           //                          [NSValue valueWithCGSize:CGSizeMake(0.4, 0.4)],
                           //                          [NSValue valueWithCGSize:CGSizeMake(1, 1.3)],
                           //                          [NSValue valueWithCGSize:CGSizeMake(0.6, 1)],
                           //                          [NSValue valueWithCGSize:CGSizeMake(1, 1)]
                           , nil];
    keyFrameAmt2.duration = duration;
    keyFrameAmt2.autoreverses = NO;
    [_colaImgV.layer addAnimation:keyFrameAmt2 forKey:nil];
    
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
//	_activityView = nil;
	_statusLabel = nil;
//	_arrowImage = nil;
//	_lastUpdatedLabel = nil;
    _puppleView = nil;
    _colaImgV = nil;
    [super dealloc];
}


@end
