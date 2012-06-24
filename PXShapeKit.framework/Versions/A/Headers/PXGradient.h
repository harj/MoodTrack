//
//  PXGradient.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/8/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXGradient : NSObject

@property (nonatomic) NSMutableArray *offsets, *colors;
@property (nonatomic) CGAffineTransform transform;
@property (readonly) CGGradientRef gradient;

- (void)addColor:(UIColor *)color withOffset:(CGFloat)offset;

@end
