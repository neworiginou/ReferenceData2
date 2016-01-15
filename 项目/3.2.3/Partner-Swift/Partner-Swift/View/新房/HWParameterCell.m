//
//  HWParameterCell.m
//  MoreHouse
//
//  Created by zhangxun on 14/11/20.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import "HWParameterCell.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"


#define kLabelMargin 5
@interface HWParameterCell()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
}
@end

@implementation HWParameterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 90, 25)];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 0, [UIScreen mainScreen].bounds.size.width - 105 - 15, 25)];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textColor = TITLE_COLOR_99;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
    }
    return self;
}

- (void)setTags:(NSArray *)arr{
    _contentLabel.text = nil;
    
    for (int i = 0; i < arr.count; i++) {
        HWTagLabel *tagL = [[HWTagLabel alloc]initWithFrame:CGRectMake(85 + (kLabelMargin + 60) * i, 11.0/2.0f - 2.5, 60, 19) text:arr[i] Font:[UIFont systemFontOfSize:13] isAutoResize:NO];
        [tagL setColor:TITLE_COLOR_99];
        [self.contentView addSubview:tagL];
    }
}

- (void)setContent:(NSString *)content{
    for (HWTagLabel *label in self.contentView.subviews) {
        if ([label isKindOfClass:[HWTagLabel class]]) {
            [label removeFromSuperview];
        }
    }
    CGSize size = [Utility calculateStringSize:content textFont:[UIFont systemFontOfSize:13] constrainedSize:CGSizeMake(kScreenWidth - 105 - 15, 1000)];
    
    _contentLabel.frame = CGRectMake(105, 4, size.width, size.height);
    _contentLabel.text = content;
}

- (void)setTitle:(NSString *)str{
    for (HWTagLabel *label in self.contentView.subviews) {
        if ([label isKindOfClass:[HWTagLabel class]]) {
            [label removeFromSuperview];
        }
    }
    _titleLabel.text = str;
}


+ (float)getCellHeightByContent:(NSString *)content
{
    CGSize size = [Utility calculateStringSize:content textFont:[UIFont systemFontOfSize:13] constrainedSize:CGSizeMake(kScreenWidth - 105 - 15, 1000)];
    return MAX(size.height + 10, 25);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
