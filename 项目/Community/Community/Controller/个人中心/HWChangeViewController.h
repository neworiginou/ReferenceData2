//
//  HWChangeViewController.h
//  Community
//
//  Created by zhangxun on 14-9-28.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWBaseViewController.h"
#import "HWChangeTextField.h"

@interface HWChangeViewController : HWBaseViewController<UITextFieldDelegate>
{
    HWChangeTextField *_tf1;
    HWChangeTextField *_tf2;
    HWChangeTextField *_tf3;
}
@end
