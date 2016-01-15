//
//  BasePickView.h
//  Community
//
//  Created by hw500028 on 14/12/10.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddressDelegate <NSObject>

- (void)sentAddress:(NSString *)address;

@end
@interface BasePickView : UIPickerView<UIPickerViewDelegate,UIPickerViewDataSource>{

    NSMutableArray *_allProvinces;
   NSMutableArray *_allCities;
    NSMutableArray *_allAreas;

}

@property (nonatomic,strong)NSString *address;

@property (nonatomic,assign)id<AddressDelegate>addressdelegate;
@end
