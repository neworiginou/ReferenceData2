//
//  ViewController.m
//  KYWaterWaveAnimation
//
//  Created by Kitten Yang on 3/16/15.
//  Copyright (c) 2015 Kitten Yang. All rights reserved.
//

#import "ViewController.h"
#import "KYWaterWaveView.h"


@interface ViewController()
@property (strong, nonatomic) IBOutlet KYWaterWaveView *waterViewXib;

@end

@implementation ViewController{
    KYWaterWaveView *waterView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    waterView = [[KYWaterWaveView alloc]initWithFrame:CGRectMake(0, 50, 50, 50)];
//    [self.view addSubview:waterView];
//    waterView.layer.cornerRadius  = waterView.frame.size.width / 2;
//    waterView.waveSpeed = 6.0f;
//    waterView.waveAmplitude = 3.0f;
//    [waterView wave];
    
//    self.waterViewXib.layer.cornerRadius = self.waterViewXib.frame.size.width / 2;
    self.waterViewXib.waveSpeed = 3.5f;
    self.waterViewXib.backgroundColor = [UIColor redColor];
    self.waterViewXib.waveAmplitude = 6.0f;//这个参数是这是上下波动的高度
    [self.waterViewXib wave];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
