//
//  BARightCell.m
//  酒吧助手
//
//  Created by 叶星龙 on 15/5/22.
//  Copyright (c) 2015年 北京局外者科技有限公司. All rights reserved.
//

#import "BARightCell.h"
#import "Header.h"
@interface BARightCell ()

@property (weak ,nonatomic) UIImageView *wineImage;

@property (weak ,nonatomic) UILabel *imageShow;

@property (weak ,nonatomic) UILabel *wineName;

@property (weak ,nonatomic) UILabel *wineMoney;

@property (weak ,nonatomic) UILabel *wineQuantity;

@property (weak ,nonatomic) UIButton *wineLeft;

@property (weak ,nonatomic) UIButton *wineRight;


@property (weak ,nonatomic) UILabel *wineMoneyOriginalPrice;

@property (weak ,nonatomic) UIView *wineMoneyOriginalPriceShow;

@end
@implementation BARightCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *wineImage =[[UIImageView alloc]init];
        [self.contentView addSubview:wineImage];
        _wineImage=wineImage;
        
        UILabel *imageShow =[[UILabel alloc]init];
        [wineImage addSubview:imageShow];
        _imageShow=imageShow;
        
        UILabel *wineName =[[UILabel alloc]init];
        [self.contentView addSubview:wineName];
        _wineName=wineName;
        
        UILabel *wineMoney =[[UILabel alloc]init];
        [self.contentView addSubview:wineMoney];
        _wineMoney =wineMoney;
        
        UILabel *wineMoneyOriginalPrice =[[UILabel alloc]init];
        [self.contentView addSubview:wineMoneyOriginalPrice];
        _wineMoneyOriginalPrice=wineMoneyOriginalPrice;
        
        UIView *wineMoneyOriginalPriceShow =[[UIView alloc]init];
        [self.contentView addSubview:wineMoneyOriginalPriceShow];
        _wineMoneyOriginalPriceShow=wineMoneyOriginalPriceShow;
        
        UILabel *wineQuantity = [[UILabel alloc]init];
        [self.contentView addSubview:wineQuantity];
        _wineQuantity=wineQuantity;
        
        UIButton *wineLeft=[[UIButton alloc]init];
        [self.contentView addSubview:wineLeft];
        _wineLeft=wineLeft;
        
        UIButton *wineRight=[[UIButton alloc]init];
        [self.contentView addSubview:wineRight];
        _wineRight=wineRight;
        
        UIView *viewShow =[[UIView alloc]initWithFrame:(CGRect){0,89.5,kWindowWidth,0.5}];
        viewShow.backgroundColor=[UIColor blackColor];
        viewShow.alpha=0.3;
        [self.contentView addSubview:viewShow];
        
        
    }
    return self;
}



