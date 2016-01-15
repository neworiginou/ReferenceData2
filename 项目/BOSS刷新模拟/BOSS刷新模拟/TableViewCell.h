//
//  TableViewCell.h
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/9.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *myContentView;

@end



@interface MyButton : UIView
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *title;
- (void)update;
@end