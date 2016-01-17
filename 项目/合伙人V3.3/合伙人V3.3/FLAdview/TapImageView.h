//
//  TapImageView.h
//  ImageTest
//
//  Created by apple on 15-4-22.
//  Copyright (c) 2015年 fengling2300. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageTapDelegate <NSObject>

-(void)imageViewTaped:(id)sender;

@end

@interface TapImageView : UIImageView

@property(nonatomic,assign)id<ImageTapDelegate> delegate;
@end
