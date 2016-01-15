//
//  HWNeighbourDetailCell.m
//  Community
//
//  Created by zhangxun on 14-9-1.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWNeighbourDetailCell.h"

@implementation HWNeighbourDetailCell
@synthesize headIV,nameLabel,dateLabel,contentLabel,detailId,detailTextLabel,lineV;
@synthesize delegare;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier containingTableView:containingTableView leftUtilityButtons:leftUtilityButtons rightUtilityButtons:rightUtilityButtons];
    if (self) {
        self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
        self.headIV.backgroundColor = [UIColor orangeColor];
        headIV.layer.cornerRadius = 15.0f;
        headIV.clipsToBounds = YES;
        [self.contentView addSubview:headIV];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIV.frame) + 8 , 10, 120, 17)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont fontWithName:FONTNAME size:12];
        nameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:nameLabel];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 115, 10, 100, 17)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont fontWithName:FONTNAME size:12];
        dateLabel.textColor = [UIColor lightGrayColor];
        dateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:dateLabel];
        
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headIV.frame) + 8 , CGRectGetMaxY(nameLabel.frame) + 3, kScreenWidth - nameLabel.frame.origin.x - 15, 20)];
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.userInteractionEnabled = YES;
        contentLabel.font = [UIFont fontWithName:FONTNAME size:14];
        [self.contentView addSubview:contentLabel];
        
        self.lineV= [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 15, 0.5)];
        lineV.backgroundColor = THEME_COLOR_LINE;
//        lineV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:lineV];
        
    }
    
    
    return self;
}



- (BOOL)canBecomeFirstResponder{
    return YES;
}

/**
 *	@brief	成为第一响应者后相应的方法
 *
 *	@param 	action 	方法名
 *	@param 	sender 	参数
 *
 *	@return	N/A
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(doCopy:) || action == @selector(startReport:)) {
        return YES;
    }
    return NO;
}

/**
 *	@brief	复制
 *
 *	@param 	sender 	入参
 *
 *	@return	N/A
 */
- (void)doCopy:(id)sender
{
    [MobClick event:@"click_copy"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:contentLabel.text];
    [self.delegare pasteSucceed];
}

- (void)startReport:(id)sender{
    [MobClick event:@"click_expose_comment"];
    [self.delegare reportWithReplyId:_currentItem.replyId];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)awakeFromNib
{
    // Initialization code
}

/**
 *	@brief	根据内容重新绘制UI
 *
 *	@param 	dict 	接收到得内容
 *
 *	@return	N/A
 */
- (void)rebuildWithInfo:(HWNeighbourDetailListItemClass *)neighbourDetailClass
{
    
    _currentItem = neighbourDetailClass;
    
    headIV.image = nil;
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBase,neighbourDetailClass.headUrl,[HWUserLogin currentUserLogin].key]];
    __weak UIImageView *blockImgV = headIV;
    [headIV setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"head_2"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"head_2"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    
    nameLabel.text = neighbourDetailClass.nickName;
    if (neighbourDetailClass.nickName.length == 0) {
        nameLabel.text = @"物业";
    }
    dateLabel.text = neighbourDetailClass.replyTime;
    contentLabel.text = neighbourDetailClass.content;
    //对楼主和@人做显示与不显示的判断，调整label位置
    
    BOOL isLouZhu = NO;
    BOOL isAtSomeBody = NO;
    NSString *replyContentStr = @"";
    if ([neighbourDetailClass.userId isEqualToString:neighbourDetailClass.topicUserId])
    {
        //显示楼主
        NSString *str = @"楼主 ";
        replyContentStr = [NSString stringWithFormat:@"%@%@",replyContentStr,str];
        isLouZhu = YES;
    }
    
    if (neighbourDetailClass.calleeUserNickName.length > 0)
    {
        //显示@人
        replyContentStr = [NSString stringWithFormat:@"%@@%@ ",replyContentStr,neighbourDetailClass.calleeUserNickName];
        isAtSomeBody = YES;
    }
    
    replyContentStr = [NSString stringWithFormat:@"%@%@",replyContentStr,neighbourDetailClass.content];
    
    CGSize size = [Utility calculateStringHeight:replyContentStr font:[UIFont fontWithName:FONTNAME size:14] constrainedSize:CGSizeMake(kScreenWidth - 15 - 40, CGFLOAT_MAX)];
    contentLabel.frame = CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y, size.width, size.height);
//    NSLog(@"setcell content = %@  height = %f",replyContentStr,size.height);
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc] initWithString:replyContentStr];

    if ([neighbourDetailClass.userId isEqualToString:neighbourDetailClass.topicUserId]) {
        [contentStr addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:14] range:NSMakeRange(0, 2)];
    }
    
    if (neighbourDetailClass.calleeUserNickName.length > 0)
    {
        [contentStr addAttribute:NSFontAttributeName value:(id)[UIFont fontWithName:FONTNAME size:14] range:NSMakeRange(3, 0)];
    }
    
    if (isLouZhu)
    {
        [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEBUTTON_RED_NORMAL range:NSMakeRange(0, 2)];
        if (isAtSomeBody)
        {
            [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_ORANGE range:NSMakeRange(3, neighbourDetailClass.calleeUserNickName.length + 1)];
            [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_SMOKE range:NSMakeRange(3 + neighbourDetailClass.calleeUserNickName.length + 1, contentStr.length - 3 - neighbourDetailClass.calleeUserNickName.length - 1)];
        }
        else
        {

            [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_SMOKE range:NSMakeRange(3, neighbourDetailClass.calleeUserNickName.length)];
        }
        
    }
    else
    {
        if (isAtSomeBody)
        {
            [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_ORANGE range:NSMakeRange(0, neighbourDetailClass.calleeUserNickName.length + 1)];
            [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_SMOKE range:NSMakeRange(neighbourDetailClass.calleeUserNickName.length + 1, contentStr.length - neighbourDetailClass.calleeUserNickName.length - 1)];
        }
        else
        {
            [contentStr addAttribute:NSForegroundColorAttributeName value:(id)THEME_COLOR_SMOKE range:NSMakeRange(0, neighbourDetailClass.content.length)];
        }
    }
    contentLabel.attributedText = contentStr;
    lineV.frame = CGRectMake(15, size.height + 39 - 0.5, kScreenWidth - 15, 0.5);
    
}

+ (float)getCellHeight:(HWNeighbourDetailListItemClass *)item
{
    NSString *replyContentStr = @"";
    if ([item.userId isEqualToString:item.topicUserId])
    {
        //显示楼主
        NSString *str = @"楼主";
        replyContentStr = [NSString stringWithFormat:@"%@%@",replyContentStr,str];
    }
    
    if (item.calleeUserNickName.length > 0)
    {
        //显示@人
        replyContentStr = [NSString stringWithFormat:@"%@@%@ ",replyContentStr,item.calleeUserNickName];
    }
    
    replyContentStr = [NSString stringWithFormat:@"%@%@",replyContentStr,item.content];
    
    CGSize size = [Utility calculateStringHeight:replyContentStr font:[UIFont fontWithName:FONTNAME size:14] constrainedSize:CGSizeMake(kScreenWidth - 15 - 40, CGFLOAT_MAX)];
    
//    NSLog(@"getHeight content = %@  height = %f",replyContentStr,size.height);
    return size.height + 40.0f;
    
}

- (void)setFinalLine
{
    self.lineV.frame = CGRectMake(0, lineV.frame.origin.y, kScreenWidth, 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
