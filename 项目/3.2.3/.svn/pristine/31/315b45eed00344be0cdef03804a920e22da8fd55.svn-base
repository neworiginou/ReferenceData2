//
//  MTCustomActionSheet.m
//  etonkids-iphone
//
//  Created by CaiJingPeng on 13-8-6.
//  Copyright (c) 2013年 wpf. All rights reserved.
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-27           选择日期时，按钮添加点击色，设置圆角

#import "MTCustomActionSheet.h"
#import "Define-OC.h"
#import "Partner_Swift-Swift.h"
@implementation MTCustomActionSheet
@synthesize delegate,buttons;
@synthesize datepicker;

#define rowNum 3        //一行显示几个

//- (id)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imgArr nameArray:(NSArray *)nameArr orientation:(UIInterfaceOrientation)orientation
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        // Initialization code
//        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
//        {
//            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 300);
//        }
//        else
//        {
//            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + (IOS7 ? 20 : 0));
//        }
//        
//        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
//        
//        int height = 285;
//        if (imgArr.count <= 4)
//        {
//            height = 178;
//        }
//        
//        UIControl *hideCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - height)];
//        hideCtrl.backgroundColor = [UIColor clearColor];
//        [hideCtrl addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:hideCtrl];
//        
//        
//        mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, height)];
//        mainView.backgroundColor = THEME_COLOR_BACKGROUND_1;
//        [self addSubview:mainView];
//        
//        count = imgArr.count;
//        
//        float marginTop = 20;
////        float marginLeft = 17.0f;
//        float marginLeft = 2 * 17.0f;
//        float imageSize = 55;
//        float gap = (kScreenWidth - 2 * marginLeft - 4 * imageSize) / 3.0f;
////        float gap = (kScreenWidth - 2 * marginLeft - 3 * imageSize) / 2.0f;
//        
//        for (int i = 0; i < imgArr.count; i++)
//        {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i]] forState:UIControlStateNormal];
//            [button setFrame:CGRectMake(i%4*96 + 35, marginTop + i/4 * 100, imageSize, imageSize)];
//            
//            if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
//            {
//                if(IPHONE5)
//                    button.frame=CGRectMake(i%4*96 +150, marginTop + i/3 * 100, imageSize, imageSize);
//                else
//                    button.frame=CGRectMake(i%4*96 +110, marginTop + i/3 * 100, imageSize, imageSize);
//            }
//            else
//            {
//                button.frame=CGRectMake(i%4*(imageSize + gap) + marginLeft, marginTop + i/4 * 100, imageSize, imageSize);
//            }
//            
//            button.tag = 777 + i;
//            [button addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
//            [mainView addSubview:button];
//            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 55, 30)];
////            if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
////                label.frame=CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30);
////            }else{
//            label.frame=CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height + 3, imageSize, 30);
////            }
//            label.text = [nameArr objectAtIndex:i];
//            label.font = [UIFont fontWithName:FONTNAME size:TITLE_FUBIAOTI_SIZE];
//            label.backgroundColor = [UIColor clearColor];
//            label.textColor = TITLE_COLOR_33;
//            label.tag = 888 + i;
//            label.lineBreakMode = NSLineBreakByWordWrapping;
//            label.numberOfLines = 0;
//            label.textAlignment = NSTextAlignmentCenter;
//            [mainView addSubview:label];
//        }
//        
//        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancelBtn setFrame:CGRectMake(0, 0, self.frame.size.width - 30, 45)];
//        cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:TITLE_BIG_SIZE];
//        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        cancelBtn.layer.borderColor = THEME_COLOR_LINE.CGColor;
//        cancelBtn.layer.borderWidth = 1.0f;
//        cancelBtn.layer.cornerRadius = 3.0f;
//        cancelBtn.layer.masksToBounds = YES;
////        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"bg_tanchuanghui.jpg"] forState:UIControlStateNormal];
//        [cancelBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:cancelBtn.frame.size] forState:UIControlStateNormal];
//        [cancelBtn setTitleColor:TITLE_COLOR_33 forState:UIControlStateNormal];
//        
//        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
//        {
//            [cancelBtn setCenter:CGPointMake((IPHONE5 ? 568 : 480) / 2,240)];
//        }
//        else
//        {
//            [cancelBtn setCenter:CGPointMake(self.frame.size.width / 2.0f, mainView.frame.size.height - 10 - cancelBtn.frame.size.height / 2.0f)];
//        }
//        
//        cancelBtn.tag = 777 + imgArr.count;
//        [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
//        [mainView addSubview:cancelBtn];
//        
////        [self reloadFrame:orientation];
//    }
//    return self;
//}
- (id)initWithFrame:(CGRect)frame andImageArr:(NSArray *)imgArr nameArray:(NSArray *)nameArr orientation:(UIInterfaceOrientation)orientation
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
        {
            self.frame = CGRectMake(0, 0, (IPHONE5 ? 568 : 480), 300);
        }
        else
        {
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + (IOS7 ? 20 : 0));
        }
        
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        
        int height = 285;
        if (imgArr.count <= rowNum)
        {
            height = 195;
        }
        
        UIControl *hideCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - height)];
        hideCtrl.backgroundColor = [UIColor clearColor];
        [hideCtrl addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideCtrl];
        
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, height)];
        //mainView.backgroundColor = THEME_COLOR_BACKGROUND_1;
        mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainView];
        
        count = imgArr.count;
        
        //MYP add v3.2修改
        UILabel *titleLabel = [UILabel newAutoLayoutView];
        titleLabel.textColor = TITLE_COLOR_33;
        titleLabel.font = [UIFont fontWithName:FONTNAME size:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"分享到";
        [mainView addSubview:titleLabel];
        [titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:mainView];
        [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:mainView];
        [titleLabel autoSetDimension:ALDimensionHeight toSize:57];
        
        CGFloat spacing = (kScreenWidth - 58 * imgArr.count) / (imgArr.count + 1);
        for (int i = 0; i < imgArr.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[imgArr objectAtIndex:i]] forState:UIControlStateNormal];
            //[button setFrame:CGRectMake(i%rowNum*96 + 35, 30 + i/rowNum * 100, 58, 58)];
            //MYP add v3.2修改
            [button setFrame:CGRectMake(i%rowNum*96 + 35, 57 + i/rowNum * 100, 58, 58)];
            
            if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
            {
                if(IPHONE5)
                    button.frame=CGRectMake(i%rowNum*96 +150, 30 + i/rowNum * 100, 58, 58);
                else
                    button.frame=CGRectMake(i%rowNum*96 +110, 30 + i/rowNum * 100, 58, 58);
            }
            else
            {
                //button.frame=CGRectMake(i%rowNum*(58*(kScreenWidth/320.0)+(kScreenWidth-80-rowNum*(58*(kScreenWidth/320.0)))/2.0) + 35, 30 + i/rowNum * 100, 58*(kScreenWidth/320.0), 58*(kScreenWidth/320.0));
                [button setFrame:CGRectMake(spacing + i % rowNum * (58 + spacing), 57 + i/rowNum * 100, 58, 58)];
            }
            
            button.tag = 777 + i;
            [button addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30)];
            label.frame=CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30);
            //            }
            label.text = [nameArr objectAtIndex:i];
            label.font = [UIFont fontWithName:FONTNAME size:14.0f];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = TITLE_COLOR_33;
            label.tag = 888 + i;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            [mainView addSubview:label];
        }
        
