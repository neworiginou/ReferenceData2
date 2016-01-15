//
//  HWMoreRecommendVC.h
//  Community
//
//  Created by niedi on 15/4/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWChannelTableView.h"


@interface HWMoreRecommendVC : HWBaseViewController<HWChannelTableViewDelegate, hwsearchListTableDelegate>
{
    HWChannelTableView *_moreRecommendView;
    
}



@end
