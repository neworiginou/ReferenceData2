//
//  CustomColorViewController.m
//  PUClient
//
//  Created by lizhongqiang on 15/7/30.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "CustomColorViewController.h"
#import "ColorCollectionViewCell.h"

#define kItemWidth (255*kScale)
#define kScale  (375.f/1242)
#define kMinimumItemSpace (30*kScale)
#define kMinimumLineSpace (70*kScale)
@interface CustomColorViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSArray *nameArray;
@end

@implementation CustomColorViewController

static NSString *colorCellId = @"colorCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(kItemWidth, kItemWidth+20);
    //flowlayout.minimumInteritemSpacing = kMinimumItemSpace;
    flowlayout.minimumLineSpacing = kMinimumLineSpace;
    flowlayout.sectionInset = UIEdgeInsetsMake(105/3.f, 19/3.f, 0, 19/3.f);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.collectionViewLayout = flowlayout;
    [self initDataArray];
    
}
- (void)initDataArray
{
    _dataArray = [NSMutableArray array];
    for(int i=0; i<12; i++)
    {
        [_dataArray addObject:[NSString stringWithFormat:@"coler_%d.9.png",i+1]];
    }
    _nameArray = @[@"炫酷黑",@"时尚蓝",@"魅力红",@"浪漫紫",@"星空紫",@"金刚蓝",@"薄荷绿",@"森林绿",@"橄榄绿",@"嚇石色",@"暖土灰",@"天空灰"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:colorCellId forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
    cell.label.text = _nameArray[indexPath.row];
    
    return cell;
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
