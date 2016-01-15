//
//  HWCommondityDetailScdCell.h
//  Community
//
//  Created by niedi on 15/8/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseTableViewCell.h"

@protocol HWCommondityDetailScdCellDelegate <NSObject>

- (void)didFinishLoadHtmlWithContentHeight:(CGFloat)height;

@end

@interface HWCommondityDetailScdCell : HWBaseTableViewCell

@property (nonatomic, strong) id<HWCommondityDetailScdCellDelegate> delegate;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

- (void)fillDataWithHtmlStr:(NSString *)HtmlStr;


+ (CGFloat)getCellHeight:(NSString *)HtmlStr;


@end
