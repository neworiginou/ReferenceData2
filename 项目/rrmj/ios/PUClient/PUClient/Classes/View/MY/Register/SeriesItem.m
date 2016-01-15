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
    UIImageView * coverImage;
    UILabel * nameLabel;
    BOOL isSelected;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMAGEW, IMAGEH)];
        coverImage.backgroundColor = [UIColor grayColor];
        coverImage.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:coverImage];
        
        selectBtn = [[UIImageView alloc]init];
        selectBtn.image = [UIImage imageNamed:@"btn_me_circle-"];
        [selectBtn setFrame:CGRectMake((IMAGEW - 20)/2, IMAGEH - 23, 20, 20)];
        selectBtn.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:selectBtn];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(X(coverImage),MaxY(coverImage) + 10, frame.size.width, 14)];
        nameLabel.textColor = [UIColor blackColor];
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
        block([_series.seriesId integerValue],isSelected);
    }
}

- (void)setSeries:(HotSeriesModel *)series
{
    _series = series;
    [coverImage sd_setImageWithURL:URL(series.imgUrl) placeholderImage:IMAGENAME(@"nopic_190x210")];
    [nameLabel setText:series.name];
}

@end
