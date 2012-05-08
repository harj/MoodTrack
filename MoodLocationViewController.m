//
//  MoodLocationViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoodLocationViewController.h"

@interface MoodLocationViewController ()

@end

@implementation MoodLocationViewController
@synthesize _mapView;

- (void)viewDidLoad
{
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.3866968;
    zoomLocation.longitude= -122.067976;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 800, 800);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];   
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self set_mapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeMoodLocation:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
