//
//  DateNextCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/15.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "DateNextCell.h"

@implementation DateNextCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString*)cellIndentifier
{
    return @"seriesCell";
}

+ (DateNextCell*)CellAtIndex:(NSInteger)index
{
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"DateNextCell" owner:nil options:nil];
    return arrayXibObjects[index];

}

- (DateNextCell*)cellWithSeries:(id)series
{
    _numLabel.text = @"1";
    _nameLabel.text = @"美国恐怖故事";
    _enNameLabel.text = @"Amricoas horror stroy";
    _RatingNum.text = @"3583万";
    _pointLabel.text = @"2.5";
    _upImage.image = IMAGENAME(@"icon_news_up");
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