//        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancelBtn setFrame:CGRectMake(0, 0, self.frame.size.width - 30, 40)];
//        
//        [cancelBtn setFrame:CGRectMake(0, 0, self.frame.size.width - 30, 40)];
//        cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
//        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
////        [cancelBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] andSize:cancelBtn.frame.size] forState:UIControlStateNormal];
//        [cancelBtn setBackgroundImage:[Utility imageWithColor:[UIColor whiteColor] _size:cancelBtn.frame.size] forState:UIControlStateNormal];
//        [cancelBtn setTitleColor:TITLE_COLOR_33 forState:UIControlStateNormal];
//        
//        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
//        {
//            [cancelBtn setCenter:CGPointMake((IPHONE5 ? 568 : 480) / 2,240)];
//        }
//        else
//        {
//            [cancelBtn setCenter:CGPointMake(self.frame.size.width/2.0f,(imgArr.count > rowNum ? 250 : 160))];
//        }
//        cancelBtn.layer.borderWidth = 0.5f;
//        cancelBtn.layer.borderColor = TITLE_COLOR_99.CGColor;
//        cancelBtn.layer.cornerRadius = 4;
//        cancelBtn.layer.masksToBounds = YES;
//        cancelBtn.tag = 777 + imgArr.count;
//        [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
//        [mainView addSubview:cancelBtn];
        
        //        [self reloadFrame:orientation];
        
        //MYP add v3.2修改
        cancelBtn = [UIButton newAutoLayoutView];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:TITLE_COLOR_33 forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
        [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:cancelBtn];
        [cancelBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
        [cancelBtn autoSetDimension:ALDimensionHeight toSize:45];
        
        [cancelBtn drawTopLine];
    }
    return self;
}