-(void)setRightData:(NSMutableDictionary *)rightData
{
    
    _rightData=rightData;
    _wineImage.frame=(CGRect){5,15,65,65};
    _wineImage.image=[UIImage imageNamed:_rightData[@"image"]];
    _wineImage.layer.masksToBounds=YES;
    _wineImage.layer.cornerRadius=6;
    _imageShow.frame=(CGRect){0,65-10,65,10};
    
    if (_rightData[@"Discount"]!=nil) {
        _imageShow.hidden=NO;
        _imageShow.text=_rightData[@"Discount"];
        _imageShow.textColor=[UIColor whiteColor];
        _imageShow.font=Font(10);
        _imageShow.textAlignment=NSTextAlignmentCenter;
        _imageShow.backgroundColor=UIColorRGBA(255, 127, 0, 1);
    }else
    {
        _imageShow.hidden=YES;
    }
    
    
    
    
    NSString *wineNameText =_rightData[@"name"];
    CGRect wineNameRect =[wineNameText boundingRectWithSize:CGSizeMake(kWindowWidth-75-CGRectGetMaxX(_wineImage.frame)-10, 35) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(14),NSFontAttributeName, nil] context:nil];
    
    _wineName.text=wineNameText;
    _wineName.font=Font(14);
    _wineName.numberOfLines=2;
    _wineName.textAlignment=NSTextAlignmentJustified;
    _wineName.frame =(CGRect){{CGRectGetMaxX(_wineImage.frame)+5,10},wineNameRect.size};
 
    NSString *wineMoneyText =[NSString stringWithFormat:@"￥%@",_rightData[@"money"]];
    CGSize wineMoneySize =[wineMoneyText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(14),NSFontAttributeName, nil]];
    _wineMoney.text=wineMoneyText;
    _wineMoney.font=Font(14);
    _wineMoney.textColor=UIColorRGBA(255, 127, 0, 1);
    _wineMoney.frame =(CGRect){{CGRectGetMaxX(_wineImage.frame),CGRectGetMaxY(_wineImage.frame)-wineMoneySize.height-wineMoneySize.height*0.5},wineMoneySize};
    
    if(_rightData[@"OriginalPrice"]!=nil)
    {
        _wineMoneyOriginalPrice.hidden=NO;
    NSString *wineMoneyOriginalPriceText =[NSString stringWithFormat:@"原价:%@",_rightData[@"OriginalPrice"]];
    CGSize wineMoneyOriginalPriceSize =[wineMoneyOriginalPriceText sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(11),NSFontAttributeName, nil]];
    _wineMoneyOriginalPrice.text=wineMoneyOriginalPriceText;
    _wineMoneyOriginalPrice.font=Font(11);
    _wineMoneyOriginalPrice.textColor=[UIColor lightGrayColor];
    _wineMoneyOriginalPrice.frame=(CGRect){{CGRectGetMaxX(_wineImage.frame),CGRectGetMaxY(_wineMoney.frame)+3},wineMoneyOriginalPriceSize};
    }else
    {
        _wineMoneyOriginalPrice.hidden=YES;
        
    }
    //吧台加号
    _wineRight.frame=(CGRect){kWindowWidth-75-10 -30,90-40,30,30};
    _wineRight.layer.masksToBounds=YES;
    _wineRight.layer.cornerRadius=30/2;
    [_wineRight setTitle:@"+" forState:UIControlStateNormal];
    [_wineRight setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_wineRight addTarget:self action:@selector(wineRightClick) forControlEvents:UIControlEventTouchUpInside];
    _wineRight.titleLabel.font=Font(13);
    _wineRight.layer.borderWidth = 1;
    _wineRight.layer.borderColor = [[UIColor redColor] CGColor];
    //吧台减号
    _wineLeft.frame=(CGRect){kWindowWidth-75 -10 -30 -30 - 30 ,90-40,30,30};
    _wineLeft.layer.masksToBounds=YES;
    _wineLeft.layer.cornerRadius=30/2;
    [_wineLeft setTitle:@"-" forState:UIControlStateNormal];
    [_wineLeft setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_wineLeft addTarget:self action:@selector(wineLeftClick) forControlEvents:UIControlEventTouchUpInside];
    _wineLeft.titleLabel.font=Font(13);
    _wineLeft.layer.borderWidth = 1;
    _wineLeft.layer.borderColor = [[UIColor redColor] CGColor];
   
    CGFloat W =(kWindowWidth-75-10 -30)-CGRectGetMaxX(_wineLeft.frame);
    _wineQuantity.frame=(CGRect){CGRectGetMaxX(_wineLeft.frame),90-40,W,30};
    _wineQuantity.text=_rightData[@"Quantity"];
    _wineQuantity.textAlignment=NSTextAlignmentCenter;
    _wineQuantity.font=Font(16);
    
    
    
    
    
}

-(void)wineRightClick
{
    int NumberInt =[_wineQuantity.text intValue];
    if (NumberInt ==99) {
        return;
    }
    ++NumberInt;
    
     _wineQuantity.text =[NSString stringWithFormat:@"%d",NumberInt];
    _rightData[@"Quantity"] = _wineQuantity.text;
    _TapActionBlock([ _rightData[@"Quantity"] integerValue],[_rightData[@"money"] integerValue] ,_rightData[@"ProductID"]);
}

-(void)wineLeftClick
{
    int NumberInt =[_wineQuantity.text intValue];
    if (NumberInt ==0) {
       
        return;
    }
    --NumberInt;
    _wineQuantity.text =[NSString stringWithFormat:@"%d",NumberInt];
    _rightData[@"Quantity"] = _wineQuantity.text;
    _TapActionBlock([ _rightData[@"Quantity"] integerValue],[_rightData[@"money"] integerValue],_rightData[@"ProductID"]);
    if (NumberInt ==0) {
      
        return;
    }
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BARightCell";
    BARightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BARightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //取消选中状态
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com