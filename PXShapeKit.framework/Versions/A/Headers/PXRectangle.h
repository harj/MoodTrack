//
//  PXRectangle.h
//  Shapes
//
//  Created by Kevin Lindsey on 5/30/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXShape.h"

@interface PXRectangle : PXShape

@property (nonatomic) CGRect bounds;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat x, y, width, height;
@property (nonatomic) CGFloat radiusX, radiusY;

- (id)initWithRect:(CGRect)rect;
- (id)initWithRect:(CGRect)rect radius:(CGFloat)radius;
- (id)initWithRect:(CGRect)rect radii:(CGSize)aRadii;

@end
