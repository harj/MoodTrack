//
//  PXLine.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/6/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXShape.h"

@interface PXLine : PXShape

@property (nonatomic) CGPoint p1;
@property (nonatomic) CGPoint p2;

- (id)initX1:(CGFloat)aX1 y1:(CGFloat)aY1 x2:(CGFloat)aX2 y2:(CGFloat)aY2;

@end
