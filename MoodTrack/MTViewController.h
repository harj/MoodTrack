//
//  MTViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MTViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UISlider *slider; 
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) CLLocationManager *locmgr;

- (IBAction)buttonPressed:(id)sender;
- (void)execSQL:(NSString *)s;


@end
