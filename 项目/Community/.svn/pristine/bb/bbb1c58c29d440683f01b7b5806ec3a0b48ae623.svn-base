//
//  HWLuckDrawViewController.m
//  Community
//
//  Created by hw500027 on 15/4/23.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：抽奖界面
//
//  修改记录：
//      姓名          日期                      修改内容
//      陆晓波        2015-04-23                创建文件
//      陆晓波        2015-04-27                砸蛋动画修改
//

#import "HWLuckDrawViewController.h"
#import "HWLuckDrawResultViewController.h"

#define height1 150/2
@interface HWLuckDrawViewController ()
{
    UIImageView *_goldEgg;
    UIImageView *_kingeggstxtImgV;
}
@end

@implementation HWLuckDrawViewController
@synthesize resultModel;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"抽奖"];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = UIColorFromRGB(0xfff7e0);
    
    //背景动画
    [self addShineView];
    //出价结果label
    CGFloat height = [self addResultOfBid];
    //中奖提示label
    [self addLuckDrawLabel:height];
    //金蛋及其相关imgV
    [self addGoldEgg];
}

-(void)addGoldEgg
{
    //金蛋
    UIImage *img = [UIImage imageNamed:@"kingeggs1"];
    _goldEgg = [[UIImageView alloc]initWithImage:img];
    _goldEgg.tag = 888;
    _goldEgg.size = img.size;
    _goldEgg.center = CGPointMake(kScreenWidth/2, CONTENT_HEIGHT/2);
    [self.view addSubview:_goldEgg];
    
    //砸金蛋提示
    _kingeggstxtImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kingeggstxt"]];
    _kingeggstxtImgV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_kingeggstxtImgV];
    [_kingeggstxtImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_goldEgg];
    [_kingeggstxtImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_goldEgg];
    
    //金蛋下方红色imgv
    UIImageView *redImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kingeggs_bg1"]];
    redImgV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:redImgV belowSubview:_goldEgg];
    
    [redImgV autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [redImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.view withOffset:img.size.height/2];
    
    //金蛋imgv 添加手势
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickGoldEgg)];
    _goldEgg.userInteractionEnabled = YES;
    [_goldEgg addGestureRecognizer:ges];
}

-(void)goldEggAnimation
{
    //砸开金蛋
    UIImage *newImg = [UIImage imageNamed:@"kingeggs2"];
    _goldEgg.image = newImg;
    _goldEgg.size = newImg.size;
    _goldEgg.center = CGPointMake(kScreenWidth/2, CONTENT_HEIGHT/2 + 10);
    
    //砸开金蛋动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5f, 1.5f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_goldEgg.layer addAnimation:popAnimation forKey:nil];
    _goldEgg.userInteractionEnabled = NO;

    //砸开金蛋礼花
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kingeggs_bg3"]];
    [self.view insertSubview:imgV belowSubview:_goldEgg];
    imgV.translatesAutoresizingMaskIntoConstraints = NO;
    [imgV autoCenterInSuperview];
}

-(void)didClickGoldEgg
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^(void)
       {
           [UIView animateWithDuration:0.4 animations:^
           {
               [_kingeggstxtImgV removeFromSuperview];
               _goldEgg.size = CGSizeMake(_goldEgg.size.width * 1.3, _goldEgg.size.height);
               _goldEgg.center = CGPointMake(kScreenWidth/2, CONTENT_HEIGHT/2);
           } completion:^(BOOL finished) {
               [self goldEggAnimation];
           }];
       });
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^(void)
       {
           HWLuckDrawResultViewController *vc = [[HWLuckDrawResultViewController alloc]init];
           vc.coinCount = [resultModel.kaoLabonus intValue];
           [self.navigationController pushViewController:vc animated:YES];
       });
    });
}

-(CGFloat)addResultOfBid
{
    UILabel *label1 = [UILabel newAutoLayoutView];
    [self.view addSubview:label1];
    label1.numberOfLines = 0;
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:height1];
    [label1 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    
    if (resultModel.samePriceTimes.intValue <= 1)
    {
        if (resultModel.uniqueLowerTimes.intValue <= 0)
        {
            // 最低唯一价
            NSString *textStr = [NSString stringWithFormat:@"恭喜，你是%@元唯一出价者！",resultModel.cutPrice];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textStr];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:15] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, resultModel.cutPrice.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:20] range:NSMakeRange(5, resultModel.cutPrice.length)];
            label1.attributedText = str;
        }
        else
        {
            // 更低唯一
            NSString *textStr = [NSString stringWithFormat:@"恭喜，你是%@元唯一出价者！\n有%@个更低唯一价",resultModel.cutPrice,resultModel.uniqueLowerTimes];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textStr];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:15] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, resultModel.cutPrice.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:20] range:NSMakeRange(5, resultModel.cutPrice.length)];
            label1.attributedText = str;
        }
    }
    else
    {
        // 显示相同价
        NSString *textStr = [NSString stringWithFormat:@"哎呀，还有%@人也出了%@元",resultModel.samePriceTimes,resultModel.cutPrice];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textStr];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStr.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:15] range:NSMakeRange(0, textStr.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(textStr.length-resultModel.cutPrice.length-1, resultModel.cutPrice.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:20] range:NSMakeRange(textStr.length-resultModel.cutPrice.length-1, resultModel.cutPrice.length)];
        label1.attributedText = str;
    }

    return [label1 systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + height1;
}

-(void)addLuckDrawLabel:(CGFloat)height
{
    UILabel *label2 = [UILabel newAutoLayoutView];
    label2.text = @"系统奖励金蛋一枚";
    [self.view addSubview:label2];
    
    [label2 autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:height];
    [label2 autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
}

-(void)addShineView
{
    UIImageView *shineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kingeggs_bg2"]];
    shineView.center = CGPointMake(self.view.frame.size.width / 2, CONTENT_HEIGHT / 2);
    
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 0, 0,1);
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= 10;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion = NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= MAXFLOAT;
    
    [shineView.layer addAnimation:animation forKey:nil];
    [self.view addSubview:shineView];
}

- (void)didReceiveMemoryWarning
{
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
