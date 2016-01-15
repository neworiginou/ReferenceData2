//
// OpenSecurityGuardSDK version 2.1.0
//

#import <Foundation/Foundation.h>

/**
 *  各compoent的compoentid，在获取component对象时传入
 */
typedef enum {
    /**
     *  签名component
     */
    SecureSignatureComponentID,
    /**
     *  动态存储component
     */
    DynamicDataStoreComponentID,
    /**
     *  静态存储component
     */
    StaticDataStoreComponentID,
    /**
     *  初始化component
     */
    InitComponentID,
    /**
     *  静态加解密component
     */
    StaticDataEncryptCompnentID,
    /**
     *  data collection compnent
     */
    DataCollectionCompnentID,
    /**
     *  dynamic data encrypt componentID
     */
    DynamicDataEncryptComponentID,
    /**
     *  StaticKeyEncrypt componentID
     */
    StaticKeyEncryptComponentID,
    /**
     *  UMID componentID
     */
    OpenUMIDComponentID,
	/**
     *  OpenSDK componentID
     */
    OpenOpenSDKComponentID,
    /**
     *  无效component
     */
    InvalidComponentID
    
} SecurityGuardComponentID;



/**
 *  签名接口，详细定义见：IOpenSecureSignatureComponent.h
 */
@protocol IOpenSecureSignatureComponent;

/**
 *  动态数据存储接口，详细定义见：IOpenDynamicDataStoreComponent.h
 */
@protocol IOpenDynamicDataStoreComponent;

/**
 *  静态数据存储接口，详细定义见：IOpenStaticDataStoreComponent.h
 */
@protocol IOpenStaticDataStoreComponent;

/**
 *  静态数据存储接口，详细定义见：IOpenStaticDataEncryptComponent.h
 */
@protocol IOpenStaticDataEncryptComponent;

/**
 *  数据采集接口，详细定义见：IOpenDataCollectionComponent.h
 */
@protocol IOpenDataCollectionComponent;

/**
 *  动态数据加密接口，详细定义见：IOpenDynamicDataEncryptComponent.h
 */
@protocol IOpenDynamicDataEncryptComponent;

/**
 *  静态密钥安全加密接口，详细定义见：IOpenStaticKeyEncryptComponent.h
 */
@protocol IOpenStaticKeyEncryptComponent;

/**
 *  获取 umid 接口， 详细定义见 IUMIDComponent.h
 */
@protocol IOpenUMIDComponent;

/**

 *  获取 openSDK 接口， 详细定义见 IOpenOpenSDKComponent.h
 */
@protocol IOpenOpenSDKComponent;

/**
 *  SecurityGuardSDK管理类
 */
@interface OpenSecurityGuardManager : NSObject

/**
 *  获取SecurityGuardManager单例对象
 *
 *  @return SecurityGuardManager单例对象
 */
+ (OpenSecurityGuardManager*) getInstance;



/**
 *  获取安全签名接口
 *
 *  @return 返回签名接口，失败时nil
 */
- (id<IOpenSecureSignatureComponent>) getSecureSignatureComp;



/**
 *  获取动态数据存储接口
 *
 *  @return 返回动态数据存储接口，失败时nil
 */
- (id<IOpenDynamicDataStoreComponent>) getDynamicDataStoreComp;



/**
 *  获取静态数据存储接口
 *
 *  @return 返回静态数据存储接口，失败时nil
 */
- (id<IOpenStaticDataStoreComponent>) getStaticDataStoreComp;



/**
 *  获取静态数据加密接口
 *
 *  @return 返回模拟器检测模块，失败时nil
 */
- (id<IOpenStaticDataEncryptComponent>) getStaticDataEncryptComp;



/**
 *  获取数据采集接口
 *
 *  @return 返回数据采集接口，失败时返回nil
 */
- (id<IOpenDataCollectionComponent>) getDataCollectionComp;



/**
 *  获取动态数据存储接口
 *
 *  @return 返回动态数据存储接口，失败时返回nil
 */
- (id<IOpenDynamicDataEncryptComponent>) getDynamicDataEncryptComp;



/**
 *  获取静态密钥安全加解密接口
 *
 *  @return 返回静态密钥安全加解密接口，失败时返回nil
 */
- (id<IOpenStaticKeyEncryptComponent>) getStaticKeyEncryptComp;



/**
 *  获取UMID接口
 *
 *  @return 返回UMID接口，失败返回nil
 */
- (id<IOpenUMIDComponent>) getUMIDComp;

/**
 *  获取OpenSDK接口
 *
 *  @return 返回OpenSDK接口，失败返回nil
 */
- (id<IOpenOpenSDKComponent>) getOpenOpenSDKComp;

/**
 *  根据传入的component id获取对应的component对象
 *
 *  @param componentId 目标compoent的id
 *
 *  @return 返回componentId对应的component对象，失败时返回nil
 */
- (id) getComponent: (SecurityGuardComponentID) componentId;



/**
 *  获取sdk当前版本号
 *
 *  @return sdk当前版本号
 */
- (NSString*) getSDKVersion;



/**
 *  是否为外部版本的无线保镖SDK
 *
 *  @return 是否为外部版本的无线保镖SDK
 */
- (BOOL) isOpen;



@end
