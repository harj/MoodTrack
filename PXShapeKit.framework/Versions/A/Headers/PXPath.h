//
//  PXPath.h
//  Shapes
//
//  Created by Kevin Lindsey on 5/31/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXShape.h"

@interface PXPath : PXShape 

+ (PXPath *)createPathFromPathData:(NSString *)data;

- (void)close;
- (void)lineToX:(CGFloat)anX y:(CGFloat) aY;
- (void)moveToX:(CGFloat)anX y:(CGFloat) aY;
- (void)cubicBezierToX1:(CGFloat)anX1 y1:(CGFloat)aY1 x2:(CGFloat)anX2 y2:(CGFloat)aY2 x3:(CGFloat)anX3 y3:(CGFloat)aY3;
- (void)quadraticBezierToX1:(CGFloat)anX1 y1:(CGFloat)aY1 x2:(CGFloat)anX2 y2:(CGFloat)aY2;

@end
