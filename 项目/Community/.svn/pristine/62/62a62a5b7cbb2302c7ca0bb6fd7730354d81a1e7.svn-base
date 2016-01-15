//
//  HWReceiveAddressModel.m
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWReceiveAddressModel.h"

@implementation HWReceiveAddressModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.detail = [dictionary stringObjectForKey:@"detail"];
        self.key = [dictionary stringObjectForKey:@"key"];;
        self.status = [dictionary stringObjectForKey:@"status"];;
        self.data = [dictionary dictionaryObjectForKey:@"data"];
        self.size= [self.data stringObjectForKey:@"size"];
        self.number= [self.data stringObjectForKey:@"number"];
        self.sort= [self.data stringObjectForKey:@"sort"];
        self.totalElements= [self.data stringObjectForKey:@"totalElements"];
        self.lastPage= [self.data stringObjectForKey:@"lastPage"];
        self.firstPage= [self.data stringObjectForKey:@"firstPage"];
        self.totalPages= [self.data stringObjectForKey:@"totalPages"];
        self.numberOfElements= [self.data stringObjectForKey:@"numberOfElements"];
        
        self.content = [self.data arrayObjectForKey:@"content"];
        self.addressArray = [NSMutableArray array];
        for (NSDictionary *anyObject in self.content) {
            HWAddressInfo *address = [[HWAddressInfo alloc] initWithDictionary:anyObject];
            [self.addressArray addObject:address];
        }
    }
    return self;
}




@end
