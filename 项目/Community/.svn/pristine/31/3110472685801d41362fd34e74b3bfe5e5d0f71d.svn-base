//
//  HWPraiseView.m
//  Community
//
//  Created by lizhongqiang on 15/1/15.
//  Copyright (c) 2015年 caijingpeng. All rights reserved.
//  修改记录
//      李中强 2015-01-16 14:33:51 修改坐标
//      李中强 2015-01-19 17:03:36 添加评论数
//

#import "HWPraiseView.h"
#import "HWNetWorkManager.h"

@implementation HWPraiseView
@synthesize praiseArr;
@synthesize delegate;
@synthesize item;
@synthesize siftLabel;
@synthesize siftArrowImg;
@synthesize commentLabel;
@synthesize detailType;
@synthesize selectBtn;
@synthesize praiseBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.praiseArr = [[NSMutableArray alloc] init];
        
        praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [praiseBtn setBackgroundImage:[UIImage imageNamed:@"praise2_ok_bg"] forState:UIControlStateSelected];
        [praiseBtn setBackgroundImage:[UIImage imageNamed:@"praise2_bg"] forState:UIControlStateNormal];
        [praiseBtn addTarget:self action:@selector(praiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        praiseBtn.frame = CGRectMake(15, 10, 59, 31);   //118 62  178 94
        [self addSubview:praiseBtn];
        
        //图标
        praiseImg = [[UIImageView alloc] initWithFrame:CGRectMake(11, 10, 13, 11.5)];
        [praiseImg setImage:[UIImage imageNamed:@"praise2"]];//26 23
        [praiseImg setBackgroundColor:[UIColor clearColor]];
        [praiseBtn addSubview:praiseImg];
        
        //数字
        praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + 20,  6,  30,  20)];
        [praiseLabel setBackgroundColor:[UIColor clearColor]];
        [praiseLabel setTextColor:[UIColor redColor]];
        [praiseLabel setTextAlignment:NSTextAlignmentCenter];
        [praiseLabel setFont:[UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL]];
        [praiseBtn addSubview:praiseLabel];
        
        //头像view
        photoView = [[UIView alloc] initWithFrame:CGRectMake(85, 10, kScreenWidth - 85, 33)];
        [photoView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:photoView];
        
        oldPhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 110, 33)];
        [oldPhotoView setBackgroundColor:[UIColor clearColor]];
        [photoView addSubview:oldPhotoView];
        
        arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 8 - 15, 20, 8, 14)];
        [arrowImg setImage:[UIImage imageNamed:@"arrow"]];
        [arrowImg setBackgroundColor:[UIColor clearColor]];
        [self addSubview:arrowImg];
        
        arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowBtn.frame = CGRectMake(80, 5, kScreenWidth - 80, 45);
        arrowBtn.backgroundColor = [UIColor clearColor];
        [arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:arrowBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5f, kScreenWidth, 0.5f)];
        [line setBackgroundColor:THEME_COLOR_LINE];
        [self addSubview:line];
        
        commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 62, kScreenWidth - 100, 20)];
        commentLabel.backgroundColor = [UIColor clearColor];
        commentLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        //    commentLabel.text = [NSString stringWithFormat:@"%@条评论",item.replyCount];
        commentLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        commentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:commentLabel];
        
        selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(kScreenWidth - 85, 62, 70, 30);
        selectBtn.backgroundColor = [UIColor clearColor];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
        
        siftLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 65, 62, 50, 20)];
        [siftLabel setBackgroundColor:[UIColor clearColor]];
        siftLabel.font = [UIFont fontWithName:FONTNAME size:THEME_FONT_SMALL];
        siftLabel.textColor = THEME_COLOR_GRAY_MIDDLE;
        [self addSubview:siftLabel];
        
        siftArrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30, 69, 15, 8)];
        siftArrowImg.backgroundColor = [UIColor clearColor];
        siftArrowImg.image = [UIImage imageNamed:@"downArrow"];
        [self addSubview:siftArrowImg];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5f, kScreenWidth, 0.5f)];
        [bottomLine setBackgroundColor:THEME_COLOR_LINE];
        [self addSubview:bottomLine];
    }
    
    return self;
}

