//
//  VideoViewController.h
//  VideoTest
//
//  Created by lkk on 13-11-25.
//  Copyright (c) 2013年 lkk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASIHTTPRequest;
@interface VideoViewController : UIViewController{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;
}
@end
