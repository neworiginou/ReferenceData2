//
//  ReviewCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewModel.h"
@interface ReviewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reviewTitle;
@property (weak, nonatomic) IBOutlet UILabel *reviewIntro;

@property (weak, nonatomic) IBOutlet UILabel *reviewSeriesName;

@property (weak, nonatomic) IBOutlet UILabel *reviewDate;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImage;

/**
 *  剧评重用id
 *
 *  @return 重用符
 */
+ (NSString *)reviewCellID;
/**
 *  返回cell
 *
 *  @param index xib 中第几个cell
 *
 *  @return cell
 */
+ (ReviewCell *)reviewCellAtIndex:(NSInteger)index;
/**
 *  返回剧评时的cell
 *
 *  @param review 剧评对象
 *
 *  @return cell
 */
- (ReviewCell*)cellWithReview:(ReviewModel*)review;


@end
