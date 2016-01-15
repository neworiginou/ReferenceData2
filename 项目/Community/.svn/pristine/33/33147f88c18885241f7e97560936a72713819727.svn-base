//
//  HWServiceIcon.m
//  Community
//
//  Created by niedi on 15/6/9.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWServiceIcon.h"

@interface HWServiceIcon ()<UIGestureRecognizerDelegate>
{
    BOOL _isDelBtnShow;
    BOOL isLongPress;
    BOOL isCanPan;
    CGFloat _scale;
    DButton *_delBtn;
    
    id _tapTarget;
    SEL _tapAction;
    
    id _longPrassTargetBegain;
    SEL _longPrassActionBegain;
    
    id _longPrassTargetEnd;
    SEL _longPrassActionEnd;
    
    id _panTargetChange;
    SEL _panActionChange;
    
    id _panTargetEnd;
    SEL _panActionEnd;
    
    id _delTarget;
    SEL _delAction;
}
@end

@implementation HWServiceIcon

- (instancetype)initWithFrame:(CGRect)frame model:(HWServiceIconModel *)model isDelImg:(BOOL)isDelImg
{
    if (self = [super initWithFrame:frame])
    {
        _isDelBtnShow = NO;
        isCanPan = NO;
        _model = model;
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        UIImageView *iconImg = [DImageV imagV:@"" frameX:0 y:0 w:width h:height];
        iconImg.backgroundColor = [UIColor clearColor];
        iconImg.contentMode = UIViewContentModeScaleAspectFill;
        iconImg.clipsToBounds = YES;
        if (![model.iconMongoKey isEqualToString:@" "])
        {
            __weak UIImageView *weakImgV = iconImg;
            [iconImg setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.iconMongoKey]] placeholderImage:[UIImage imageNamed:@"quetu"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                
                if (error != nil)
                {
                    weakImgV.image = [UIImage imageNamed:@"quetu"];
                }
                else
                {
                    weakImgV.image = image;
                }
            }];
        }
        else
        {
            iconImg.image = [UIImage imageNamed:model.iconImgName];
            iconImg.backgroundColor = [UIColor clearColor];
        }
        
        [self addSubview:iconImg];
        
        CGFloat titleFont ;
        if (IPHONE4 || IPHONE5)
        {
            titleFont = 13;
        }
        else if (IPHONE6)
        {
            titleFont = 14;
        }
        else
        {
            titleFont = 15;
        }
        
        UILabel *lab = [DLable LabTxt:model.name txtFont:titleFont txtColor:THEME_COLOR_TEXT frameX:0 y:height / 3 * 2 - 5 w:width h:16];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        
        _delBtn = [DButton btnTxt:nil frameX:width - 35  y:0 w:35 h:35 target:self action:@selector(delBtnClick)];
        _delBtn.backgroundColor = [UIColor clearColor];
        _delBtn.alpha = 0.0f;
        [self addSubview:_delBtn];
        
        if (isDelImg)
        {
            UIImageView *delImg = [DImageV imagV:@"delIcon" frameX:5 y:10 w:20 h:20];
            [_delBtn addSubview:delImg];
        }
        else
        {
            UIImageView *delImg = [DImageV imagV:@"editor_icon_3" frameX:5 y:10 w:20 h:20];
            [_delBtn addSubview:delImg];
        }
        
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longGesture.minimumPressDuration = 0.3;
        longGesture.delegate = self;
        [self addGestureRecognizer:longGesture];
        
        //拖动手势/移动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)delBtnClick
{
    if (_delAction && _delTarget)
    {
        [_delTarget performSelector:_delAction withObject:self];
    }
}

- (void)addTarget:(id)target action:(SEL)action forIconEvents:(iconEvent)iconEvent
{
    switch (iconEvent)
    {
        case IconTap:
        {
            _tapTarget = target;
            _tapAction = action;
        }
            break;
        case IconLongPressBegain:
        {
            _longPrassTargetBegain = target;
            _longPrassActionBegain = action;
        }
            break;
        case IconLongPressEnd:
        {
            _longPrassTargetEnd = target;
            _longPrassActionEnd = action;
        }
            break;
        case IconPanChange:
        {
            _panTargetChange = target;
            _panActionChange = action;
        }
        case IconPanEnd:
        {
            _panTargetEnd = target;
            _panActionEnd = action;
        }
            break;
        case iconDel:
        {
            _delTarget = target;
            _delAction = action;
        }
            
        default:
            break;
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    NSLog(@"拖动手势");
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        if (isCanPan)
        {
            if (_panActionChange && _panTargetChange)
            {
                [_panTargetChange performSelector:_panActionChange withObject:pan];
            }
        }
    }
    
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        isCanPan = NO;
        if (_panActionEnd && _panTargetEnd)
        {
            [_panTargetEnd performSelector:_panActionEnd withObject:pan];
        }
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)press
{
    NSLog(@"长按手势");
    _scale = 1.1f;
    
    if (press.state == UIGestureRecognizerStateBegan)
    {
        isLongPress = YES;
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideDelBtnAnimation) object:nil];
        if (_longPrassTargetBegain && _longPrassActionBegain)
        {
            [_longPrassTargetBegain performSelector:_longPrassActionBegain withObject:press];
        }
    }
    
    if (press.state == UIGestureRecognizerStateEnded)
    {
        [self performSelector:@selector(changeLongPressState:) withObject:@"0" afterDelay:0.1];
        if (_longPrassActionEnd && _longPrassTargetEnd)
        {
            [_longPrassTargetEnd performSelector:_longPrassActionEnd withObject:press];
        }
    }
}

- (void)changeLongPressState:(NSString *)status
{
    if ([status isEqualToString:@"0"])
    {
        isLongPress = NO;
    }
}

- (void)longPressBegainAction:(CGPoint)begainCenter
{
    _isDelBtnShow = YES;
    isCanPan = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        _delBtn.alpha = 1.0f;
        self.backgroundColor = UIColorFromRGB(0xf5f5f5);
        self.center = begainCenter;
        self.transform = CGAffineTransformScale(self.transform, _scale, _scale);
    }];
}

- (void)longPressEndAction:(CGPoint)endCenter
{
    isCanPan = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.center = endCenter;
        self.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (!isLongPress)
    {
        NSLog(@"tap");
        
        if (_isDelBtnShow)
        {
            _isDelBtnShow = NO;
            [self hideDelBtnAnimation];
        }
        else
        {
            NSLog(@"tapAction");
            if (_tapAction && _tapTarget)
            {
                [_tapTarget performSelector:_tapAction withObject:tap];
            }
        }
    }
}

- (void)hideDelBtnAnimation
{
    _isDelBtnShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _delBtn.transform = CGAffineTransformScale(_delBtn.transform, 0.01, 0.01);
        self.backgroundColor = UIColorFromRGB(0xffffff);
    } completion:^(BOOL finished) {
        _delBtn.alpha = 0.0f;
        _delBtn.transform = CGAffineTransformIdentity;
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
