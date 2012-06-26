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


-(void)plotData:(NSDate *)arefDate
{
    
    NSTimeInterval days = [arefDate timeIntervalSinceNow] * -1;
    
    // Create graph from theme
	graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
	[graph applyTheme:theme]; 
    
    //Create host view
    self.hostingView = [[CPTGraphHostingView alloc] 
                        initWithFrame:CGRectMake(-29, 45, 365, 448)];
    self.hostingView.collapsesLayers = NO;
    self.hostingView.hostedGraph = graph;
    
    [self.view addSubview:self.hostingView];
    
	graph.plotAreaFrame.paddingLeft	= 50.0f;
	graph.plotAreaFrame.paddingTop	= 20.0f;
	graph.plotAreaFrame.paddingRight = 5.0f;
	graph.plotAreaFrame.paddingBottom = 45.0f;
    
    graph.plotAreaFrame.borderLineStyle = nil;
        
    // We modify the graph's plot space to setup the axis' min / max values.
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    NSTimeInterval xLow = 0.0f;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xLow) length:CPTDecimalFromFloat(days)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromString(@"0") length:CPTDecimalFromString(@"10")];
    
	// Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
	CPTXYAxis *x		  = axisSet.xAxis;
    x.title = [NSString stringWithFormat:@"Time (last %.0f days)", (days/86400)];
    x.titleOffset = 10.0f;
	x.majorIntervalLength		  = CPTDecimalFromFloat(86400.0f);
	x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
	x.minorTicksPerInterval		  = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateStyle = kCFDateFormatterShortStyle;
	CPTTimeFormatter *timeFormatter = [[CPTTimeFormatter alloc] initWithDateFormatter:dateFormatter];
	timeFormatter.referenceDate = arefDate;
	x.labelFormatter			= nil;

	CPTXYAxis *y = axisSet.yAxis;
    y.title = @"Mood Score";
    y.titleOffset = 20.0f;
	y.majorIntervalLength		  = CPTDecimalFromString(@"1");
	y.minorTicksPerInterval		  = 1;
	y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setGeneratesDecimalNumbers:NO];
    
    y.labelFormatter = numberFormatter;
    
    
	// Create a blue plot area
	CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
	CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
	lineStyle.miterLimit		= 1.0f;
	lineStyle.lineWidth			= 1.5f;
	lineStyle.lineColor			= [CPTColor blueColor];
	boundLinePlot.dataLineStyle = lineStyle;
	boundLinePlot.identifier	= @"Blue Plot";
	boundLinePlot.dataSource	= self;
	[graph addPlot:boundLinePlot];
    
	
	boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
    
	// Add plot symbols
	CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
	symbolLineStyle.lineColor = [CPTColor blackColor];
	CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbol.fill			 = [CPTFill fillWithColor:[CPTColor blueColor]];
	plotSymbol.lineStyle	 = symbolLineStyle;
	plotSymbol.size			 = CGSizeMake(5.0, 5.0);
	boundLinePlot.plotSymbol = plotSymbol;
    
    
}

-(void)queryData
{
    // Add some initial data
	NSMutableArray *queryArray = [[NSMutableArray alloc] init];
    
    PFUser *currentuser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    [query whereKey:@"user" equalTo:currentuser];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
                [queryArray addObject:object];
            }
            
            PFObject *last = [queryArray objectAtIndex:0];
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            for ( int i = 0; i < queryArray.count; i ++) {
                PFObject *data = [queryArray objectAtIndex:i];
                
                //repeated line in plot function
                //NSDate *refDate = [[NSDate date] dateByAddingTimeInterval: -1987200];
                NSDate *refDate = last.createdAt;
                
                NSTimeInterval d = [data.createdAt timeIntervalSinceDate:refDate];
                id x = [NSDecimalNumber numberWithFloat:d];
                id y = [data objectForKey:@"mood_value"];
                [dataArray addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys: x, @"x", y, @"y", nil]];
            }
            
            self.dataForPlot = dataArray;
            [self plotData:last.createdAt];
        } else {
            NSLog(@"parse has failed me!");
        }
    }];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self queryData];
    
}

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

- (IBAction)closeMoodGraph:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
