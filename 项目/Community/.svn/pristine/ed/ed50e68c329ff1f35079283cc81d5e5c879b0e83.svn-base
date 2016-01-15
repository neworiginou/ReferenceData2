//
//  MineExtendHeaderView.h
//  TEST
//
//  Created by gusheng on 14-8-29.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineExtendHeaderView : UIView
{
    IBOutlet UILabel* DetailLabel;
    IBOutlet UIImageView *headImage;
    IBOutlet UISegmentedControl *segCtrl;
    IBOutlet UILabel *totalTitleLabel;
    IBOutlet UILabel *totalActiveTitleLabel;
    IBOutlet UILabel *totalRegisterLabel;
}
@property(nonatomic,copy)void(^clickSegmentBlock)(int index);
@property(nonatomic,strong)IBOutlet UILabel* totalScanLabel;
@property(nonatomic,strong)IBOutlet UILabel* totalActiveLabel;
@property(nonatomic,strong)IBOutlet UILabel* totalRegisterLabel;
@property(nonatomic,strong)IBOutlet UILabel* DetailLabel;

-(IBAction)clickSegment:(id)sender;
@end
