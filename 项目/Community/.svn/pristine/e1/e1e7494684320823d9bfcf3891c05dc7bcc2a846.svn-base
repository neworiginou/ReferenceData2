//
//  HWHTTPRequestOperationManager.m
//  Haowu_3.0
//
//  Created by PengHuang on 13-12-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "HWHTTPRequestOperationManager.h"
#import "SBJsonParser.h"
#import "HWHomePageViewController.h"
#import "AppDelegate.h"
#import "Base64.h"

@implementation HWHTTPRequestOperationManager

+ (instancetype)accountManager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kUrlBaseAccount]];
}

+ (instancetype)cutManager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kUrlBaseCut]];
}
+ (instancetype)testPaymanager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kUrlBasePay]];
}

+ (instancetype)manager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kUrlBase]];
}

+ (instancetype)societyManager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kSocietyUrlBase]];
}

+ (instancetype)adManager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kADUrlBase]];
}

+ (instancetype)gameManager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kUrlBaseGame]];
}

+ (instancetype)testManager
{
    return [[HWHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://172.16.24.76:8080"]];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return self;
}


- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSString *))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"请求出错");//[error localizedDescription]
    }];
    
    [self.operationQueue addOperation:operation];
        
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
//    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}


//红包加密接口

- (AFHTTPRequestOperation *)redPacketPost:(NSString *)URLString parameters:(NSDictionary *)parameters queue:(NSOperationQueue *)queue success:(void(^)(id responseObject))success failure:(void (^)(NSString * code,NSString * error))failure
{
    NSMutableDictionary * parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:@"5.0" forKey:@"versionCode"];
    [parDict setPObject:@"kaola" forKey:@"appKey"];
    int tempInt = arc4random()%10000000;

    [parDict setPObject:[NSString stringWithFormat:@"%d",tempInt] forKey:@"nonce"];
    [parDict setPObject:[Utility getUUID] forKey:@"mac"];
    [parDict setPObject:[Utility getTimeStampForUnix] forKey:@"timestamp"];
    [parDict setPObject:[Utility encryptParameter:parDict] forKey:@"digest"];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]parameters:parDict error:nil];
    [request setTimeoutInterval:15.0f];
    NSLog(@"request:%@ \n %@",request,parDict);
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        //        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if([[dict objectForKey:@"status"] intValue]==kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else if([[dict objectForKey:@"status"] intValue] == kStatusQiangQianBao)
                {
                    // 注册时 抢钱宝用户   登录时  用户不存在
                    failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                    }
                    else
                    {
                        failure([dict stringObjectForKey:@"status"], @"服务器被口水淹没，排水中");
                    }
                }
                
                
            }
            
        }
        //        //nslog(@"dict = %@",dict );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //nslog(@"errr = %@",error);
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkError], @"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    return operation;
    
}


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           queue:(NSOperationQueue *)queue
                         success:(void (^)(id responese))success
                         failure:(void (^)(NSString *code, NSString *error))failure
{
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
//    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
//    [parDict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
//    if (![self.baseURL.absoluteString isEqualToString:kADUrlBase] && ![self.baseURL.absoluteString isEqualToString:kSocietyUrlBase]) // 社区接口
//    {
        NSMutableString *sign = [NSMutableString string];
        
        NSArray* arr = [parDict allKeys];
        arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
            NSComparisonResult result = [obj1 compare:obj2];
            return result == NSOrderedDescending;
        }];
        
        for (int i = 0 ; i < arr.count ; i++)
        {
            NSString *key = [arr objectAtIndex:i];
            [sign appendFormat:@"%@%@", key, [parDict objectForKey:key]];
        }
        [sign appendString:@"F2B4E48EA7BA64578152D5EF3AB0F70FEB0E978F"];
        
        NSString *str = [(NSString *)sign md5:sign];
        
        NSData *data = [[str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *codestr=[[NSString alloc] initWithData:[Base64 encodeData:data] encoding:NSUTF8StringEncoding];
        
        [parDict setPObject:codestr forKey:@"digest"];
//    }
//    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
//    [parDict setDictionary:parameters];
    
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]parameters:parDict error:nil];
    [request setTimeoutInterval:15.0f];
    NSLog(@"request:%@ \n %@",request,parDict);
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
//        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if([[dict objectForKey:@"status"] intValue]==kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    NSLog(@"%@", request);
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else if([[dict objectForKey:@"status"] intValue] == kStatusQiangQianBao)
                {
                    // 注册时 抢钱宝用户   登录时  用户不存在
                    failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                    }
                    else
                    {
                        failure([dict stringObjectForKey:@"status"], @"服务器被口水淹没，排水中");
                    }
                }
            }
        }
        //        //nslog(@"dict = %@",dict );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //nslog(@"errr = %@",error);
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkError], @"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    return operation;
}

