//
//  MTViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTViewController.h"
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>
#import "MoodData.h"
#import <Parse/Parse.h>

@implementation MTViewController

@synthesize slider;
@synthesize button;
@synthesize locmgr;
@synthesize spinner;

- (void) saveMood:(CLLocation *)l {
    
    double lat = l.coordinate.latitude;
    double lon = l.coordinate.longitude;
    double h = l.horizontalAccuracy;
    double v = l.verticalAccuracy;
    double accuracy = sqrt(h*h+v*v);
    double mood_value = slider.value;
    
    NSLog(@"Slider value: %f", slider.value);
    
    PFObject *mood = [PFObject objectWithClassName:@"Mood"];
    [mood setObject:[NSNumber numberWithDouble:mood_value] forKey:@"mood_value"];
    [mood setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [mood setObject:[NSNumber numberWithDouble:lon] forKey:@"lon"];
    [mood setObject:[NSNumber numberWithDouble:accuracy] forKey:@"accuracy"];
    [mood saveEventually];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Mood saved!"
                                                      message:@"Your mood has been saved to parse"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];

    [self.spinner stopAnimating];
    [self.button setEnabled:YES];
}

- (void) waitForGoodLocation:(NSNumber *)n {
    CLLocation *l = locmgr.location;
    
    NSLog(@"Checking for good location...");
    
    if (l != NULL) {
        NSTimeInterval locAgeSeconds = -1 * [l.timestamp timeIntervalSinceNow];
        NSLog(@"Location is %f seconds old.", locAgeSeconds);
        
        if (locAgeSeconds < 30.0) {
            // This location is good, proceed storing in database.
            [self saveMood:l];            
            return;
        }
    }
    
    NSLog(@"No good location.");
    
    if ([n intValue] >= 5) {
        NSLog(@"5 iterations passed.  Giving up...");
        [self saveMood:l];
    } else {
        
        [self.spinner startAnimating];
        [self.button setEnabled:NO];
        
        [self performSelector:@selector(waitForGoodLocation:)
                   withObject:[NSNumber numberWithInt:[n intValue] + 1]
                   afterDelay:1.0];
    }
    
}

- (IBAction)buttonPressed:(id)sender
{
    NSLog(@"Button pressed");    
    [self waitForGoodLocation:[NSNumber numberWithInt:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"furley_bg.png"]];
    
	// Do any additional setup after loading the view, typically from a nib.
    locmgr = [[CLLocationManager alloc] init];
    locmgr.delegate = self; 
    locmgr.desiredAccuracy = kCLLocationAccuracyBest; 
    locmgr.distanceFilter = kCLDistanceFilterNone; 
    [locmgr startUpdatingLocation];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
