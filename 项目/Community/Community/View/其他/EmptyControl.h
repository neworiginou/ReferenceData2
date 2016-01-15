//
//  EmptyControl.h
//  HaoWu
//
//  Created by PengHuang on 13-11-2.
//  Copyright (c) 2013年 PengHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^removeBtnClicked)(void);

@interface EmptyControl : UIView {

}

- (id)initWithTitle:(NSString*)_text frame:(CGRect)_frame onClick:(removeBtnClicked)_clickBlock;

@end
