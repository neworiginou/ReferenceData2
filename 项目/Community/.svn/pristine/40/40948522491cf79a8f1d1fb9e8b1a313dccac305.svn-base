//
//  HWServeTableViewCell.m
//  Community
//
//  Created by lizhongqiang on 14-9-6.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWServeTableViewCell.h"

@implementation HWServeTableViewCell
{
    UILabel *labelOutSell;              //上门服务
    UILabel *labelAuthorized;           //认证
}
@synthesize delegate;
@synthesize labPhone;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        leftBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 70, 70)];
        [leftBgView setBackgroundColor:[UIColor clearColor]];
        leftBgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapGesture:)];
        [leftBgView addGestureRecognizer:tap];
        [self.contentView addSubview:leftBgView];
        
        _imgShop = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        [_imgShop setBackgroundColor:[UIColor clearColor]];
        _imgShop.layer.cornerRadius = 25.0f;
        _imgShop.layer.masksToBounds = YES;
        [leftBgView addSubview:_imgShop];
        
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(73, 15, kScreenWidth - 73 - 45, 21)];
        [_labName setBackgroundColor:[UIColor clearColor]];
        _labName.textColor = THEME_COLOR_SMOKE;
        [_labName setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_BIG]];
        [leftBgView addSubview:_labName];
        
        //添加认证  上门   店铺名字过长为...
        //左  146  73  右 94  47
        labelAuthorized = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 47 - 5 - 40 - 40, 10, 40, 16)];//这里的x是最大值
        [labelAuthorized setBackgroundColor:[UIColor whiteColor]];
        [labelAuthorized setText:@"认证"];
        labelAuthorized.font = [UIFont fontWithName:FONTNAME size:12.0f];
        labelAuthorized.textColor = [UIColor colorWithRed:101.0/255.0 green:185.0/255.0 blue:171.0/255.0 alpha:1.0];
        labelAuthorized.textAlignment = NSTextAlignmentCenter;
        labelAuthorized.layer.cornerRadius = 8.0f;
        labelAuthorized.layer.borderWidth = 1.0f;
        labelAuthorized.layer.borderColor = [UIColor colorWithRed:101.0/255.0 green:185.0/255.0 blue:171.0/255.0 alpha:1.0].CGColor;
//        labelAuthorized.hidden = YES;
        [leftBgView addSubview:labelAuthorized];
        
        labelOutSell = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 47 - 40, 10, 40, 16)];
        [labelOutSell setBackgroundColor:[UIColor clearColor]];
        labelOutSell.font = [UIFont fontWithName:FONTNAME size:12.0f];
        labelOutSell.textColor = UIColorFromRGB(0xffa300);
        labelOutSell.textAlignment = NSTextAlignmentCenter;
        labelOutSell.text = @"上门";
        labelOutSell.layer.cornerRadius = 8.0f;
        labelOutSell.layer.borderWidth = 1.0f;
        labelOutSell.layer.borderColor = UIColorFromRGB(0xffa300).CGColor;
//        labelOutSell.hidden = YES;
        [leftBgView addSubview:labelOutSell];
//
//        
//        _labCallNum = [[UILabel alloc] initWithFrame:CGRectMake(73, 35, 200, 21)];
//        [_labCallNum setBackgroundColor:[UIColor clearColor]];
//        [_labCallNum setTextColor:THEME_COLOR_TEXT];
//        [_labCallNum setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
//        [leftBgView addSubview:_labCallNum];
        
        labPhone = [[UILabel alloc] initWithFrame:CGRectMake(73, 35, kScreenWidth - 73 - 45, 21)];
        [labPhone setBackgroundColor:[UIColor clearColor]];
        [labPhone setTextColor:THEME_COLOR_TEXT];
        [labPhone setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
        [leftBgView addSubview:labPhone];
        
        UIButton *btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCall setBackgroundColor:[UIColor clearColor]];
        [btnCall setFrame:CGRectMake(kScreenWidth - 45, 0, 45, 70)];
        [btnCall setImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
//        btnCall.showsTouchWhenHighlighted = YES;
        [btnCall addTarget:self action:@selector(btnCallClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnCall];
        
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 69.5, kScreenWidth, 0.5)];
        [line setBackgroundColor:THEME_COLOR_LINE];
        [self.contentView addSubview:line];
    }
    return self;
}

static float firstHeight = 18.0f;

