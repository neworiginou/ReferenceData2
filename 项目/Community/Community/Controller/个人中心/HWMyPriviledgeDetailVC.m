//
//  HWMyPriviledgeDetailVC.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWMyPriviledgeDetailVC.h"
#import "HWGeneralControl.h"

@interface HWMyPriviledgeDetailVC ()

@end

@implementation HWMyPriviledgeDetailVC
@synthesize priviledgeNum;

- (void)viewDidLoad
{
    [super viewDidLoad];
     noActivityTimeTV.hidden = NO;
    self.navigationItem.titleView = [Utility navTitleView:@"优惠券详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = nil;
    self.view.backgroundColor = BACKGROUND_COLOR;
    
//    [self createHeaderView];
//    [self createFooterView];
}

-(void)createActivityTime:(UIImageView *)priviledgeIV headerView:(UIView *)headerView
{
    
}

//创建没有活动倒计时的View
-(void)createNoActivity:(UIImageView *)noActivityTime headerView:(UIView *)headerViewTemp
{
    noActivityTimeTV = [HWGeneralControl createView:CGRectMake(0, CGRectGetMaxY(noActivityTime.frame), kScreenWidth, 40)];
   
    noActivityTimeTV.backgroundColor = [UIColor clearColor];
    [headerViewTemp addSubview:noActivityTimeTV];
    
    UILabel *priviledgeTicketNumLabelTemp = [HWGeneralControl createLabel:CGRectMake(15, kPriviledgeDetailTop,40, 16) font:14.0 textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_SMOKE];
    priviledgeTicketNumLabelTemp.text = @"券号: ";
    [noActivityTimeTV addSubview:priviledgeTicketNumLabelTemp];
    
    priviledgeTicketLabel = [HWGeneralControl createLabel:CGRectMake(CGRectGetMaxX(priviledgeTicketNumLabelTemp.frame), kPriviledgeDetailTop, 300, 16) font:14.0 textAligment:NSTextAlignmentLeft labelColor:THEME_COLOR_TEXT];
    priviledgeTicketLabel.text = @"";
    [noActivityTimeTV addSubview:priviledgeTicketLabel];
    [self drawDottedLine];
    [self queryListData:priviledgeId];
    
}
//画虚线
-(void)drawDottedLine
{
    UIImageView *lineImageV = [HWGeneralControl createImageView:CGRectMake(12,noActivityTimeTV.frame.size.height-0.5, kScreenWidth-2*12, 1) image:@""];
    lineImageV.backgroundColor = [UIColor whiteColor];
    [noActivityTimeTV addSubview:lineImageV];
    
    UIGraphicsBeginImageContext(lineImageV.frame.size);   //开始画线
    [lineImageV.image drawInRect:CGRectMake(0, 0, lineImageV.frame.size.width, lineImageV.frame.size.height)];
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {2,1};
    CGContextSetStrokeColorWithColor(context, THEME_COLOR_TEXT.CGColor);
    
    CGContextSetLineDash(context, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(context, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(context, kScreenWidth-10, 0.0);
    CGContextStrokePath(context);
    lineImageV.image = UIGraphicsGetImageFromCurrentImageContext();
    CGContextClosePath(context);
}
-(void)createFooterView
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)queryListData:(NSString *)priviledgeIdStr
{
    HWUserLogin *user = [HWUserLogin currentUserLogin];
    [Utility hideMBProgress:self.view];
    [Utility showMBProgress:self.view message:@"请求数据"];
    HWHTTPRequestOperationManager *manage = [HWHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setPObject:user.key forKey:@"key"];
    [dict setPObject:priviledgeIdStr forKey:@"couponId"];
    
    [manage POST:kPriviledgeDetail parameters:dict queue:nil success:^(id responseObject) {
        [Utility hideMBProgress:self.view];
        NSDictionary *respDic = (NSDictionary *)[responseObject dictionaryObjectForKey:@"data"];
        priviledgeModel = [[HWPriviledgeDetailModel alloc]initWithDic:respDic];
        _priviledgeModel = priviledgeModel;
        [self refershUI:priviledgeModel];
    } failure:^(NSString *code, NSString *error) {
        NSLog(@"error %@",error);
        [Utility hideMBProgress:self.view];
        [Utility showToastWithMessage:error inView:self.view];
        self.priviledgeIV.image = [UIImage imageNamed:IMAGE_PLACE];
    }];
}
-(void)refershUI:(HWPriviledgeDetailModel*)priviledgeModelTemp
{
    //start
    __weak UIImageView *blockImgV = self.priviledgeIV;
    [self.priviledgeIV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:priviledgeModelTemp.priviledgeImageUrl]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
    //end

    if ([priviledgeModel.priviledgeUrl length]!=0) {
        [self followRecordContent:[NSString stringWithFormat:@"共%@张剩%@张",priviledgeModel.totalPriviledge,priviledgeModel.remainPriviledge]];
        brandLabel.textColor = THEME_COLOR_ORANGE;
        
        NSRange contentRange = {0,[_priviledgeModel.brandStr length]};
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_priviledgeModel.brandStr];
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        brandLabel.attributedText = content;
    }
    else
    {
        priviledgeTicketNumLabel.text = [NSString stringWithFormat:@"共%@张剩%@张",priviledgeModel.totalPriviledge,priviledgeModel.remainPriviledge];
        noPriviledgeTicketNumLabel.text = [NSString stringWithFormat:@"共%@张剩%@张",priviledgeModel.totalPriviledge,priviledgeModel.remainPriviledge];
        brandLabel.textColor = THEME_COLOR_TEXT;
        brandLabel.text = _priviledgeModel.brandStr;
    }
    if ([brandLabel.text length]==0)
    {
        shopLabel.hidden = YES;
    }
    priviledgeLabel.text = priviledgeModelTemp.priviledgeContent;
    if ([priviledgeModelTemp.starTime length]!=0) {
         startDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModelTemp.starTime];
    }
    if ([priviledgeModelTemp.endTime length]!=0) {
        endDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModelTemp.endTime];
    }
    startDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModelTemp.starTime];
    
    endDateLabel.text = [Utility getTimeWithTimestamp:priviledgeModelTemp.endTime];
    CGRect factualRect =  [HWGeneralControl returnLabelFactualSize:startDateLabel font:13];
    
    [startDateLabel setFrame:CGRectMake(72, CGRectGetMaxY(priviledgeLabel.frame)+5, factualRect.size.width, 13)];
    [toLabel setFrame:CGRectMake(CGRectGetMaxX(startDateLabel.frame)+2, CGRectGetMaxY(priviledgeLabel.frame)+5, 12, 13)];
    [endDateLabel setFrame:CGRectMake(CGRectGetMaxX(toLabel.frame)+2, CGRectGetMaxY(priviledgeLabel.frame)+5, factualRect.size.width, 13)];
    priviledgeTicketLabel.text = priviledgeNum;
    [priviledgeDetailTableV reloadData];
}
//tableview代理方法
#pragma - mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PriviledgeDetailIdentifier";
    HWPriviledgeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HWPriviledgeDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];

    int row = (int)indexPath.row;
    [cell setPriviledgContent:[priviledgeModel.ruleArry objectAtIndex:row]];
    ;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [HWGeneralControl createView:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = [UIColor whiteColor];
    return  headerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [HWGeneralControl createView:CGRectMake(0, 0, kScreenWidth, 10)];
    footerView.backgroundColor = [UIColor whiteColor];
    return  footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ruleStr = [priviledgeModel.ruleArry objectAtIndex:indexPath.row];
    CGSize labelSize = [ruleStr sizeWithFont:[UIFont systemFontOfSize:13.0]
                           constrainedToSize:CGSizeMake(kScreenWidth-27, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];
    return  labelSize.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [priviledgeModel.ruleArry count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}


//跳转商家链接
-(void)businessUrl:(id)sender
{
    [MobClick event:@"click_shangjiamingcheng"];
    [MobClick event:@"click_qianwangchakan"];
    if([_priviledgeModel.priviledgeUrl length]>0)
    {
        NSURL *url;
        if (!([_priviledgeModel.priviledgeUrl rangeOfString:@"http://"].location == NSNotFound)) {
             url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_priviledgeModel.priviledgeUrl]];
        }
        else
        {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_priviledgeModel.priviledgeUrl]];
        }
        [[UIApplication sharedApplication] openURL:url];
    }
    
}
//赋值
-(void)followRecordContent:(NSString *)str
{
    NSAttributedString *contentStr = [self setStringdiffrentColor:str color:THEME_COLOR_ORANGE contentStr:@"剩"];
    [priviledgeTicketNumLabel setAttributedText:contentStr];
    [noPriviledgeTicketNumLabel setAttributedText:contentStr];
}
//修改字体颜色
-(NSMutableAttributedString *)setStringdiffrentColor:(NSString *)str color:(UIColor *)color contentStr:(NSString *)contentStr
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range=[str rangeOfString:contentStr];
    int length = (int)[str length]-2 - (int)range.location;
    NSRange newRange = NSMakeRange(range.location+1, length);
    
    [string addAttribute:NSForegroundColorAttributeName value:color range:newRange];
    
    return string;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
