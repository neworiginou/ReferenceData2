//
//  HWDetailBaseInfoCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-4.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWDetailBaseInfoCellDelegate <NSObject>

- (void)didFinishedWebview:(UIWebView *)webview;

@end

@interface HWDetailBaseInfoCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, assign)id<HWDetailBaseInfoCellDelegate> delegate;


@end
