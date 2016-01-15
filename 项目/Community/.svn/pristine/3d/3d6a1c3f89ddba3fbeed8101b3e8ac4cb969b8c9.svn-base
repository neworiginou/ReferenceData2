//
//  NoCommunityView.m
//  Community
//
//  Created by gusheng on 14-9-11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "NoCommunityView.h"

@implementation NoCommunityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (instancetype) init {
    id obj = loadObjectFromNib(@"NoCommunityView", [NoCommunityView class], self);
    if (obj) {
        self = (NoCommunityView *)obj;
    } else {
        self = [self init];
    }
    self.backgroundColor = THEME_COLOR_ORANGE;
    return self;
}
-(IBAction)clickCreateCommunity:(id)sender
{
    if (_createCommunity) {
        _createCommunity();
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
