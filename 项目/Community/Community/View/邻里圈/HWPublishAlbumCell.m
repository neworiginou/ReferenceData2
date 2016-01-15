//
//  HWPublishAlbumCell.m
//  Community
//
//  Created by caijingpeng.haowu on 14-9-12.
//  Copyright (c) 2014年 caijingpeng. All rights reserved.
//

#import "HWPublishAlbumCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define MARGIN_LEFT     (kScreenWidth - IMAGE_WIDTH * 4 - DISTANCE * 3) / 2.0f
#define DISTANCE        10*kScreenRate
#define IMAGE_WIDTH     70*kScreenRate

@implementation HWPublishAlbumCell
@synthesize imgBtnOne, imgBtnTwo, imgBtnThree, imgBtnFour, cameraBtn, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.imgBtnOne = [[HWAssetsView alloc] initWithFrame:CGRectMake(MARGIN_LEFT, 5, IMAGE_WIDTH, IMAGE_WIDTH)];
        self.imgBtnOne.layer.cornerRadius = 3.0f;
        self.imgBtnOne.layer.masksToBounds = YES;
        self.imgBtnOne.delegate = self;
        [self.contentView addSubview:self.imgBtnOne];
        
        self.cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraBtn.frame = self.imgBtnOne.frame;
        [cameraBtn setImage:[UIImage imageNamed:@"cameraGray"] forState:UIControlStateNormal];
        [cameraBtn setImageEdgeInsets:UIEdgeInsetsMake((70 - 33) / 2.0f, (70 - 43) / 2.0f, (70 - 33) / 2.0f, (70 - 43) / 2.0f)];
        cameraBtn.hidden = YES;
        cameraBtn.layer.cornerRadius = 3.0f;
        cameraBtn.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
        cameraBtn.layer.borderWidth = 1.0f;
        [cameraBtn addTarget:self action:@selector(toCamera:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cameraBtn];
        
        self.imgBtnTwo = [[HWAssetsView alloc] initWithFrame:CGRectMake(MARGIN_LEFT + (IMAGE_WIDTH + DISTANCE) * 1.0f, 5, IMAGE_WIDTH, IMAGE_WIDTH)];
        self.imgBtnTwo.layer.cornerRadius = 3.0f;
        self.imgBtnTwo.layer.masksToBounds = YES;
        self.imgBtnTwo.delegate = self;
        [self.contentView addSubview:self.imgBtnTwo];
        
        self.imgBtnThree = [[HWAssetsView alloc] initWithFrame:CGRectMake(MARGIN_LEFT + (IMAGE_WIDTH + DISTANCE) * 2.0f, 5, IMAGE_WIDTH, IMAGE_WIDTH)];
        self.imgBtnThree.layer.cornerRadius = 3.0f;
        self.imgBtnThree.layer.masksToBounds = YES;
        self.imgBtnThree.delegate = self;
        [self.contentView addSubview:self.imgBtnThree];
        
        self.imgBtnFour = [[HWAssetsView alloc] initWithFrame:CGRectMake(MARGIN_LEFT + (IMAGE_WIDTH + DISTANCE) * 3.0f, 5, IMAGE_WIDTH, IMAGE_WIDTH)];
        self.imgBtnFour.layer.cornerRadius = 3.0f;
        self.imgBtnFour.layer.masksToBounds = YES;
        self.imgBtnFour.delegate = self;
        [self.contentView addSubview:self.imgBtnFour];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setImage:(NSMutableArray *)assets withIndex:(long)index
{
    
    if (index == 0)
    {
        self.cameraBtn.hidden = NO;
        
        self.imgBtnTwo.asset = [assets pObjectAtIndex:index];
        self.imgBtnThree.asset = [assets pObjectAtIndex:index + 1];
        self.imgBtnFour.asset = [assets pObjectAtIndex:index + 2];
    }
    else
    {
        self.cameraBtn.hidden = YES;
        
        self.imgBtnOne.asset = [assets pObjectAtIndex:index];
        self.imgBtnTwo.asset = [assets pObjectAtIndex:index + 1];
        self.imgBtnThree.asset = [assets pObjectAtIndex:index + 2];
        self.imgBtnFour.asset = [assets pObjectAtIndex:index + 3];
    }
    
}

- (void)toCamera:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectTakePhoto)])
    {
        [delegate didSelectTakePhoto];
    }
}

- (void)didSelectedAssetsView:(HWAssetsView *)aView
{
    if (delegate && [delegate respondsToSelector:@selector(didSelectAlbumPicture:)])
    {
        CGImageRef ref = [[aView.asset defaultRepresentation]fullResolutionImage];
        UIImageOrientation orient = (UIImageOrientation)[[aView.asset defaultRepresentation] orientation];
        UIImage *img = [[UIImage alloc]initWithCGImage:ref scale:1.0f orientation:orient];
        
        [delegate didSelectAlbumPicture:[img fixOrientation]];
    }
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
