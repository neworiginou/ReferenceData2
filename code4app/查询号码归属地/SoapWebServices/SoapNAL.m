//
//  SoapNAL.m
//  SoapWebServices
//
//  Created by SC2 on 14-2-28.
//  Copyright (c) 2014年 北京士昌信息技术有限公司. All rights reserved.
//

#import "SoapNAL.h"
#define MacthingElement @"getMobileCodeInfoResult"

static SoapNAL *instance;

@implementation SoapNAL

+(SoapNAL *)shareInstance{
    if (instance==nil) {
        instance=[[self alloc] init];
    }
    return instance;
}

-(void)parserSoapXML:(NSMutableData *)soapData withParserBlock:(SoapNALBlock)block{
    self.soapBlock=block;
    xmlParser=[[NSXMLParser alloc] initWithData:soapData];
    xmlParser.delegate=self;
    [xmlParser parse];
}

#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:MacthingElement]) {
        if (!_soapResults) {
            _soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        [_soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:MacthingElement]) {
        self.soapBlock(_soapResults);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号码信息"
                                                        message:[NSString stringWithFormat:@"%@", _soapResults]
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        elementFound = FALSE;
        // 强制放弃解析
        [xmlParser abortParsing];
    }
}

// 解析结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (_soapResults) {
        _soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (_soapResults) {
        _soapResults = nil;
    }
}

@end
