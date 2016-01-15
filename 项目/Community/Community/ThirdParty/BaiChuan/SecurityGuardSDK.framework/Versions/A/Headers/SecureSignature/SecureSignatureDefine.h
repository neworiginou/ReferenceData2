//
// SecurityGuardSDK version 2.1.0
//

/**
 *  签名调用中，SecurityGuardParamContex中paramDict参数中使用到的key
 */

/**
 *  签名接口入参key，top, umid签名使用
 */
extern NSString* const SG_KEY_SIGN_INPUT;


/**
 *  seedkey，top 签名使用
 */
extern NSString* const SG_KEY_SIGN_SEEDKEY;

/**
 *  签名调用中，SecurityGuardParamContex中requestType参数中使用到的值
 */

/**
 *  top签名
 */
extern NSInteger const SG_ENUM_SIGN_TOP;

/**
 *  umid签名
 */
extern NSInteger const SG_ENUM_SIGN_UMID;

/**
 *  原始top签名(无seekKey)
 */
extern NSInteger const SG_ENUM_SIGN_TOP_OLD;

/**
 *  common hmac sha1签名
 */
extern NSInteger const SG_ENUM_SIGN_COMMON_HMAC_SHA1;

/**
 *  common md5签名
 */
extern NSInteger const SG_ENUM_SIGN_COMMON_MD5;

/**
 *  无效签名类型
 */
extern NSInteger const SG_ENUM_SIGN_INVALID;