//
//  SeriesItem.m
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SeriesItem.h"

#define IMAGEW 65
#define IMAGEH 70

@implementation SeriesItem
{
    UIImageView * selectBtn;
    BOOL isSelected;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMAGEW, IMAGEH)];
        coverImage.backgroundColor = [UIColor grayColor];
        coverImage.contentMode = UIViewContentModeScaleToFill;
        [coverImage sd_setImageWithURL:URL(@"http://pic.baike.soso.com/p/20131101/20131101173255-1526197099.jpg") placeholderImage:nil];
        [self addSubview:coverImage];
        
        selectBtn = [[UIImageView alloc]init];
        selectBtn.image = [UIImage imageNamed:@"btn_me_circle-"];
        [selectBtn setFrame:CGRectMake((IMAGEW - 20)/2, IMAGEH - 23, 20, 20)];
        selectBtn.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:selectBtn];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(X(coverImage),MaxY(coverImage) + 10, frame.size.width, 14)];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"破产姐妹";
        nameLabel.font = SYSTEMFONT(12);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectItem:)];
        [self addGestureRecognizer:gesture];
        
    }
    return self;
}

- (void)selectItem:(UITapGestureRecognizer*)gesture
{
    isSelected = !isSelected;
    if (isSelected) {
        selectBtn.image = IMAGENAME(@"btn_me_circle-_-ok");
    }else{
        selectBtn.image = IMAGENAME(@"btn_me_circle-");
    }
    
    SeriesSelectBlock block = self.selectBlock;
    if (block) {
        block(10,isSelected);
    }
}

@end
