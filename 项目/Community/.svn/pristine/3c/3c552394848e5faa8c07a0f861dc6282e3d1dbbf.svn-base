//
//  HWPriviledgeDetailTableViewCell.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWPriviledgeDetailTableViewCell.h"
#import "HWGeneralControl.h"
#define kPriviledgeDetailCellHeight 25
#define kPriviledgeDetailRuleLeft 15
#define kPriviledgeDetailLeft 10
@implementation HWPriviledgeDetailTableViewCell
@synthesize contentLabel;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        contentLabel = [HWGeneralControl createLabel:CGRectMake(kPriviledgeDetailRuleLeft+2,0, kScreenWidth-kPriviledgeDetailRuleLeft-kPriviledgeDetailLeft-2, kPriviledgeDetailCellHeight) font:13.0f textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_GRAY_MIDDLE];
        [self addSubview:contentLabel];
    }
    return self;
}

-(void)setPriviledgContent:(NSString *)contentStr
{
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, 4*kPriviledgeDetailCellHeight);
    contentLabel.text = contentStr;
    CGRect factualSize =[HWGeneralControl returnLabelFactualHeightSize:contentLabel font:13.0f];
    [contentLabel setFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, contentLabel.frame.size.width, factualSize.size.height)];
}
@end
