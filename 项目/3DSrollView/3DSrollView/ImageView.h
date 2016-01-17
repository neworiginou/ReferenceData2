//
//  ImageView.h
//  3DSrollView
//
//  Created by lizhongqiang on 16/1/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MyLeft=10,
    MyRight
}MyDirection;
@interface ImageView : UIImageView
@property (nonatomic, assign)int page;
@property (nonatomic, assign)MyDirection direction;
@property (nonatomic, assign)CGFloat removeOffsetX;

- (void)currentPageMove:(CGFloat)contentOffX;
- (void)nextPageMove:(CGFloat)contentOffX;
- (void)lastPageMove:(CGFloat)contentOffX;
@end
