//
//  HWSoundPlayButton.h
//  Community
//
//  Created by hw500027 on 15/1/12.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWAudioManager.h"

@interface HWSoundPlayButton : UIButton
{
    HWAudioManager *customerAudio;
}
typedef enum{
    buttonStatusStop = 0,
    buttonStatusPlay,
    buttonStatusPause
}soundStatus;

-(id)initWithTitle:(NSString*)titleName isBig:(BOOL)big;

-(void)setSoundBtnUrl:(NSString*)soundUrl andIndex:(NSIndexPath*)index;

- (void)setString:(NSString *)title;

@property (nonatomic,assign)soundStatus buttonStatus;

@end
