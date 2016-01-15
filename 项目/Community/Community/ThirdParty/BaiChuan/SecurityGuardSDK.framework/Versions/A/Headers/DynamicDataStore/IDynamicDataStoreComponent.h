//
// SecurityGuardSDK version 2.1.0
//

#ifndef SecurityGuardSDK_IDynamicDataStoreComponent_h
#define SecurityGuardSDK_IDynamicDataStoreComponent_h



/**
 *  动态存储接口
 */
@protocol IDynamicDataStoreComponent <NSObject>



/**
 *  获取动态存储中的string值
 *
 *  @param key string值对应的key
 *
 *  @return 返回存储的value，如果没有找到，返回nil
 */
- (NSString*) getString: (NSString*) key;



/**
 *  向动态存储中存储string
 *
 *  @param value 要存储的string
 *  @param key   存储值要使用的key
 *
 *  @return 存储操作结果
 */
- (int) putString: (NSString*) value forKey: (NSString*) key;



/**
 *  删除key对应的string值
 *
 *  @param key 删除操作的结果
 */
- (void) removeStringForKey: (NSString*) key;



/**
 *  获取动态存储中的data值
 *
 *  @param key data值对应的key
 *
 *  @return 存储中存储的value，如果没有找到，返回nil
 */
- (NSData*) getData: (NSString*) key;



/**
 *  向动态存储中存储data
 *
 *  @param value 要存储的data（存入的data size不宜过大）
 *  @param key   存储值要使用的key
 *
 *  @return 存储操作结果
 */
- (int) putData: (NSData*) value forKey: (NSString*) key;



/**
 *  删除key对应的data值
 *
 *  @param key 删除操作的结果
 */
- (void) removeDataForKey: (NSString*) key;



/**
 *  获取动态存储中的integer值
 *
 *  @param key integer值对应的key
 *
 *  @return 存储中存储的value，如果没有找到，返回0
 */
- (NSInteger) getInteger: (NSString*) key;



/**
 *  向动态存储中存储integer
 *
 *  @param value 要存储的integer
 *  @param key   存储值要使用的key
 *
 *  @return 存储操作结果
 */
- (int) putInteger: (NSInteger) value forKey: (NSString*) key;



/**
 *  删除key对应的integer值
 *
 *  @param key 删除操作的结果
 */
- (void) removeIntegerForKey: (NSString*) key;



/**
 *  获取动态存储中的float值
 *
 *  @param key float值对应的key
 *
 *  @return 存储中存储的value，如果没有找到，返回0.0f
 */
- (float) getFloat: (NSString*) key;



/**
 *  向动态存储中存储float
 *
 *  @param value 要存储的float
 *  @param key   存储值要使用的key
 *
 *  @return 存储操作结果
 */
- (int) putFloat: (float) value forKey: (NSString*) key;



/**
 *  删除key对应的float值
 *
 *  @param key 删除操作的结果
 */
- (void) removeFloatForKey: (NSString*) key;



/**
 *  获取动态存储中的double值
 *
 *  @param key double值对应的key
 *
 *  @return 存储中存储的value，如果没有找到，返回0.0f
 */
- (double) getDouble: (NSString*) key;



/**
 *  向动态存储中存储double
 *
 *  @param value 要存储的double
 *  @param key   存储值要使用的key
 *
 *  @return 存储操作结果
 */
- (int) putDouble: (double) value forKey: (NSString*) key;



/**
 *  删除key对应的double值
 *
 *  @param key 删除操作的结果
 */
- (void) removeDoubleForKey: (NSString*) key;



/**
 *  获取动态存储中的bool值
 *
 *  @param key bool值对应的key
 *
 *  @return 存储中存储的value，如果没有找到，返回NO
 */
- (BOOL) getBool: (NSString*) key;



/**
 *  向动态存储中存储bool
 *
 *  @param value 要存储的bool
 *  @param key   存储值要使用的key
 *
 *  @return 存储操作结果
 */
- (int) putBool: (BOOL) value forKey: (NSString*) key;



/**
 *  删除key对应的boll值
 *
 *  @param key 删除操作的结果
 */
- (void) removeBoolForKey: (NSString*) key;



@end



#endif
