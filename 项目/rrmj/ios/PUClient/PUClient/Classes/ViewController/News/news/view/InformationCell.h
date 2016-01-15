//
//  InformationCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsIntroModel;
@class ReviewModel;
@interface InformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *mixView;
@property (weak, nonatomic) IBOutlet UILabel *mixTitle;
@property (weak, nonatomic) IBOutlet UILabel *mixIntro;
@property (weak, nonatomic) IBOutlet UILabel *mixDate;
@property (weak, nonatomic) IBOutlet UIButton *mixReplyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *mixIageView;
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UILabel *bigTitle;
@property (weak, nonatomic) IBOutlet UILabel *bigDate;
@property (weak, nonatomic) IBOutlet UIButton *bigReplyBtn;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@property (weak, nonatomic) IBOutlet UILabel *reviewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *reviewImage;
@property (weak, nonatomic) IBOutlet UILabel *reviewIntro;
@property (weak, nonatomic) IBOutlet UILabel *reviewSeriesName;
@property (weak, nonatomic) IBOutlet UILabel *reviewDate;

/**
 *  cell重用标识符
 *
 *  @return 标识符
 */
+ (NSString *)cellID;

/**
 *  返回cell
 *
 *  @param index xib 中第几个cell
 *
 *  @return cell
 */
+ (InformationCell *)informationCellAtIndex:(NSInteger)index;
/**
 *  显示信息
 *
 *  @param information 信息对象
 *
 *  @return 信息
 */
- (InformationCell *)cellWithInformation:(NewsIntroModel*)information;
/**
 *  更具对象返回高度
 *
 *  @param information 信息对象
 *
 *  @return 高度
 */
+ (CGFloat)heightForRowWithInformation:(NewsIntroModel *)information;

- (InformationCell *)cellWithRating:(ReviewModel*)rating;

@end