-(void)setCellDataWithShopItem:(HWShopItemClass *)shopItem
{
    _labName.text = shopItem.shopName;
    
    //先手机后座机
    NSString *strPhone = @"";
    if (shopItem.mobileNumber.length > 0)
    {
        BOOL isPhone = [Utility validateMobile:shopItem.mobileNumber];
        if (isPhone)
        {
            strPhone = shopItem.mobileNumber;
        }
    }
    else if (shopItem.phoneNumber.length > 0)
    {
        
        strPhone = shopItem.phoneNumber;
    }
    
    labPhone.text = strPhone;
    
    
//    _labCallNum.text = [NSString stringWithFormat:@"%@次拨打",shopItem.dialCount];
//    
    CGSize shopNameSize;
    if (IOS7)
    {
        NSDictionary *attribute = @{NSFontAttributeName:_labName.font};
        shopNameSize = [_labName.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
        shopNameSize = [_labName.text sizeWithFont:_labName.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 21)];
    }
//    NSLog(@"~~ %f",shopNameSize.width);
    //0 认证中   1 认证拒绝    2 已认证
    if ([shopItem.auditStatus isEqualToString:@"2"])
    {
        //有认证
        if ([shopItem.outSell isEqualToString:@"1"])
        {
            //有上门
            float widthMax = kScreenWidth - 73.0f - 47.0f - 40.0f - 5.0f - 40.0f - 5.0f;
            if (shopNameSize.width <= widthMax)
            {
                _labName.frame = CGRectMake(73, 15, shopNameSize.width, 21);
                labelAuthorized.frame = CGRectMake(73 + shopNameSize.width + 5, firstHeight, 40, 16);
                labelOutSell.frame = CGRectMake(73 + shopNameSize.width + 5 + 40 + 5, firstHeight, 40, 16);
                
            }
            else
            {
                _labName.frame = CGRectMake(73, 15, widthMax, 21);
                labelOutSell.frame = CGRectMake(kScreenWidth - 47 - 40 - 5, firstHeight, 40, 16);
                labelAuthorized.frame = CGRectMake(kScreenWidth - 47 - 40 - 5 - 40 - 5, firstHeight, 40, 16);
            }
        }
        else
        {
            labelOutSell.hidden = YES;
            float widthMax = kScreenWidth - 73.0f - 47.0f - 40.0f - 5.0f;
            if (shopNameSize.width <= widthMax)
            {
                _labName.frame = CGRectMake(73, 15, shopNameSize.width, 21);
                labelAuthorized.frame = CGRectMake(73 + shopNameSize.width + 5, firstHeight, 40, 16);
                
            }
            else
            {
                _labName.frame = CGRectMake(73, 15, widthMax, 21);
                labelAuthorized.frame = CGRectMake(kScreenWidth - 47 - 40, firstHeight, 40, 16);
            }
        }
    }
    else
    {
        labelAuthorized.hidden = YES;
        if ([shopItem.outSell isEqualToString:@"1"])
        {
            //有上门
            float widthMax = kScreenWidth - 73.0f - 47.0f - 40.0f - 5.0f;
            if (shopNameSize.width <= widthMax)
            {
                _labName.frame = CGRectMake(73.0f, 15, shopNameSize.width, 21);
                labelOutSell.frame = CGRectMake(73.0f + shopNameSize.width + 5, firstHeight, 40, 16);
            }
            else
            {
                _labName.frame = CGRectMake(73.0f, 15, widthMax, 21);
                labelOutSell.frame = CGRectMake(kScreenWidth - 47 - 40, firstHeight, 40, 16);
            }
        }
        else
        {
            float widthMax = kScreenWidth - 73.0f - 47.0f;
            _labName.frame = CGRectMake(73.0f, 15, widthMax, 21);
            labelOutSell.hidden = YES;
        }
    }
    
    
    [_imgShop setImage:[UIImage imageNamed:@"shopDefault"]];
    __weak UIImageView *shopImage = _imgShop;
    NSString *strUrl = [NSString stringWithFormat:@"%@/hw-sq-app-web/%@",kUrlBase,shopItem.iconUrl];
    [_imgShop setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"shopDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error) {
            shopImage.image = [UIImage imageNamed:@"shopDefault"];
        }
        else
        {
            shopImage.image = image;
        }
    }];
    
}

- (void)leftTapGesture:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.numberOfTapsRequired == 1) {

        NSLog(@"手指点击");
        
        
        if (delegate && [delegate respondsToSelector:@selector(selectCell:)])
        {
            [delegate selectCell:(int)self.tag];
        }
    }
    
}

- (void)btnCallClick:(id)sender
{
    NSLog(@"拨打电话");
    
    if (delegate && [delegate respondsToSelector:@selector(callPhone:)])
    {
        [delegate callPhone:(int)self.tag];
    }
    
}

- (void)moveDownAnimate
{
    CABasicAnimation *downAnim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    downAnim.fromValue = [NSNumber numberWithFloat:0.0f];
    downAnim.toValue = [NSNumber numberWithFloat:70.0f];
    downAnim.duration = 0.6f;
    downAnim.autoreverses = NO;
    downAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.contentView.layer addAnimation:downAnim forKey:@"down"];
}


- (void)loadingAnimate
{
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    [self.contentView setBackgroundColor:UIColorFromRGB(0x333333)];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    [activity startAnimating];
    [self.contentView addSubview:activity];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
