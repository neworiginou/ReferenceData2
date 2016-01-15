//
//  HWServiceItemClass.m
//  Community
//
//  Created by caijingpeng.haowu on 14-8-27.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServiceItemClass.h"

@implementation HWServiceItemClass


@synthesize shopArray;
@synthesize propertyDic;
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init])
    {
//        self.propertyArray = [[NSMutableArray alloc] init];
        self.shopArray = [[NSMutableArray alloc] init];
        NSDictionary *dict = [dic dictionaryObjectForKey:@"property"];
        if (dict.count != 0)
        {
            propertyDic = [[HWPropertyItemClass alloc] initWithDictionary:dict];
        }
        
        
//        NSArray *arrProperty = [dic arrayObjectForKey:@"property"];
//        for (int i = 0; i < arrProperty.count; i ++)
//        {
//            [self.propertyArray addObject:[[HWPropertyItemClass alloc] initWithDictionary:[arrProperty objectAtIndex:i]]];
//            
//        }
        
        NSArray *arrShop = [dic arrayObjectForKey:@"shop"];
        for (int i = 0; i < arrShop.count; i ++)
        {
            [self.shopArray addObject:[[HWShopItemClass alloc] initWithDictionary:[arrShop objectAtIndex:i]]];
        }
        
    }
    return self;
}

-(void)dealloc
{
    self.shopArray = nil;
    self.propertyDic = nil;
//    self.propertyArray = nil;
}

@end
