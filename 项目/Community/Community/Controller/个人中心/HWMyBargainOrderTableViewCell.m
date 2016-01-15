//
//  HWMyBargainOrderTableViewCell.m
//  Community
//
//  Created by D on 14/12/9.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWMyBargainOrderTableViewCell.h"


@implementation HWMyBargainOrderTableViewCell
@synthesize bargainOrderModel;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    self.backgroundColor = BACKGROUND_COLOR;
    self.layer.masksToBounds = YES;
    
    
    self.backImg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 155)];
    self.backImg.userInteractionEnabled = YES;
    self.backImg.backgroundColor = [UIColor whiteColor];
    self.backImg.userInteractionEnabled = YES;
    self.backImg.layer.borderColor = THEME_COLOR_LINE.CGColor;
    self.backImg.layer.borderWidth = 0.5;
    [self addSubview:self.backImg];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    self.titleLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_BIG];
    self.titleLab.text = @"无底线";
    self.titleLab.textColor = THEME_COLOR_SMOKE;
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.backImg addSubview:self.titleLab];
    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payBtn.frame = CGRectMake(kScreenWidth - 60 - 15, 8, 60, 30);
    [self.payBtn setButtonOrangeStyle];
    [self.payBtn setTitle:@"付款" forState:UIControlStateNormal];
    self.payBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:14.5];
    [self.payBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backImg addSubview:self.payBtn];
    
    self.unPayLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - self.payBtn.frame.origin.x - 10 - 45, 13, 50, 20)];
    self.unPayLab.font = [UIFont fontWithName:FONTNAME size:16];
    self.unPayLab.text = @"未支付";
    self.unPayLab.textColor = THEME_COLOR_ORANGE;
    [self.backImg addSubview:self.unPayLab];
    
    UILabel * lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, 0.5)];
    lineLab.backgroundColor = THEME_COLOR_LINE;
    lineLab.layer.borderWidth = 0.5;
    lineLab.layer.borderColor = THEME_COLOR_LINE.CGColor;
    [self.backImg addSubview:lineLab];
    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, lineLab.frame.origin.y + 10, 65, 65)];
    self.img.layer.cornerRadius = 2;
    self.img.layer.borderColor = THEME_COLOR_LINE.CGColor;
    self.img.layer.borderWidth = 0.5;
    self.img.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
    [self.backImg addSubview:self.img];
    
    self.infoLab = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.img.frame.size.width + 10, lineLab.frame.origin.y + 10, kScreenWidth - (15 + self.img.frame.size.width + 10 + 15), 0)];
    self.infoLab.backgroundColor = [UIColor clearColor];
    self.infoLab.numberOfLines = 0;
    self.infoLab.lineBreakMode = NSLineBreakByCharWrapping;
    self.infoLab.textColor = THEME_COLOR_SMOKE;
    self.infoLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.infoLab];
    
    self.priceTLab = [[UILabel alloc] initWithFrame:CGRectMake(self.infoLab.frame.origin.x, CGRectGetMaxY(self.infoLab.frame) + 5, 50, 15)];
    self.priceTLab.backgroundColor = [UIColor clearColor];
    self.priceTLab.text = @"价格 : ¥";
    self.priceTLab.textColor = THEME_COLOR_TEXT;
    self.priceTLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.priceTLab];
    
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceTLab.frame), self.priceTLab.frame.origin.y, 45, 15)];
    self.priceLab.backgroundColor= [UIColor clearColor];
    self.priceLab.textAlignment = NSTextAlignmentLeft;
    self.priceLab.textColor = THEME_COLOR_TEXT;
    self.priceLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.priceLab];
    
    self.numTLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLab.frame) + 5, self.priceTLab.frame.origin.y, 50, 15)];
    self.numTLab.backgroundColor = [UIColor clearColor];
    self.numTLab.text = @"数量 ：";
    self.numTLab.textColor = THEME_COLOR_TEXT;
    self.numTLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.numTLab];
    
    self.numLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.numTLab.frame), self.priceLab.frame.origin.y, 80, 15)];
    self.numLab.backgroundColor = [UIColor clearColor];
    self.numLab.textAlignment = NSTextAlignmentLeft;
    self.numLab.textColor = THEME_COLOR_TEXT;
    self.numLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.numLab];
    
    self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.img.frame.size.width + 10, CGRectGetMaxY(self.numTLab.frame) + 10, kScreenWidth - (15 + self.img.frame.size.width + 10), 0.5)];
    self.lineLab.backgroundColor = THEME_COLOR_LINE;
    self.lineLab.layer.borderColor = THEME_COLOR_LINE.CGColor;
    self.lineLab.layer.borderWidth = 0.5;
    [self.backImg addSubview:self.lineLab];
    
    self.buttomNumTLab = [[UILabel alloc] initWithFrame:CGRectMake(self.infoLab.frame.origin.x, self.lineLab.frame.origin.y + 12, 15, 15)];
    self.buttomNumTLab.backgroundColor = [UIColor clearColor];
    self.buttomNumTLab.text = @"共";
    self.buttomNumTLab.textColor = THEME_COLOR_TEXT;
    self.buttomNumTLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.buttomNumTLab];
    
    self.buttomNumLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buttomNumTLab.frame), self.buttomNumTLab.frame.origin.y, 15, 15)];
    self.buttomNumLab.backgroundColor = [UIColor clearColor];
    self.buttomNumLab.textColor = UIColorFromRGB(0xFC6400);
    self.buttomNumLab.textAlignment = NSTextAlignmentCenter;
    self.buttomNumLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.buttomNumLab];
    
    self.totalPayTLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.buttomNumLab.frame) + 15, self.buttomNumTLab.frame.origin.y, 96, 15)];
    self.totalPayTLab.backgroundColor = [UIColor clearColor];
    self.totalPayTLab.text = @"件商品  实付 ：";
    self.totalPayTLab.textColor = THEME_COLOR_TEXT;
    self.totalPayTLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.totalPayTLab];
    
    self.totalPayLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.totalPayTLab.frame) + 96, self.buttomNumTLab.frame.origin.y, 100, 15)];
    self.totalPayLab.backgroundColor = [UIColor clearColor];
    self.totalPayLab.textColor = UIColorFromRGB(0xFC6400);
    self.totalPayLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.totalPayTLab sizeToFit];
    [self.backImg addSubview:self.totalPayLab];
    
    self.ThirdLineLab = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.buttomNumTLab.frame) + 13, kScreenWidth, 0.5)];
    self.ThirdLineLab.backgroundColor = THEME_COLOR_LINE;
    self.ThirdLineLab.layer.borderWidth = 0.5;
    self.ThirdLineLab.layer.borderColor = THEME_COLOR_LINE.CGColor;
    [self.backImg addSubview:self.ThirdLineLab];
    
    self.orderNumLab = [[UILabel alloc] initWithFrame:CGRectMake(self.infoLab.frame.origin.x, self.ThirdLineLab.frame.origin.y, 800, 30)];
    self.orderNumLab.text = @"订单号 : ";
    self.orderNumLab.backgroundColor = [UIColor clearColor];
    self.orderNumLab.textColor = THEME_COLOR_TEXT;
    self.orderNumLab.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
    [self.backImg addSubview:self.orderNumLab];
    
    self.lineIm = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderNumLab.frame), kScreenWidth, 10)];
    self.lineIm.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:self.lineIm];
    
}

