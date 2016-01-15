//
//  EveryDayRecordView.m
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "EveryDayRecordView.h"
#import "Utility.h"
@implementation EveryDayRecordView
@synthesize phoneTypeLabel,scanTimeLabel,activeLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (instancetype) init {
    id obj = loadObjectFromNib(@"EveryDayRecordView", [EveryDayRecordView class], self);
    if (obj) {
        self = (EveryDayRecordView *)obj;
    } else {
        self = [self init];
    }
    self.backgroundColor = UIColorFromRGB(0xfbfbfb);
//    phoneTypeLabel.textColor = UIColorFromRGB(0x666666);
//    phoneTypeLabel.font = [UIFont systemFontOfSize:15];
//    scanTimeLabel.textColor = UIColorFromRGB(0x6666666);
//    scanTimeLabel.font = [UIFont systemFontOfSize:15];
//    activeLabel.textColor = UIColorFromRGB(0x666666);
//    activeLabel.font = [UIFont systemFontOfSize:15];
    //    ADD_LINE(0, 29, 320, self);
    return self;
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
