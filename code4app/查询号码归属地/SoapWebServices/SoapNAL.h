//
//  SoapNAL.h
//  SoapWebServices
//
//  Created by SC2 on 14-2-28.
//  Copyright (c) 2014年 北京士昌信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SoapNALBlock) (NSMutableString *parserXML);
@interface SoapNAL : NSObject<NSXMLParserDelegate>{
    NSXMLParser *xmlParser;
    BOOL elementFound;
}
@property(nonatomic,strong)SoapNALBlock soapBlock;
@property(nonatomic,strong)NSMutableString *soapResults;
+(SoapNAL *)shareInstance;
-(void)parserSoapXML:(NSMutableData *)soapData withParserBlock:(SoapNALBlock)block;
@end
