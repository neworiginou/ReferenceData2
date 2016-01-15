//
//  WYYCAccountDetailViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCAccountDetailViewController.h"
#import "WYYCAccountCell.h"
#import "WYYCAccount.h"
@interface WYYCAccountDetailViewController ()
@property (strong,nonatomic) NSMutableArray *accountArray;
@end

@implementation WYYCAccountDetailViewController

static NSString * const reuseIdentifier = @"account";

- (NSMutableArray *)accountArray
{
    if (!_accountArray) {
        self.accountArray=[[NSMutableArray alloc]init];
    }
    return _accountArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"账户明细";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"WYYCAccountCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    for (int i = 0 ; i <= 6; i++) {
        WYYCAccount *account=[[WYYCAccount alloc]init];
        account.orderNum=[NSString stringWithFormat:
                          @"%d",10000+arc4random()/1000];
        account.itemName = @"代驾收入";
        account.date = [NSDate date];
        account.balance = @(200+arc4random()/1000);
        [self.accountArray addObject:account];
    }
    
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的大小
    CGFloat width=[UIScreen mainScreen].bounds.size.width-20;
    layout.itemSize = CGSizeMake(width,85);
    layout.minimumLineSpacing = 5;
    //     layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return [self initWithCollectionViewLayout:layout];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.accountArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WYYCAccountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.account=self.accountArray[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
