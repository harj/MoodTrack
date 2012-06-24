//
//  PXCircle.h
//  Shapes
//
//  Created by Kevin Lindsey on 5/31/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXShape.h"

@interface PXCircle : PXShape

@property CGPoint center;
@property CGFloat radius;

-(id) initCenter:(CGPoint)aCenter radius:(CGFloat) aRadius;

@end
