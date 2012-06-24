//
//  PXRadialGradient.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/8/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXGradient.h"
#import "PXPaint.h"

@interface PXRadialGradient : PXGradient <PXPaint>

@property (nonatomic) CGPoint startCenter, endCenter;
@property (nonatomic) CGFloat radius;

@end
