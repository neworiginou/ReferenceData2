

#import <Foundation/Foundation.h>

/**
 * User ID 的BizType
 * */
extern const unsigned char BIZ_UID[];

/**
 * Item ID 的BizType
 * */
extern const unsigned char BIZ_IID[];

/**
 * Trade ID 的BizType
 * */
extern const unsigned char BIZ_TID[];


@protocol IOpenSDKComponent <NSObject>
/**
 * 分析 Open ID
 *
 * @param openId        openId的数值
 *
 * @param appIdKey      appId对应的key值
 *
 * @param saltKey       salt对应的key值
 *
 * @param bizType       解析类型
 *
 * @return	openId中包含的指定内容，传人非法参数时返回nil
 */
- (NSNumber*) analyzeOpenId:(NSString*) openId
                   appIdKey: (NSString*) appIdKey
                    saltKey: (NSString*) saltKey
                    bizType: (NSData*) bizType;

@end
