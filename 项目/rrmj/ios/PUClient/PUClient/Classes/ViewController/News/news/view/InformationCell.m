//
//  InformationCell.m
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "InformationCell.h"
#import "NewsIntroModel.h"
#import "ReviewModel.h"
@implementation InformationCell

- (void)awakeFromNib {
    // Initialization code
}

+ (NSString *)cellID
{
    // 必须和界面上的一致
    return @"informationCell";
}

// 从xib中加载 实例化一个girlCell对象
+ (InformationCell *)informationCellAtIndex:(NSInteger)index
{
    // mainBundel加载xib,扩展名不用写.xib
    NSArray *arrayXibObjects = [[NSBundle mainBundle] loadNibNamed:@"InformationCell" owner:nil options:nil];
    return arrayXibObjects[index];
}
// 返回封装好数据之后的,girlCell对象
- (InformationCell *)cellWithInformation:(NewsIntroModel*)information
{
    // 前面,通过连线,将xib中的各个控件,连接到GirlCell类,成为它的成员属性了,这样一来就不用通过tag取得xib中每一个控件了
    // 返回封装好数据之后的,girlCell对象
    if ([information.showType isEqualToString:@"common"]) {
        _bigView.hidden = NO;
        _mixView.hidden = YES;
        
        //[_image1 sd_setImageWithURL:URL(information.imgList[0]) placeholderImage:IMAGENAME(@"nopic_190x210")];
        //[_image2 sd_setImageWithURL:URL(information.imgList[1]) placeholderImage:IMAGENAME(@"nopic_190x210")];
        //[_image3 sd_setImageWithURL:URL(information.imgList[2]) placeholderImage:IMAGENAME(@"nopic_190x210")];
        
        _bigDate.text = information.createTimeStr;
        _bigTitle.text = information.title;
        [_bigReplyBtn setTitle:[NSString stringWithFormat:@"%@评论",information.commentCount] forState:UIControlStateNormal];
        
    }else{
        
        _mixView.hidden = NO;
        _bigView.hidden = YES;
        
        _mixTitle.text = information.title;
        _mixIntro.text = information.subTitle;
        _mixDate.text = information.createTimeStr;
        [_mixReplyBtn setTitle:[NSString stringWithFormat:@"%@评论",information.commentCount] forState:UIControlStateNormal];
        [_mixIageView sd_setImageWithURL:URL(information.imgList[0]) placeholderImage:IMAGENAME(@"nopic_190x210")];
    }
    
    return self;
}

- (InformationCell *)cellWithRating:(ReviewModel *)rating
{
    _mixView.hidden = NO;
    _bigView.hidden = YES;
    
    _mixTitle.text = rating.title;
    _mixIntro.text = rating.brief;
    _mixDate.text = rating.createTimeStr;
//    [_mixReplyBtn setTitle:[NSString stringWithFormat:@"%@评论",rating.commentCount] forState:UIControlStateNormal];
    [_mixIageView sd_setImageWithURL:URL(rating.bannerUrl) placeholderImage:IMAGENAME(@"nopic_190x210")];
    return self;
}

+ (CGFloat)heightForRowWithInformation:(NewsIntroModel*)information
{
    if ([information.showType isEqualToString:@"common"]) {
        return 170;
    }
    return 100;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
