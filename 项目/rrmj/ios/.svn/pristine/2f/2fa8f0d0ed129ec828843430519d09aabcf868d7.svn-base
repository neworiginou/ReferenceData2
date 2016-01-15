//
//  UploadIconApi.m
//  PUClient
//
//  Created by RRLhy on 15/8/4.
//  Copyright (c) 2015年 RRLhy. All rights reserved.
//

#import "UploadIconApi.h"

@implementation UploadIconApi
{
    UIImage  * _image;
    NSString * _nickName;
    NSString * _sex;
    NSString * _birthday;
    NSString * _city;
    NSString * _sign;
    NSString * _token;
}
- (id)initWith:(UIImage*)image nickName:(NSString*)nickname sex:(NSString*)sex birthDay:(NSString*)birthday city:(NSString*)city sign:(NSString*)sign token:(NSString*)token
{
    self = [super init];
    if (self) {
        _image = image;
        _nickName = nickname;
        _sex = sex;
        _birthday = birthday;
        _city = city;
        _sign = sign;
        _token = token;
    }
    return self;
}

- (NSString*)requestUrl
{
    return [NSString stringWithFormat:@"/user/updateUser?token=%@",_token];
}

- (id)requestArgument
{
    return @{@"token":_token};
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (AFConstructingBlock)constructingBodyBlock
{
    return ^(id<AFMultipartFormData> formData) {
        
        if (_image) {
            NSData * data = UIImageJPEGRepresentation(_image, 0.9);
            NSString * name = @"image.png";
            NSString * formKey = @"headImg";
            NSString * type = @"png/jpeg";
            [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
        }
     
        [formData appendPartWithFormData:[_nickName dataUsingEncoding:NSUTF8StringEncoding] name:@"nickName"];
        [formData appendPartWithFormData:[_sex dataUsingEncoding:NSUTF8StringEncoding] name:@"sex"];
        [formData appendPartWithFormData:[_city dataUsingEncoding:NSUTF8StringEncoding] name:@"city"];
        [formData appendPartWithFormData:[_sign dataUsingEncoding:NSUTF8StringEncoding] name:@"sign"];
        [formData appendPartWithFormData:[_birthday dataUsingEncoding:NSUTF8StringEncoding] name:@"birthday"];
    };
}
@end
