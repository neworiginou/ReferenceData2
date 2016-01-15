//
//  HWShareViewModel.h
//  MoreHouse
//
//  Created by caijingpeng.haowu on 14-11-25.
//  Copyright (c) 2014年 lizhongqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTCustomActionSheet.h"
@interface HWShareViewModel : NSObject<MTCustomActionSheetDelegate>
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
