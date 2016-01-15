//
//  HWHTTPRequestOperationManager.h
//  Haowu_3.0
//
//  Created by PengHuang on 13-12-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "HWRequestConfig.h"

@interface HWHTTPRequestOperationManager : AFHTTPRequestOperationManager

///---------------------------
/// @name Making HTTP Requests
///---------------------------

+ (instancetype)societyManager;
+ (instancetype)adManager;
+ (instancetype)testPaymanager;
+ (instancetype)cutManager;
+ (instancetype)accountManager;
+ (instancetype)gameManager;
+ (instancetype)testManager;

/**
 Creates and runs an `AFHTTPRequestOperation` with a `GET` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param queue      The OperationQueue. If nil self.operationQueue
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the request operation, and the response object created by the client response serializer.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request operation and the error describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */
//- (AFHTTPRequestOperation *)GET:(NSString *)URLString
//                     parameters:(NSDictionary *)parameters
//                          queue:(NSOperationQueue*)queue
//                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSString *error))failure;

/**
 Creates and runs an `AFHTTPRequestOperation` with a `HEAD` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes a single arguments: the request operation.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request operation and the error describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */
//- (AFHTTPRequestOperation *)HEAD:(NSString *)URLString
//                      parameters:(NSDictionary *)parameters
//                           queue:(NSOperationQueue*)queue
//                         success:(void (^)(AFHTTPRequestOperation *operation))success
//                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 Creates and runs an `AFHTTPRequestOperation` with a multipart `POST` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param block A block that takes a single argument and appends data to the HTTP body. The block argument is an object adopting the `AFMultipartFormData` protocol.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the request operation, and the response object created by the client response serializer.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request operation and the error describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           queue:(NSOperationQueue *)queue
                         success:(void (^)(id responese))success
                         failure:(void (^)(NSString *code, NSString *error))failure;

- (AFHTTPRequestOperation *)redPacketPost:(NSString *)URLString
                               parameters:(NSDictionary *)parameters
                                    queue:(NSOperationQueue *)queue
                                  success:(void(^)(id responseObject))success
                                  failure:(void (^)(NSString * code,NSString * error))failure;

- (AFHTTPRequestOperation *)POSTIndentifyAndBusinessVertifyImage:(NSString *)URLString
                                                      parameters:(NSDictionary *)parameters
                                                           queue:(NSOperationQueue *)queue
                                                         success:(void (^)(id responseObject))success
                                                         failure:(void (^)(NSString *error))failure;

- (AFHTTPRequestOperation *)POSTImage:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure;

- (AFHTTPRequestOperation *)POSTAudio:(NSString *)URLString
                           parameters:(NSDictionary *)parameters
                                queue:(NSOperationQueue *)queue
                              success:(void (^)(id responseObject))success
                              failure:(void (^)(NSString *error))failure;
- (AFHTTPRequestOperation *)POSTAvatarImage:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                      queue:(NSOperationQueue *)queue
                                    success:(void (^)(id responseObject))success
                                    failure:(void (^)(NSString *error))failure;
- (AFHTTPRequestOperation *)POSTPhotoImage:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     queue:(NSOperationQueue *)queue
                                   success:(void (^)(id responseObject))success
                                   failure:(void (^)(NSString *error))failure;
- (AFHTTPRequestOperation *)POSTManagerPhotoImage:(NSString *)URLString
                                       parameters:(NSDictionary *)parameters
                                            queue:(NSOperationQueue *)queue
                                          success:(void (^)(id responseObject))success
                                          failure:(void (^)(NSString *error))failure;
- (AFHTTPRequestOperation *)POSTManyAndShopImagePhotoImage:(NSString *)URLString
                                                parameters:(NSDictionary *)parameters
                                                     queue:(NSOperationQueue *)queue
                                                   success:(void (^)(id responseObject))success
                                                   failure:(void (^)(NSString *error))failure;
- (AFHTTPRequestOperation *)POSTShowImage:(NSString *)URLString
                               parameters:(NSDictionary *)parameters
                                    queue:(NSOperationQueue *)queue
                                  success:(void (^)(id responseObject))success
                                  failure:(void (^)(NSString *error))failure;

/**
 Creates and runs an `AFHTTPRequestOperation` with a `PUT` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the request operation, and the response object created by the client response serializer.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request operation and the error describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */
//- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
//                     parameters:(NSDictionary *)parameters
//                          queue:(NSOperationQueue*)queue
//                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 Creates and runs an `AFHTTPRequestOperation` with a `PATCH` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the request operation, and the response object created by the client response serializer.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request operation and the error describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */
//- (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
//                       parameters:(NSDictionary *)parameters
//                            queue:(NSOperationQueue*)queue
//                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 Creates and runs an `AFHTTPRequestOperation` with a `DELETE` request.
 
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the request operation, and the response object created by the client response serializer.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the request operation and the error describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */
//- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
//                        parameters:(NSDictionary *)parameters
//                             queue:(NSOperationQueue*)queue
//                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           queue:(NSOperationQueue *)queue
                      settimeout:(NSTimeInterval)time
                         success:(void (^)(id responese))success
                         failure:(void (^)(NSString *code, NSString *error))failure;
@end
