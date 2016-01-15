//
//  HWAddressManagerCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-12-19.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWAddressManagerCell.h"

@implementation HWAddressManagerCell

@synthesize nameLabel;
@synthesize telephoneLabel;
@synthesize addressLabel;
@synthesize selectImgV;
@synthesize editButton;
@synthesize deleteButton;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:15.0f];
        nameLabel.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:nameLabel];
        
        //电话
        telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) + 5, 10, 100, 20)];
        telephoneLabel.backgroundColor = [UIColor clearColor];
        telephoneLabel.font = [UIFont systemFontOfSize:15.0f];
        telephoneLabel.textColor = THEME_COLOR_SMOKE;
        [self.contentView addSubview:telephoneLabel];
        //地址
        addressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        addressLabel.font = [UIFont systemFontOfSize:14.0f];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.numberOfLines = 0;
        addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        addressLabel.textColor = THEME_COLOR_TEXT;
        [self.contentView addSubview:addressLabel];
        
        selectImgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 15 - 25, 25, 25, 25)];
        selectImgV.image = [UIImage imageNamed:@"choose_ok2"];
//        selectImgV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:selectImgV];
        
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectZero;
        [editButton setButtonGrayStyle];
        [editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(doEdit:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:editButton];
        
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectZero;
        [deleteButton setButtonRedStyle];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(doDelete:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:deleteButton];
        
        
        
    }
    return self;
}

- (void)setAddressInfo:(AddressModel *)info
{
    nameLabel.text = [NSString stringWithFormat:@"收件人：%@",info.name];
    telephoneLabel.text = info.mobile;
    NSString *address = [NSString  stringWithFormat:@"收货地址 : %@",info.address];
    CGSize size = [Utility calculateStringHeight:address font:[UIFont systemFontOfSize:14] constrainedSize:CGSizeMake(kScreenWidth - 15 - 50, 1000)];
    addressLabel.text = info.address;
    addressLabel.frame = CGRectMake(15, CGRectGetMaxY(nameLabel.frame) + 5, kScreenWidth - 15 - 50, size.height);

    editButton.frame = CGRectMake(0, CGRectGetMaxY(addressLabel.frame) + 15, kScreenWidth / 2.0f, 30);
    [editButton setButtonGrayStyle];
    editButton.layer.cornerRadius = 0;
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    editButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
    
    deleteButton.frame = CGRectMake(kScreenWidth/ 2.0f, CGRectGetMaxY(addressLabel.frame) + 15, kScreenWidth / 2.0f, 30);
    [deleteButton setButtonRedStyle];
    deleteButton.titleLabel.font = [UIFont fontWithName:FONTNAME size:13.0f];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
}

+ (float)getCellHeight:(AddressModel *)info
{
    NSString *address = [NSString  stringWithFormat:@"收货地址 : %@",info.address];
    CGSize size = [Utility calculateStringHeight:address font:[UIFont systemFontOfSize:14] constrainedSize:CGSizeMake(kScreenWidth - 40, 1000)];
    return 80 + size.height;
}

- (void)doDelete:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectedDelete:)]) {
        [delegate didSelectedDelete:self];
    }
}

- (void)doEdit:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectedEdit:)]) {
        [delegate didSelectedEdit:self];
    }
}
@end
