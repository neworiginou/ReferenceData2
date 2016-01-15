//
//  WYYCProfileTableViewController.m
//  无忧云车司机
//
//  Created by luosai19910103@163.com on 15/6/19.
//  Copyright (c) 2015年 wuyouyunche. All rights reserved.
//

#import "WYYCProfileTableViewController.h"
#import "WYYCAccountViewController.h"
#import "WYYCCommentTableViewController.h"
#import "WYYCAdviceViewController.h"
#import "WYYCMoreTableViewController.h"
#import "WYYCMessageCenterTableViewController.h"
@interface WYYCProfileTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *driverIcon;
@property (weak, nonatomic) IBOutlet UILabel *driverName;
@property (weak, nonatomic) IBOutlet UILabel *driverTelephone;



@end

@implementation WYYCProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"个人中心";
    self.driverName.text=@"姓名：张三";
    self.driverTelephone.text=@"电话：17090409555";
    self.driverIcon.image=[UIImage imageNamed:@"head"];
    self.driverIcon.layer.cornerRadius=25;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {

            WYYCAccountViewController *accountVC=[[WYYCAccountViewController alloc]init];
            [self.navigationController pushViewController:accountVC animated:YES];
        }
            break;
        case 2:
        {
            WYYCCommentTableViewController *commentVC=[[WYYCCommentTableViewController alloc]init];
            [self.navigationController pushViewController:commentVC animated:YES];
        }
            break;
        case 3:
        {
            WYYCAdviceViewController *adviceVC=[[WYYCAdviceViewController alloc]init];
            [self.navigationController pushViewController:adviceVC animated:YES];
        }
            break;
        case 4:
        {
            WYYCMessageCenterTableViewController *messageVC=[[WYYCMessageCenterTableViewController alloc]init];
            [self.navigationController pushViewController:messageVC animated:YES];
        }
            break;
        case 5:
        {
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            
            WYYCMoreTableViewController *moreVC=[storyboard instantiateViewControllerWithIdentifier:@"more" ];
            [self.navigationController pushViewController:moreVC animated:YES];
        }
            break;

            
        default:
            break;
    }
    
}

@end
