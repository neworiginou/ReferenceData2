//
//  DateVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/11.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "DateVC.h"
#import "DateCell.h"

@interface DateVC ()<UITableViewDataSource,UITableViewDelegate,DateCellDelegate>

@property (nonatomic,strong)NSMutableArray * sourecArray;

@property (nonatomic,strong)UITableView * dateTableView;

@end

@implementation DateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navImage.hidden = YES;
    [self.view addSubview:self.dateTableView];
    self.sourecArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <7; i++) {
        NSDictionary * dic = @{@"day":@"12",@"weekDay":@"星期一",@"month":@"Jul",@"unfold":@"0",@"seriesArray":@[@"少女卧底",@"护士当家",@"美国恐怖故事",@"副总统",@"电脑狂人",@"难的幸福",@"浩克与SMASH特工队",@"英伦魔法师",@"权力的游戏",@"硅谷",@"塞勒姆",@"公元",@"美国奥德赛",@"真实的人类",@"政局边缘",@"侦探",@"末日孤舰",@"球手",@"陨落星辰"]};
        DateModel * date = [DateModel objectWithKeyValues:dic];
        [self.sourecArray addObject:date];
    }
}

- (UITableView*)dateTableView
{
    if (!_dateTableView) {
        _dateTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 30 - 49) style:UITableViewStylePlain];
        _dateTableView.delegate = self;
        _dateTableView.dataSource = self;
        _dateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_dateTableView];
    }
    return _dateTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

#pragma mark 每一行怎样显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //2，去缓存中取出可循环利用的cell
    DateCell * cell = [tableView dequeueReusableCellWithIdentifier:[DateCell dateIndentifier]];
    //3，如果缓存中没有可利用的cell，则创建
    if(cell == nil){
        cell = [DateCell dateCell];
        cell.delegate = self;
    }
    
    DateModel * date = self.sourecArray[indexPath.row];
    cell = [cell configureWithDate:date];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateModel * model = self.sourecArray[indexPath.row];
    return [DateCell heightForCellWithDate:model];
}

- (void)unfoldCell:(DateCell *)dateCell
{
    NSIndexPath * index = [self.dateTableView indexPathForCell:dateCell];
    DateModel * model = self.sourecArray[index.row];
    model.unfold = !model.unfold;
    [self.dateTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
    
    if (index.row == 6) {
        [_dateTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [_dateTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
