//
//  HWHaiwaiBaseInfoCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-5.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWHaiwaiBaseInfoCell.h"

@implementation HWHaiwaiBaseInfoCell
@synthesize webView,leftLabel,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 70, 20)];
        leftLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
        leftLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:leftLabel];
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(80, 10, kScreenWidth - 90, 1)];
        webView.delegate = self;
        webView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:webView];
        
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)web
{
    if (delegate && [delegate respondsToSelector:@selector(didFinishedHaiwaiWebview:)]) {
        [delegate didFinishedHaiwaiWebview:web];
    }
}


@end









