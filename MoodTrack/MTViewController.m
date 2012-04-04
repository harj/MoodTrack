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
    
    NSLog(@"Slider value: %f", slider.value);
    
    NSString *s = [NSString stringWithFormat:@"INSERT INTO mood \
                   (mood_value, lat, lon, accuracy) \
                   VALUES \
                   (%f, %f, %f, %f);", slider.value, lat, lon, accuracy];
    NSLog(@"%@", s);               
    [self execSQL:s];
    
    //Should probably check if SQL statement was executed before displaying this
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Mood saved!"
                                                      message:@"Your mood has been saved to a sqlite3 database."
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
    
    [self execSQL:@"CREATE TABLE IF NOT EXISTS mood ( \
     id INTEGER NOT NULL PRIMARY KEY, \
     mood_value DOUBLE PRECISION, \
     ts DATETIME DEFAULT CURRENT_TIMESTAMP, \
     lat DOUBLE PRECISION, \
     lon DOUBLE PRECISION, \
     accuracy DOUBLE PRECISION \
     );"];
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

- (void) execSQL:(NSString *)s
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:
                              [docsDir stringByAppendingPathComponent: @"moodtrack.db"]];
    
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3 *db;
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK) {
        NSLog(@"Error opening sqlite KVDB.");
    }

    char *errMsg;
    const char *sql_stmt = [s UTF8String];
    if (sqlite3_exec(db, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
        NSLog(@"Error executing sqlite statement");
    } else {
        NSLog(@"Statement executed");
    }
    
    sqlite3_close(db);
}

@end