- (void)setItem:(HWNeighbourItemClass *)neiItem
{
    item = neiItem;
    [self initContentView];
}

- (void)initContentView
{
    
    praiseNum = [item.likeCount intValue];
    self.praiseArr = item.topicPraiseArr;
    
    
    NSString *numStr = item.likeCount;
    if ([numStr intValue] > 99) {
        numStr = @"99+";
    }
    praiseLabel.text = [NSString stringWithFormat:@"%@",numStr];
    
    
    
    if ([item.isPraise isEqualToString:@"1"])
    {
        praiseBtn.selected = YES;
        praiseLabel.textColor = [UIColor whiteColor];
        praiseImg.image = [UIImage imageNamed:@"praise2_ok"];
    }
    else
    {
        praiseBtn.selected = NO;
        praiseLabel.textColor = [UIColor redColor];
        praiseImg.image = [UIImage imageNamed:@"praise2"];
    }
    
    [self initPraisePhoto];
    
    
}

- (void)initPraisePhoto
{
    for (UIView *view in oldPhotoView.subviews)
    {
        [view removeFromSuperview];
    }
    
//    NSLog(@"count = %d",self.praiseArr.count);
    
    if (IPHONE6 || IPHONE6PLUS)
    {
        if (self.praiseArr.count > 6)
        {
            arrowImg.hidden = NO;
            arrowBtn.hidden = NO;
        }
        else
        {
            arrowImg.hidden = YES;
            arrowBtn.hidden = YES;
        }
    }
    else
    {
        if (self.praiseArr.count > 5)
        {
            arrowImg.hidden = NO;
            arrowBtn.hidden = NO;
        }
        else
        {
            arrowImg.hidden = YES;
            arrowBtn.hidden = YES;
        }
    }
    
    for (int i = 0; i < self.praiseArr.count; i ++)
    {
        if (IPHONE6 || IPHONE6PLUS)
        {
            if (i == 6) {
                
                return;
            }
        }
        else
        {
            if (i == 5) {
                return;
            }
        }
 
        UIImageView *headPhotoImg = [[UIImageView alloc] initWithFrame:CGRectMake(IPHONE6 ? (40*i*(kScreenRate - 0.1)) : (40 * i * kScreenRate), 0, 33, 33)];
        headPhotoImg.layer.cornerRadius = 17.0f;
        headPhotoImg.layer.masksToBounds = YES;
        [oldPhotoView addSubview:headPhotoImg];
        
        HWClickZanConsumerModel *model = [item.topicPraiseArr objectAtIndex:i];
        NSURL *url;
        if (model.headUrl.length > 0)
        {
            url = [NSURL URLWithString:[Utility imageDownloadUrl:model.headUrl]];
        }
        else if (model.mongodbKey.length > 0)
        {
            url = [NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:model.mongodbKey]];
        }
        else
        {
            url = [NSURL URLWithString:@""];
        }
        
        __block UIImageView *blockImg = headPhotoImg;   //[Utility imageDownloadWithMongoDbKey:model.mongodbKey]
        [headPhotoImg setImageWithURL:url placeholderImage:[UIImage imageNamed:@"head_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (!error)
                blockImg.image = image;
            else
                blockImg.image = [UIImage imageNamed:@"head_placeholder"];
        }];
    }
}

/**
 *	@brief	点击箭头跳转下级的事件代理
 *
 *	@param 	sender 	btn
 *
 *	@return	nil
 */
- (void)arrowBtnClick:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(arrowClick)])
    {
        [delegate arrowClick];
    }
}


/**
 *	@brief	点击删选按钮的回调
 *
 *	@param 	sender 	btn
 *
 *	@return	nil
 */
- (void)selectBtnClick:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(siftClick)])
    {
        [delegate siftClick];
    }
}

/**
 *	@brief	点赞/取消点赞
 *
 *	@param 	sender 	btn
 *
 *	@return	nil
 */