/////////////////////////////////////////////////
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           queue:(NSOperationQueue *)queue
                      settimeout:(NSTimeInterval)time
                         success:(void (^)(id responese))success
                         failure:(void (^)(NSString *code, NSString *error))failure
{
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    //    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    //    [parDict setPObject:[HWUserLogin currentUserLogin].key forKey:@"key"];
    //    if (![self.baseURL.absoluteString isEqualToString:kADUrlBase] && ![self.baseURL.absoluteString isEqualToString:kSocietyUrlBase]) // 社区接口
    //    {
    NSMutableString *sign = [NSMutableString string];
    
    NSArray* arr = [parDict allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result == NSOrderedDescending;
    }];
    
    for (int i = 0 ; i < arr.count ; i++)
    {
        NSString *key = [arr objectAtIndex:i];
        [sign appendFormat:@"%@%@", key, [parDict objectForKey:key]];
    }
    [sign appendString:@"F2B4E48EA7BA64578152D5EF3AB0F70FEB0E978F"];
    
    NSString *str = [(NSString *)sign md5:sign];
    
    NSData *data = [[str uppercaseString] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *codestr=[[NSString alloc] initWithData:[Base64 encodeData:data] encoding:NSUTF8StringEncoding];
    
    [parDict setPObject:codestr forKey:@"digest"];
    //    }
    //    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    //    [parDict setDictionary:parameters];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]parameters:parDict error:nil];
    [request setTimeoutInterval:time];
    NSLog(@"request:%@ \n %@",request,parDict);
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        //        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if([[dict objectForKey:@"status"] intValue]==kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else if([[dict objectForKey:@"status"] intValue] == kStatusQiangQianBao)
                {
                    // 注册时 抢钱宝用户   登录时  用户不存在
                    failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict stringObjectForKey:@"status"], [dict stringObjectForKey:@"detail"]);
                    }
                    else
                    {
                        failure([dict stringObjectForKey:@"status"], @"服务器被口水淹没，排水中");
                    }
                }
                
                
            }
            
        }
        //        //nslog(@"dict = %@",dict );
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //nslog(@"errr = %@",error);
        if(failure)
            failure([NSString stringWithFormat:@"%d", kStatusNetworkError], @"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    return operation;
}
/////////////////////////////////////////////////



//发送头像请求
- (AFHTTPRequestOperation *)POSTAvatarImage:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parameters allKeys])
        {
            if ([dictKey isEqualToString:@"file"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}

//晒图片

- (AFHTTPRequestOperation *)POSTShowImage:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     queue:(NSOperationQueue *)queue
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@&source=1",URLString, [HWUserLogin currentUserLogin].key];
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parameters allKeys])
        {
            if ([dictKey isEqualToString:@"file"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}


//上传一张图片
- (AFHTTPRequestOperation *)POSTPhotoImage:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                      queue:(NSOperationQueue *)queue
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parameters allKeys])
        {
            if ([dictKey isEqualToString:@"pic1"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}
//上传多张张图片
- (AFHTTPRequestOperation *)POSTManagerPhotoImage:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     queue:(NSOperationQueue *)queue
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        for (NSString *dictKey in [parameters allKeys])
//        {
//            if ([dictKey isEqualToString:@"pics"])
//            {
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//                NSString *documentsDirectory = [paths objectAtIndex:0];
//                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
//                NSArray *photoDataArry = [parameters objectForKey:dictKey];
//                for (int i = 0; i < [photoDataArry count]; i++) {
//                    NSData *imageData = [photoDataArry objectAtIndex:i];
//                    [imageData writeToFile:savedImagePath atomically:YES];
//                    [formData appendPartWithFileData:imageData name:@"pics" fileName:savedImagePath mimeType:@"image/jpeg"];
//                }
//            }
//        }
    } error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}

