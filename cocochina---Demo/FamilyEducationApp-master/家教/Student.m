//
//  Student.m
//  家教
//
//  Created by goofygao on 15/11/9.
//  Copyright © 2015年 goofyy. All rights reserved.
//

#import "Student.h"
#import "MJExtension/MJExtension.h"

@implementation Student

-(id)initWithDict:(NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)cellWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}


@end
