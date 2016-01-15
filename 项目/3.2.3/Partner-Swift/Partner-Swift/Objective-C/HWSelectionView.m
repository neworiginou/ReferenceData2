//
//  HWSelectionView.m
//  MoreHouse
//
//  Created by zhangxun on 14/11/21.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWSelectionView.h"

#define kImageSize 19
#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define TITLE_COLOR_99                      UIColorFromRGB(0x999999)

@interface HWSelectionView()
{
    UIImageView *_imageV;
    UILabel *_titleLabel;
}
@end

@implementation HWSelectionView
@synthesize allowMore,isSelected;

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kImageSize, kImageSize)];
        [self addSubview:_imageV];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageV.frame.size.width, 0, 80, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = TITLE_COLOR_99;
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
       
        self.backgroundColor = [UIColor whiteColor];
        
        _imageV.center = CGPointMake(kImageSize / 2.0f, self.frame.size.height / 2.0f);
        _titleLabel.center = CGPointMake(_titleLabel.center.x, self.frame.size.height / 2.0f);
        CGRect rect =  [self returnLabelFactualSize:_titleLabel font:15.0];
        _titleLabel.frame = rect;
        _titleLabel.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, kImageSize + 5 + _titleLabel.frame.size.width + 5, 20);
        _imageV.image = [UIImage imageNamed:@"choose_2_1"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSel)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
-(CGRect)returnLabelFactualSize:(UILabel *)caculationLabel font:(NSInteger)fontSize
{
    caculationLabel.numberOfLines = 0;
    caculationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    caculationLabel.textAlignment = NSTextAlignmentCenter;
    CGRect textLabelFrame = caculationLabel.frame;
    caculationLabel.frame = textLabelFrame;
    CGSize labelSize = [caculationLabel.text sizeWithFont:[UIFont systemFontOfSize:fontSize]
                                        constrainedToSize:CGSizeMake(MAXFLOAT, caculationLabel.frame.size.height)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    
    textLabelFrame.size.width = labelSize.width;
    return textLabelFrame;
    
}
- (void)doSel{
    if (allowMore) {
        isSelected = !isSelected;
        if (!isSelected) {
            _imageV.image = [UIImage imageNamed:@"choose_2_1"];
            [self.delegate deSelected:self];
        }else{
            _imageV.image = [UIImage imageNamed:@"choose_2_2"];
            [self.delegate selected:self];
        }
        
    }
    else{
        isSelected = YES;
        _imageV.image = [UIImage imageNamed:@"choose_2_2"];
        [self.delegate selected:self];
    }
}

- (void)setDeselected{
    isSelected = NO;
    _imageV.image = [UIImage imageNamed:@"choose_2_1"];
}

- (void)setSelected{
    isSelected = YES;
    _imageV.image = [UIImage imageNamed:@"choose_2_2"];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
