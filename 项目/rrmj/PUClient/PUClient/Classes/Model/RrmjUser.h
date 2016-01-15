//
//  RrmjUser.h
//  PUClient
//
//  Created by RRLhy on 15/7/22.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 "errorCode": "",
 "userInfo": {
 "email": "123456",
 "nickName": "&aring;&aring;&deg;&aring;&shy;&copy;",
 "loginName": "15978777289",
 "sex": 0,
 "birthday": null,
 "city": null,
 "registerFrom": "0",
 "silverCount": 0,
 "mobile": "",
 "roleInfo": "",
 "isBlack": false,
 "qqAcount": "",
 "qqWeiboAccount": "",
 "weixinAccount": "",
 "sinaWeiboAccount": "",
 "yixinAccount": "",
 "score": 0,
 "headImgUrl": "http://img.rrmj.tv/",
 "intro": "",
 "confirmInfo": "",
 "isConfirmed": false,
 "replyCount": null,
 "bgImgUrl": "http://img.rrmj.tv/",
 "seriesCount": null,
 "articleCount": null,
 "fansCount": null,
 "jhCount": 0,
 "continuousDay": 0,
 "receiveLimit": 1,
 "hasSignIn": false,
 "continuousStr": "",
 "isSilence": false,
 "userCode": "1868750808",
 "focusCount": null,
 "favoriteCount": null,
 "isFocused": false,
 "unreadMsgCount": 0,
 "headImgUrlStr": "../static/images/head20x20.png",
 "sign": "",
 "token": "dcbcb24925ca4e81b913139870c52bdc",
 "level": 1,
 "levelName": "美剧菜鸟",
 "createTime": 1437962018687,
 "updateTime": 1437962018687,
 "createTimeStr": "5秒前",
 "id": 4366541
 },
 "success": true
 }*/
@interface RrmjUser : NSObject<NSCoding>
/**
 *  邮箱
 */
@property (nonatomic,copy)NSString * email;
/**
 *  昵称
 */
@property (nonatomic,copy)NSString * nickName;
/**
 *  账号
 */
@property (nonatomic,copy)NSString * loginName;
/**
 *  用户图像
 */
@property (nonatomic,copy)NSString * sex;
/**
 *  昵称
 */
@property (nonatomic,copy)NSString * birthday;
/**
 *  简介
 */
@property (nonatomic,copy)NSString * city;
@property (nonatomic,copy)NSString * registerFrom;
@property (nonatomic,copy)NSString * silverCount;
@property (nonatomic,copy)NSString * mobile;
@property (nonatomic,copy)NSString * roleInfo;
@property (nonatomic,copy)NSString * isBlack;
@property (nonatomic,copy)NSString * qqAcount;
@property (nonatomic,copy)NSString * weixinAccount;
@property (nonatomic,copy)NSString * sinaWeiboAccount;
@property (nonatomic,copy)NSString * score;
@property (nonatomic,copy)NSString * headImgUrl;
@property (nonatomic,copy)NSString * intro;
@property (nonatomic,copy)NSString * confirmInfo;
@property (nonatomic,copy)NSString * isConfirmed;
@property (nonatomic,copy)NSString * replyCount;
@property (nonatomic,copy)NSString * bgImgUrl;
@property (nonatomic,copy)NSString * seriesCount;
@property (nonatomic,copy)NSString * articleCount;
@property (nonatomic,copy)NSString * fansCount;
@property (nonatomic,copy)NSString * jhCount;
@property (nonatomic,copy)NSString * continuousDay;
@property (nonatomic,copy)NSString * isSilence;
@property (nonatomic,copy)NSString * continuousStr;
@property (nonatomic,copy)NSString * focusCount;
@property (nonatomic,copy)NSString * favoriteCount;
@property (nonatomic,copy)NSString * isFocused;
@property (nonatomic,copy)NSString * unreadMsgCount;
@property (nonatomic,copy)NSString * headImgUrlStr;
@property (nonatomic,copy)NSString * sign;
@property (nonatomic,copy)NSString * token;
@property (nonatomic,copy)NSString * level;
@property (nonatomic,copy)NSString * levelName;
@property (nonatomic,copy,setter=setId:)NSString * Id;
@property (nonatomic,copy)NSString * createTimeStr;

@end
