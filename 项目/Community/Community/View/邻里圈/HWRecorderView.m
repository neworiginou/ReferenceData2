//
//  HWRecorderView.m
//  CallPhoneAlert
//
//  Created by caijingpeng.haowu on 14-9-12.
//  Copyright (c) 2014年 Lizhongqiang. All rights reserved.
//

#import "HWRecorderView.h"
#import "AppDelegate.h"


@implementation HWRecorderView
@synthesize state;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self initialView];
//        recordAudio = [[RecordAudio alloc] init];
//        
//        [recordAudio initRecord];
//        recordTime = 0;
//        
//        activeCountDown = NO;
    }
    return self;
}

- (void)initialView
{
    _bigCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 152, 152)];
    _bigCircle.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    _bigCircle.image = [UIImage imageNamed:@"bigCircle"];
    _bigCircle.alpha = 0.0f;
    [self addSubview:_bigCircle];
    
    _midCircle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 138, 138)];
    _midCircle.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    _midCircle.image = [UIImage imageNamed:@"middleCircle"];
    _midCircle.alpha = 0.0f;
    [self addSubview:_midCircle];
    
    _frontImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _frontImgV.backgroundColor = THEME_COLOR_BLUE;
    _frontImgV.image = [UIImage imageNamed:@"voiceClear"];
    _frontImgV.layer.cornerRadius = 100 / 2.0f;
    _frontImgV.layer.masksToBounds = YES;
    _frontImgV.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    [self addSubview:_frontImgV];
    
    _playerProgress = [[KACircleProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_frontImgV.frame) + 5, CGRectGetHeight(_frontImgV.frame) + 5)];
    _playerProgress.trackColor = [UIColor whiteColor];
    _playerProgress.progressColor = UIColorFromRGB(0xfcbc00);
    _playerProgress.progressWidth = 5.0f;
    _playerProgress.progress = 0.0f;
    _playerProgress.center = _frontImgV.center;
    [self addSubview:_playerProgress];
    
    
    _controlV = [[UIControl alloc] initWithFrame:self.bounds];
    [self addSubview:_controlV];
    
    [self setTouchUpInsideEvent];
    
}

