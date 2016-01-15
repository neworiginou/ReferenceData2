//
//  ReviewCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "ReviewCell.h"

@implementation ReviewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString*)reviewCellID
{
    return @"reviewCell";
}

// 从xib中加载 实例化一个girlCell对象
+ (ReviewCell *)reviewCellAtIndex:(NSInteger)index
{
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"ReviewCell" owner:nil options:nil];
    return arrayXibObjects[index];
}

- (ReviewCell *)cellWithReview:(ReviewModel*)review
{
    [_reviewImage sd_setImageWithURL:URL(review.posterUrl) placeholderImage:IMAGENAME(@"nopic_190x210")];
//    _reviewIntro.text =@"昨日像那东流水，离我远去不可留，抽刀断水水更流，你不爱我我不愁";
    
    _reviewTitle.text = review.title;
    _reviewIntro.text = review.brief;
    _reviewSeriesName.text = review.seriesName;
    _reviewDate.text = review.createTimeStr;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