- (CGFloat)calculateStringHeight:(NSString *)string {
    self.subHeight = 0;
    CGFloat height = [Utility calculateStringHeight:string font:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL] constrainedSize:CGSizeMake(kScreenWidth - (15 + 65 + 10) - 15, CGFLOAT_MAX)].height;
    return height - self.infoLab.frame.size.height;
}

- (CGRect)calculateFrame:(UIView *)view {
    return CGRectMake(view.frame.origin.x, view.frame.origin.y + self.subHeight, view.frame.size.width, view.frame.size.height);
}

- (void)showForModel:(HWMyBargainOrderModel *)model {
    
    self.subHeight = [self calculateStringHeight:model.productName];  //  计算高度差
    CGRect frame = self.backImg.frame;
    frame.size.height = frame.size.height + self.subHeight;
    self.backImg.frame = frame;
    
    self.infoLab.text = model.productName;
    self.infoLab.frame = CGRectMake(self.infoLab.frame.origin.x, self.infoLab.frame.origin.y, self.infoLab.frame.size.width, self.infoLab.frame.size.height + self.subHeight);
//    self..frame = CGRectMake(self..frame.origin.x, self..frame.origin.y, self..frame.size.width, self..frame.size.height + self.subHeight);
    
    self.priceTLab.frame = [self calculateFrame:self.priceTLab];
    self.priceLab.frame = [self calculateFrame:self.priceLab];
    self.numTLab.frame = [self calculateFrame:self.numTLab];
    self.numLab.frame = [self calculateFrame:self.numLab];
    self.lineLab.frame = [self calculateFrame:self.lineLab];
    self.buttomNumTLab.frame = [self calculateFrame:self.buttomNumTLab];
    self.buttomNumLab.frame = [self calculateFrame:self.buttomNumLab];
    self.totalPayTLab.frame = [self calculateFrame:self.totalPayTLab];
    self.totalPayLab.frame = [self calculateFrame:self.totalPayLab];
    self.ThirdLineLab.frame = [self calculateFrame:self.ThirdLineLab];
    self.orderNumLab.frame = [self calculateFrame:self.orderNumLab];
    self.lineIm.frame = [self calculateFrame:self.lineIm];;
    
    __block HWMyBargainOrderTableViewCell * cell = self;
    
    if(model.bigImg) {
        [self.img setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.bigImg]] placeholderImage:[UIImage imageNamed:@"rupture"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (!error) {
                cell.img.image = image;
            }
        }];
    } else if (model.smallImg) {
        [self.img setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:model.smallImg]] placeholderImage:[UIImage imageNamed:@"rupture"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (!error) {
                cell.img.image = image;
            }
        }];
    }
    //更改价格及数量的位置
    CGFloat width = [Utility calculateStringHeight:model.marketPrice font:self.priceLab.font constrainedSize:CGSizeMake(1000,self.priceLab.frame.size.height)].width;
    self.priceLab.text = model.marketPrice;
    frame = self.priceLab.frame;
    frame.size.width = width;
    self.priceLab.frame = frame;
    
    frame = self.numTLab.frame;
    frame.origin.x = self.priceLab.frame.origin.x + width + 15;
    self.numTLab.frame = frame;
    
    self.numLab.text = model.orderAmount;
    frame = self.numLab.frame;
    frame.origin.x = self.numTLab.frame.origin.x + self.numTLab.frame.size.width - 5;
    self.numLab.frame = frame;
    
    //更改数量及实付位置
    width = [Utility calculateStringHeight:self.numLab.text font:self.buttomNumLab.font constrainedSize:CGSizeMake(1000, self.buttomNumLab.frame.size.height)].width;
    self.buttomNumLab.text = model.orderAmount;
    frame = self.buttomNumLab.frame;
    frame.size.width = width;
    self.buttomNumLab.frame = frame;
    
    frame = self.totalPayTLab.frame;
    frame.origin.x = self.buttomNumLab.frame.origin.x + width + 3;
    self.totalPayTLab.frame = frame;
    
    if (![model.payMoney isEqualToString:@""]) {
        self.totalPayLab.text = [NSString stringWithFormat:@"￥%@", model.payMoney];
    }
    frame = self.totalPayLab.frame;
    frame.origin.x = self.totalPayTLab.frame.origin.x + self.totalPayTLab.frame.size.width - 5;
    self.totalPayLab.frame = frame;
    
    self.orderNumLab.text = [NSString stringWithFormat:@"订单号 : %@",model.orderNum];
    
    if ([model.orderStatus intValue]==0)
    {
        self.payBtn.hidden = NO;
        self.payBtn.userInteractionEnabled = YES;
        self.unPayLab.frame = CGRectMake(kScreenWidth - 60 - 15 - 10 - 45, self.unPayLab.frame.origin.y, self.unPayLab.frame.size.width, self.unPayLab.frame.size.height);
        self.unPayLab.text = @"未支付";
        self.unPayLab.textColor = THEME_COLOR_ORANGE;
    }
    else
    {
        if ([model.sendStatus isEqualToString:@"0"]) {
            self.payBtn.hidden = YES;
            self.unPayLab.frame = CGRectMake(kScreenWidth - self.unPayLab.frame.size.width - 15, self.unPayLab.frame.origin.y, self.unPayLab.frame.size.width, self.unPayLab.frame.size.height);
            self.unPayLab.text = @"未发货";
            self.unPayLab.textColor = UIColorFromRGB(0xFC6400);
        }
        else
        {
            self.payBtn.hidden = YES;
            self.unPayLab.frame = CGRectMake(kScreenWidth - self.unPayLab.frame.size.width - 15, self.unPayLab.frame.origin.y, self.unPayLab.frame.size.width, self.unPayLab.frame.size.height);
            self.unPayLab.text = @"已发货";
            self.unPayLab.textColor = THEME_COLOR_TEXT;
        }
    }
    
