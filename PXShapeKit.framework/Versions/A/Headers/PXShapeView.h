//
//  PXShapeView.h
//  Shapes
//
//  Created by Kevin Lindsey on 5/30/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXScene.h"

@interface PXShapeView : UIView

@property (nonatomic, strong) PXScene *scene;
@property (nonatomic, strong) NSString *resourcePath;

@property (nonatomic) CGPoint shapeCenter;
@property (nonatomic) CGPoint shapeTranslation;
@property (nonatomic) CGPoint shapeScale;
@property (nonatomic) CGFloat shapeRotation;
@property (readonly) CGAffineTransform shapeTransform;

- (void) resetTransforms;
- (void) applyBoundsToScene;

@end