/**
 *	@brief	有奖邀约自定义actionsheet初始化
 *
 *	@param 	frame 	父类初始化frame
 *	@param 	imgArr 	图片数组（非图片对象，图片名字）
 *	@param 	nameArr 	文字数组
 *	@param 	orientation 	方向
 *
 *	@return	N/A
 */
- (id)initWithFrame:(CGRect)frame picturesArray:(NSArray *)imgArr titleArray:(NSArray *)nameArr orientation:(UIInterfaceOrientation)orientation

{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (IPHONE5 ? 548 : 460) + (IOS7 ? 20 : 0));
        
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        
        int height = 135;
        if (imgArr.count < 4)
        {
            height = 195;
        }
        
        UIControl *hideCtrl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - height)];
        hideCtrl.backgroundColor = [UIColor clearColor];
        [hideCtrl addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:hideCtrl];
        
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, height)];
        mainView.backgroundColor = [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1];
        [self addSubview:mainView];
        
        count = imgArr.count;
        
        for (int i = 0; i<imgArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:i]] forState:UIControlStateNormal];
            
            [button setFrame:CGRectMake(i+i*106, 0, 106, 90)];
            [button setBackgroundColor:[UIColor whiteColor]];
            
            button.tag = 777 + i;
            [button addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:button];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((button.frame.size.width - 33) /2.0, 18, 33, 33)];
            imageV.image = [UIImage imageNamed:[imgArr objectAtIndex:i]];
            [button addSubview:imageV];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30)];
            //            if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            //                label.frame=CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30);
            label.frame=CGRectMake(button.center.x - 29, button.frame.size.height - 30, 58, 30);
            label.text = [nameArr objectAtIndex:i];
            label.font = [UIFont fontWithName:FONTNAME size:10.0f];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.tag = 888 + i;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            [mainView addSubview:label];
        }
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setFrame:CGRectMake(0, 91, self.frame.size.width, 44)];
        cancelBtn.titleLabel.font = [UIFont fontWithName:FONTNAME size:17.0f];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"bg_tanchuanghui.jpg"] forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        cancelBtn.tag = 777 + imgArr.count;
        [cancelBtn addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:cancelBtn];
        
        //        [self reloadFrame:orientation];
    }
    return self;
}



