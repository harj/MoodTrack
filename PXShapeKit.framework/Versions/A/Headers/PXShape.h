//
//  PXShape.h
//  Shapes
//
//  Created by Kevin Lindsey on 5/30/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXRenderable.h"
#import "PXStyleable.h"
#import "PXScene.h"
#import "PXExpression.h"

@interface PXShape : NSObject <PXRenderable,PXStyleable>

@property (readonly, nonatomic) CGPathRef path;
@property (readonly, nonatomic) PXScene *owningScene;

- (void)addExpression:(id<PXExpression>)expression forKey:(NSString *)key;
- (void)removeExpressionForKey:(NSString *)key;

- (CGPathRef)buildPath;
- (void)clearPath;
- (void)renderChildren:(CGContextRef)context;

@end
