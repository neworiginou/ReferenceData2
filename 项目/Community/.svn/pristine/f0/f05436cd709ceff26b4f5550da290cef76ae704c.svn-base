//
//  HWSearchListTableView.m
//  Community
//
//  Created by hw500028 on 15/1/13.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  功能描述:搜索tableView
//      姓名         日期               修改内容
//     杨庆龙     2015-01-15           创建文件
//     杨庆龙     2015-01-17           加入是否保存历史记录逻辑
//     杨庆龙     2015-01-19           ios6plus的适配
#import "HWSearchListTableView.h"
#import "HWNoFoundPicView.h"
@interface HWSearchListTableView ()
{
    BOOL  isEditing;             //搜索框是否输入文字
    BOOL  isSave;                //是否保存本地
}

@property (nonatomic, strong) HWNoFoundPicView * nofoundView;

@end

@implementation HWSearchListTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = NO;
        self.baseTable.scrollsToTop = NO;
        isSave = YES;

    }
    return self;
}

#pragma mark - setterMethod

- (void)setIsShow:(BOOL)isShow
{
    _isShow = isShow;
    if (!_isShow) {
        isEditing = NO;
    }
    [self.baseTable reloadData];
}


- (HWNoFoundPicView *)nofoundView
{
    if (_nofoundView == nil)
    {
        _nofoundView = [[HWNoFoundPicView alloc]initWithText:@"暂无此话题"];
        [self addSubview:_nofoundView];
    }
    return _nofoundView;
}

- (void)setSearchWord:(NSString *)searchWord
{
    _searchWord = searchWord;
    if (_searchWord.length == 0)
    {
        isEditing = NO;
    }
    else
    {
        isEditing = YES;
    }
    [self.baseTable reloadData];
    [self queryListData];
}

#pragma mark - queryData


- (void)queryListData
{
    /**
     *  name:查询名称
        size：查询的条数，最大30条
        key:用户KEY
     */
    if (_searchWord.length > 0) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setPObject:_searchWord forKey:@"name"];
        [params setPObject:@(100) forKey:@"size"];
        [params setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        [manager POST:kSearchList parameters:params queue:nil success:^(id responese)
        {
            [self.baseListArr removeAllObjects];
            NSDictionary *dict = [responese objectForKey:@"data"];
            NSArray *array = [dict objectForKey:@"content"];
            for (NSDictionary *dic in array) {
                HWChannelModel *model = [[HWChannelModel alloc]initWithChannel:dic];
                [self.baseListArr addObject:model];
            }
            [self.baseTable reloadData];
        } failure:^(NSString *code, NSString *error)
        {
            [Utility showToastWithMessage:error inView:self];
        }];
        
    }

}

#pragma mark - tableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (isEditing)
    {
        if (self.baseListArr.count == 0)
        {
            self.nofoundView.hidden = NO;
        }
        else
        {
            self.nofoundView.hidden = YES;
        }

        return self.baseListArr.count;
    }
    else
    {
            NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:ksearchArr];
        self.nofoundView.hidden = YES;
            return array.count;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row == 0)
    {
        [Utility topLine:cell.contentView];
    }

    //是否编辑
    if (isEditing)
    {
        HWChannelModel *model = [self.baseListArr pObjectAtIndex:indexPath.row];
        cell.textLabel.text = model.channelName;
    }
    else
    {
        NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:ksearchArr];
        HWChannelModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:[array pObjectAtIndex:indexPath.row]];
            cell.textLabel.text = model.channelName;
    }
    //底部线
    UIView *view = [UIView newAutoLayoutView];
    [cell.contentView addSubview:view];
    [view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [view autoSetDimension:ALDimensionHeight toSize:0.5];
    view.backgroundColor = THEME_COLOR_LINE;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"click_pingdaoliebiaoshousuo"];//maidian_1.2.1
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HWChannelModel *model;
    if (isEditing)
    {
        model = self.baseListArr[indexPath.row];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
        NSMutableArray *array = [[[NSUserDefaults standardUserDefaults]objectForKey:ksearchArr] mutableCopy];
       //判断历史是否包含当前所选
        for (NSInteger i = 0; i < array.count; i++)
        {
            HWChannelModel *tempModel = [NSKeyedUnarchiver unarchiveObjectWithData:[array pObjectAtIndex:i]];
            if ([model.channelName isEqualToString:tempModel.channelName])
            {
                isSave = NO;
                break;
            }
            isSave = YES;
        }
        if (isSave == YES)
        {
            //判断历史记录是否够4个,不是保存,是更新文件
            if (array.count >= 4)
            {
                [array removeObjectAtIndex:0];
                [array addObject:data];
                
            }
            else
            {
                [array addObject:data];
                
            }
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:ksearchArr];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        model = self.baseListArr[indexPath.row];
    }
    else
    {
        NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:ksearchArr];
        NSData *data = array[indexPath.row];
        model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
        
    //点击cell推出控制器
    if ([self.delegate respondsToSelector:@selector(searchListTableView:pushCtroller:)] && self.delegate != nil)
    {
        [self.delegate searchListTableView:(HWSearchListTableView *)tableView pushCtroller:model];
    }
    
}

@end
