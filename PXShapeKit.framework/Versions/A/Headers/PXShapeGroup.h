//
//  PXShapeGroup.h
//  Shapes
//
//  Created by Kevin Lindsey on 6/1/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXShape.h"
#import "PXRenderable.h"

typedef enum {
    kAlignViewPortNone,
    kAlignViewPortXMinYMin,
    kAlignViewPortXMinYMid,
    kAlignViewPortXMinYMax,
    kAlignViewPortXMidYMin,
    kAlignViewPortXMidYMid,
    kAlignViewPortXMidYMax,
    kAlignViewPortXMaxYMin,
    kAlignViewPortXMaxYMid,
    kAlignViewPortXMaxYMax,
} AlignViewPortType;

typedef enum {
    kCropTypeMeet,
    kCropTypeSlice
} CropType;

@interface PXShapeGroup : PXShape

@property CGFloat width, height;
@property (nonatomic) CGRect viewport;
@property (nonatomic) AlignViewPortType viewportAlignment;
@property (nonatomic) CropType viewportCrop;

- (void)addShape:(id<PXRenderable>)shape;
- (void)removeShape:(id<PXRenderable>)shape;

@end