//    switch (model.sendStatus.intValue) {
//        case 0:
//        {
//            self.payBtn.hidden = YES;
//            self.unPayLab.frame = CGRectMake(kScreenWidth - self.unPayLab.frame.size.width - 15, self.unPayLab.frame.origin.y, self.unPayLab.frame.size.width, self.unPayLab.frame.size.height);
//            self.unPayLab.text = @"已发货";
//            self.unPayLab.textColor = THEME_COLOR_TEXT;
//        }
//            break;
//        case 1:
//        {
//            self.payBtn.hidden = YES;
//            self.unPayLab.frame = CGRectMake(kScreenWidth - self.unPayLab.frame.size.width - 15, self.unPayLab.frame.origin.y, self.unPayLab.frame.size.width, self.unPayLab.frame.size.height);
//            self.unPayLab.text = @"未发货";
//            self.unPayLab.textColor = UIColorFromRGB(0xFC6400);
//            
//        }
//            break;
//        case 2:
//        {
//            self.payBtn.hidden = NO;
//            self.unPayLab.frame = CGRectMake(kScreenWidth - 60 - 15 - 10 - 45, self.unPayLab.frame.origin.y, self.unPayLab.frame.size.width, self.unPayLab.frame.size.height);
//            self.unPayLab.text = @"未支付";
//        }
//            break;
//        default:
//            break;
//    }
    
    
}

- (void)buttonClick
{
    if (_comeInPay) {
        _comeInPay(bargainOrderModel);
    }
}


@end
