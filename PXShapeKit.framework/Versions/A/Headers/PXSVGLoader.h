//
//  PXSVGLoader.h
//  Shapes
//
//  Created by Kevin Lindsey on 6/4/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PXScene;

@interface PXSVGLoader : NSObject <NSXMLParserDelegate>

+ (PXScene *) loadFromURL:(NSURL *)URL;

@end
