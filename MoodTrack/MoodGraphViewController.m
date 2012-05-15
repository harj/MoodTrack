//
//  MoodGraphViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoodGraphViewController.h"
#import <Parse/Parse.h>

@interface MoodGraphViewController ()

@end

@implementation MoodGraphViewController

@synthesize dataForPlot;
@synthesize hostingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create graph from theme
	graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
	[graph applyTheme:theme];
	

    //Create host view
    self.hostingView = [[CPTGraphHostingView alloc] 
                        initWithFrame:[[UIScreen mainScreen]bounds]];
    self.hostingView.collapsesLayers = NO;
    self.hostingView.hostedGraph = graph;
    
    [self.view addSubview:self.hostingView];
    
	graph.paddingLeft	= 10.0;
	graph.paddingTop	= 10.0;
	graph.paddingRight	= 10.0;
	graph.paddingBottom = 10.0;
    
	// Setup plot space
    float xAxisMin = 0;
    float xAxisMax = 50;
    float yAxisMin = 0;
    float yAxisMax = 10;
    
    // We modify the graph's plot space to setup the axis' min / max values.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xAxisMin) length:CPTDecimalFromFloat(xAxisMax - xAxisMin)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yAxisMin) length:CPTDecimalFromFloat(yAxisMax - yAxisMin)];
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
	x.majorIntervalLength		  = CPTDecimalFromString(@"0.5");
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.5");
	x.minorTicksPerInterval		  = 1;
	    
	CPTXYAxis *y = axisSet.yAxis;
	y.majorIntervalLength		  = CPTDecimalFromString(@"0.5");
	y.minorTicksPerInterval		  = 1;
	y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.5");
	    
	// Create a blue plot area
	CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
	CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
	lineStyle.miterLimit		= 1.0f;
	lineStyle.lineWidth			= 3.0f;
	lineStyle.lineColor			= [CPTColor blueColor];
	boundLinePlot.dataLineStyle = lineStyle;
	boundLinePlot.identifier	= @"Blue Plot";
	boundLinePlot.dataSource	= self;
	[graph addPlot:boundLinePlot];
    
	// Do a blue gradient
	CPTColor *areaColor1	   = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
	CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
	areaGradient1.angle = -90.0f;
	CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
	boundLinePlot.areaFill		= areaGradientFill;
	boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
    
	// Add plot symbols
	CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
	symbolLineStyle.lineColor = [CPTColor blackColor];
	CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbol.fill			 = [CPTFill fillWithColor:[CPTColor blueColor]];
	plotSymbol.lineStyle	 = symbolLineStyle;
	plotSymbol.size			 = CGSizeMake(10.0, 10.0);
	boundLinePlot.plotSymbol = plotSymbol;
    
	// Add some initial data
	NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    // PFUser *currentuser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache; 
    // [query whereKey:@"user" equalTo:currentuser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [dataArray addObject:object];
            }
        } else {
            NSLog(@"parse has failed me!");
        }
        NSLog(@"inblock, %d mood objects", dataArray.count);
    }];
    
    NSLog(@"out of block, %d mood objects", dataArray.count);
    
	NSUInteger i;
	for ( i = 0; i < dataArray.count; i++ ) {
        PFObject *data = [dataArray objectAtIndex:i];
		id x = [data objectForKey:@"lat"];
		id y = [data objectForKey:@"mood_value"];
		[dataArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
	}
    
	self.dataForPlot = dataArray;
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
	return [dataForPlot count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
	NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
	NSNumber *num = [[dataForPlot objectAtIndex:index] valueForKey:key];
    
	return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods

-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
	static CPTTextStyle *positiveStyle = nil;
	static CPTTextStyle *negativeStyle = nil;
    
	NSNumberFormatter *formatter = axis.labelFormatter;
	CGFloat labelOffset			 = axis.labelOffset;
	NSDecimalNumber *zero		 = [NSDecimalNumber zero];
    
	NSMutableSet *newLabels = [NSMutableSet set];
    
	for ( NSDecimalNumber *tickLocation in locations ) {
		CPTTextStyle *theLabelTextStyle;
        
		if ( [tickLocation isGreaterThanOrEqualTo:zero] ) {
			if ( !positiveStyle ) {
				CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
				newStyle.color = [CPTColor greenColor];
				positiveStyle  = newStyle;
			}
			theLabelTextStyle = positiveStyle;
		}
		else {
			if ( !negativeStyle ) {
				CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
				newStyle.color = [CPTColor redColor];
				negativeStyle  = newStyle;
			}
			theLabelTextStyle = negativeStyle;
		}
        
		NSString *labelString		= [formatter stringForObjectValue:tickLocation];
		CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
        
		CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
		newLabel.tickLocation = tickLocation.decimalValue;
		newLabel.offset		  = labelOffset;
        
		[newLabels addObject:newLabel];

	}
    
	axis.axisLabels = newLabels;
    
	return NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
