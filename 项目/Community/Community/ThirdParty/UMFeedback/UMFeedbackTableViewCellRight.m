//
//  UMFeedbackTableViewCellRight.m
//  UMeng Analysis
//
//  Created by liuyu on 9/18/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMFeedbackTableViewCellRight.h"

#define TOP_MARGIN 20.0f

@implementation UMFeedbackTableViewCellRight

@synthesize timestampLabel = _timestampLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f) {
            self.textLabel.backgroundColor = [UIColor whiteColor];
        }

        self.textLabel.font = [UIFont systemFontOfSize:15.0f];
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];

        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _timestampLabel.textAlignment = NSTextAlignmentCenter;
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont systemFontOfSize:12.0f];
        _timestampLabel.textColor = THEME_COLOR_TEXT;
        _timestampLabel.frame = CGRectMake(0.0f, 12, self.bounds.size.width, 18);

        [self.contentView addSubview:_timestampLabel];

        CGRect textLabelFrame = self.textLabel.frame;
        textLabelFrame.origin.y = 20;
        textLabelFrame.size.width = self.bounds.size.width - 50;
        self.textLabel.frame = textLabelFrame;

        messageBackgroundView = [[UIImageView alloc] initWithFrame:self.textLabel.frame];
        messageBackgroundView.image = [[UIImage imageNamed:@"messages_right_bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(35, 30, 10, 60)];
        [self.contentView insertSubview:messageBackgroundView belowSubview:self.textLabel];

        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.size.width = 226;

    CGSize labelSize = [self.textLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f]
                                       constrainedToSize:CGSizeMake(226, MAXFLOAT)
                                           lineBreakMode:NSLineBreakByWordWrapping];

    textLabelFrame.size.height = labelSize.height + 10;
    textLabelFrame.origin.y = 20.0f + TOP_MARGIN;
    textLabelFrame.origin.x = kScreenWidth - labelSize.width - 20 - 5;
    self.textLabel.frame = textLabelFrame;

    messageBackgroundView.frame = CGRectMake(textLabelFrame.origin.x - 8, textLabelFrame.origin.y - 2, labelSize.width + 16 + 10, labelSize.height + 13);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor);

    CGContextSetLineWidth(context, 0.0);
    CGContextMoveToPoint(context, 0, 21); //start at this point
    CGContextAddLineToPoint(context, (self.bounds.size.width - 120) / 2, 21); //draw to this point

    CGContextMoveToPoint(context, self.bounds.size.width, 21); //start at this point
    CGContextAddLineToPoint(context, self.bounds.size.width - (self.bounds.size.width - 120) / 2, 21); //draw to this point

    CGContextStrokePath(context);

}

@end
