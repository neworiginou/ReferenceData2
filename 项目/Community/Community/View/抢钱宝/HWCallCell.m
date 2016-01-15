//
//  HWCallCell.m
//  HaoWu_4.0
//
//  Created by caijingpeng.haowu on 14-6-3.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWCallCell.h"

@implementation HWCallCell
@synthesize callBtn,titleLab,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
        titleLab.font = [UIFont fontWithName:FONTNAME size:13.0f];
        [self.contentView addSubview:titleLab];
        
        callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [callBtn setImage:[UIImage imageNamed:@"housePhone"] forState:UIControlStateNormal];
        callBtn.frame = CGRectMake(320 - 12 - 37, (60 - 37)/2.0f, 37, 37);
        [callBtn addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:callBtn];
        
    }
    return self;
}
- (void)doCall:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didClickCallButton)]) {
        [delegate didClickCallButton];
    }
}


@end
