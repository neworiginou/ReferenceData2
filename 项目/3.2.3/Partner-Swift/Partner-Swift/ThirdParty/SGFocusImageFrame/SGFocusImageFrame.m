//
//  SGFocusImageFrame.m
//  SGFocusImageFrame
//
//  Created by Shane Gao on 17/6/12.
//  Copyright (c) 2012 Shane Gao. All rights reserved.
//

#import "SGFocusImageFrame.h"
#import <objc/runtime.h>
#import "Define-OC.h"
#import "UIImageView+WebCache.h"
#import "Partner_Swift-Swift.h"
static const void *SG_FOCUS_ITEM_ASS_KEY = &SG_FOCUS_ITEM_ASS_KEY;

#define HEIGHT_OF_PAGE_CONTROL 20.f

#pragma mark - SGFocusImageItem Definition
@implementation SGFocusImageItem
- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag type:(NSString *)atype id:(NSString * )aId
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.image = image;
        self.tag = tag;
        self.type = atype;
        self.aId = aId;
    }
    return self;
}

+ (id)itemWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag type:(NSString *)atype id:(NSString * )aId
{
    return [[SGFocusImageItem alloc] initWithTitle:title image:image tag:tag type:atype id:aId];
}

@end
@implementation SGRobItem
- (id)initWithHouseId:(NSString *)houseIdTemp
{
    self = [super init];
    if (self)
    {
        self.houseId = houseIdTemp;
    }
    return self;
}
+ (id)itemWithHouseId:(NSString *)houseId
{
    return [[SGRobItem alloc]initWithHouseId:houseId];
}


@end
#pragma mark - SGFocusImageFrame Definition

