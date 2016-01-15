//
//  HWMyPriviledgeDetailVC.h
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWPriviledgeDetailVC.h"

@interface HWMyPriviledgeDetailVC :HWPriviledgeDetailVC
{
    UILabel *priviledgeTicketLabel;
}
@property(nonatomic,strong)NSString *priviledgeNum;
@end
