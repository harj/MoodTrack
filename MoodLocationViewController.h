//
//  MoodLocationViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MoodLocationViewController : UIViewController {
    
}


@property (strong, nonatomic) IBOutlet MKMapView *_mapView;

- (IBAction)closeMoodLocation:(id)sender;

@end
