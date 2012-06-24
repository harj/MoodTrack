//
//  UIColor+PXColors.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/15/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PXColors)

+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;
+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString withAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithRGBAValue:(uint)value;
+ (UIColor *)colorWithARGBValue:(uint)value;
+ (UIColor *)colorWithRGBValue:(uint)value;

- (BOOL)getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha;

@end
