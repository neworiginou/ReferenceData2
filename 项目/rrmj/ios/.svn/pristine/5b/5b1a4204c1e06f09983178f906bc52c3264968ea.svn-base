//
//  TopSegMentrol.h
//  PUClient
//
//  Created by RRLhy on 15/7/23.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock) (NSInteger currentIndex);

@interface TopSegMentrol : UIView

@property (nonatomic,copy)SelectBlock itemBlock;

@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,strong)UIButton * currentBtn;

- (instancetype)initWithFrame:(CGRect)frame itemsTitleArray:(NSArray*)titleArray;

@end
