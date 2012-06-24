//
//  PXPaint.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/7/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PXPaint <NSObject>

- (void)applyStrokeToPath:(CGPathRef)path withContext:(CGContextRef)context;
- (void)applyFillToPath:(CGPathRef)path withContext:(CGContextRef)context;

@end
