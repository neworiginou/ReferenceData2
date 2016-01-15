//
//  SilverCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/3.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SilverCell.h"
#import "Silver.h"
@implementation SilverCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backImage.image = [UIImage stretchImageWithName:@"bg_me_Contents"];
    
}

+ (NSString *)cellID
{
    // 必须和界面上的一致
    return @"silverCell";
}

// 从xib中加载 实例化一个girlCell对象
+ (SilverCell *)silverCellAtIndex:(NSInteger)index
{
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"SilverCell" owner:nil options:nil];
    return arrayXibObjects[index];
}
// 返回封装好数据之后的,girlCell对象
- (SilverCell *)cellWithSilver:(Silver*)silver
{
    // 前面,通过连线,将xib中的各个控件,连接到GirlCell类,成为它的成员属性了,这样一来就不用通过tag取得xib中每一个控件了
    _name.text = silver.type;
    _time.text = silver.createTimeStr;
    _silverNum.text =silver.silverCount;
    // 返回封装好数据之后的,girlCell对象
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