- (void)setTouchUpInsideEvent
{
    [_controlV removeTarget:self action:@selector(touchDownStartRecord:) forControlEvents:UIControlEventTouchDown];
    [_controlV removeTarget:self action:@selector(touchUpStopRecord:) forControlEvents:UIControlEventTouchUpInside];
    [_controlV removeTarget:self action:@selector(touchUpStopRecord:) forControlEvents:UIControlEventTouchUpOutside];
    [_controlV addTarget:self action:@selector(tapMethod:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTouchDownEvent
{
    [_controlV removeTarget:self action:@selector(tapMethod:) forControlEvents:UIControlEventTouchUpInside];
    [_controlV addTarget:self action:@selector(touchDownStartRecord:) forControlEvents:UIControlEventTouchDown];
    [_controlV addTarget:self action:@selector(touchUpStopRecord:) forControlEvents:UIControlEventTouchUpInside];
    [_controlV addTarget:self action:@selector(touchUpStopRecord:) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)touchUpStopRecord:(id)sender
{
    if (state == Recordering)
    {
        [self stopRecord];
        
        NSLog(@"recorder end");
    }
}

- (void)touchDownStartRecord:(id)sender
{
    if (recordAudio.recorderError != nil)
    {
        AppDelegate *appDel = SHARED_APP_DELEGATE;
        [Utility showToastWithMessage:@"录音失败" inView:appDel.window];
        return;
    }
    
    if (state == RecorderStart)
    {
        [MobClick event:@"longpress_mic"];
        
        [self startRecord];
        self.state = Recordering;
        _frontImgV.backgroundColor = THEME_COLOR_BLUE;
        NSLog(@"recordering");
    }
}

- (void)tapMethod:(UIGestureRecognizer *)sender
{
    if (state == Stop)
    {
        [MobClick event:@"click_play"];
        NSLog(@"play");
        [self playRecord];
        self.state = Playing;
    }
    else if (state == Pause)
    {
        [recordAudio play];
        self.state = Playing;
    }
    else if (state == Playing)
    {
        NSLog(@"pause");
        [recordAudio pausePlay];
        self.state = Pause;
    }
    else if (state == Inactive)
    {
        NSLog(@"向下滚动");
        if (delegate && [delegate respondsToSelector:@selector(moveToRecordState)])
        {
            [delegate moveToRecordState];
            self.state = RecorderStart;
        }
    }
    else if (state == RecorderStart)
    {
        NSLog(@"录制时间太短");
    }
}

- (void)setState:(RecorderState)s
{
    state = s;
    if (state == Inactive)
    {
        _frontImgV.backgroundColor = THEME_COLOR_BLUE;
        _frontImgV.image = [UIImage imageNamed:@"voiceClear"];
        
        recordAudio.delegate = nil;
        [self hideMeterView];
        if ([timer isValid])
        {
            [timer invalidate];
        }
        timer = nil;
        
        activeCountDown = NO;
        [recordAudio stopPlay];
        _playerProgress.hidden = YES;
        [self setTouchUpInsideEvent];
    }
    else if (state == RecorderStart)
    {
        _frontImgV.backgroundColor = THEME_COLOR_BLUE;
        _frontImgV.image = [UIImage imageNamed:@"voiceClear"];
        
        if ([timer isValid])
        {
            [timer invalidate];
        }
        timer = nil;
        recordTime = 0;
        activeCountDown = NO;
        [recordAudio initRecord];
        recordAudio.delegate = self;
        [self setTouchDownEvent];
        _playerProgress.hidden = YES;
    }
    else if (state == Pause)
    {
        activeCountDown = NO;
        _frontImgV.image = [UIImage imageNamed:@"recordPlay"];
        [self setTouchUpInsideEvent];
    }
    else if (state == Stop)
    {
        if ([timer isValid])
        {
            [timer invalidate];
        }
        timer = nil;
        recordTime = 0;
        activeCountDown = NO;
        _playerProgress.progress = 0;
        _frontImgV.image = [UIImage imageNamed:@"recordPlay"];
        [self setTouchUpInsideEvent];
    }
    else if (state == Playing)
    {
        activeCountDown = YES;
        _frontImgV.image = [UIImage imageNamed:@"recordPause"];
        _playerProgress.hidden = NO;
    }
    else if (state == Recordering)
    {
        _frontImgV.image = [UIImage imageNamed:@"voiceClear"];
        _playerProgress.hidden = YES;
    }
    
    if (delegate && [delegate respondsToSelector:@selector(recordState:)])
    {
        [delegate recordState:state];
    }
}

- (void)resetState
{
    self.state = RecorderStart;
    _frontImgV.backgroundColor = THEME_COLOR_BLUE;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)recordTime
{
    if (activeCountDown)
    {
        recordTime++;
        if (delegate && [delegate respondsToSelector:@selector(recordTiming:)])
        {
            [delegate recordTiming:recordTime];
        }
        
        float progress = recordTime / (float)audioTotalTime;
        _playerProgress.progress = progress;
        
        if (recordTime >= RECORD_MAX_TIME)
        {
            [self stopRecord];
        }
    }
}

- (void)hideMeterView
{
    [UIView animateWithDuration:0.4f animations:^{
        _midCircle.alpha = 0.0f;
        _bigCircle.alpha = 0.0f;
    }];
}

#pragma mark -
#pragma mark recorder Method

//开始录制
- (void)startRecord
{
    [recordAudio startRecord];
    curAudio = nil;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(recordTime) userInfo:nil repeats:YES];
    activeCountDown = YES;
}

//停止录制
- (void)stopRecord
{
    if ([timer isValid])
    {
        [timer invalidate];
    }
    timer = nil;
    
    [self hideMeterView];
    
    NSURL *url = [recordAudio stopRecord];
    
    if (recordTime < RECORD_MIN_TIME)
    {//2s
        NSLog(@"录音时间过短");
//        [Utility showAlertWithMessage:@"录音时间过短"];
        self.state = RecorderStart;
        return;
    }
    
    
    if (url != nil)
    {
        curAudio =  EncodeWAVEToAMR([NSData dataWithContentsOfURL:url],1,16);
        if (curAudio)
        {
            [recordAudio initPlayerWithData:curAudio];
        }
        else
        {
            AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [Utility showToastWithMessage:@"录音失败" inView:appDel.window];
        }
    }
    else
    {
        AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [Utility showToastWithMessage:@"录音失败" inView:appDel.window];
    }
    
    if (delegate && [delegate respondsToSelector:@selector(finishRecordWithData:andDuration:)])
    {
        [delegate finishRecordWithData:curAudio andDuration:recordTime];
    }
    
    audioTotalTime = recordTime;
    
    recordTime = 0;
    self.state = Stop;
}

//播放
- (void)playRecord
{
    if (curAudio.length > 0)
    {
        [recordAudio play];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(recordTime) userInfo:nil repeats:YES];
        activeCountDown = YES;
    }
    
    
}

- (void)stopPlay
{
    [recordAudio stopPlay];
}

- (void)RecordStatus:(int)status
{
    if (status == 1)
    {
        if ([timer isValid])
        {
            [timer invalidate];
        }
        timer = nil;
        recordTime = 0;
        activeCountDown = NO;
        self.state = Stop;
    }
    else if (status == 3)
    {
//        if ([timer isValid])
//        {
//            [timer invalidate];
//        }
//        timer = nil;
        self.state = Pause;
        
    }
}

- (void)resetRecord
{
    [recordAudio stopPlay];
    self.state = RecorderStart;
    curAudio = nil;
}

- (void)didRecoderUpdateMeters:(float)value
{
    if (value > -50 && value < -40)
    {
        // middle
        [UIView animateWithDuration:0.4f animations:^{
            _midCircle.alpha = 1.0f;
            _bigCircle.alpha = 0.0f;
        }];
        
    }
    else if (value >= -40)
    {
        //big
        [UIView animateWithDuration:0.4f animations:^{
            _midCircle.alpha = 1.0f;
            _bigCircle.alpha = 1.0f;
        }];
    }
    else
    {
        //normal
        [UIView animateWithDuration:0.4f animations:^{
            _midCircle.alpha = 0.0f;
            _bigCircle.alpha = 0.0f;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
