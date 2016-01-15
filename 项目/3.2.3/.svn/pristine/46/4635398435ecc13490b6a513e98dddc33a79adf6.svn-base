//
//  SGFocusImageFrame.h
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGFocusImageItem : NSObject
@property (nonatomic, strong)  NSString      *title;
@property (nonatomic, strong)  NSString      *image;
@property (nonatomic, strong)  NSString      *type;//广告还是优惠劵
@property (nonatomic)          NSInteger     tag;
@property (nonatomic, strong)  NSString      *aId;//广告id

- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag type:(NSString *)atype id:(NSString * )aId;
+ (id)itemWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag type:(NSString *)atype id:(NSString * )aId;
@end

@interface SGRobItem : NSObject
@property(nonatomic, strong)NSString * houseId;
- (id)initWithHouseId:(NSString *)houseId;
+ (id)itemWithHouseId:(NSString *)houseId;
@end

#pragma mark - SGFocusImageFrameDelegate

@class SGFocusImageFrame;
@protocol SGFocusImageFrameDelegate <NSObject>
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame
           didSelectItem:(SGFocusImageItem *)item;
- (void)commeInRob:(SGRobItem *)robItem;
@end

@interface SGFocusImageFrame : UIView <UIGestureRecognizerDelegate,
                                       UIScrollViewDelegate>
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItems:(SGFocusImageItem *)items, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItemsArrray:(NSArray *)items detailarr:(NSArray *)detailArry;

@property (nonatomic, assign) BOOL autoScrolling;
@property (nonatomic) NSTimeInterval switchTimeInterval; // default for 10.0s
@property (nonatomic, assign) id<SGFocusImageFrameDelegate> delegate;
@property (nonatomic, copy) void (^didSelectItemBlock)(SGFocusImageItem *item);
@property (nonatomic, strong)UILabel *customerNumLabel;
@property (nonatomic, strong)UILabel *houseLabel;
@property (nonatomic,strong)NSArray * detailArr;
@end