- (id)initWithTitle:(NSString *)title delegate:(id<MTCustomActionSheetDelegate>)myDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        
        NSMutableArray* arrays = [NSMutableArray array];
        
        va_list argList;
        
        if (otherButtonTitles) {
            [arrays addObject:otherButtonTitles];
            va_start(argList, otherButtonTitles);
            
            NSString *arg;
            while ((arg = va_arg(argList, NSString *))) {
                
                if (arg) {
                    //                    NSString *str=[NSString stringWithFormat:@"%@",arg];
                    [arrays addObject:arg];
                }
            }
            va_end(argList);
            
        }
        
        if (cancelButtonTitle != nil) {
            [arrays addObject:cancelButtonTitle];
        }
        
        self.delegate = myDelegate;
        
        self.buttons = arrays;
        
        mainView = [[UIView alloc] initWithFrame:CGRectZero];
        mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainView];
        
        int h = 10; // 计算高度.
        
        if (title != nil)
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, [UIScreen mainScreen].bounds.size.width - 50, 30)];
            titleLabel.text = title;
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [mainView addSubview:titleLabel];
            
            h += 30;
        }
        
        for (int i = 0;i < self.buttons.count;i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[self.buttons objectAtIndex:i] forState:UIControlStateNormal];
            
            if (cancelButtonTitle != nil && i == self.buttons.count - 1)
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"cancelDeep.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"loginBtn.png"] forState:UIControlStateNormal];
            }
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(30, h + 10 + (40 + (i == self.buttons.count - 1 ? 13 : 10)) * i, [UIScreen mainScreen].bounds.size.width - 60, 45)];
            btn.tag = 777 + i;
            [btn addTarget:self action:@selector(doClick:) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:btn];
        }
        
        mainView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, h + self.buttons.count * 50 + 10 + 13);
        
    }
    return self;
}



- (id)initWithDatePicker:(NSDate *)date
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, [UIScreen mainScreen].bounds.size.width, 216 + 40)];
//        mainView.backgroundColor = CELLCOLOR;
        mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainView];
//        [mainView release];
        
        
        datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 216)];
        datepicker.datePickerMode = UIDatePickerModeDate;
        datepicker.date = date;
        [mainView addSubview:datepicker];

        
        NSArray *arr = [NSArray arrayWithObjects:@"取消",@"确定", nil];
        for (int i = 0; i < 2; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //[btn setBackgroundColor:CD_MainColor];
            [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.frame = CGRectMake(10 + i*([UIScreen mainScreen].bounds.size.width - 50 - 20), 5, 50, 30);
            btn.tag = 777 + i;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 3.0f;
            [btn addTarget:self action:@selector(doClickByDatePicker:) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:btn];
            if(i == 0)
            {
                [btn setBackgroundImage:[Utility imageWithColor:CD_Btn_GrayColor _size:CGSizeMake(50, 30)] forState:UIControlStateNormal];
                [btn setBackgroundImage:[Utility imageWithColor:CD_Btn_GrayColor_Clicked _size:CGSizeMake(50, 30)] forState:UIControlStateNormal];
            }
            else
            {
                [btn setBackgroundImage:[Utility imageWithColor:CD_Btn_MainColor _size:CGSizeMake(50, 30)] forState:UIControlStateNormal];
                [btn setBackgroundImage:[Utility imageWithColor:CD_Btn_MainColor_Clicked _size:CGSizeMake(50, 30)] forState:UIControlStateNormal];
            }
        }
    }
    
    return self;
}

-(id)initWithSRMonthPicker:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        
        UIControl *cancelControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 216 - 40)];
        cancelControl.backgroundColor = [UIColor clearColor];
        [cancelControl addTarget:self action:@selector(doCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelControl];
        
        
        mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, [UIScreen mainScreen].bounds.size.width, 216 + 40)];
        mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainView];
        //        [mainView release];
        
        
        monthDatePicker = [[SRMonthPicker alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 216)];
        monthDatePicker.date = date;
        monthDatePicker.maximumYear = @2020;
        monthDatePicker.minimumYear = @1900;
        monthDatePicker.yearFirst = YES;
        [mainView addSubview:monthDatePicker];
        //        [datepicker release];
        
        NSArray *arr = [NSArray arrayWithObjects:@"取消",@"确定", nil];
        for (int i = 0; i < 2; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if ([arr[i]  isEqual: @"取消"])
            {
                [btn setBackgroundColor:[UIColor grayColor]];

            }
            else
            {
                [btn setBackgroundColor:CD_MainColor];
            }

            
            //            [btn setBackgroundImage:[UIImage imageNamed:@"loginBtn.png"] forState:UIControlStateNormal];
            //            btn.backgroundColor = [UIColor colorWithRed:101/255.0f green:184/255.0f blue:206/255.0f alpha:1.0];
            [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.frame = CGRectMake(10 + i*([UIScreen mainScreen].bounds.size.width - 50 - 20), 5, 50, 30);
            btn.tag = 777 + i;
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds  =true;
            [btn addTarget:self action:@selector(doClickByMonthDatePicker:) forControlEvents:UIControlEventTouchUpInside];
            [mainView addSubview:btn];
        }

    }
    return self;
}

