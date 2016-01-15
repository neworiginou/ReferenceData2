//
// SecurityGuardSDK version 2.1.0
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
     *  Open SDK Component ID
     */
    OpenSDKComponentID,
    /**
     *  UMID componentID
     */
    UMIDComponentID,
    /**
     *  无效component
     */
    InvalidComponentID
    
} SecurityGuardComponentID;



/**
 *  签名接口，详细定义见：ISecureSignatureComponent.h
 */
@protocol ISecureSignatureComponent;

/**
 *  动态数据存储接口，详细定义见：IDynamicDataStoreComponent.h
 */
@protocol IDynamicDataStoreComponent;

/**
 *  静态数据存储接口，详细定义见：IStaticDataStoreComponent.h
 */
@protocol IStaticDataStoreComponent;

/**
 *  静态数据存储接口，详细定义见：IStaticDataEncryptComponent.h
 */
@protocol IStaticDataEncryptComponent;

/**
 *  数据采集接口，详细定义见：IDataCollectionComponent.h
 */
@protocol IDataCollectionComponent;

/**
 *  动态数据加密接口，详细定义见：IDynamicDataEncryptComponent.h
 */
@protocol IDynamicDataEncryptComponent;

/**
 *  静态密钥安全加密接口，详细定义见：IStaticKeyEncryptComponent.h
 */
@protocol IStaticKeyEncryptComponent;

/**
 *  OpenSDK接口，详细定义见：IOpenSDKComponent.h
 */
@protocol IOpenSDKComponent;
/**
 *  获取 umid 接口， 详细定义见 IUMIDComponent.h
 */
@protocol IUMIDComponent;

/**
 *  SecurityGuardSDK管理类
 */
@interface SecurityGuardManager : NSObject



/**
 *  获取SecurityGuardManager单例对象
 *
 *  @return SecurityGuardManager单例对象
 */
+ (SecurityGuardManager*) getInstance;



/**
 *  获取安全签名接口
 *
 *  @return 返回签名接口，失败时nil
 */
- (id<ISecureSignatureComponent>) getSecureSignatureComp;



/**
 *  获取动态数据存储接口
 *
 *  @return 返回动态数据存储接口，失败时nil
 */
- (id<IDynamicDataStoreComponent>) getDynamicDataStoreComp;



/**
 *  获取静态数据存储接口
 *
 *  @return 返回静态数据存储接口，失败时nil
 */
- (id<IStaticDataStoreComponent>) getStaticDataStoreComp;



/**
 *  获取静态数据加密接口
 *
 *  @return 返回模拟器检测模块，失败时nil
 */
- (id<IStaticDataEncryptComponent>) getStaticDataEncryptComp;



/**
 *  获取数据采集接口
 *
 *  @return 返回数据采集接口，失败时返回nil
 */
- (id<IDataCollectionComponent>) getDataCollectionComp;



/**
 *  获取动态数据存储接口
 *
 *  @return 返回动态数据存储接口，失败时返回nil
 */
- (id<IDynamicDataEncryptComponent>) getDynamicDataEncryptComp;



/**
 *  获取静态密钥安全加解密接口
 *
 *  @return 返回静态密钥安全加解密接口，失败时返回nil
 */
- (id<IStaticKeyEncryptComponent>) getStaticKeyEncryptComp;


/**
 *  获取OpenSDK接口
 *
 *  @return 返回OpenSDK接口，失败时返回nil
 */
- (id<IOpenSDKComponent>) getOpenSDKComp;


/**
 *  获取UMID接口
 *
 *  @return 返回UMID接口，失败返回nil
 */
- (id<IUMIDComponent>) getUMIDComp;



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
