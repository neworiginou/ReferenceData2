//
//  HWCommondityDetailScdCell.m
//  Community
//
//  Created by niedi on 15/8/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWCommondityDetailScdCell.h"

@interface HWCommondityDetailScdCell () <UIWebViewDelegate>
{
    UIWebView *_webView;
    UITextView *_textView;
}
@end

@implementation HWCommondityDetailScdCell
@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 2 * 15, 0)];
//        _textView.showsVerticalScrollIndicator = NO;
//        _textView.showsVerticalScrollIndicator = NO;
//        _textView.userInteractionEnabled = NO;
//        [self.contentView addSubview:_textView];
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(7, 0, kScreenWidth - 2 * 15, 1)];
        _webView.scrollView.scrollEnabled = NO;
//        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        [self.contentView addSubview:_webView];
        
        _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        CGFloat cellHeight = CONTENT_HEIGHT - 200 * kScreenRate - 65 - 80;
        _activity.center = CGPointMake(kScreenWidth / 2.0f, cellHeight / 2.0f);
        [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activity];
        
        CGAffineTransform transform = _activity.transform;
        //Scale
        transform = CGAffineTransformScale(transform, 1.2, 1.2);
        //Rotate
        [_activity setTransform:transform];
    }
    return self;
}

- (void)fillDataWithHtmlStr:(NSString *)HtmlStr
{
    HtmlStr = [[self class] updateImageSizeOfHTMLString:HtmlStr withSize:CGSizeMake(kScreenWidth - 2 * 15, 1)];
    [_webView loadHTMLString:HtmlStr baseURL:nil];
    NSLog(@"size: %f, %f", _webView.scrollView.contentSize.width, _webView.scrollView.contentSize.height);
    
//    HtmlStr = [[self class] updateImageSizeOfHTMLString:HtmlStr withSize:CGSizeMake(kScreenWidth - 2 * 15, 0)];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[HtmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    [_textView setAttributedText:attributedString];
//    
//    CGSize size = [_textView sizeThatFits:CGSizeMake(kScreenWidth - 2 * 15, FLT_MAX)];
//    CGRect frame = _textView.frame;
//    frame.size = CGSizeMake(kScreenWidth - 30, size.height);
//    _textView.frame = frame;
//    _textView.contentSize = frame.size;
}

+ (CGFloat)getCellHeight:(NSString *)HtmlStr
{
//    HtmlStr = [self updateImageSizeOfHTMLString:HtmlStr withSize:CGSizeMake(kScreenWidth - 2 * 15, 0)];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[HtmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 2 * 15, 0)];
//    [textView setAttributedText:attributedString];
//    
//    CGSize size = [textView sizeThatFits:CGSizeMake(kScreenWidth - 2 * 15, FLT_MAX)];
//    return size.height;
    return 0;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"size: %f, %f", _webView.scrollView.contentSize.width, _webView.scrollView.contentSize.height);
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activity startAnimating];
    
    NSLog(@"size: %f, %f", _webView.scrollView.contentSize.width, _webView.scrollView.contentSize.height);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activity stopAnimating];
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    
    if (delegate && [delegate respondsToSelector:@selector(didFinishLoadHtmlWithContentHeight:)])
    {
        [delegate didFinishLoadHtmlWithContentHeight:frame.size.height];
    }
}

+ (NSString *)updateImageSizeOfHTMLString:(NSString *)HTMLString withSize:(CGSize)size
{
    NSString *imageNode = @"<img src=";
    NSString *styleNode = @"width:";
    NSString *pxSuffix = @"px";
    NSString *tmpHTMLString = HTMLString;
    NSString *maskSize = [NSString stringWithFormat:@"%.f",size.width];
    NSInteger i = HTMLString.length;
    while (i) {
        NSRange imageNodeRange = [tmpHTMLString rangeOfString:imageNode];
        if (imageNodeRange.location == NSNotFound) {
            break;
        }
        tmpHTMLString = [tmpHTMLString substringFromIndex:imageNodeRange.location + imageNodeRange.length];
        
        NSRange styleNodeRange = [tmpHTMLString rangeOfString:styleNode];
        if (styleNodeRange.location != NSNotFound)
        {
            tmpHTMLString = [tmpHTMLString substringFromIndex:styleNodeRange.location + styleNodeRange.length];
            
            NSRange pxRange = [tmpHTMLString rangeOfString:pxSuffix];
            
            if (pxRange.location != NSNotFound)
            {
                NSRange width = NSMakeRange([HTMLString rangeOfString:tmpHTMLString].location, pxRange.location);
                if (width.location != NSNotFound)
                {
                    NSString *widthString = [HTMLString substringWithRange:width];
                    HTMLString = [HTMLString stringByReplacingCharactersInRange:width withString:maskSize];
                    i = HTMLString.length -  width.location;
                    tmpHTMLString = [tmpHTMLString substringFromIndex:widthString.length + pxRange.length];
                }
            }
        }
    }
    return HTMLString;
}

@end
