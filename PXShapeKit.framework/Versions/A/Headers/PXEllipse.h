//
//  PXEllipse.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/6/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXShape.h"

@interface PXEllipse : PXShape

@property CGPoint center;
@property CGFloat radiusX, radiusY;

- (id)initCenter:(CGPoint)aCenter radiusX:(CGFloat)aRadiusX radiusY:(CGFloat)aRadiusY;

@end
