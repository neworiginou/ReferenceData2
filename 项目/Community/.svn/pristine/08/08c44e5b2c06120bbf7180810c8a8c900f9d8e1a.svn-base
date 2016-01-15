//
//  GKRecordProgressView.h
//  Camera
//
//  Created by caijingpeng on 13-12-15.
//  Copyright (c) 2013年 caijingpeng. All rights reserved.
//
//  视频录制进度条

#import <UIKit/UIKit.h>

@protocol GKRecordProgressViewDelegate <NSObject>

- (void)reachMinProgress;

@end

@interface GKRecordProgressView : UIView
{
    
    UIView *headView;
}

@property (nonatomic) float progress;
@property (nonatomic, assign) id<GKRecordProgressViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *progressSegments;

- (void)markSegment;

@end
