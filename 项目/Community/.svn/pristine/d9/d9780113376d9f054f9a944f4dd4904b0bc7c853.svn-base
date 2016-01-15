//
//  HWCollectionLayout.m
//  TestOne
//
//  Created by gusheng on 14-12-9.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWCollectionLayout.h"
#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
@implementation HWCollectionLayout
-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake((kScreenWidth-4*30)/3, 100);
        //        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(15, 15, 20, 15);
        self.minimumLineSpacing = 15.0;
        self.minimumInteritemSpacing = 30.0;
        self.headerReferenceSize = CGSizeMake(kScreenWidth, 15
                                              );
        self.footerReferenceSize = CGSizeMake(kScreenWidth, 30);
    }
    return self;
}
@end
