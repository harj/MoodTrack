//
//  PXScope.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/11/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXExpression.h"

@interface PXScope : NSObject

@property (nonatomic, strong) PXScope *parentScope;
@property (readonly, nonatomic, strong) NSMutableArray *childScopes;

- (id<PXExpression>)expressionForKey:(NSString *)key;
- (void)addExpression:(id<PXExpression>)expression forKey:(NSString *)key;
- (void)addFloat:(float)floatValue forKey:(NSString *)key;
- (void)addNumber:(NSNumber *)number forKey:(NSString *)key;
- (void)removeExpressionForKey:(NSString *)key;

@end
