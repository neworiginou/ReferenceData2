//
//  ApplyBusinessLicenseVertifyViewController.h
//  Community
//
//  Created by gusheng on 14-9-8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyBusinessLicenseVertifyViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIImageView *identifyFrontImageView;
@property(nonatomic,strong)UIImageView *identifyBackImageView;
@property(nonatomic,strong)UIImageView *businessLinceseImageViewTemp;
@property(nonatomic,strong)IBOutlet UIImageView *businessLinceseImageView;
@property(nonatomic,strong)IBOutlet UIImageView *businessLinceseSampleImageView;
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)UIImagePickerController *ipc;
-(IBAction)clickSubmitBusinessLicense:(id)sender;
@end
