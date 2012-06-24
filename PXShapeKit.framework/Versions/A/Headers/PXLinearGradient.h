//
//  PXLinearGradient.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/8/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXPaint.h"
#import "PXGradient.h"

typedef enum {
    kLinearGradientDirectionTopToBottom,
    kLinearGradientDirectionLeftToRight,
    kLinearGradientDirectionBottomToTop,
    kLinearGradientDirectionRightToLeft,
    kLinearGradientDirectionUserDefined
} LinearGradientDirectionType;

@interface PXLinearGradient : PXGradient <PXPaint>

@property (nonatomic) LinearGradientDirectionType direction;
@property (nonatomic) CGPoint p1, p2;

+ (PXLinearGradient *)gradientFromStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;
+ (PXLinearGradient *)gradientStartColorHexString:(NSString *)startColor endColorHexString:(NSString *)endColor;

@end
