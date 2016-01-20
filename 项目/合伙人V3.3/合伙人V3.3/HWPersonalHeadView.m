//
//  HWPersonalHeadView.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/18.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HWPersonalHeadView.h"
#import "UIView+AutoLayout.h"
#import "HWPersonSegmentCtrl.h"
#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define FONTNAME                            @"Helvetica Neue"
#define FONT(fontSize)                      [UIFont fontWithName:FONTNAME size:fontSize]
#define CD_MainColor UIColorFromRGB(0xff6600)
#define kHeadImageWidth (81)
@interface HWPersonalHeadView ()
@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *componyLabel;
@property (nonatomic, strong)HWPersonSegmentCtrl *segmentCtrl;
@end
@implementation HWPersonalHeadView
- (UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = kHeadImageWidth/2.0;
        _headImageView.layer.borderWidth = 2.9;
        _headImageView.layer.borderColor = [UIColor colorWithRed:251/255.0 green:188/255.0 blue:77/255.0 alpha:1.0].CGColor;
        _headImageView.backgroundColor = [UIColor redColor];
    }
    return _headImageView;
}
- (UILabel *)nameLabel{
    if(_nameLabel == nil){
        _nameLabel = [UILabel newAutoLayoutView];//[[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"某某先生";
        _nameLabel.font = FONT(18);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (UILabel *)componyLabel{
    if(_componyLabel == nil){
        _componyLabel = [UILabel newAutoLayoutView];//[[UILabel alloc]initWithFrame:CGRectZero];
        _componyLabel.textColor = [UIColor whiteColor];
        _componyLabel.text =@"好屋房产经纪中介公司";
        _componyLabel.font = FONT(13);
        _componyLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _componyLabel;
}
- (HWPersonSegmentCtrl *)segmentCtrl{
    if(_segmentCtrl == nil){
        _segmentCtrl = [[HWPersonSegmentCtrl alloc]init];
    }
    return _segmentCtrl;
}
- (instancetype)init{
    if(self = [super init]){
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 489/2.0);
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];//CD_MainColor;
        
        [self addSubview:self.headImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.componyLabel];
        [self addSubview:self.segmentCtrl];
        
        self.autoresizesSubviews = YES;
        
    }
    return self;
}
- (void)layoutSubviews{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat y = 99/2.0;
    self.headImageView.frame = CGRectMake(screenWidth/2.0-kHeadImageWidth/2.0, y, kHeadImageWidth, kHeadImageWidth);
    
    [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImageView withOffset:7];
    [self.nameLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.headImageView];
    
    [self.componyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:7.1];
    [self.componyLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.nameLabel];
    
    [self.nameLabel sizeToFit];
    [self.componyLabel sizeToFit];
    
    //self.segmentCtrl.frame = CGRectMake(0, 489/2.0-47, [UIScreen mainScreen].bounds.size.width, 47);
#if 1
    [self.segmentCtrl autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:0];
    [self.segmentCtrl autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withOffset:0];
    [self.segmentCtrl autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:nil withOffset:47];
#endif
}
@end
