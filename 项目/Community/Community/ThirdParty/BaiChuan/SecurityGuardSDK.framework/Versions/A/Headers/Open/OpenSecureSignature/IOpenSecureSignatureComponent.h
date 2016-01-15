//
// OpenSecurityGuardSDK version 2.1.0
//

#ifndef OpenSecurityGuardSDK_IOpenSecureSignatureComponent_h
#define OpenSecurityGuardSDK_IOpenSecureSignatureComponent_h

@class OpenSecurityGuardParamContext;



/**
 *  签名接口
 */
@protocol IOpenSecureSignatureComponent <NSObject>



/**
 *  发起签名请求
 *
 *  @param paramContext 包含签名所需要参数的结构体对象
 *
 *  @param authCode SDK的授权码，不传或为空串，使用默认加密文件
 *
 *  @return 签名值，失败时返回nil
 */
- (NSString*) signRequest: (OpenSecurityGuardParamContext*) paramContext
                 authCode: (NSString*) authCode;



@end



#endif
