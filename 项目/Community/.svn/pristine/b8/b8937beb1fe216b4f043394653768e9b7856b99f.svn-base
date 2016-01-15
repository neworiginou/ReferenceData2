//
//  HWLuckNoAwardViewController.m
//  Community
//
//  Created by hw500027 on 15/5/7.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//

#import "HWLuckNoAwardViewController.h"

#define HEIGHT1 65
#define HEIGHT2 45
@interface HWLuckNoAwardViewController ()
{
    UIImageView *resultImgV;
    UILabel *resultLabel;
}
@end

@implementation HWLuckNoAwardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"无底线"];
    self.navigationController.navigationBarHidden = NO;
    
    //显示砍价结果图片
    resultImgV = [UIImageView newAutoLayoutView];
    [self.view addSubview:resultImgV];
    [resultImgV autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [resultImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:HEIGHT1];
    
    //出价结果label
    resultLabel = [UILabel newAutoLayoutView];
    [self.view addSubview:resultLabel];
    resultLabel.numberOfLines = 0;
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [resultLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:resultImgV withOffset:HEIGHT2];
    [resultLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];

    if (_resultModel.samePriceTimes.intValue <= 1)
    {
        UIImage *img = [UIImage imageNamed:@"duihao"];
        resultImgV.image = img;
        [resultImgV autoSetDimensionsToSize:CGSizeMake(floorf(img.size.width/2*kScreenRate), floorf(img.size.height/2*kScreenRate))];
        if (_resultModel.uniqueLowerTimes.intValue <= 0)
        {
            // 最低唯一价
            NSString *textStr = [NSString stringWithFormat:@"恭喜，你是%@元唯一出价者！",_resultModel.cutPrice];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textStr];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:15] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, _resultModel.cutPrice.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:20] range:NSMakeRange(5, _resultModel.cutPrice.length)];
            resultLabel.attributedText = str;
        }
        else
        {
            // 更低唯一
            NSString *textStr = [NSString stringWithFormat:@"恭喜，你是%@元唯一出价者！\n有%@个更低唯一价",_resultModel.cutPrice,_resultModel.uniqueLowerTimes];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textStr];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:15] range:NSMakeRange(0, textStr.length)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(5, _resultModel.cutPrice.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:20] range:NSMakeRange(5, _resultModel.cutPrice.length)];
            resultLabel.attributedText = str;
        }
    }
    else
    {
        // 显示相同价
        UIImage *img = [UIImage imageNamed:@"cuohao"];
        resultImgV.image = img;
        [resultImgV autoSetDimensionsToSize:CGSizeMake(floorf(img.size.width/2*kScreenRate), floorf(img.size.height/2*kScreenRate))];
        
        NSString *textStr = [NSString stringWithFormat:@"哎呀，还有%@人也出了%@元",_resultModel.samePriceTimes,_resultModel.cutPrice];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:textStr];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, textStr.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:15] range:NSMakeRange(0, textStr.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(textStr.length-_resultModel.cutPrice.length-1, _resultModel.cutPrice.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:FONTNAME size:20] range:NSMakeRange(textStr.length-_resultModel.cutPrice.length-1, _resultModel.cutPrice.length)];
        resultLabel.attributedText = str;
    }

    //显示3秒后返回无底线label
    CGFloat edgeTopHeight = HEIGHT1 + [resultImgV systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + HEIGHT2 + [resultLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [self autoTurnBackLabel:edgeTopHeight];
}

//显示3秒后返回无底线label
-(void)autoTurnBackLabel:(CGFloat)edgeTopHeight
{
    CGFloat height = 30;
    NSInteger time = 3;
    UILabel *label = [UILabel newAutoLayoutView];
    label.textColor = THEME_COLOR_TEXT;
    label.font = [UIFont fontWithName:FONTNAME size:14];
    [self.view addSubview:label];
    label.tag = time;
    [label autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:edgeTopHeight + height];
    [label autoSetDimension:ALDimensionHeight toSize:14];
    label.text = [NSString stringWithFormat:@"%ld秒后返回无底线",(long)time];
    [self performSelector:@selector(coldDown:) withObject:label afterDelay:1];
}

-(void)coldDown:(UILabel *)label
{
    label.tag = label.tag - 1;
    if (label.tag >= 0)
    {
        label.text = [NSString stringWithFormat:@"%ld秒后返回无底线",(long)label.tag];
    }
    else if (label.tag == -1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self performSelector:@selector(coldDown:) withObject:label afterDelay:1];
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
