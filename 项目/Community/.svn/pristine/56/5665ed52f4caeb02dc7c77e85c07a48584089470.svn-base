//
//  HWAddShopNumCell.m
//  Community
//
//  Created by hw500028 on 14/12/11.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAddShopNumCell.h"

@implementation HWAddShopNumCell
{
    UIImageView *imgV;
    UILabel *label;
}
- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}


- (void)initViews{
    imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (50 - 33) / 2.0f, 33, 33)];
    [self.contentView addSubview:imgV];
    

    
    label= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imgV.frame) + 10, 0, kScreenWidth - 100, 50.0f)];

    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    label.textColor = THEME_COLOR_SMOKE;
    [self.contentView addSubview:label];



}

- (void)setModel:(HWAddShopNumModel *)model{

    if (_model != model) {
        _model = model;
    }
    //图片地址
    NSString *str = [Utility imageDownloadWithMongoDbKey:_model.iconMongodbKey];
    
    __weak UIImageView *weakImgV = imgV;
    [imgV setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error != nil) {
            weakImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            weakImgV.image = image;
        }
    }];
 //label
    label.text = _model.dictCodeText;

}
@end
