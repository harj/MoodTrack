//
//  PXSolidPaint.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/7/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXPaint.h"

@interface PXSolidPaint : NSObject <PXPaint>

@property (nonatomic, strong) UIColor *color;

+ (PXSolidPaint *)blackPaint;

- (id)initWithColor:(UIColor *)aColor;

@end
