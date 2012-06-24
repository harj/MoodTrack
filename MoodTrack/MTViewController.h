//
//  MTViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "MoodThoughtViewController.h"

@interface MTViewController : UIViewController <CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, ThoughtDelegate> 
{
    NSString *moodThought;
}

@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UISlider *slider; 
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) CLLocationManager *locmgr;
@property (strong, nonatomic) NSString *moodThought;

- (IBAction)buttonPressed:(id)sender;

@end
