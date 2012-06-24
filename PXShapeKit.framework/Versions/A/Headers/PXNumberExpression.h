//
//  PXNumberExpression.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/12/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXBaseExpression.h"

@interface PXNumberExpression : PXBaseExpression

+ (PXNumberExpression *)ONE;

- (id)initWithNumber:(NSNumber *)aNumber;

@property (readonly, nonatomic, strong) NSNumber *number;

@end
