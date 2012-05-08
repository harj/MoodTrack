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
    NSString *moodScore;
    NSString *moodTime;
    NSNumber *lat;
    NSNumber *lon;
    
}


@property (strong, nonatomic) IBOutlet MKMapView *_mapView;
@property (strong, nonatomic) NSString *moodScore;
@property (strong, nonatomic) NSString *moodTime;
@property (strong, nonatomic) NSNumber *lat; 
@property (strong, nonatomic) NSNumber *lon;

- (IBAction)closeMoodLocation:(id)sender;

@end
