//
//  HWInviteCustomSuccedModel.m
//  Community
//
//  Created by niedi on 15/6/17.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWInviteCustomSuccedModel.h"

@implementation HWInviteCustomSuccedModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.visitorMobile = [dict stringObjectForKey:@"visitorMobile"];
        self.villageName = [dict stringObjectForKey:@"villageName"];
        self.visitorDate = [dict stringObjectForKey:@"visitorDate"];
        self.dateCount = [dict stringObjectForKey:@"dateCount"];
        self.zxing = [dict stringObjectForKey:@"zxing"];
        self.visitorName = [dict stringObjectForKey:@"visitorName"];
        self.relationship = [dict stringObjectForKey:@"relationship"];
        self.isVisit = [dict stringObjectForKey:@"isVisit"];
        self.isPast = [dict stringObjectForKey:@"isPast"];
        self.isValid = [dict stringObjectForKey:@"isValid"];
        self.tvId = [dict stringObjectForKey:@"tvId"];
        self.buttonStatus = [dict stringObjectForKey:@"buttonStatus"];
        self.SixConunt = [dict stringObjectForKey:@"SixConunt"];
    }
    return self;
}



@end

/*出参：
 /访客手机/
 private String visitorMobile ;
 /访问小区/
 private String villageName ;
 /开始日期/
 private String visitorDate ;
 /有效天数/
 private String dateCount;
 /二维码/
 private String zxing;
 /访客名字/
 private String visitorName;
 /访客关系/
 private String relationship;
 /预约来访 – 0没有到访 1有到访/
 private String isVisit;
 /是否过期 — 0显示绿色 1显示灰色/
 private String isPast;
 /是否无效 ---- 0有效邀请 1无效邀请/
 private String isValid;
 /访客表id/
 private Long tvId;
 /按钮状态 ---------0显示 1显示/
 private String buttonStatus;
 /大于6个长期访客 ------ 0显示 1不显示/
 private String SixConunt;*/


