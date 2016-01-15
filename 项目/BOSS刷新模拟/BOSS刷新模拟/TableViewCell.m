//
//  TableViewCell.m
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/9.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "TableViewCell.h"
#define MyCustomButton(value,imageName,titleName)\
- (MyButton *)value{\
if(value == nil){\
    value = [[MyButton alloc]init];\
    value.title = titleName;\
    value.image = [UIImage imageNamed:imageName];\
    value.backgroundColor = [UIColor clearColor];\
    [self.myContentView addSubview:value];\
}\
return value;\
}
//WithFrame:CGRectMake(10, 10, 40, 40)
@interface TableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong)UILabel *myTitleLabel;
@property (nonatomic, strong)UILabel *salary;
@property (nonatomic, strong)MyButton *locationBtn;
@property (nonatomic, strong)MyButton *yearBtn;
@property (nonatomic, strong)MyButton *educationBtn;
@end

@implementation TableViewCell
@synthesize locationBtn;
@synthesize yearBtn;
@synthesize educationBtn;

- (CAShapeLayer *)shapeLayer:(CGPoint)point{
//    if(_shapeLayer == nil){
    CAShapeLayer *_shapeLayer = nil;
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.path = [self path:point];
        _shapeLayer.lineWidth = 0.3;
        [_shapeLayer setStrokeColor:[[UIColor colorWithRed:244/255 green:244/255 blue:244/255 alpha:1.0] CGColor]];
        _shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:3.5],
                                       [NSNumber numberWithInt:1.5],
                                       nil];
        //_shapeLayer.masksToBounds = YES;
//    }
    return _shapeLayer;
}
- (UILabel *)myTitleLabel{
    if(_myTitleLabel == nil){
        _myTitleLabel = [[UILabel alloc]init];
        _myTitleLabel.textColor = [UIColor colorWithRed:78/255.f green:195/255.f blue:185/255.f alpha:1.0];
        _myTitleLabel.font = [UIFont fontWithName:@"lowanOldStyle-Bold" size:24];
        _myTitleLabel.text = @"iOS开发工程师";
        [self.myContentView addSubview:self.myTitleLabel];
    }
    return _myTitleLabel;
}
- (CGMutablePathRef)path:(CGPoint)point{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth([UIScreen mainScreen].bounds)-20-point.x, point.y);
   
    return path;
}
- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.myContentView.layer.cornerRadius = 6;
    self.myContentView.layer.masksToBounds = YES;
    
    self.topHeightConstraint.constant = 57;
    self.bottomHeightConstraint.constant = 27;
    
    [self.myContentView.layer addSublayer:[self shapeLayer:CGPointMake(10, 57)]];
    [self.myContentView.layer addSublayer:[self shapeLayer:CGPointMake(10, CGRectGetHeight(self.myContentView.frame)-27)]];
    
    [self.topView addSubview:self.locationBtn];
    [self.topView addSubview:self.yearBtn];
    [self.topView addSubview:self.educationBtn];
}
MyCustomButton(locationBtn, @"location",@"上海");
MyCustomButton(yearBtn, @"location",@"1-3年");
MyCustomButton(educationBtn, @"location",@"本科");
- (UILabel *)salary{
    if(_salary == nil){
        _salary = [[UILabel alloc]init];
        _salary.text = @"￥10k-20k";
        _salary.textColor = [UIColor redColor];
        _salary.font = [UIFont fontWithName:@"Thonburi" size:14];
        [self.topView addSubview:_salary];
    }
    return _salary;
}
- (void)layoutSubviews{
    [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myContentView.mas_top).with.offset(9);
        make.left.equalTo(self.myContentView.mas_left).with.offset(8);
        make.width.with.offset(200);
        
    }];
    [self.salary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).with.offset(8);
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(8.5);
        make.width.with.offset(80);
        make.height.with.offset(40);
    }];
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(9);
        make.left.equalTo(self.salary.mas_right).with.offset(8);
        make.width.with.offset(45);
        make.height.with.offset(40);
    }];
    [self.locationBtn update];
    [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(9);
        make.left.equalTo(self.locationBtn.mas_right).with.offset(8);
        make.width.with.offset(45);
        make.height.with.offset(40);
    }];
    [self.yearBtn update];
    [self.educationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView.mas_bottom).with.offset(9);
        make.left.equalTo(self.yearBtn.mas_right).with.offset(8);
        make.width.with.offset(45);
        make.height.with.offset(40);
    }];
    [self.educationBtn update];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


#define MyFrameToCenter(frame) ({\
CGPoint center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);\
CGFloat radius = MIN(center.x, center.y);\
CGRect myframe = CGRectMake(0, center.y-radius, 2*radius, 2*radius);\
myframe;})\


#define RepeatCode if (self.title&&!self.image) {\
self.titleFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);\
}\
if(self.title&&self.image){\
    CGFloat width = CGRectGetWidth(frame)/kScale;\
    self.imageFrame = CGRectMake(0, 0, width, CGRectGetHeight(frame));\
    self.titleFrame = CGRectMake(width, 0, CGRectGetWidth(frame)-width, CGRectGetHeight(frame));\
}\
if(self.image&&!self.title){\
    self.imageFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);\
}

@interface  MyButton()
@property (nonatomic, assign)CGImageRef imageRef;
@property (nonatomic, assign)CGRect imageFrame;
@property (nonatomic, assign)CGRect titleFrame;
@property (nonatomic, assign)BOOL usedConstrain;
#define kScale 3;
#define kOffX 5;
@end
@implementation MyButton

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageRef = image.CGImage;
    if(self.title){
        
    }else{
        self.imageFrame = self.bounds;
    }
    [self setNeedsDisplay];
}
//- (void)layoutSubviews{
//    
//    [self setNeedsDisplay];
//}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    RepeatCode;
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    if(self.image){
        CGFloat x = CGRectGetWidth(self.frame)/kScale;
        CGFloat widht = CGRectGetWidth(self.frame)-x;
        self.titleFrame = CGRectMake(x, 0, widht, CGRectGetHeight(self.frame));
    }else{
        self.titleFrame = self.bounds;
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    if(rect.size.height == 0){
        return;
        
    }
    if(self.usedConstrain){
        rect.size.height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
#if 1
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextTranslateCTM(ctx, 0, rect.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextDrawImage(ctx, MyFrameToCenter(self.imageFrame),self.imageRef);
    CGContextRestoreGState(ctx);
    
    [self drawString:self.title inRect:self.titleFrame font:[UIFont fontWithName:@"GillSans-Light" size:14] textColor:[UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1.0]];
#endif
   
}
- (void)update{
    CGRect frame =  CGRectZero;
    frame.size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    frame.origin = CGPointZero;
    
    RepeatCode;
    [self setNeedsDisplay];
}
#pragma mark ---- paragraphStyle.alignment = NSTextAlignmentCenter;在这里仅仅作用是水平方向上有效
- (CGRect )drawString:(NSString *)text
            inRect:(CGRect)contextRect
              font:(UIFont *)font
         textColor:(UIColor *)textColor
{
    
    CGFloat fontHeight = font.lineHeight;
    CGFloat yOffset = floorf((contextRect.size.height - fontHeight) / 2.0) + contextRect.origin.y;
    
    CGRect textRect = CGRectMake(contextRect.origin.x, yOffset, contextRect.size.width, fontHeight);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];//[[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [text drawInRect:textRect withAttributes:@{
                                               NSForegroundColorAttributeName: textColor,
                                               NSFontAttributeName: font,
                                               NSParagraphStyleAttributeName: paragraphStyle}];
    return textRect;
}
@end