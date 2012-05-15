//
//  MoodGraphViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface MoodGraphViewController : UIViewController
<CPTPlotDataSource,CPTAxisDelegate>

{
	CPTXYGraph *graph;
    
	NSMutableArray *dataForPlot;
}

@property (nonatomic, retain) NSMutableArray *dataForPlot;
@property (nonatomic, retain) CPTGraphHostingView *hostingView;

@end
