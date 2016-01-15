//
//  AddAddressTableViewCell.m
//  Community
//
//  Created by hw500028 on 14/12/8.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "AddAddressTableViewCell.h"
#import "UIViewExt.h"
@implementation AddAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


#pragma mark - Views

- (void)initViews{

    UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 18)];
    ImageView.image = [UIImage imageNamed:@"创建小区位置"];
    [self.contentView addSubview:ImageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(ImageView.right +5, 10, 200, 22)];
    label.text = @"请选择收货地址";
    [self.contentView addSubview:label];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
