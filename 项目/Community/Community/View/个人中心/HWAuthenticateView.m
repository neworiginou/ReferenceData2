//
//  HWAuthenticateView.m
//  Community
//
//  Created by hw500027 on 15/6/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//
//  功能描述：个人-认证-添加门牌 view
//
//  修改记录：
//      姓名         日期               修改内容
//     陆晓波     2015-06-15            创建文件
//

#import "HWAuthenticateView.h"
#import "HWInputBackView.h"
#import "HWWuYeAddHouseModel.h"

@interface HWAuthenticateView() <HWAuthenticateMoreAddressViewControllerDelegate>
{
    UIView *headView;
    UILabel *detailAddressLabel;
    HWWuYeAddHouseModel *_model;
}
@end

@implementation HWAuthenticateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.isNeedHeadRefresh = NO;
        isLastPage = YES;
        [self configUI];
    }
    return self;
}

- (void)didSelectedAddressView:(NSString *)address
{
    detailAddressLabel.text = address;
}

//备注信息label
- (CGFloat)addPSLabel:(CGFloat)originY
{
    UILabel *label = [UILabel newAutoLayoutView];
    [headView addSubview:label];
    label.numberOfLines = 0;
    label.text = @"您的门牌号仅作为物业认证资料提交，未经您的许可我们不会透露给他人。";
    label.font = FONT(14);
    label.textColor = THEME_COLOR_TEXT;
    
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:headView withOffset:15 + originY];
    [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:headView  withOffset:15];
    [label autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:headView  withOffset:- 15];
    [label setPreferredMaxLayoutWidth:kScreenWidth - 30];
    
    return originY + 15 + [label systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
}

//提交按钮
- (CGFloat)addConfirmBtn:(CGFloat)originY
{
    CGFloat padding_height = 20;
    CGSize btnSize = CGSizeMake(kScreenWidth - 30, 45);

    UIButton *confirmBtn = [UIButton newAutoLayoutView];

    [headView addSubview:confirmBtn];
    confirmBtn.layer.cornerRadius = 3;
    confirmBtn.layer.masksToBounds = YES;
    
    [confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    
    [confirmBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:headView  withOffset:originY + padding_height];
    [confirmBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:headView  withOffset:15];
    [confirmBtn autoSetDimensionsToSize:btnSize];
    
    [confirmBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_NORMAL andSize:btnSize] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[Utility imageWithColor:THEBUTTON_GREEN_HIGHLIGHT andSize:btnSize] forState:UIControlStateHighlighted];
    
    [confirmBtn addTarget:self action:@selector(didClickconfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    
    return originY + [confirmBtn systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + padding_height;
}

- (void)didClickconfirmBtn
{
    if (detailAddressLabel.text.length == 0)
    {
        [Utility showToastWithMessage:@"请选择门牌" inView:self];
    }
    else
    {
        [Utility hideMBProgress:self];
        [Utility showMBProgress:self message:@"请求数据"];
        
        NSMutableDictionary *parame = [[NSMutableDictionary alloc] init];
        [parame setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
        [parame setPObject:_model.buildingNo forKey:@"buildingNo"];
        [parame setPObject:_model.unitNo forKey:@"unitNo"];
        [parame setPObject:_model.roomNo forKey:@"roomNo"];
        
        HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
        [manager POST:kSubmitNotAuthentication parameters:parame queue:nil success:^(id responese)
         {
             [Utility hideMBProgress:self];
             if ([[responese stringObjectForKey:@"status"] isEqual:@"1"])
             {
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 [defaults setObject:[parame stringObjectForKey:@"buildingNo"] forKey:kAuthBuildingNo];
                 [defaults setObject:[parame stringObjectForKey:@"unitNo"] forKey:kAuthUnitNo];
                 [defaults setObject:[parame stringObjectForKey:@"roomNo"] forKey:kAuthRoomNo];
                 [defaults setObject:[responese stringObjectForKey:@"data"] forKey:kAuthApplyId];
                 [defaults synchronize];
                 
                 if (_delegate && [_delegate respondsToSelector:@selector(didSelectConfirmBtn)])
                 {
                     [_delegate didSelectConfirmBtn];
                 }
             }
             
         } failure:^(NSString *code, NSString *error)
         {
             [Utility hideMBProgress:self];
             [Utility showToastWithMessage:error inView:self];
         }];
    }
}

- (void)popToAuthenticateStressAddressViewController:(HWWuYeAddHouseModel *)model
{
    _model = model;
    if (model.unitNo.length == 0)
    {
        detailAddressLabel.text = [NSString stringWithFormat:@"%@号楼%@室",model.buildingNo,model.roomNo];
    }
    else
    {
        detailAddressLabel.text = [NSString stringWithFormat:@"%@号楼%@单元%@室",model.buildingNo,model.unitNo,model.roomNo];
    }
}

- (void)didTapAddressLabel
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectAddAddressLabel:)])
    {
        HWAuthenticateMoreAddressViewController *vc = [[HWAuthenticateMoreAddressViewController alloc] init];
        vc.delegate = self;
        [_delegate didSelectAddAddressLabel:vc];
    }
}

//门牌
- (CGFloat)addStreetAddress:(CGFloat)originY
{
    HWInputBackView *intputView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, originY, kScreenWidth, 45) withLineCount:1];
    [headView addSubview:intputView];
    
    UILabel *titleLabel = [UILabel newAutoLayoutView];
    [intputView addSubview:titleLabel];
    titleLabel.text = @"门牌";
    titleLabel.font = FONT(15);
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:intputView withOffset:15];
    [titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:intputView];
    
    
    //门牌
    detailAddressLabel = [UILabel newAutoLayoutView];
    [intputView addSubview:detailAddressLabel];
    detailAddressLabel.font = FONT(15);
    [detailAddressLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:intputView withOffset:- 15];
    [detailAddressLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:intputView];
    detailAddressLabel.textColor = THEME_COLOR_TEXT;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAddressLabel)];
    [intputView addGestureRecognizer:tap];
    
    return CGRectGetMaxY(intputView.frame);
}

//小区
- (CGFloat)addVillage
{
    HWInputBackView *intputView = [[HWInputBackView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 45) withLineCount:1];
    [headView addSubview:intputView];
    
    UILabel *titleLabel = [UILabel newAutoLayoutView];
    [intputView addSubview:titleLabel];
    titleLabel.text = @"小区";
    titleLabel.font = FONT(15);
    [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:intputView withOffset:15];
    [titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:intputView];
    
    //小区名
    UILabel *detailLabel = [UILabel newAutoLayoutView];
    [intputView addSubview:detailLabel];
    detailLabel.font = FONT(15);
    detailLabel.text = [HWUserLogin currentUserLogin].villageName;
    [detailLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:intputView withOffset:- 15];
    [detailLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:intputView];
    detailLabel.textColor = THEME_COLOR_TEXT;
    
    return CGRectGetMaxY(intputView.frame);
}

- (void)configUI
{
    headView = [[UIView alloc] initWithFrame:self.frame];
    self.baseTable.tableHeaderView = headView;
    
    //小区
    CGFloat originY1 = [self addVillage];
    //门牌
    CGFloat originY2 = [self addStreetAddress:originY1];
    //提交按钮
    CGFloat originY3 = [self addConfirmBtn:originY2];
    //备注信息
    CGFloat originY4 = [self addPSLabel:originY3];
    
    
    [headView setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, originY4)];
    self.baseTable.tableHeaderView = headView;
}

@end
