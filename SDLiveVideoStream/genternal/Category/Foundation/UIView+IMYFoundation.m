//
//  UIView+IMYFoundation.m
//  IMYFoundation
//


#import "UIView+IMYFoundation.h"

@implementation UIView (IMYFoundation)

- (void)imy_removeAllSubviews {
    NSArray *array = self.subviews;
    for (UIView *subview in array) {
        [subview removeFromSuperview];
    }
}

- (id)imy_findParentViewWithClass:(Class)clazz {
    return [self imy_findParentViewWithFilterBlock:^BOOL(UIView *_Nonnull view) {
        return [view isKindOfClass:clazz];
    }];
}

- (id)imy_findParentViewWithClasses:(NSArray<Class> *)classes {
    return [self imy_findParentViewWithFilterBlock:^BOOL(UIView *_Nonnull view) {
        for (Class clazz in classes) {
            if ([view isKindOfClass:clazz]) {
                return YES;
            }
        }
        return NO;
    }];
}

- (id)imy_findParentViewWithFilterBlock:(BOOL (^)(UIView *))filter {
    if (filter(self)) {
        return self;
    }
    UIView *view = self.superview;
    while (view && !filter(view)) {
        view = view.superview;
    }
    return view;
}

- (id)imy_findSubviewWithClass:(Class)clazz {
    UIView *resultView = nil;

    NSMutableArray *stackArray = [NSMutableArray array];
    NSArray *subviews = self.subviews;
    ///使用堆栈 模拟递归效果
    while (subviews.count > 0) {
        for (UIView *subview in subviews) {
            if ([subview isKindOfClass:clazz]) {
                resultView = subview;
                break;
            } else if (subview.subviews.count > 0) {
                [stackArray addObject:subview];
            }
        }
        if (resultView) {
            break;
        }
        if (stackArray.count > 0) {
            UIView *view = stackArray.lastObject;
            subviews = view.subviews;

            [stackArray removeLastObject];
        } else {
            subviews = nil;
        }
    }
    return resultView;
}
- (id)imy_findViewWithTag:(NSInteger)tag {
    UIView *resultView = nil;
    NSArray *subviews = self.subviews;
    for (UIView *subview in subviews) {
        if (subview.tag == tag) {
            resultView = subview;
            break;
        }
    }
    return resultView;
}
- (id)imy_viewController {
    UIView *next = self;
    do {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
        next = next.superview;
    } while (next);
    return nil;
}

- (CGFloat)imy_left {
    return self.frame.origin.x;
}

- (void)setImy_left:(CGFloat)left {
    CGRect frame = self.frame;
    if (frame.origin.x != left) {
        frame.origin.x = left;
        self.frame = frame;
    }
}

- (CGFloat)imy_top {
    return self.frame.origin.y;
}

- (void)setImy_top:(CGFloat)top {
    CGRect frame = self.frame;
    if (frame.origin.y != top) {
        frame.origin.y = top;
        self.frame = frame;
    }
}

- (CGFloat)imy_right {
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

- (void)setImy_right:(CGFloat)right {
    CGRect frame = self.frame;
    CGFloat newRight = right - frame.size.width;
    if (frame.origin.x != newRight) {
        frame.origin.x = newRight;
        self.frame = frame;
    }
}

- (CGFloat)imy_bottom {
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (void)setImy_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    CGFloat newBottom = bottom - frame.size.height;
    if (frame.origin.y != newBottom) {
        frame.origin.y = newBottom;
        self.frame = frame;
    }
}

- (CGFloat)imy_centerX {
    return self.center.x;
}

- (void)setImy_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    if (center.x != centerX) {
        center.x = centerX;
        self.center = center;
    }
}

- (CGFloat)imy_centerY {
    return self.center.y;
}

- (void)setImy_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    if (center.y != centerY) {
        center.y = centerY;
        self.center = center;
    }
}

- (CGFloat)imy_width {
    return self.frame.size.width;
}

- (void)setImy_width:(CGFloat)width {
    if (isnan(width)) {
        width = 0;
    }
    CGRect frame = self.frame;
    if (frame.size.width != width) {
        frame.size.width = width;
        self.frame = frame;
    }
}

- (CGFloat)imy_height {
    return self.frame.size.height;
}

- (void)setImy_height:(CGFloat)height {
    if (isnan(height)) {
        height = 0;
    }
    CGRect frame = self.frame;
    if (frame.size.height != height) {
        frame.size.height = height;
        self.frame = frame;
    }
}

- (CGSize)imy_size {
    return self.frame.size;
}

- (void)setImy_size:(CGSize)size {
    CGRect frame = self.frame;
    if (!CGSizeEqualToSize(frame.size, size)) {
        frame.size = size;
        self.frame = frame;
    }
}

- (CGPoint)imy_origin {
    return self.frame.origin;
}

- (void)setImy_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    if (!CGPointEqualToPoint(frame.origin, origin)) {
        frame.origin = origin;
        self.frame = frame;
    }
}

- (CGPoint)imy_selfcenter {
    CGRect frame = self.frame;
    return CGPointMake(frame.size.width / 2, frame.size.height / 2);
}

- (void)imy_sizeToFit {
    [self sizeToFit];
    CGRect frame = self.frame;
    CGRect toFrame = CGRectMake(ceil(frame.origin.x), ceil(frame.origin.y), ceil(frame.size.width), ceil(frame.size.height));
    if (!CGRectEqualToRect(frame, toFrame)) {
        self.frame = toFrame;
    }
}

@end
