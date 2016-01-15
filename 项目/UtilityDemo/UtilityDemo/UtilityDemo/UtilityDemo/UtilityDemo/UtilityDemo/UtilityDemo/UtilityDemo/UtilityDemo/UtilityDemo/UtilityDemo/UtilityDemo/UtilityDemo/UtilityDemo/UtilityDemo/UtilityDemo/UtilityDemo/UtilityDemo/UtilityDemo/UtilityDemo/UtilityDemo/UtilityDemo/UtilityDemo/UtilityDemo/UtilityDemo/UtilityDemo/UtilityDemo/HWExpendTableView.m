//
//  ExpendTableView.m
//  FangDaiDemo
//
//  Created by baiteng-5 on 14-1-21.
//  Copyright (c) 2014年 org.baiteng. All rights reserved.
//

#import "HWExpendTableView.h"
#import "Define-OC.h"

@implementation HWExpendTableView
@synthesize expendTab;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        expendTab = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        expendTab.backgroundView.alpha = 0;
        expendTab.dataSource = self;
        expendTab.delegate = self;
        expendTab.scrollEnabled = YES;
        [self addSubview:expendTab];
    }
    return self;
}

#pragma mark -------Tab Dele-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellWithIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    while (cell.contentView.subviews.lastObject) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    
    NSUInteger row = [indexPath row];
    //名称栏
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, 100, 20)];
    name.backgroundColor = [UIColor clearColor];
    name.text = [self.nameAry objectAtIndex:row];
    name.font = [UIFont fontWithName:FONTNAME size:14];
    [cell.contentView addSubview:name];
    //数据栏
    UILabel * data = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120 - 15, 17, 120, 18)];
    data.backgroundColor = [UIColor clearColor];
    data.text = [self.dataAry objectAtIndex:row];
    data.font = [UIFont fontWithName:FONTNAME size:12];
    data.textAlignment = NSTextAlignmentRight;
    data.textColor = UIColorFromRGB(0x999999);
    [cell.contentView addSubview:data];
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
