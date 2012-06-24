//
//  PXRenderable.h
//  ShapeKit
//
//  Created by Kevin Lindsey on 5/30/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXScope.h"

@protocol PXRenderable <NSObject>

@property (nonatomic, strong) id<PXRenderable> parent;
@property (nonatomic, strong) PXScope *scope;
@property CGAffineTransform transform;

-(void) render:(CGContextRef) context;

@end