- (void)praiseBtnClick:(id)sender
{
    if (self.chuanChuanMenCanNotHandle) //yes不可操作
    {
        return;
    }
    
    [MobClick event:@"click_neirongxiangqingzantong"]; //maidian_1.2.1
    UIButton *btn = (UIButton *)sender;
    if (btn.selected)
    {
        praiseNum --;
        praiseImg.image = [UIImage imageNamed:@"praise2"];
        praiseLabel.textColor = [UIColor redColor];
    }
    else
    {
        praiseNum ++;
        praiseImg.image = [UIImage imageNamed:@"praise2_ok"];
        praiseLabel.textColor = [UIColor whiteColor];
    }
    NSString *praiseNumStr = [NSString stringWithFormat:@"%d",praiseNum];
    if (praiseNum > 99) {
        praiseNumStr = @"99+";
    }
    praiseLabel.text = [NSString stringWithFormat:@"%@",praiseNumStr];
    btn.selected = !btn.selected;
    
    NSString *isPraise;
    if (btn.selected)
    {
//        [self praiseSuccess];
        item.commentCount = [NSString stringWithFormat:@"%d",item.commentCount.intValue + 1];
        isPraise = @"1";
    }
    else
    {
//        [self cancelPraise];
        item.commentCount = [NSString stringWithFormat:@"%d",item.commentCount.intValue - 1];
        isPraise = @"0";
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:isPraise forKey:@"isPraise"];
    [dict setPObject:[NSString stringWithFormat:@"%d",praiseNum] forKey:@"likeCount"];
    
    if (detailType == detailResourceNeighbour)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(changeLike:)])
        {
            [self.delegate changeLike:dict];
        }
    }
    else if (detailType == detailResourceChannel)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(changeLike:)])
        {
            [self.delegate changeLike:dict];
        }
    }
    
    
    
    //直接访问
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:item.cardID forKey:@"topicId"];
    [param setObject:[HWUserLogin currentUserLogin].userId forKey:@"userId"];
    [param setObject:(btn.selected ? @"1" : @"0") forKey:@"type"];
    [param setObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    
    if (![Utility isConnectionAvailable])
    {
        [[HWNetWorkManager currentManager] saveRequestWithParameters:param requestId:item.cardID];
        return;
    }
    
    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
    [manager POST:kPraise parameters:param queue:nil success:^(id responese) {
//        NSLog(@"praise responese = %@",responese);
        //刷新数据
        [delegate praiseBefore];
    } failure:^(NSString *code, NSString *error) {
//        NSLog(@"praise error = %@",error);
//        [Utility showToastWithMessage:error inView:self];
        
    }];
}

///**
// *	@brief	点赞成功动画
// *
// *	@return
// */
//- (void)praiseSuccess
//{
//    [UIView animateWithDuration:.2f animations:^{
//        oldPhotoView.frame = CGRectMake(40 * kScreenRate, 0, kScreenWidth - 85, 33);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:.2f animations:^{
//            newPhotoImg.frame = CGRectMake(0, 0, 33, 33);
//            [newPhotoImg setCenter:CGPointMake(17, 17)];
//        } completion:^(BOOL finished) {
//            newPhotoImg.frame = CGRectMake(0, 0, 33, 33);
//        }];
//    }];
//}
//
///**
// *	@brief	取消点赞
// *
// *	@return
// */
//- (void)cancelPraise
//{
//    //假如是已赞  点击取消  要删除自己的头像
//    
//    [UIView animateWithDuration:.2f animations:^{
//        newPhotoImg.frame = CGRectMake(17, 17, 0, 0);
//        newPhotoImg.center = CGPointMake(17, 17);
//    } completion:^(BOOL finished) {
//        newPhotoImg.frame = CGRectMake(17, 17, 0, 0);
//        [UIView animateWithDuration:.2f animations:^{
//            oldPhotoView.frame = CGRectMake(0, 0, kScreenWidth - 85, 33);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }];
//}

- (void)dealloc
{
    
}

@end
