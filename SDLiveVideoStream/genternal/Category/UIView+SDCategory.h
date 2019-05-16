//
//  UIView+BCCategory.h
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SDCategory)



/**
 *  获取x
 */
- (CGFloat)sd_x;
/**
 *  获取y
 */
- (CGFloat)sd_y;
/**
 *  获取width
 */
- (CGFloat)sd_width;
/**
 *  获取height
 */
- (CGFloat)sd_height;
/**
 *  获取size
 */
- (CGSize)sd_size;


/**
 *  设置x坐标
 */
- (void)setSd_x:(CGFloat)originX;
/**
 *  设置y坐标
 */
- (void)setSd_y:(CGFloat)originY;
/**
 *  设置with宽度
 */
- (void)setSd_width:(CGFloat)width;
/**
 *  设置height宽度
 */
- (void)setSd_height:(CGFloat)height;

/**
 *  增加with宽度
 */
- (void)sd_addWidth:(CGFloat)width;
/**
 *  增加height宽度
 */
- (void)sd_addHeight:(CGFloat)height;

/**
 *  减少with宽度
 */
- (void)sd_subWidth:(CGFloat)width;
/**
 *  减少height宽度
 */
- (void)sd_subHeight:(CGFloat)height;


/**
 *  设置size大小
 */
- (void)sd_setSize:(CGSize)size;

////打印frame的大小
-(void)sd_logFrame:(NSString *)tip;

// 移除此view上的所有子视图
- (void)sd_removeAllSubviews;
//移除指定的tag的view
- (void)sd_removeViewWithTag:(NSInteger)tag;
//查找指定的view
- (id)sd_findViewWithTag:(NSInteger)tag;
// 通过类名获取指定view  fg 获取系统uipageviewcontroller隐藏控件  clazz:[UIScrollView Class]
- (id)sd_findSubviewWithClass:(Class)clazz;
//获取ViewController  时间响应链
- (id)sd_viewController;


// 加载Xib
+ (id)sd_loadNib;
// 加载Xib
+ (id)sd_loadNibName:(NSString*)nibName;


//添加圆角、边框
-(void)sd_addCornerRadiusBorder:(CGFloat)cornerRadius  borderWidth:(CGFloat)borderWidth   borderColor:(UIColor*)borderColor;
//加圆角
-(void)sd_addCornerRadius:(CGFloat)cornerRadius;
//加边框
-(void)sd_addCornerBorder:(CGFloat)borderWidth   borderColor:(UIColor*)borderColor;
//半角边
-(void)sd_addHalfCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii  borderWidth:(CGFloat)borderWidth   borderColor:(UIColor*)borderColor;

@end
