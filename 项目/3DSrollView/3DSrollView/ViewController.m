//
//  ViewController.m
//  3DSrollView
//
//  Created by lizhongqiang on 16/1/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)ScrollView *scrollView;

@end

@implementation ViewController
- (ScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[ScrollView alloc]initWithFrame:CGRectMake(20, 64, [UIScreen mainScreen].bounds.size.width-40, 200)];//375-50====>325
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.imagesArray = @[[NSString stringWithFormat:@"%d.jpg",1],[NSString stringWithFormat:@"%d.jpg",2],[NSString stringWithFormat:@"%d.jpg",3],[NSString stringWithFormat:@"%d.jpg",4],[NSString stringWithFormat:@"%d.jpg",5],[NSString stringWithFormat:@"%d.jpg",6]];
        //[self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
