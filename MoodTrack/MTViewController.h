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
#import "V8HorizontalPickerView.h"
#import "V8HorizontalPickerViewProtocol.h"

@interface MTViewController : UIViewController <CLLocationManagerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, ThoughtDelegate, UIPickerViewDelegate, UIPickerViewDataSource, V8HorizontalPickerViewDelegate, V8HorizontalPickerViewDataSource> 
{
}

@property (strong, nonatomic) IBOutlet UIPickerView *scorePicker;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *noteAdded;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) CLLocationManager *locmgr;
@property (strong, nonatomic) NSString *moodThought;
@property (strong, nonatomic) NSArray *moodScoreValues;

@property (strong, nonatomic) V8HorizontalPickerView *pickerView;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)logout:(id)sender;

@end
