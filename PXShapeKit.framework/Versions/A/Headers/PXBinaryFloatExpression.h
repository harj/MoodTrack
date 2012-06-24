//
//  PXBinaryFloatExpression.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/11/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXBaseExpression.h"

typedef enum {
    kAddition,
    kSubstraction,
    kMultiplication,
    kDivision
} BinaryOperatorType;

@interface PXBinaryFloatExpression : PXBaseExpression

@property id<PXExpression> lhs, rhs;
@property BinaryOperatorType operatorType;

- (id)initLHS:(id<PXExpression>)lhs RHS:(id<PXExpression>)rhs withOperatorType:(BinaryOperatorType)operatorType;

@end
