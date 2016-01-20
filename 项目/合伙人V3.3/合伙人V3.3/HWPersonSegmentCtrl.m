//
//  HWPersonSegmentCtrl.m
//  合伙人V3.3
//
//  Created by lizhongqiang on 16/1/18.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "HWPersonSegmentCtrl.h"
#import "UIView+AutoLayout.h"
@implementation HWPersonSegmentCtrl
- (instancetype)init{
    if(self = [super init]){
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:63/255.0 blue:6/255.0 alpha:1.0];
        
        NSArray *imageArray = @[@{@"业绩":@""},@{@"钱包":@""},@{@"积分":@""}];//view.translatesAutoresizingMaskIntoConstraints = NO;
        for (int i=0 ; i<imageArray.count; i++) {
            CGFloat width = [UIScreen mainScreen].bounds.size.width/3;
            CGFloat x = i*width;
            NSDictionary *dic = imageArray[i];
            NSString *key = [[dic allKeys] lastObject];
            //[self buttonWithTitle:key imageName:[dic objectForKey:key] frame:CGRectMake(x, 0, width, 45) offX:x];
            
            
        }
    }
    return self;
}
- (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)name frame:(CGRect)frame offX:(CGFloat)x{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];//[UIButton newAutoLayoutView];//
   // btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.frame = frame;
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0,40, 20)];
    label.text =@"8908";
    btn.backgroundColor = [UIColor redColor];
    [btn addSubview:label];
     [btn setTitle:@"dadadada" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [self addSubview:btn];
#if 1
    
    [btn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:x];
    [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:0];
    [btn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:0];
    [btn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self withOffset:x];
#endif
    
    return btn;
}
@end
@implementation MyButton



@end