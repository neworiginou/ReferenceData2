//
//  MyItemView.m
//  PUClient
//
//  Created by RRLhy on 15/7/29.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "MyItemView.h"
#import "CustomYBtn.h"
@implementation MyItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float x = 200.0/1242.0;
        float width = (Main_Screen_Width-6)/4;
        float height = x*Main_Screen_Width;
        
        NSArray * array = @[@{@"title":@"回复",@"imageN":@"icon_me_thread_n",@"imageH":@"icon_me_thread__h"},
                            @{@"title":@"发帖",@"imageN":@"icon_me_posts_n",@"imageH":@"icon_me_posts__h"},
                            @{@"title":@"收藏",@"imageN":@"icon_me_collect_n",@"imageH":@"icon_me_collect__h"},
                            @{@"title":@"银币",@"imageN":@"icon_me_silver_n",@"imageH":@"icon_me_silver_h"}];
        
        for (int i = 0 ; i< array.count ; i++) {
            CustomYBtn * btn = [CustomYBtn buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:array[i][@"imageN"]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:array[i][@"imageH"]] forState:UIControlStateHighlighted];
            [btn setTitle:array[i][@"title"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(selectitem:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:SYSTEMFONT(12)];
            [btn.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [btn setFrame:CGRectMake(i*(width + 2), 0, width, height)];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn setTag:i];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)selectitem:(UIButton*)sender
{
    MyItemBlock block = self.selectBlock;
    
    if (block) {
        self.selectBlock(sender.tag);
    }
}

@end
