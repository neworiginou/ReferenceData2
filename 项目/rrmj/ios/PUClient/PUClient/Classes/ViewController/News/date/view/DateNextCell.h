//
//  DateNextCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/15.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateNextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *enNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *RatingNum;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upImage;

+ (NSString *)cellIndentifier;

/**
 *  返回cell
 *
 *  @param index xib 中第几个cell
 *
 *  @return cell
 */
+ (DateNextCell *)CellAtIndex:(NSInteger)index;
/**
 *  显示信息
 *
 *  @param information 信息对象
 *
 *  @return 信息
 */
- (DateNextCell *)cellWithSeries:(id)series;

@end
