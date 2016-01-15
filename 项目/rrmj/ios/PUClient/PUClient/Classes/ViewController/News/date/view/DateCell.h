//
//  DateCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DateModel.h"
@class DateCell;

@protocol DateCellDelegate <NSObject>

- (void)unfoldCell:(DateCell*)dateCell;

@end

@interface DateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *weak;
@property (weak, nonatomic) IBOutlet UIButton *expandBtn;

@property (nonatomic,assign)id <DateCellDelegate> delegate;
/**
 *  重用标示符
 *
 *  @return 重用符
 */
+ (NSString*)dateIndentifier;
/**
 *  获取cell
 *
 *  @return cell
 */
+ (DateCell*)dateCell;
/**
 *  cell展示
 *
 *  @param date 排期对象
 *
 *  @return cell
 */
- (DateCell*)configureWithDate:(DateModel *)date;
/**
 *  根据对象返回高度
 *
 *  @param date 排期表对象
 *
 *  @return cell高度
 */
+ (CGFloat)heightForCellWithDate:(DateModel*)date;

@end

