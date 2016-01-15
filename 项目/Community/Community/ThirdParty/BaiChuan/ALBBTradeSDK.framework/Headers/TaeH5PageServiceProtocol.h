//
//  TaeCoreServiceProtocol.h
//  TAESDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14/11/24.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaeH5PageServiceProtocol <NSObject>

@required
-(void) showPage:(UIViewController *) parentController
                 isNeedPush:(BOOL) isNeedPush
                    openUrl:(NSString *)openUrl;


@end
