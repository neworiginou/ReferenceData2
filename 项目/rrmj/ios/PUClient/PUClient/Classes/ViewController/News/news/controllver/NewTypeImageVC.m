//
//  NewTypeImageVC.m
//  PUClient
//
//  Created by RRLhy on 15/8/12.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "NewTypeImageVC.h"
#import "MLPictureBrowser.h"
#import "NewsImageApi.h"
#import "NewsDetailModel.h"
@interface NewTypeImageVC ()<MLPictureBrowserDelegate>

@end

@implementation NewTypeImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navImage.image = [UIImage stretchImageWithName:@"nav_bg_black"];
    
    MLPictureBrowser *mvc = [[MLPictureBrowser alloc]init];
    mvc.delegate = self;
    NSArray *array = @[
                       @"http://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/50da81cb39dbb6fd1d515a2b0b24ab18972b37b0.jpg",
                       @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=d0f37d60fa1986184147e8847ed52f73/a1ec08fa513d26973a06f05c57fbb2fb4216d8de.jpg",
                       @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=a0e078ee552c11dfded1b823571f63d0/eaf81a4c510fd9f91513ea64272dd42a2834a4b3.jpg",
                       @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=091af36f9a22720e7bcee5fa4ff30b46/5243fbf2b2119313b093a9bd67380cd790238dee.jpg",
                       @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=d8a403cd1c178a82ce3c78a0c23b728d/63d9f2d3572c11dff36e4622612762d0f703c270.jpg",
                       @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=93cf6adecc1b9d168ac79d61c7e6b48f/a71ea8d3fd1f41347203fd7f271f95cad1c85eff.jpg",
                       @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=aa593826bc096b6381195950380b8744/0dd7912397dda1440d2b93bbb0b7d0a20cf4869d.jpg",
                       @"http://g.hiphotos.baidu.com/image/w%3D2048/sign=6f0576085e6034a829e2bf81ff2b4854/71cf3bc79f3df8dc27207098cf11728b4710289e.jpg",
                       
                       ];
    NSArray *titleArray = @[
                            @"不错啊",
                            @"测试延迟 double delayInSeconds = 1  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTimedispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ ",
                            @"good",
                            @"水电费http://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/50da81cb39dbb6fd1d515a2b0b24ab18972b37b0.jpghttp://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/.jpghttp://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/.jpghttp://h.hiphotos.baidu.com/image/%3D204sign=e7e477224334970a4773172fa1f2d0c8/.jpg",
                            @"阿斯蒂芬",
                            @"中国http://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/50da81cb39dbb6fd1d515a2b0b24ab18972b37b0.jpghttp://h.hiphotos.baidu.com/image/w%3D2048/sign=e7e477224334970a4773172fa1f2d0c8/50da81cb39dbb6fd1d515a2b0b24ab18972b37b0.jpg",
                            //                       @"http://a.hiphotos.baidu.com/image/w%3D2048/sign=aa593826bc096b6381195950380b8744/0dd7912397dda1440d2b93bbb0b7d0a20cf4869d.jpg",
                            //                       @"http://g.hiphotos.baidu.com/image/w%3D2048/sign=6f0576085e6034a829e2bf81ff2b4854/71cf3bc79f3df8dc27207098cf11728b4710289e.jpg",
                            @" ",
                            @" "];
   
    
//    [mvc showWithPictureURLs:array atIndex:1];
//    [mvc showWithPictureURLs:array withTextArray:titleArray atIndex:2];
//    [mvc showWithPictureURLs:array withTextArray:titleArray WithcommentNum:@"评论" atIndex:2 at];
//
    mvc.superView = self.view;
//    [mvc showWithPictureURLs:array withTextArray:titleArray WithcommentNum:@"评论" atIndex:2];
    [self requestData];
}

- (void)requestData
{
    
    NewsImageApi * api = [[NewsImageApi alloc]initWithInfoId:self.infoModel.ID userID:[UserInfoConfig sharedUserInfoConfig].userInfo.Id];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary * dic = request.responseJSONObject;
        if (dic) {
            JsonModel * json = [JsonModel objectWithKeyValues:dic];
            
            if (json.code == SUCCESSCODE) {
                
                NSDictionary * info = json.data[@"info"];
                NewsDetailModel * model = [NewsDetailModel objectWithKeyValues:info];
                
//                [relateView configureWithSeries:model.seriesViewList stars:model.actorViewList];
            }else{
                
                [IanAlert alertError:json.msg length:TIMELENGTH];
            }
            
        }else{
            
            [IanAlert alertError:ERRORMSG1 length:TIMELENGTH];
        }

        NSLog(@"图片类资讯%@",dic);
        
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

- (void)PictureBrowserCommentButtonClick:(UIButton *)button
{
    NSLog(@"turn vc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