- (void)doCancel:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        mainView.frame = CGRectMake(0,
                                    (IPHONE5 ? 548 : 460) + mainView.frame.size.height,
                                    [UIScreen mainScreen].bounds.size.width,
                                    mainView.frame.size.height);
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        mainView.frame = CGRectMake(0,
                                    view.frame.size.height - mainView.frame.size.height,
                                    view.frame.size.width,
                                    mainView.frame.size.height);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)doClick:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(actionSheet:didClickButtonByIndex:)])
    {
        [delegate actionSheet:self didClickButtonByIndex:sender.tag%777];
    }

    [self doCancel:nil];
}

- (void)doClickByDatePicker:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(actionSheet:didClickButtonByIndex:selectDate:)]) {
        [delegate actionSheet:self didClickButtonByIndex:sender.tag%777 selectDate:datepicker.date];
    }
    [self doCancel:nil];
}

//年月时间选择气回调
- (void)doClickByMonthDatePicker:(UIButton *)sender
{
    if (sender.tag%777 == 1)
    {
        if (delegate && [delegate respondsToSelector:@selector(actionSheet:didClickButtonByIndex:selectMonthDate:)])
        {
            NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([monthDatePicker.date timeIntervalSinceReferenceDate] + 24*3600)];
//            NSLog(@"date ======= %@",newDate);
            [delegate actionSheet:self didClickButtonByIndex:sender.tag%777 selectMonthDate:newDate];
        }
    }

    [self doCancel:nil];
}

- (void)reloadFrame:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        self.frame = CGRectMake(0, 0, (IPHONE5 ? 568 : 480), 300);
        mainView.frame = CGRectMake(0, self.frame.size.height - 285, self.frame.size.width, 285);
        
        
        //     [button setFrame:CGRectMake(i%3*96 + 35, 30 + i/3 * 100, 58, 58)];
        //  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30)];
        
        for (int i=0; i<count; i++) {
            UIButton *button=(UIButton *)[mainView viewWithTag:i+777];
            
            UILabel *label=(UILabel *)[mainView viewWithTag:i+888];
            
            
            if(IPHONE5)
                button.frame=CGRectMake(i%4*96 +150, 30 + i/4 * 100, 58, 58);
            else
                button.frame=CGRectMake(i%4*96 +110, 30 + i/4 * 100, 58, 58);
            
            label.frame=CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30);
            
        }
        
        [cancelBtn setCenter:CGPointMake((IPHONE5 ? 568 : 480) / 2,240)];
        
    }else{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        mainView.frame = CGRectMake(0, self.frame.size.height - 285, self.frame.size.width, 285);
        
        for (int i=0; i<count; i++) {
            UIButton *button=(UIButton *)[mainView viewWithTag:i+777];
            button.frame=CGRectMake(i%4*96 + 35, 30 + i/4 * 100, 58, 58);
            UILabel *label=(UILabel *)[mainView viewWithTag:i+888];
            label.frame=CGRectMake(button.center.x - 29, button.frame.origin.y + button.frame.size.height, 58, 30);
        }
        
        [cancelBtn setCenter:CGPointMake(160,240)];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
