//
//  HWMsgShareViewModel.h
//  Partner-Swift
//
//  Created by hw500029 on 15/8/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTCustomActionSheet.h"

@interface HWMsgShareViewModel : NSObject<MTCustomActionSheetDelegate>
{
    MTCustomActionSheet *actionSheet;
}

@property (nonatomic, strong) NSString *shareContent;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIViewController *presentController;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, strong) void(^shareSuccess)(NSString * type);

- (id)initWithShareContent:(NSString *)content image:(UIImage *)image shareUrl:(NSString *)url;
- (void)showInView:(UIView *)view presentController:(UIViewController *)controller;
-(void)hideView;

@end
