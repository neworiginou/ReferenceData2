//
//  HWGeneralizeCell.m
//  Community
//
//  Created by zhangxun on 14-9-18.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWGeneralizeCell.h"

@implementation HWGeneralizeCell

@synthesize theImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        theImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kActImageHeight)];
        [self.contentView addSubview:theImageView];
    }
    return self;
}

- (void)rebuildWithInfo:(HWChannelItemClass *)neighbourClass indexPath:(NSIndexPath *)index
{
    theImageView.image = nil;
    
    NSURL *imageUrl = [NSURL URLWithString:[Utility imageDownloadWithMongoDbKey:neighbourClass.mongodbKey]];
    __weak UIImageView *blockImgV = theImageView;
    [theImageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"holdImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:@"holdImage"];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            {
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
    }];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
