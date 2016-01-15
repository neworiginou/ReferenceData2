//
//  ETZoomScrollView.h
//  ScrollViewWithZoom
//

#import <UIKit/UIKit.h>

@protocol ETZoomScrollViewDelegate <NSObject>
@optional
- (void)handleSingleTap;

@end

@interface ETZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
    UITapGestureRecognizer *singleTapGesture;
    UITapGestureRecognizer *doubleTapGesture;
    UITapGestureRecognizer *ownerGesture;
    UIView *flagView;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, assign) id<ETZoomScrollViewDelegate> tDelegate;

//- (void)reloadFrame:(float)originX;
- (void)removeAllGesture;

@end
