//
//  HWDetailBaseInfoCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWDetailBaseInfoCell.h"

@implementation HWDetailBaseInfoCell
@synthesize webView,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 0)];
        webView.delegate = self;
        webView.scrollView.scrollEnabled = NO;
        [self.contentView addSubview:webView];
        
    }
    return self;
}
- (void)webViewDidFinishLoad:(UIWebView *)web
{
    
    if (delegate && [delegate respondsToSelector:@selector(didFinishedWebview:)]) {
        [delegate didFinishedWebview:web];
    }
}


@end
