//
//  PXStyleable.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/11/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXPaint.h"

@class PXShape;

@protocol PXStyleable <NSObject>

// stroke-related properties
@property (nonatomic, strong) id<PXPaint> strokeColor;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic, strong) NSArray* dashArray;
@property (nonatomic) CGFloat dashOffset;
@property (nonatomic) CGLineCap lineCap;
@property (nonatomic) CGLineJoin lineJoin;
@property (nonatomic) CGFloat miterLimit;

// fill-related properties
@property (nonatomic, strong) id<PXPaint> fillColor;

// other properties
@property (nonatomic) CGFloat opacity;
@property (nonatomic) BOOL visible;

// NOTE: ideally the type here should be a protocol that returns a CGPathRef
@property (nonatomic, strong) PXShape *clippingPath;

@end
