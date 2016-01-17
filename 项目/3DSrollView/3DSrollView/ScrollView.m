//
//  ScrollView.m
//  3DSrollView
//
//  Created by lizhongqiang on 16/1/15.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ScrollView.h"
#import "ImageView.h"
@interface ScrollView()
{
    CGFloat oldOffsetX;
}
#define Testing \
CGFloat width = CGRectGetWidth(scrollView.frame);\
if (scrollView.contentOffset.x <= 0) {\
    scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-2*width, 0);\
}else if(scrollView.contentOffset.x >= scrollView.contentSize.width-width){\
    scrollView.contentOffset  = CGPointMake(width, 0);\
}

@property (nonatomic, assign)CGRect visibleRect;
@property (nonatomic, strong)ImageView *last;
@property (nonatomic, strong)ImageView *current;
@property (nonatomic, strong)ImageView *next;
@end
@implementation ScrollView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectOffset(frame, -frame.origin.x, -frame.origin.y)];
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor yellowColor];
        self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        
        self.scrollView.pagingEnabled = YES;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self addSubview:self.scrollView];
    }
    return self;
}
- (void)setImagesArray:(NSArray *)imagesArray{
    _imagesArray = imagesArray;
    for(int i=0; i<imagesArray.count+2; i++){//8--7
        NSString *imageName = nil;
        if(i==0){
            imageName = [imagesArray lastObject];
        }else if(i == imagesArray.count+1){
            imageName = [imagesArray firstObject];
        }else{
            imageName = [imagesArray objectAtIndex:i-1];
        }
        [self.scrollView addSubview:[self imageView:CGPointMake(i*CGRectGetWidth(self.scrollView.frame), 0) frame:self.scrollView.frame tag:i+1 imageName:imageName]];
    }
    self.scrollView.contentSize = CGSizeMake((imagesArray.count+2)*CGRectGetWidth(self.scrollView.frame), 0);
}
//在scrollView.contentOffset第一次手动设置的时候，观察者是无法获取到的scrollView.contentOffset变化的
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    UIScrollView *scrollView = (UIScrollView *)object;
    self.currentPage = (scrollView.contentOffset.x)/CGRectGetWidth(self.scrollView.frame)+1;
    
    
    if(self.lastPage!=self.currentPage){
        self.lastPage = self.currentPage;
        
        self.last = [scrollView viewWithTag:self.currentPage-1];
        self.current = [scrollView viewWithTag:self.currentPage];
        self.next = [scrollView viewWithTag:self.currentPage+1];
    }
#if 1

    if(oldOffsetX>scrollView.contentOffset.x+20){
        self.direction = Right;
    }else if (oldOffsetX<scrollView.contentOffset.x+20){
        self.direction = Left;
    }
    self.visibleRect = CGRectOffset(self.frame, scrollView.contentOffset.x, 0);
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[ImageView class]]){
            ImageView *view = (ImageView *)obj;
            view.direction = (MyDirection)self.direction;
        }
        
    }];
#if 1
    if (self.currentPage == 0) {
        return;
    }
    [self.current currentPageMove:scrollView.contentOffset.x-(self.currentPage-1)*CGRectGetWidth(self.scrollView.frame)];
    
    [self.next nextPageMove:scrollView.contentOffset.x-(self.currentPage-1)*CGRectGetWidth(self.scrollView.frame)];
    
#endif
    oldOffsetX = scrollView.contentOffset.x;
#endif
}
//scrollViewDidScroll方法获取到的scrollView。contentOffset没有，对scrollView添加观察者，观察的准确，
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    Testing;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    Testing;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    Testing;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    Testing;
}
- (ImageView *)imageView:(CGPoint)point frame:(CGRect)frame tag:(int)tag imageName:(NSString *)name{
    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(point.x, point.y, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    imageView.image = [UIImage imageNamed:name];
    imageView.tag = tag;
    imageView.backgroundColor = [UIColor colorWithRed:(arc4random()%255/255.0 )green:(arc4random()%255/255.0 ) blue:(arc4random()%255/255.0 ) alpha:1.0];//[UIColor redColor];//
    return imageView;
   
}
@end