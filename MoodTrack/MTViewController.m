//
//  MTViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MTViewController.h"
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "LogInViewController.h"
#import "SignUpViewController.h"

@implementation MTViewController

@synthesize score;
@synthesize slider;
@synthesize locmgr;
@synthesize spinner;
@synthesize moodThought;
@synthesize noteAdded;

- (void)saveThought:(NSString *)thought
{
    self.moodThought = thought;
    self.noteAdded.text = @"Note added";
}

- (void) saveMood:(CLLocation *)l
{
    double lat = l.coordinate.latitude;
    double lon = l.coordinate.longitude;
    double h = l.horizontalAccuracy;
    double v = l.verticalAccuracy;
    double accuracy = sqrt(h*h+v*v);
    double mood_value = slider.value;
    NSLog(@"Slider value: %f", slider.value);

    PFUser *user = [PFUser currentUser];
    NSString *thought = self.moodThought;
    PFObject *mood = [PFObject objectWithClassName:@"Mood"];
    [mood setObject:[NSNumber numberWithDouble:mood_value] forKey:@"mood_value"];
    [mood setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [mood setObject:[NSNumber numberWithDouble:lon] forKey:@"lon"];
    [mood setObject:[NSNumber numberWithDouble:accuracy] forKey:@"accuracy"];
    [mood setObject:user forKey:@"user"];
    
    //Only add thought if it exists
    if (thought) {
          [mood setObject:thought forKey:@"thought"];
    }
    
    [mood saveEventually];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Mood tracked"
                                                      message:@"Your mood score has been tracked"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];

    self.noteAdded.text = nil;
    [self.spinner stopAnimating];
}

- (void) waitForGoodLocation:(NSNumber *)n {
    CLLocation *l = locmgr.location;
    
    NSLog(@"Checking for good location...");
    
    if (l != NULL) {
        NSTimeInterval locAgeSeconds = -1 * [l.timestamp timeIntervalSinceNow];
        NSLog(@"Location is %f seconds old.", locAgeSeconds);
        
        if (locAgeSeconds < 30.0) {
            // This location is good, proceed storing in database.
            [self saveMood:l];            
            return;
        }
    }
    
    NSLog(@"No good location.");
    
    if ([n intValue] >= 5) {
        NSLog(@"5 iterations passed.  Giving up...");
        [self saveMood:l];
    } else {
        
        [self.spinner startAnimating];
        
        [self performSelector:@selector(waitForGoodLocation:)
                   withObject:[NSNumber numberWithInt:[n intValue] + 1]
                   afterDelay:1.0];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openThought"])
    {
        MoodThoughtViewController *thought = [segue destinationViewController];
        thought.myDelegate = self;
    }
}

// Actions

- (IBAction)buttonPressed:(id)sender
{    
    [self waitForGoodLocation:[NSNumber numberWithInt:0]];
}


- (void)sliderChanged:(UISlider *)aslider {
    score.text = [NSString stringWithFormat:@"Mood Score: %.0f", aslider.value];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"furley_bg.png"]];

	// Do any additional setup after loading the view, typically from a nib.
    locmgr = [[CLLocationManager alloc] init];
    locmgr.delegate = self; 
    locmgr.desiredAccuracy = kCLLocationAccuracyBest; 
    locmgr.distanceFilter = kCLDistanceFilterNone; 
    [locmgr startUpdatingLocation];
    
}

- (void)viewDidUnload
{
    [self setScore:nil];
    [self setNoteAdded:nil];
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
    PFUser *currentuser = [PFUser currentUser];
    
    if (!currentuser) {
        LogInViewController *logInController = [[LogInViewController alloc] init];
        logInController.signUpController = [[SignUpViewController alloc] init];
    
        //Customize login screen fields
        logInController.fields = PFLogInFieldsUsernameAndPassword 
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton 
        | PFLogInFieldsPasswordForgotten;
        
        logInController.delegate = self;
        logInController.signUpController.delegate = self;
        
        [self presentModalViewController:logInController animated:YES];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController 
               didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
