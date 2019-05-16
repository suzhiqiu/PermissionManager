
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (IMYFoundation)

/**
 *  @brief 移除所有的子类
 */
- (void)imy_removeAllSubviews;

/**
 *  @brief 找到第一个 这个class 的父视图
 */
- (nullable id)imy_findParentViewWithClass:(Class)clazz;
- (nullable id)imy_findParentViewWithClasses:(NSArray<Class> *)classes;
- (nullable id)imy_findParentViewWithFilterBlock:(BOOL (^)(UIView *view))filter;

/**
 *  @brief 找到第一个 这个class 的子视图
 */
- (nullable id)imy_findSubviewWithClass:(Class)clazz;

/**
 *  @brief 只会遍历 子视图，  系统的方法 会遍历子视图的子视图
 */
- (nullable id)imy_findViewWithTag:(NSInteger)tag;

/**
 *  @brief 查找当前view 的 viewController
 */
- (nullable id)imy_viewController;

@property (nonatomic) CGFloat imy_left;

@property (nonatomic) CGFloat imy_top;

@property (nonatomic) CGFloat imy_right;

@property (nonatomic) CGFloat imy_bottom;

@property (nonatomic) CGFloat imy_width;

@property (nonatomic) CGFloat imy_height;

@property (nonatomic) CGFloat imy_centerX;

@property (nonatomic) CGFloat imy_centerY;

@property (nonatomic) CGPoint imy_origin;

@property (nonatomic) CGSize imy_size;

@property (nonatomic, readonly) CGPoint imy_selfcenter;

///像素对齐的问题, 保证没有小数点
- (void)imy_sizeToFit;

@end

NS_ASSUME_NONNULL_END
