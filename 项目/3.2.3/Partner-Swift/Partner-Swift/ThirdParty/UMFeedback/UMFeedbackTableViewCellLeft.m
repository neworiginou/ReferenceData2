//
//  FeedbackTableViewCell.m
//  UMeng Analysis
//
//  Created by liuyu on 9/18/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMFeedbackTableViewCellLeft.h"
#import "Partner_Swift-Swift.h"
#import "Define-OC.h"

#define TOP_MARGIN 20.0f

@implementation UMFeedbackTableViewCellLeft

@synthesize timestampLabel = _timestampLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0f) {
            self.textLabel.backgroundColor = [UIColor whiteColor];
        }
        
        self.textLabel.font = [UIFont fontWithName:FONTNAME size:13];
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = TITLE_COLOR_33;

        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _timestampLabel.textAlignment = NSTextAlignmentCenter;
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont fontWithName:FONTNAME size:13];
        _timestampLabel.textColor = TITLE_COLOR_99;
        _timestampLabel.frame = CGRectMake(0.0f, 10, self.bounds.size.width, 18);

        [self.contentView addSubview:_timestampLabel];

        messageBackgroundView = [[UIImageView alloc] initWithFrame:self.textLabel.frame];
        messageBackgroundView.image = [[UIImage imageNamed:@"sall_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(35, 25, 10, 20)];
        [self.contentView insertSubview:messageBackgroundView belowSubview:self.textLabel];

        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect textLabelFrame = self.textLabel.frame;
    textLabelFrame.origin.x = 25;
    textLabelFrame.size.width = 226;

    CGSize labelSize = [self.textLabel.text sizeWithFont:[UIFont fontWithName:FONTNAME size:13]
                                       constrainedToSize:CGSizeMake(226.0f, MAXFLOAT)
                                           lineBreakMode:NSLineBreakByWordWrapping];
    textLabelFrame.size.height = labelSize.height;
    textLabelFrame.origin.y = 25.0f + TOP_MARGIN;
    self.textLabel.frame = textLabelFrame;

    messageBackgroundView.frame = CGRectMake(10, textLabelFrame.origin.y - 6 - 5, labelSize.width + 16 + 10, labelSize.height + 23);
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
