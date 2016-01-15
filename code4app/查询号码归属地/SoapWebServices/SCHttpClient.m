//
//  SCHttpClient.m
//  SoapWebServices
//
//  Created by SC2 on 14-2-28.
//  Copyright (c) 2014年 北京士昌信息技术有限公司. All rights reserved.
//

#import "SCHttpClient.h"
#import "SCHeader.h"
#import "SoapNAL.h"
@implementation SCHttpClient

-(void)postRequestWithPhoneNumber:(NSString *)number{
    //创建SOAP信息
    NSString *soapMsg= [NSString stringWithFormat:
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        "<soap12:Envelope "
                        "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                        "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                        "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
                        "<soap12:Body>"
                        "<getMobileCodeInfo xmlns=\"http://WebXml.com.cn/\">"
                        "<mobileCode>%@</mobileCode>"
                        "<userID>%@</userID>"
                        "</getMobileCodeInfo>"
                        "</soap12:Body>"
                        "</soap12:Envelope>", number, @""];
    NSLog(@"SOAPMsg==%@",soapMsg);
    //创建URL请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:WebServicesURL]];
    NSString *msgLength=[NSString stringWithFormat:@"%d",[number length]];
    // 添加请求的详细信息，与请求报文前半部分的各字段对应
    [request addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:4]];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        soapData=[[NSMutableData alloc] init];
    }
}


#pragma mark- 
#pragma mark -NSURLConnectionDelegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [soapData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [soapData appendData:data];
    NSString *theXML = [[NSString alloc] initWithBytes:[soapData mutableBytes]
                                                length:[soapData length]
                                              encoding:4];
    // 打印出得到的XML
    NSLog(@"得到的XML=%@", theXML);
    [[SoapNAL shareInstance] parserSoapXML:soapData withParserBlock:^(NSString *parserXML) {
        NSLog(@"parserXML==%@",parserXML);
    }];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}


@end
