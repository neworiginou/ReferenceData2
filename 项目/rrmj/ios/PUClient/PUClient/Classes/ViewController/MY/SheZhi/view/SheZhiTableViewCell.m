//
//  SheZhiTableViewCell.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/30.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "SheZhiTableViewCell.h"

@interface SheZhiTableViewCell ()

@end

@implementation SheZhiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    self.detailLabel.font = [UIFont fontWithName:@"STHeitiSC Light" size:1.f];
//
    self.titleLabel.font = [UIFont fontWithName:@"STHeitiSC Light" size:1.f];
    
    self.titleLabel.font = [UIFont systemFontOfSize:48/3.f];
    self.detailLabel.font = [UIFont systemFontOfSize:48/3.5f];
    self.detailLabel.textColor = [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.f];
//    self.titleLabel.textColor = [UIColor blackColor];
    // [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGContextMoveToPoint(ctx, 0, self.frame.size.height - 0.3);
    CGContextAddLineToPoint(ctx, self.frame.size.width, self.frame.size.height - 0.3);
    CGContextSetLineWidth(ctx, 0.3);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor grayColor].CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    这个方法，要在实现了- (void)drawRect:(CGRect)rect方法才会调用
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
