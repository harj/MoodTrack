//
//  MoodLocationViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MoodLocationViewController : UIViewController <MKMapViewDelegate> {
    NSString *moodScore;
    NSString *moodThought;
    NSString *moodTime;
    NSNumber *lat;
    NSNumber *lon;
    MKMapView *mapview;
    
}


@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *moodThoughtLabel;
@property (strong, nonatomic) NSString *moodScore;
@property (strong, nonatomic) NSString *moodThought;
@property (strong, nonatomic) NSString *moodTime;
@property (strong, nonatomic) NSNumber *lat; 
@property (strong, nonatomic) NSNumber *lon;

- (IBAction)closeMoodLocation:(id)sender;


@end
