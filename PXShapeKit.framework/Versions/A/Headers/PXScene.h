//
//  PXScene.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/11/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXRenderable.h"

@interface PXScene : NSObject <PXRenderable>

@property (nonatomic) CGRect bounds;
@property (nonatomic, strong) id<PXRenderable> shape;

- (id<PXRenderable>)shapeForName:(NSString *)name;
- (void)addShape:(id<PXRenderable>)shape forName:(NSString *)name;

@end
