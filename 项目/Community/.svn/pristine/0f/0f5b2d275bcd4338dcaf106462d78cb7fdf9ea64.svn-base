//
//  MineExtendHeaderView.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "MineExtendHeaderView.h"
#import "Utility.h"
@implementation MineExtendHeaderView
@synthesize totalActiveLabel,totalScanLabel,totalRegisterLabel,DetailLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (instancetype) init {
    id obj = loadObjectFromNib(@"MineExtendHeaderView", [MineExtendHeaderView class], self);
    if (obj) {
        self = (MineExtendHeaderView *)obj;
    } else {
        self = [self init];
    }
    segCtrl.tintColor =UIColorFromRGB(0x8ACF1C);
//    totalActiveLabel.textColor = THEME_COLOR_ORANGE;
//    totalScanLabel.textColor = THEME_COLOR_ORANGE;
//    totalTitleLabel.textColor = UIColorFromRGB(0x666666);
//    totalActiveTitleLabel.textColor =  UIColorFromRGB(0x666666);
    CGSize size = CGSizeMake(238,80);
    [self createDynamicLabel:@"考拉社区是一款基于小区的服务型社交应用" size:size];
    //    ADD_LINE(0, 29, 320, self);
    headImage.layer.cornerRadius = 5.0f;
    headImage.layer.masksToBounds = YES;
    return self;
}
-(IBAction)clickSegment:(id)sender
{
    UISegmentedControl *segC = (UISegmentedControl *)sender;
    int index = segC.selectedSegmentIndex;
    if (_clickSegmentBlock) {
        _clickSegmentBlock(index);
    }
}
//创建内容可动态变化的Label
-(void)createDynamicLabel:(NSString *)str size:(CGSize)specifySize
{
    DetailLabel.numberOfLines = 0;
    UIFont *fontTwo = [UIFont systemFontOfSize:15];
    DetailLabel.font =fontTwo;
    DetailLabel.textColor = UIColorFromRGB(0x666666);
    DetailLabel.backgroundColor = [UIColor clearColor];
    CGSize actualSizeTwo = [str sizeWithFont:fontTwo constrainedToSize:specifySize lineBreakMode:NSLineBreakByWordWrapping];
    DetailLabel.frame = CGRectMake(72 ,DetailLabel.frame.origin.y, 238,actualSizeTwo.height);
    [DetailLabel setText:str];
    //
    
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
