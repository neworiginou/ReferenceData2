//
//  HWHaiwaiBaseInfoCell.h
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-5.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWHaiwaiBaseInfoCellDelegate <NSObject>

- (void)didFinishedHaiwaiWebview:(UIWebView *)webview;

@end

@interface HWHaiwaiBaseInfoCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, assign)id<HWHaiwaiBaseInfoCellDelegate> delegate;

@end
