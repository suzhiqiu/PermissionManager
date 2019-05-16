//
//  UIView+BCCategory.m
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import "UIView+SDCategory.h"

@implementation UIView (SDCategory)


/**
 *  获取x
 */
- (CGFloat)sd_x
{
    return self.frame.origin.x;
}

/**
 *  获取y
 */
- (CGFloat)sd_y
{
    return self.frame.origin.y;
}
/**
 *  获取width
 */
- (CGFloat)sd_width
{
    return self.frame.size.width;
}

/**
 *  获取height
 */
- (CGFloat)sd_height
{
    return self.frame.size.height;
}
/**
 *  获取size
 */
- (CGSize)sd_size
{
    return self.frame.size;
}



/**
 *  设置x坐标
 */
- (void)setSd_x:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

/**
 *  设置y坐标
 */
- (void)setSd_y:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

/**
 *  设置with宽度
 */
- (void)setSd_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
/**
 *  设置height宽度
 */
- (void)setSd_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


/**
 *  增加with宽度
 */
- (void)sd_addWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width += width;
    self.frame = frame;
}

/**
 *  增加height宽度
 */
- (void)sd_addHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height +=height;
    self.frame = frame;
}

/**
 *  减少with宽度
 */
- (void)sd_subWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width -= width;
    self.frame = frame;
}
/**
 *  减少height宽度
 */
- (void)sd_subHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height -=height;
    self.frame = frame;
}



/**
 *  设置size大小
 */
- (void)sd_setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


//打印frame的大小
-(void)sd_logFrame:(NSString *)tip
{
    NSLog(@"%@ -- %@",tip,NSStringFromCGRect(self.frame));
}



// 移除此view上的所有子视图
- (void)sd_removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

//移除指定的tag的view
- (void)sd_removeViewWithTag:(NSInteger)tag
{
    for (UIView *view in [self subviews])
    {
        if (view.tag == tag)
        {
            [view removeFromSuperview];
        }
    }
}

//查找指定的view
- (id)sd_findViewWithTag:(NSInteger)tag
{
    for (UIView *view in [self subviews])
    {
        if (view.tag == tag)
        {
            return view;
        }
    }
    return nil;
}
// 通过类名获取指定view  fg 获取系统uipageviewcontroller隐藏控件  clazz:[UIScrollView Class]
- (id)sd_findSubviewWithClass:(Class)clazz
{
    UIView* resultView = nil;
    
    NSMutableArray* stackArray = [NSMutableArray array];
    NSArray* subviews = self.subviews;
    ///使用堆栈 模拟递归效果
    while (subviews.count > 0)
    {
        for (UIView* subview in subviews)
        {
            if ([subview isKindOfClass:clazz])
            {
                resultView = subview;
                break;
            }
            else if (subview.subviews.count > 0)
            {
                [stackArray addObject:subview];
            }
        }
        if (resultView)
        {
            break;
        }
        if (stackArray.count > 0)
        {
            UIView* view = stackArray.lastObject;
            subviews = view.subviews;
            
            [stackArray removeLastObject];
        }
        else
        {
            subviews = nil;
        }
    }
    return resultView;
}


//获取ViewController  时间响应链
- (id)sd_viewController
{
    UIView* next = self;
    do {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
        next = next.superview;
        
    } while (next);
    
    return nil;
}




// 加载Xib
+ (id)sd_loadNib
{
//    NSArray *view=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
//    NSLog(@"view:%@",view);
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// 加载Xib
+ (id)sd_loadNibName:(NSString*)nibName
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
}

//添加圆角、边框
-(void)sd_addCornerRadiusBorder:(CGFloat)cornerRadius  borderWidth:(CGFloat)borderWidth   borderColor:(UIColor*)borderColor
{
    [self sd_addCornerRadius:cornerRadius];
    [self sd_addCornerBorder:borderWidth borderColor:borderColor];
}

//加圆角
-(void)sd_addCornerRadius:(CGFloat)cornerRadius
{
    [self.layer setCornerRadius:cornerRadius];
    [self.layer setMasksToBounds:YES];
}

//加边框
-(void)sd_addCornerBorder:(CGFloat)borderWidth   borderColor:(UIColor*)borderColor
{
    [self.layer setBorderWidth:borderWidth];
    
    if(borderColor)
    {
        [self.layer setBorderColor:[borderColor CGColor]];
    }
}

//半角边
-(void)sd_addHalfCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii  borderWidth:(CGFloat)borderWidth   borderColor:(UIColor*)borderColor
{

    CGRect layerFrame=self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:layerFrame byRoundingCorners:corners cornerRadii:cornerRadii];//圆角大小


    //设置遮罩
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = layerFrame;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    if (borderWidth==0)
    {
        return;
    }
    
    //设置边框
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];

    borderLayer.frame = layerFrame;
    borderLayer.path  = maskPath.CGPath;

    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth=borderWidth;

    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.strokeStart = 0.f;
    borderLayer.strokeEnd = 1.f;


    [self.layer addSublayer:borderLayer];
  
}




@end
