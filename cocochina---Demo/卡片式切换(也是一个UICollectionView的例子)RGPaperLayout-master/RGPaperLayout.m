//
//  RGPapersLayout.m
//  RGPapersLayout
//
//  Created by ROBERA GELETA on 2/23/15.
//  Copyright (c) 2015 ROBERA GELETA. All rights reserved.
//



#import "RGPaperLayout.h"

@implementation RGPaperLayout
{
    CGFloat previousOffset;
    CGFloat _visibleRectWidth;
    
}
@synthesize maxAngle = _maxAngle;

- (void)prepareLayout {
    [super prepareLayout];
    [self setupLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
#if 0
这个是代理方法，返回单个cell的尺寸--也可以通过UICollectionViewLayoutAttributes去分别设置每个cell的尺寸
- (CGSize)collectionViewContentSize
{
    return CGSizeZero;
}
#endif
- (void)setupLayout
{
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.width /1.5, self.collectionView.bounds.size.height/1.5);
    _visibleRectWidth = self.collectionView.bounds.size.width;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled  = NO;
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attribs = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;//根据collectView当前滚动到的位置来计算可见的范围rect
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    CGFloat collectionViewHeight = self.collectionView.bounds.size.height/1.9;
    
    for (UICollectionViewLayoutAttributes *attributes in attribs) {
        if (CGRectIntersectsRect(attributes.frame, rect))//判断两个矩形(attributes.frame,rect)是否有交叉--
                                                         //也就是判断当前的cell是否可见
        {
            CGFloat cardX = attributes.center.x;
            //计算当前可见矩形中心点x的位置
            CGFloat distance =  self.collectionView.contentOffset.x + (1/2.0 * _visibleRectWidth);
            //获取当前cell的中心点x的相对于屏幕的位置
            CGFloat computedOffset = cardX  - distance;
            
            CGFloat fractionComputedOffset = computedOffset /(attributes.bounds.size.width /17.0);
            CGFloat fraction = computedOffset/ attributes.bounds.size.width;//获取偏移位置相对于cell宽度的倍数
            
            fraction = [self allowedRadian:fraction index:[attribs indexOfObject:attributes]];
            CGFloat offset = fabsf((fractionComputedOffset)* (1 - fabsf(cosf(fraction))));//这个是cell的y随着旋转角的增大，而增大
            CGFloat yComputedOffset = collectionViewHeight + offset;
            attributes.center = CGPointMake(attributes.center.x, yComputedOffset + 0.4*(collectionViewHeight));
            
            //transform
            attributes.transform3D  = [self transformFromFraction:fraction];
            
            
            
        }
    }
    
    return attribs;
}

- (CGFloat)allowedRadian:(CGFloat)angle index:(NSInteger)index
{//这里之所以要判断90°的特殊情况，是因为大于90°余玄值小于0，小于90°的余玄值大于0，所以上面的fabsf((fractionComputedOffset)* (1 - fabsf(cosf(fraction))));方法，会在大于90°的时候随着角度的减小而增大，当角度小于90°的时候，会随着角度的减小而增大
    if(angle > M_PI/2)//90弧度
    {
        angle = M_PI/2;
    }else if (angle < (-1 *M_PI/2))
    {
        angle = -1 * M_PI /2;
    }
    return angle;
    
}


- (CATransform3D)transformFromFraction:(CGFloat)fraction
{
    CATransform3D t = CATransform3DIdentity;
    t.m34 = 1.0/5000;//透视效果，要操作的这个对象要有旋转的角度，且必须要放在旋转之前，否则没有效果。正直/负值都有意义
    //负值表示焦点沿Z轴的负方向移动----值越大越接近于被投影对象的真实大小
    //正值表示焦点沿Z轴的正方向移动
    /*
     m34矩阵值得作用：
     m34负责z轴方向的translation（移动），m34= -1/D,  默认值是0，也就是说D无穷大，这意味layer in projection plane（投射面）和layer in world coordinate重合了。D值越大效果越明显
     上面最重要的是m34这个属性，CATransform3DRotate获取的旋转如果之前联合的transform不支持透视，那在x、y轴上做旋转是只有frame放大缩小的变化，我们需要的是在旋转的时候要使得离视角近的地方放大，离视角远的地方缩小，就是所谓的视差来形成3D的效果。
     */
    CGFloat radianFraction = fraction * self.maxAngle;
    t = CATransform3DRotate(t, radianFraction, 0, 0, 1);
    return t;
}

- (CGRect)newYCenterFromFraction:(CGFloat)fraction
{
    CGRect newY;
    
    return newY;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}



#pragma mark - Lazy Loading
- (void)setMaxAngle:(CGFloat)maxAngle
{
    _maxAngle = maxAngle;
    [self invalidateLayout];
}


- (CGFloat)maxAngle
{
    if(_maxAngle == 0)
    {
        _maxAngle = 0.15;
    }
    return _maxAngle;
}


@end
