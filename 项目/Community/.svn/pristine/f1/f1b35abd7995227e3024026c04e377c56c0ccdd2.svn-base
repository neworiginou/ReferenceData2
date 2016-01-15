//
//  HWReceiveAddressCell.m
//  Community
//
//  Created by ryder on 8/3/15.
//  Copyright (c) 2015 caijingpeng. All rights reserved.
//

#import "HWReceiveAddressCell.h"
#import "UIViewExt.h"
#import "SWTableViewCell.h"
#import "HaveAddressTableView.h"

@implementation HWReceiveAddressCell

+ (HWReceiveAddressCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"cell";
    HWReceiveAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil)
    {
        cell = [[HWReceiveAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify containingTableView:tableView leftUtilityButtons:nil rightUtilityButtons:nil];
        cell.rightUtilityButtons = [cell rightUtilityButtons];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier containingTableView:containingTableView leftUtilityButtons:leftUtilityButtons rightUtilityButtons:rightUtilityButtons];
    if (self)
    {
        
        self.tableView = containingTableView;
        NSLog(@"containingTableView == %p",containingTableView);
    }
    return self;
    
}

#pragma mark 视图
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)orderAddressLabel{
    if (_orderAddressLabel == nil) {
        _orderAddressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _orderAddressLabel.font = [UIFont systemFontOfSize:15.0f];
        _orderAddressLabel.backgroundColor = [UIColor clearColor];
        _orderAddressLabel.numberOfLines = 0;
        _orderAddressLabel.textColor =[UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1];
        [self.contentView addSubview:_orderAddressLabel];
        
    }
    return _orderAddressLabel;
}

- (UILabel *)phoneNumLabel{
    if (_phoneNumLabel == nil) {
        _phoneNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _phoneNumLabel.backgroundColor = [UIColor clearColor];
        _phoneNumLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_phoneNumLabel];
        
    }
    return _phoneNumLabel;
}

- (UIImageView *)selectImage{
    if (_selectImage == nil) {
        _selectImage = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_selectImage];
        [_selectImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_selectImage autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0f];
        [_selectImage autoSetDimension:ALDimensionHeight toSize:25.0f];
        [_selectImage autoSetDimension:ALDimensionWidth toSize:25.0f];
        _selectImage.image = [UIImage imageNamed:@"支付选择"];
    }
    return _selectImage;
}



- (void)initViews{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.phoneNumLabel];
    [self.contentView addSubview:self.orderAddressLabel];
}

#pragma mark --
- (void)setSelected:(BOOL)selected
{
    if (selected == YES)
    {
        [self selectCell];
    }
}


- (void)setupdata
{
    //名字
    self.nameLabel.frame = CGRectMake(15, 15, 150, 20);
    NSString *name = [NSString stringWithFormat:@"收件人 : %@",self.addressModel.name];
    self.nameLabel.text = name;
    //电话
    self.phoneNumLabel.frame = CGRectMake(_nameLabel.right + 10, 15, 100, 20);
    NSString *phoneNum = [NSString stringWithFormat:@"%@",self.addressModel.mobile];
    self.phoneNumLabel.text = phoneNum;
    //地址
    NSString *address = [NSString  stringWithFormat:@"收货地址 : %@",self.addressModel.address];
    CGSize size = [Utility calculateStringHeight:address font:[UIFont systemFontOfSize:15] constrainedSize:CGSizeMake(kScreenWidth - 40, 1000)];
    self.orderAddressLabel.frame = CGRectMake(15, self.nameLabel.bottom + 10, kScreenWidth - 60, size.height);
    self.orderAddressLabel.text = address;
    //////底部线
    UIView *line = [UIView newAutoLayoutView];
    [self.contentView addSubview:line];
    [line autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0,1.0f, 0) excludingEdge:ALEdgeTop];
    [line autoSetDimension:ALDimensionHeight toSize:0.5f];
    line.backgroundColor = THEME_COLOR_LINE;
    //选中图片
    if ([self.addressModel.isSelected isEqualToString:@"1"])
    {
        self.selectImage.hidden = NO;
    }
    else
    {
        self.selectImage.hidden = YES;
    }
//    self.selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 40, (80 + size.height - 25)/2, 25, 25)];
//    _selectImage.image = [UIImage imageNamed:@"支付选择"];
//    _selectImage.hidden = YES;
//    [self.contentView addSubview:_selectImage];
}

- (void)setAddressModel:(HWAddressInfo *)addressModel{
    if (_addressModel != addressModel) {
        _addressModel = addressModel;
    }
    [self setupdata];
}

- (void)setIsDefault:(NSString *)isDefault
{
    _isDefault = isDefault;
    if ([_isDefault integerValue] == 1)
    {
        [self selectCell];
    }
    
}

+ (CGFloat)getHeightWithModel:(HWAddressInfo *)model{
    
    CGFloat height;
    NSString *address = [NSString stringWithFormat:@"收货地址 : %@",model.address];
    CGSize size =  [Utility calculateStringHeight:address font:[UIFont systemFontOfSize:15.0f] constrainedSize:CGSizeMake(kScreenWidth - 40, 1000)];
    //    height = CGRectGetMaxY(_orginLabel.frame);
    height  = 55.5f + size.height;
    return height;
    
}

-(void)selectCell{
    //    [super selectCell];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    
    if (![_tableView isKindOfClass:[HaveAddressTableView class]] )
    {
        for (NSUInteger i = 0; i < array.count; i++) {
            NSIndexPath *path = (NSIndexPath *)array[i];
            HWReceiveAddressCell *cell = (HWReceiveAddressCell *)[_tableView cellForRowAtIndexPath:path];
            cell.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1];
            cell.nameLabel.textColor = [UIColor blackColor];
            cell.phoneNumLabel.textColor = [UIColor blackColor];
            cell.orderAddressLabel.textColor = [UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1];
            cell.selectImage.hidden = YES;
            
        }
        
    }
    
    
    self.backgroundColor = [UIColor colorWithRed:114/255.0f green:114/255.0f blue:114/255.0f alpha:1];
    self.selectImage.hidden = NO;
    [self selectFontColor];
    
}


//选中后字体颜色

- (void)selectFontColor{
    self.nameLabel.textColor = [UIColor whiteColor];
    self.phoneNumLabel.textColor = [UIColor whiteColor];
    self.orderAddressLabel.textColor = [UIColor whiteColor];
}

- (NSArray *)rightUtilityButtons
{
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"编辑"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    return rightUtilityButtons;
}

@end
