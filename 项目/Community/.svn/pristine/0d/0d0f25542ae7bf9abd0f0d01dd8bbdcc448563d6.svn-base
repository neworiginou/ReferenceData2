//
//  HWMyPriviledgeTableViewCell.m
//  TestOne
//
//  Created by gusheng on 14-12-8.
//  Copyright (c) 2014年 gusheng. All rights reserved.
//

#import "HWMyPriviledgeTableViewCell.h"
#import "HWGeneralControl.h"
#import "HWPriviledgeStatusView.h"
#define kMyPriviledgeCellHeight 200
@implementation HWMyPriviledgeTableViewCell
@synthesize priviledgeOrderNumLabel;
@synthesize priviledgeIV;
@synthesize priviledgeStatusV;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = BACKGROUND_COLOR;
        UIImageView *backgroundIV = [HWGeneralControl createImageView:CGRectMake(0, 0,kScreenWidth , 181) image:@""];
        backgroundIV.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"sawtooth"];
         backgroundIV.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 30, 30)];
        [self addSubview:backgroundIV];
        
        
        priviledgeOrderNumLabel = [HWGeneralControl createLabel:CGRectMake(kScreenWidth-10-300, 0, 300, 30) font:15.0f textAligment:NSTextAlignmentRight labelColor:THEME_COLOR_SMOKE];
        [self addSubview:priviledgeOrderNumLabel];
        
        priviledgeIV = [HWGeneralControl createImageView:CGRectMake(10, 30, kScreenWidth-2*10, 130) image:@""];
        [self addSubview:priviledgeIV];
        priviledgeIV.layer.borderColor = THEME_COLOR_LINE.CGColor;
        priviledgeIV.layer.borderWidth = 0.5;
        priviledgeIV.backgroundColor = [UIColor clearColor];
        
        UIImageView *lineImageV = [HWGeneralControl createImageView:CGRectMake(0, 0, kScreenWidth, 0.5) image:@""];
        lineImageV.layer.shadowColor = THEME_COLOR_GRAY_MIDDLE.CGColor;
        lineImageV.layer.shadowOffset = CGSizeMake(0, 2);
        lineImageV.layer.shadowOpacity = 0.5;
        lineImageV.layer.cornerRadius = 1.0f;
        lineImageV.backgroundColor = THEME_COLOR_LINE;
        [self addSubview:lineImageV];
        
        //判断状态
        priviledgeStatusV = [[HWPriviledgeStatusView alloc]initWithFrame:CGRectMake(kScreenWidth-50-10, 30, 50, 50)];
        priviledgeStatusV.hidden = YES;
        priviledgeStatusV.backgroundColor = [UIColor clearColor];
        [self addSubview:priviledgeStatusV];
        //end
        
    }
    return self;
}

-(void)setMyPriviledge:(HWMyPriviledgeModel *)myPriviledgeModel
{
    self.priviledgeOrderNumLabel.text = myPriviledgeModel.priviledgeNumStr;
    self.priviledgeIV.image = [UIImage imageNamed:@""];
    if ([myPriviledgeModel.priviledgeStatus isEqualToString:@"0"]) {
        self.priviledgeOrderNumLabel.textColor = THEME_COLOR_TEXT;
    }
    else
    {
        self.priviledgeOrderNumLabel.textColor = THEME_COLOR_SMOKE;
    }
    
    //start
//    NSURL *avatarUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hw-sq-app-web/%@&key=%@",kUrlBaseTest,myPriviledgeModel.priviledgeImageUrl,@"e2a3b251-841b-4e0c-ab9f-e50bbb1e8ea5"]];
    
    __weak UIImageView *blockImgV = self.priviledgeIV;
    __weak HWMyPriviledgeTableViewCell *myself = self;
     __block HWPriviledgeStatusView *statusView = self.priviledgeStatusV;
    [self.priviledgeIV setImageWithURL:[NSURL URLWithString:[Utility imageDownloadUrl:myPriviledgeModel.priviledgeImageUrl]] placeholderImage:[UIImage imageNamed:IMAGE_PLACE] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        if (error)
        {
            NSLog(@"Error : load image fail.");
            blockImgV.image = [UIImage imageNamed:IMAGE_BREAK_CUBE];
        }
        else
        {
            blockImgV.image = image;
            if (cacheType == 0)
            { // request url
                CATransition *transition = [CATransition animation];
                transition.duration = 1.0f;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.type = kCATransitionFade;
                [blockImgV.layer addAnimation:transition forKey:nil];
            }
        }
        if ([myPriviledgeModel.priviledgeStatus isEqualToString:@"1"])
        {
            statusView.hidden = YES;
        }
        else if([myPriviledgeModel.priviledgeStatus isEqualToString:@"0"])
        {
            statusView.priviledgeStatus.text = @"已过期";
            statusView.hidden = NO;
            blockImgV.image = [myself grayImage:image];
        }
    }];
    //end
    
    
}
-(UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}
+(UIImage *)imageWithImage:(UIImage *)image darkValue:(float)darkValue
{
    return [[self class] imageWithImage:image pixelOperationBlock:^(UInt8 *redRef, UInt8 *greenRef, UInt8 *blueRef) {
        *redRef = *redRef * darkValue;
        *greenRef = *greenRef * darkValue;
        *blueRef = *blueRef * darkValue;
    }];
}
+(UIImage *)imageWithImage:(UIImage *)image pixelOperationBlock:(void(^)(UInt8 *redRef, UInt8 *greenRef, UInt8 *blueRef))block
{
    if(block == nil)
        return image;
    
    CGImageRef  imageRef = image.CGImage;
    if(imageRef == NULL)
        return nil;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef   data = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
            
            // RGB値を取得
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            block(&red,&green,&blue);
            
            *(tmp + 0) = red;
            *(tmp + 1) = green;
            *(tmp + 2) = blue;
        }
    }
    
    // 効果を与えたデータ生成
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    // 画像を生成
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [UIImage imageWithCGImage:effectedCgImage];
    
    // データの解放
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}
@end
