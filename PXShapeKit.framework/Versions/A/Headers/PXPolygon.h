//
//  PXPolygon.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/9/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import "PXShape.h"

@interface PXPolygon : PXShape

@property (nonatomic) BOOL closed;
@property (nonatomic, strong) NSArray *points;

- (id)initWithPoints:(NSArray *)pointArray;

@end
