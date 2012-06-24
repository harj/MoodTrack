//
//  PXExpression.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/12/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PXScope;

@protocol PXExpression <NSObject>

// predicates
- (BOOL) hasNumberValue;
- (BOOL) hasObjectValue;

// getters
- (NSNumber *)numberFromScope:(PXScope *)scope;
- (float)floatFromScope:(PXScope *)scope;
- (id)objectFromScope:(PXScope *)scope;

@end
