//
//  PXButton.h
//  PXComponentKit
//
//  Created by Paul Colton on 6/8/12.
//  Copyright (c) 2012 Socialdart, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PXShapeKit/PXShapeKit.h>

@interface PXButton : UIButton

@property (nonatomic, unsafe_unretained) CGFloat cornerRadius;
@property (nonatomic, unsafe_unretained) CGFloat borderWidth;
@property (nonatomic) BOOL displayShadow;

- (id<PXPaint>)backgroundPaintForState:(UIControlState)state;
- (id<PXPaint>)foregroundPaintForState:(UIControlState)state;
- (void)setBackgroundPaint:(id<PXPaint>)paint forState:(UIControlState)state;
- (void)setForegroundPaint:(id<PXPaint>)paint forState:(UIControlState)state;

@end
