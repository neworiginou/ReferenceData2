//
//  HWGameNameView.h
//  KaoLaSpread
//
//  Created by Weiyuanlin on 15/1/13.
//  Copyright (c) 2015年 hw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWGameNameModel.h"

@protocol HWGameNameViewDelegate <NSObject>

/**
 *	@brief	传递Model值给分享视图
 *
 *	@param 	model 	模
 *
 *	@return	N/A
 */
- (void)getModelValue:(HWGameNameModel *)model;

@end

@interface HWGameNameView : UIView

@property (nonatomic ,strong) UIImageView *littleImgView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *qrCodeImgView;
@property (nonatomic ,strong) UILabel *urlLabel;
@property (nonatomic, strong) NSString *gameId;//gameId(必填，游戏ID)，
@property (nonatomic, strong) NSString *appkey;//appkey(必填，)
@property (nonatomic, strong) NSString *code;//code(必填，)
@property (nonatomic, assign) id <HWGameNameViewDelegate> delegate;

- (id)initWithGameId:(NSString *)gameId appkey:(NSString *)appkey code:(NSString *)code;
@end