@interface SGFocusImageFrame ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation SGFocusImageFrame
@synthesize customerNumLabel;
- (void)dealloc
{
    objc_setAssociatedObject(self, SG_FOCUS_ITEM_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)initWithFrame:(CGRect)frame delegate:(id<SGFocusImageFrameDelegate>)delegate focusImageItemsArrray:(NSArray *)items detailarr:(NSArray *)detailArry
{
    self = [super initWithFrame:frame];
    if (self) {
        objc_setAssociatedObject(self, SG_FOCUS_ITEM_ASS_KEY, items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = delegate;
        self.detailArr  = detailArry;
        [self initImageFrame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
           delegate:(id<SGFocusImageFrameDelegate>)delegate
    focusImageItems:(SGFocusImageItem *)firstItem, ...
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *imageItems = [NSMutableArray array];  
        SGFocusImageItem *eachItem;
        va_list argumentList;
        if (firstItem) {
            [imageItems addObject: firstItem];
            va_start(argumentList, firstItem);       
            while((eachItem = va_arg(argumentList, SGFocusImageItem *))) {
                [imageItems addObject: eachItem];            
            }
            va_end(argumentList);
        }
        objc_setAssociatedObject(self, SG_FOCUS_ITEM_ASS_KEY, imageItems, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = delegate;
        [self initImageFrame];
    }
    return self;
}

- (void)initImageFrame
{
    [self initParameters];
    [self setupViews];
}

#pragma mark - private methods

- (void)initParameters
{
    self.switchTimeInterval = 10.f;
    self.autoScrolling = YES;
}

- (void)setupViews
{
    CGFloat mainWidth = self.frame.size.width, mainHeight = self.frame.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, mainWidth, mainHeight - HEIGHT_OF_PAGE_CONTROL)];
    
    CGSize size = CGSizeMake(20.0f, HEIGHT_OF_PAGE_CONTROL);
    CGRect pcFrame = CGRectMake(mainWidth - size.width-15, mainHeight - size.height-90, size.width, size.height);
    if (IPHONE6PLUS)
    {
        pcFrame = CGRectMake(mainWidth - size.width-15, mainHeight - size.height-100, size.width, size.height);
    }
    else if(IPHONE6)
    {
        pcFrame = CGRectMake(mainWidth - size.width-15, mainHeight - size.height-100, size.width, size.height);
    }
    else if(IPHONE6PLUSFangda)
    {
        pcFrame = CGRectMake(mainWidth - size.width-15, mainHeight - size.height-100, size.width, size.height);
    }
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:pcFrame];
    [pageControl addTarget:self action:@selector(pageControlTapped:) forControlEvents:UIControlEventTouchUpInside];
   
    
    /*
    scrollView.layer.cornerRadius = 10;
    scrollView.layer.borderWidth = 1 ;
    scrollView.layer.borderColor = [[UIColor lightGrayColor ] CGColor];
     */
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.layer.cornerRadius = 10.0f;
    scrollView.layer.masksToBounds = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceHorizontal = YES;
    
    pageControl.currentPage = 0;
   
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.delegate = self;
    [scrollView addGestureRecognizer:tapGestureRecognize];
    
    NSArray *imageItems = objc_getAssociatedObject(self, SG_FOCUS_ITEM_ASS_KEY);
    pageControl.numberOfPages = imageItems.count;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    CGSize scrollViewSize = scrollView.frame.size;
    UIImageView *imageView;
    UIImageView * backImage;
   
  //  NSArray * arr = [[NSArray alloc]initWithObjects:@"我是你的小苹果",@"我好饿呀",@"789", nil];
  
    UILabel * detailLable;
    for (int i = 0; i < imageItems.count; i++)
    {
        SGFocusImageItem *item = [imageItems objectAtIndex:i];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollViewSize.width, 0.f, scrollViewSize.width, 180)];
        detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10,0, scrollViewSize.width, 40)];
        backImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*scrollViewSize.width, 180-40, scrollViewSize.width, 40)];
        if (IPHONE6PLUS)
        {
            imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, 250);
            backImage.frame = CGRectMake(backImage.frame.origin.x, 250-40, backImage.frame.size.width, 40);
           // detailLable.frame = CGRectMake(detailLable.frame.origin.x, 250-50, detailLable.frame.size.width, 40);

           
        }
        else if (IPHONE6)
        {
            imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, 220);
             backImage.frame = CGRectMake(backImage.frame.origin.x, 220-40, backImage.frame.size.width, 40);
          //  detailLable.frame = CGRectMake(detailLable.frame.origin.x, 220-50, detailLable.frame.size.width, 40);
            // detailLable.frame = CGRectMake(10, 10, 200, 40);

          

        }
        else if(IPHONE6PLUSFangda)
        {
            imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, 250);
            backImage.frame = CGRectMake(backImage.frame.origin.x, 250-40, backImage.frame.size.width, 40);
            //detailLable.frame = CGRectMake(detailLable.frame.origin.x, 250-50, detailLable.frame.size.width, 40);
          

        }
        detailLable.textColor = [UIColor whiteColor];
        detailLable.font = [UIFont systemFontOfSize:15];
        if (self.detailArr.count > 0) {
             detailLable.text = self.detailArr[i];
        }
       
       
       // backImage.backgroundColor  = [UIColor colorWithWhite:0 alpha:0.6];
        backImage.image = [UIImage imageNamed:@"mask_"];
       // NSString *url = [Utility getConsultUrl];
        NSString *imageUrl = [NSString stringWithFormat:@"%@",item.image];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"ic_empty.png"] options:SDWebImageProgressiveDownload];
        
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:scrollView];
       
        [scrollView addSubview:imageView];
        [scrollView addSubview:backImage];
       // [scrollView bringSubviewToFront:backImage];
        [backImage addSubview:detailLable];
        [self addSubview:pageControl];
        [self bringSubviewToFront:pageControl];
    }
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.layer.cornerRadius = 10.0f;
    backBtn.layer.masksToBounds = YES;
    backBtn.frame = CGRectMake(0, imageView.frame.size.height, scrollViewSize.width, scrollViewSize.height-imageView.frame.size.height);
    [self addSubview:backBtn];
    //增加抢客标题以及抢客按钮
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,imageView.frame.size.height+15,100, 20)];
    if(IPHONE6)
    {
        titleLabel.frame = CGRectMake(15,imageView.frame.size.height+15,100, 20);
    }
    else if(IPHONE6PLUS)
    {
        titleLabel.frame = CGRectMake(15,imageView.frame.size.height+15,100, 20);
    }
    else if(IPHONE6PLUSFangda)
    {
        titleLabel.frame = CGRectMake(15,imageView.frame.size.height+15,100, 20);
    }
    
    
    if(IPHONE5)
    {
        titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
   
    else
    {
        titleLabel.font = [UIFont systemFontOfSize:22.0f];

        
    }
     titleLabel.text = @"今日释放";
    titleLabel.textColor = TITLE_COLOR_33;
    
    [self addSubview:titleLabel];
    
    
    customerNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, imageView.frame.size.height+15+20, 110, 30)];
    if(IPHONE6)
    {
        customerNumLabel.frame = CGRectMake(15, imageView.frame.size.height+15+5+10+10, 110, 30);
    }
    else if(IPHONE6PLUS)
    {
         customerNumLabel.frame = CGRectMake(15, imageView.frame.size.height+10+5+15+10, 110, 30);
    }
    if (IPHONE5) {
        customerNumLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    customerNumLabel.textColor = [UIColor blackColor];
  //  customerNumLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:30.0];
//    NSString * str = @"客户 0";
//    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:str];
//    NSRange rang = NSMakeRange(3, 1);
//    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIFont fontWithName:@"Helvetica Neue" size:30.0] range:rang];
//    customerNumLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:customerNumLabel];
    //房源
    self.houseLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, imageView.frame.size.height+15+10+10, 110, 30)];
    if(IPHONE6)
    {
        self.houseLabel.frame = CGRectMake(130, imageView.frame.size.height+15+5+10+10, 110, 30);
    }
    else if(IPHONE6PLUS)
    {
        self.houseLabel.frame = CGRectMake(130, imageView.frame.size.height+15+5+10+10, 110, 30);
    }
    if (IPHONE5) {
        self.houseLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    self.houseLabel.textColor = [UIColor blackColor];
    //self.houseLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:30.0];

//    NSString * str1 = @"房源 0";
//    NSMutableAttributedString * attributeStr1 = [[NSMutableAttributedString alloc]initWithString:str1];
//    NSRange rang1 = NSMakeRange(3, 1);
//    [attributeStr1 addAttribute:NSForegroundColorAttributeName value:[UIFont fontWithName:@"Helvetica Neue" size:30.0] range:rang1];
//
//    self.houseLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.houseLabel];
    

    
    
    UIButton *robBtn = [[UIButton alloc]initWithFrame:CGRectMake(scrollViewSize.width-25-70,5+scrollView.frame.origin.x+imageView.frame.size.height+10, 70, 40)];
    if (IPHONE6)
    {
        robBtn.frame = CGRectMake(scrollViewSize.width-25-70,3.5+scrollView.frame.origin.x+imageView.frame.size.height+15, 70, 40);
    }
    else if(IPHONE6PLUS)
    {
        robBtn.frame = CGRectMake(scrollViewSize.width-25-70,3.5+scrollView.frame.origin.x+imageView.frame.size.height+15, 70, 40);
    }
    else if(IPHONE6PLUSFangda)
    {
        robBtn.frame = CGRectMake(scrollViewSize.width-25-70,3.5+scrollView.frame.origin.x+imageView.frame.size.height+15, 70, 40);

    }
    robBtn.backgroundColor = THEME_COLOR_RED_NORMAL;
    [robBtn setTitle:@"抢" forState:UIControlStateNormal];
    [robBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    robBtn.layer.cornerRadius = 3.0f;
    robBtn.layer.masksToBounds = YES;
    [robBtn addTarget:self action:@selector(robCustomer:) forControlEvents:UIControlEventTouchUpInside];
    [robBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:robBtn];

    scrollView.contentSize = CGSizeMake(scrollViewSize.width * imageItems.count, mainHeight - HEIGHT_OF_PAGE_CONTROL);
    self.scrollView = scrollView;
    self.pageControl = pageControl;
    self.pageControl.frame = CGRectMake(self.pageControl.frame.origin.x, pageControl.frame.origin.y, pageControl.frame.size.width, pageControl.frame.size.height);
    [self bringSubviewToFront:pageControl];
}
-(void)robCustomer:(id)sender
{
//    UIButton *button = (UIButton *)sender;
//    NSLog(@"第几个楼盘%ld",button.tag);
    if ([_delegate respondsToSelector:@selector(commeInRob:)])
    {
        [_delegate commeInRob:nil];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Actions

- (void)pageControlTapped:(id)sender
{
    UIPageControl *pc = (UIPageControl *)sender;
    [self moveToTargetPage:pc.currentPage];
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    int targetPage = (int)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    NSArray *imageItems = objc_getAssociatedObject(self, SG_FOCUS_ITEM_ASS_KEY);
    if (targetPage > -1 && targetPage < imageItems.count) {
        SGFocusImageItem *item = [imageItems objectAtIndex:targetPage];
        //delegate 
        if (_delegate && [_delegate respondsToSelector:@selector(foucusImageFrame:didSelectItem:)]) {
            [_delegate foucusImageFrame:self didSelectItem:item];
        }
        
        //block
        if (_didSelectItemBlock) {
            _didSelectItemBlock(item);
        }
    }
}

#pragma mark - ScrollView MOve

- (void)moveToTargetPage:(NSInteger)targetPage
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    CGFloat targetX = targetPage * self.scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:self.switchTimeInterval];
}

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    
    CGFloat targetX = self.scrollView.contentOffset.x + self.scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    
    if (self.autoScrolling)
    {
        [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:self.switchTimeInterval];
    }
}

- (void)moveToTargetPosition:(CGFloat)targetX
{
    //NSLog(@"moveToTargetPosition : %f" , targetX);
    if (targetX >= self.scrollView.contentSize.width) {
        targetX = 0.0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    self.pageControl.currentPage = (int)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
}

- (void)setAutoScrolling:(BOOL)enable
{
    _autoScrolling = enable;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
    if (_autoScrolling)
    {
         [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:self.switchTimeInterval];
    }
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

@end
