//
//  CommentCell.h
//  PUClient
//
//  Created by RRLhy on 15/8/14.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *nickLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UserHeaderView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *parentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *parentImage;

+ (NSString *)cellIndentifier;

/**
 *  返回cell
 *
 *  @param index xib 中第几个cell
 *
 *  @return cell
 */
+ (CommentCell *)commentCellAtIndex:(NSInteger)index;
/**
 *  显示信息
 *
 *  @param information 信息对象
 *
 *  @return 信息
 */
- (CommentCell *)cellWithComment:(CommentModel *)comment;
/**
 *  更具对象返回高度
 *
 *  @param information 信息对象
 *
 *  @return 高度
 */
+ (CGFloat)heightForRowWithComment:(CommentModel *)comment;
@end
