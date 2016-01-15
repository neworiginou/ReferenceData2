//
//  ALICoreACL.h
//  Pods
//
//  Created by madding.lip on 4/6/15.
//
//

#ifndef Pods_ALICoreACL_h
#define Pods_ALICoreACL_h

@interface ALICoreACL: NSObject

+(instancetype) sharedInstance;

-(instancetype)initWithRefresh:(BOOL) forckRefresh;

-(BOOL) hasWebPageAccessPermission:(NSString *)url;

-(BOOL) hasPluginLoadPermission:(NSString *)name;

-(BOOL) isBrowserMode;

@end

#endif
