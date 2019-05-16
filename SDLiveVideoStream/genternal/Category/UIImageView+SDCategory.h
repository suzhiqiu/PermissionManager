//
//  UIImageView+CXFadeInFadeOut.h
//  网络加载图片淡出效果
//
//  Created by 蔡翔 on 16/7/29.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (SDCategory)

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder animateWithDuration:(CGFloat)duration;

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options;

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock;

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options animateWithDuration:(CGFloat)duration;

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options animateWithDuration:(CGFloat)duration  completed:(SDWebImageCompletionBlock)completedBlock;

@end
