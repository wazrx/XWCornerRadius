//
//  UIView+XWAddForRoundedCorner.h
//  PlayCornerRadius
//
//  Created by 肖文 on 2017/1/18.
//  Copyright © 2017年 肖文. All rights reserved.
//  该类设置圆角的原理为在view的最上层绘制一张相应的遮罩图片，图片的背景只要保证和view的父视图背景色一样，就能达到圆角的效果，

#import <UIKit/UIKit.h>

@interface UIView (XWAddForRoundedCorner)


/**
 设置一个四角圆角

 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)xw_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角

 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)xw_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角

 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)xw_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end

@interface CALayer (XWAddForRoundedCorner)

@property (nonatomic, strong) UIImage *contentImage;//contents的便捷设置

/**如下分别对应UIView的相应API*/

- (void)xw_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)xw_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)xw_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
