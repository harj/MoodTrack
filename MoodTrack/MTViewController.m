//
//  MTViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTViewController.h"
#import <sqlite3.h>

@implementation MTViewController

@synthesize slider;
@synthesize button;


- (IBAction)buttonPressed:(id)sender
{
    NSLog(@"Button pressed");
    NSLog(@"Slider value: %f", slider.value);
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
	// Do any additional setup after loading the view, typically from a nib.
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

+ (void) execSQL:(NSString *)s
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
    }
    
    sqlite3_close(db);
}

@end