//上传多张张图片以及店铺图片
- (AFHTTPRequestOperation *)POSTManyAndShopImagePhotoImage:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                            queue:(NSOperationQueue *)queue
                                          success:(void (^)(id responseObject))success
                                          failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parDict allKeys])
        {
            if ([dictKey isEqualToString:@"pics"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSArray *photoDataArry = [parDict objectForKey:dictKey];
                for (int i = 0; i < [photoDataArry count]; i++) {
                    NSData *imageData = [photoDataArry objectAtIndex:i];
                    [imageData writeToFile:savedImagePath atomically:YES];
                    [formData appendPartWithFileData:imageData name:@"pics" fileName:savedImagePath mimeType:@"image/jpeg"];
                }
            }
            else if([dictKey isEqualToString:@"banners"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parDict objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parDict objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}
//发送身份认证和营业执照
- (AFHTTPRequestOperation *)POSTIndentifyAndBusinessVertifyImage:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                      queue:(NSOperationQueue *)queue
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parDict allKeys])
        {
            if ([dictKey isEqualToString:@"yyzzFile"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
            else if ([dictKey isEqualToString:@"idCard0File"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
            else if ([dictKey isEqualToString:@"idCard1File"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
                failure([dict objectForKey:@"detail"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}
- (AFHTTPRequestOperation *)POSTImage:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parameters allKeys])
        {
            if ([dictKey isEqualToString:@"pubFile"] || [dictKey isEqualToString:@"file"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"image/jpeg"];
            }
        }
    } error:nil];
    
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}


- (AFHTTPRequestOperation *)POSTAudio:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure {
    
    NSMutableDictionary *parDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [parDict setPObject:@"1" forKey:@"appUrlVersion"];
    [parDict setPObject:[Utility getLocalAppVersion] forKey:@"versionCode"];
    
    URLString = [NSString stringWithFormat:@"%@?&key=%@",URLString, [HWUserLogin currentUserLogin].key];
    
//    if ([self.baseURL.absoluteString isEqualToString:kUrlBase]) // 社区接口
//    {
        NSString *appkey = REQUEST_APPKEY;
        NSString *timestamp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
        NSString *secret = REQUEST_SECRET;
        NSString *nonce = [Utility getRandomString];
        
        [parDict setPObject:appkey forKey:@"appkey"];
        [parDict setPObject:timestamp forKey:@"timestamp"];
        [parDict setPObject:nonce forKey:@"nonce"];
        
        NSString *sign = [NSString stringWithFormat:@"%@%@%@%@", appkey, timestamp, secret, nonce];
        [parDict setPObject:[sign sha1] forKey:@"signature"];
//    }
    
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *dictKey in [parameters allKeys])
        {
            if ([dictKey isEqualToString:@"pubFile"] || [dictKey isEqualToString:@"file"])
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.amr",dictKey]];
                NSData *imageData = [parameters objectForKey:dictKey];
                
                [imageData writeToFile:savedImagePath atomically:YES];
                [formData appendPartWithFileData:[parameters objectForKey:dictKey] name:dictKey fileName:savedImagePath mimeType:@"audio/AMR"];
            }
        }
    } error:nil];
    
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //解析返回数据
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *dict = [parser objectWithData:responseObject];
        if([[dict objectForKey:@"status"] intValue] == kStatusSuccess)
        {
            if(success)
                success(dict);
        }
        else
        {
            if(failure)
            {
                if([[dict objectForKey:@"status"] intValue] == kStatusLogout)
                {
                    AppDelegate *appDel = (AppDelegate *)SHARED_APP_DELEGATE;
                    HWHomePageViewController *homePageVC = [[HWHomePageViewController alloc] init];
                    HWBaseNavigationController *navCtr = [[HWBaseNavigationController alloc] initWithRootViewController:homePageVC];
                    [appDel.window.rootViewController presentViewController:navCtr animated:YES completion:nil];
                    [[HWUserLogin currentUserLogin] userLogout];
                }
                else
                {
                    if ([[dict objectForKey:@"detail"] isKindOfClass:[NSString class]])
                    {
                        failure([dict objectForKey:@"detail"]);
                    }
                    else
                    {
                        failure(@"网络打瞌睡了，稍后再试");
                    }
                }
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(@"网络打瞌睡了，稍后再试");
    }];
    if(queue==nil)
        [self.operationQueue addOperation:operation];
    else
        [queue addOperation:operation];
    
    return operation;
}


@end
