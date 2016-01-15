//
//  StarItem.m
//  PUClient
//
//  Created by RRLhy on 15/7/20.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "StarItem.h"

@implementation StarItem
{
    UIImageView * selectBtn;
    UIImageView * coverImage;
    UILabel * nameLabel;
    UILabel * roleLab;
    BOOL isSelected;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        coverImage = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 80)/2, 0, 80, 80)];
        coverImage.layer.cornerRadius = 40;
        coverImage.layer.masksToBounds = YES;
        coverImage.backgroundColor = [UIColor brownColor];
        [self addSubview:coverImage];
        
        selectBtn = [[UIImageView alloc]init];
        selectBtn.image = [UIImage imageNamed:@"btn_me_circle-"];
        [selectBtn setFrame:CGRectMake((WIDTH(coverImage) - 20)/2, HEIGHT(coverImage) - 23, 20, 20)];
        selectBtn.contentMode = UIViewContentModeScaleAspectFit;
        [coverImage addSubview:selectBtn];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,MaxY(coverImage) + 12, frame.size.width, 12)];
        nameLabel.textColor = REDCOLOR;
        nameLabel.font = SYSTEMFONT(12);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        roleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,MaxY(nameLabel) + 5, frame.size.width, 12)];
        roleLab.textColor = [UIColor blackColor];
        roleLab.font = SYSTEMFONT(12);
        roleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:roleLab];
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectItem:)];
        [self addGestureRecognizer:gesture];;
        
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
    StarSelectBlok block = self.selectBlok;
    
    if (block) {
        block([_star.groupId integerValue],isSelected);
    }
}

- (void)setStar:(HotStarModel *)star
{
    _star = star;
    [coverImage sd_setImageWithURL:URL(star.headImgUrl) placeholderImage:IMAGENAME(@"nopic_190x210")];
    [nameLabel setText:star.name];
    [roleLab setText:star.roleName];
}

@end
