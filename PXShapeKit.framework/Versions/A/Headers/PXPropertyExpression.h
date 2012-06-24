//
//  PXPropertyExpression.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/15/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXBaseExpression.h"

@interface PXPropertyExpression : PXBaseExpression

@property (readonly, nonatomic, strong) id object;
@property (readonly, nonatomic, strong) NSString *name;

- (id)initPropertyName:(NSString *)name withObject:(id)object;

@end
