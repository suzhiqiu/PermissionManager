//
//  UIImageView+CXFadeInFadeOut.m
//  网络加载图片淡出效果
//
//  Created by 蔡翔 on 16/7/29.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "UIImageView+SDCategory.h"

@implementation UIImageView (Fade)

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setImageFadeWithURL:url placeholderImage:placeholder  animateWithDuration:0.5f];
}

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder animateWithDuration:(CGFloat)duration
{
    //SDWebImageRetryFailed  下载失败可以重试  SDWebImageLowPriority  滑动的时候也可以下载图片
    [self sd_setImageFadeWithURL:url placeholderImage:placeholder options: SD_FF_OPTIONS  animateWithDuration:duration];
}

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self sd_setImageFadeWithURL:url placeholderImage:placeholder options:options animateWithDuration:0.2];
}

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock{
    
    [self sd_setImageFadeWithURL:url placeholderImage:placeholder options:options animateWithDuration:0.2 completed:completedBlock];
}

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options animateWithDuration:(CGFloat)duration
{
    [self sd_setImageFadeWithURL:url placeholderImage:placeholder options:options animateWithDuration:duration completed:nil];
}

- (void)sd_setImageFadeWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options animateWithDuration:(CGFloat)duration  completed:(SDWebImageCompletionBlock)completedBlock
{
    __weak typeof(self) wself = self;
    
    [self sd_setImageWithURL:url placeholderImage:placeholder  options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(completedBlock){
            completedBlock(image,error,cacheType,imageURL);
        }
        
        if(image && cacheType ==SDImageCacheTypeNone)
        {
            wself.alpha=0.0f;
            
            [UIView animateWithDuration:duration animations:^{
                
                wself.alpha=1.0f;
            }];
            
        }else
        {
            wself.alpha=1.0f;
        }
        
    }];
}
@end
