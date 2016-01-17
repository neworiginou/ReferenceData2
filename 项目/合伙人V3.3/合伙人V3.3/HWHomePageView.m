//
//  HWHomePageView.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/16.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HWHomePageView.h"
#import "HWHomeHeadView.h"
#define FONTNAME                            @"Helvetica Neue"
#define FONT(fontSize)                      [UIFont fontWithName:FONTNAME size:fontSize]
#define UIColorFromRGB(rgbValue)	    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define CD_LineColor                        UIColorFromRGB(0xd7d7d7)
#define THEME_COLOR_LINE                    UIColorFromRGB(0xd6d6d6)
@interface HWHomePageView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation HWHomePageView
- (UIScrollView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (instancetype)init{
    if(self = [super init]){
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-49);//-49
//        self.tableView.backgroundColor = [UIColor redColor];
        
        
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }else if(section == 1){
        return 3;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 775/2.0;
    }
    return 67/2.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 25/2.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 178/2.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        HWHomeHeadView *view = [[HWHomeHeadView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        CALayer *liner1 = [CALayer layer];
        liner1.frame = CGRectMake(0, 775/2.0-0.65, [UIScreen mainScreen].bounds.size.width, 0.65);
        liner1.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0].CGColor;
        [view.layer addSublayer:liner1];
        return view;
        
    }
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    CALayer *liner1 = [CALayer layer];
    liner1.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.65);
    liner1.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0].CGColor;
    [view.layer addSublayer:liner1];
    
    CALayer *liner2 = [CALayer layer];
    liner2.frame = CGRectMake(0, 67/2.0-0.65, [UIScreen mainScreen].bounds.size.width, 0.65);
    liner2.backgroundColor = [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0].CGColor;
    [view.layer addSublayer:liner2];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 1, 100, 67/2.0-2)];
    label.text = @"热门楼盘";
    label.font = FONT(14.5);
    [view addSubview:label];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
@end
