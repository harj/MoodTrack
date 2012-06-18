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

@interface MTViewController : UIViewController <CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate> 
{
}

@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UISlider *slider; 
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) CLLocationManager *locmgr;

- (IBAction)buttonPressed:(id)sender;

@end
