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
    BOOL isSelected;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * coverImage = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - 80)/2, 0, 80, 80)];
        coverImage.layer.cornerRadius = 40;
        coverImage.layer.masksToBounds = YES;
        coverImage.backgroundColor = [UIColor brownColor];
        [coverImage sd_setImageWithURL:URL(@"http://appfile.suning.cn/upload/img/logo/20131129/5297efc624b4732093710b77da9ec9518b36ed34603f083ee1107.png") placeholderImage:nil];
        [self addSubview:coverImage];
        
        selectBtn = [[UIImageView alloc]init];
        selectBtn.image = [UIImage imageNamed:@"btn_me_circle-"];
        [selectBtn setFrame:CGRectMake((WIDTH(coverImage) - 20)/2, HEIGHT(coverImage) - 23, 20, 20)];
        selectBtn.contentMode = UIViewContentModeScaleAspectFit;
        [coverImage addSubview:selectBtn];
        
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,MaxY(coverImage) + 12, frame.size.width, 12)];
        nameLabel.textColor = REDCOLOR;
        nameLabel.text = @"破产姐妹";
        nameLabel.font = SYSTEMFONT(12);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        
        UILabel * roleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,MaxY(nameLabel) + 5, frame.size.width, 12)];
        roleLab.textColor = [UIColor blackColor];
        roleLab.text = @"艾米利'亚克拉";
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
        block(10,isSelected);
    }
}

@end
