//
// SecurityGuardSDK version 2.1.0
//

#import <Foundation/Foundation.h>

/**
 *  安全凭证加解密模块使用加密算法
 */

/**
 *  des算法
 */
extern NSInteger const CIPHER_MODE_DES;



/**
 *  3des算法
 */
extern NSInteger const CIPHER_MODE_3DES;



/**
 *  aes128算法
 */
extern NSInteger const CIPHER_MODE_AES128;



/**
 *  aes192算法
 */
extern NSInteger const CIPHER_MODE_AES192;



/**
 *  aes256算法
 */
extern NSInteger const CIPHER_MODE_AES256;



/**
 *  rsa算法
 */
extern NSInteger const CIPHER_MODE_RSA;



/**
 *  无效算法
 */
extern NSInteger const CIPHER_MODE_INVALID;

/**
 *  安全凭证加解密模块使用的错误码
 */

/**
 *  seedSecret存储失败
 */
extern NSInteger const SG_SAVE_FAILED;



/**
 *  seedSecret覆盖成功
 */
extern NSInteger const SG_OVERRIDE_SUCCESS;



/**
 *  seedSecret存储成功
 */
extern NSInteger const SG_SAVE_SUCCESS;



/**
 *  删除 seedSecret失败
 */
extern NSInteger const SG_REMOVE_FAILED;



/**
 *  删除 seedSecret成功
 */
extern NSInteger const SG_REMOVE_SUCCESS;



/**
 *  删除失败，没有此项 
 */
extern NSInteger const SG_NO_SUCH_ITEM;