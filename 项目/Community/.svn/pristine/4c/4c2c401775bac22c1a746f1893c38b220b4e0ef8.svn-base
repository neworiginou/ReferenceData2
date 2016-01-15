//
//  HWOrderCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-7.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWOrderCell.h"

@implementation HWOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //45  15
        labLeft = [[UILabel alloc] initWithFrame:CGRectMake(15, (45 - 27) / 2.0f + 1.0f, 150, 27)];
        [labLeft setBackgroundColor:[UIColor clearColor]];
        [labLeft setTextAlignment:NSTextAlignmentLeft];
        [labLeft setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
        [labLeft setTextColor:THEME_COLOR_TEXT];
        [self.contentView addSubview:labLeft];
        
        labRight = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, kScreenWidth - 135, 30)];
        labRight.numberOfLines = 0;
        [labRight setBackgroundColor:[UIColor clearColor]];
        [labRight setTextColor:THEME_COLOR_SMOKE];
        [labRight setTextAlignment:NSTextAlignmentRight];
        [labRight setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [self.contentView addSubview:labRight];
        
    }
    
    
    return self;
}

-(void)setOrderCellDic:(NSDictionary *)orderCellDic
{
    labLeft.text = [orderCellDic objectForKey:@"left"];
    labRight.text = [orderCellDic objectForKey:@"right"];
    
    CGSize sizeRight = [labRight.text sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedToSize:CGSizeMake(kScreenWidth - 130, CGFLOAT_MAX)];
    [labRight setFrame:CGRectMake(100, 15, kScreenWidth - 130, sizeRight.height)];
}

+ (CGFloat)getOrderCellHeight:(NSDictionary *)dic
{
    NSString *str = [dic objectForKey:@"right"];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG] constrainedToSize:CGSizeMake(kScreenWidth - 130, CGFLOAT_MAX)];
    return fmaxf(45.0f, size.height + 30.0f);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
