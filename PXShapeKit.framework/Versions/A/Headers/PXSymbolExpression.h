//
//  PXSymbolExpression.h
//  PXShapeKit
//
//  Created by Kevin Lindsey on 6/12/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXBaseExpression.h"

@interface PXSymbolExpression : PXBaseExpression

@property (readonly, nonatomic, strong) NSString *symbol;

- (id)initWithSymbol:(NSString *)aSymbol;

@end
