//
//  Student.h
//  家教
//
//  Created by goofygao on 15/11/9.
//  Copyright © 2015年 goofyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface Student : NSObject

/*
 ‘id’:‘xx’  //自增id
 ‘stu_id’:‘xx’ //索引用户表对应的id
 ‘username’:‘xxx’ //用户昵称
 ‘stu_name’:‘xxx’ //发布人的姓名
 ‘stu_sign’:‘xxx’ //标记该发布是否义教，是1否0
 ‘stu_sex’:‘xxx’ //发布人性别
 ‘stu_age’:‘xxx’ //发布人年龄
 ‘stu_num’:‘xxx’ //发布人联系方式
 ‘stu_addr’:‘xxx’//发布人住址
 ‘stu_edu’:‘xxx’ //发布人学历
 ‘stu_major’:‘xxx’ //发布人专业
 ‘stu_course’:‘xxx’//发布人可辅导课程
 ‘stu_intro’:‘xxx’ //发布人自我介绍
 ‘stu_pic’:‘xxx’ //发布人的头像储存地址
 ‘stu_collect’:‘xxx’//该发布信息被收藏次数
 ‘stu_bcost’:‘xxx’ //发布的价格区间 开始
 ‘stu_lcost’:‘xxx’//发布的价格区间 结束
 ‘volTime’:‘xxx’//发布的需要的义工时间
 ‘bfree_time’:‘xxx’//发布的空闲时间 开始
 ‘lfree_time’:‘xxx’//发布的空闲时间 结束
 ‘kind’:‘x’  //发布的组织类型 0/1/2分别对应个人 社区 组织
 ‘created_at’;‘201x-0x-xx 0x:xx:xx’//发布时间
 */

@property (nonatomic,copy) NSString *id;
/**
 *  索引用户表对应的id
 */
@property (nonatomic,assign) int stu_id;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *username;
/**
 *  发布人的姓名
 */
@property (nonatomic,copy) NSString *stu_name;
/**
 *  标记该发布是否义教，是1否0
 */
@property (nonatomic,copy) NSString *stu_sign;
/**
 *  发布人性别
 */
@property (nonatomic,copy) NSString *stu_sex;
/**
 *  发布人年龄
 */
@property (nonatomic,assign) int stu_age;
/**
 *  发布人联系方式
 */
@property (nonatomic,copy) NSString *stu_num;
/**
 *  发布人住址
 */
@property (nonatomic,copy) NSString *stu_addr;
/**
 *  发布人学历
 */
//@property (nonatomic,copy) NSString *stu_edu;
/**
 *  发布人专业
 */
@property (nonatomic,copy) NSString *stu_major;
/**
 *  发布人可辅导课程
 */
@property (nonatomic,copy) NSString *stu_course;
/**
 *  发布人自我介绍
 */
@property (nonatomic,copy) NSString *stu_intro;
/**
 *  发布人的头像储存地址
 */
@property (nonatomic,strong) NSURL *stu_pic;
/**
 *  该发布信息被收藏次数
 */
@property (nonatomic,assign) int stu_collect;
/**
 *  发布的价格区间 开始
 */
@property (nonatomic,assign) int stu_bcost;
/**
 *  发布的价格区间 结束
 */
@property (nonatomic,assign) int stu_lcost;
/**
 *  发布的需要的义工时间
 */
@property (nonatomic,copy) NSString *volTime;
/**
 *  发布的空闲时间 开始
 */
@property (nonatomic,copy) NSString *free_time;
/**
 *  发布的空闲时间 结束
 */
//@property (nonatomic,copy) NSString *lfree_time;
/**
 *  发布的组织类型 0/1/2分别对应个人 社区 组织
 */
@property (nonatomic,assign) int kind;
/**
 *  发布时间
 */
@property (nonatomic,copy) NSString *created_at;

@property (nonatomic,copy) NSString *updated_at;

@property (nonatomic,copy) NSString *stu_grade;

@property (nonatomic,assign) int stu_star;

@property (nonatomic,copy) NSString *stu_edu;

@property (nonatomic,assign) int real_sign;

@property (nonatomic,copy) NSString *stu_freHis;

@property (nonatomic,copy) NSString *stu_school;

@property (nonatomic,assign) int num;

@property (nonatomic,copy) NSString *stu_history;



//@property (nonatomic,copy) NSString *

-(id)initWithDict:(NSDictionary *)dict;
+(instancetype)cellWithDict:(NSDictionary *)dict;

@end
