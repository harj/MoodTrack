//
//  MoodLocationViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoodLocationViewController.h"
#import "MapViewAnnotation.h"

@interface MoodLocationViewController ()

@end

@implementation MoodLocationViewController
@synthesize moodThoughtLabel;
@synthesize mapView;
@synthesize moodScore;
@synthesize moodThought;
@synthesize moodTime;
@synthesize lat;
@synthesize lon;

- (MKAnnotationView *)mapView:(MKMapView *)MapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MapViewAnnotation";   
    if ([annotation isKindOfClass:[MapViewAnnotation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[MapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            // NSLog(@"no view");
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
            NSLog(@"this ran");
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES; 
        
        return annotationView;
    }
    
    return nil;    
}


-(void)plotMood {
    
    mapView.delegate = self;
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [lat doubleValue];
    zoomLocation.longitude= [lon doubleValue];
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 800, 800);
    // 3
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    // 4
    [mapView setRegion:adjustedRegion animated:YES];   
    
    MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithCoordinate:zoomLocation title:[NSString stringWithFormat:@"Mood Score: %@", moodScore] subtitle:moodTime];
    [mapView selectAnnotation:annotation animated:YES];
    [mapView addAnnotation:annotation];
    
}

- (void)viewDidLoad

{
    mapView.delegate = self;
    
    if (moodThought == NULL) {
        [moodThoughtLabel setTextAlignment:UITextAlignmentCenter];
        moodThoughtLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:18];
        moodThoughtLabel.text = @"No note added";
    } else {
        moodThoughtLabel.text = [NSString stringWithFormat:@"NOTE:\n%@", moodThought];
    }
    
    [self plotMood];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];

}


- (void)viewDidUnload
{
    [self setMoodThoughtLabel:nil];
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
