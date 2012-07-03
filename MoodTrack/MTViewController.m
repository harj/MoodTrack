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

@synthesize scorePicker;
@synthesize score;
@synthesize locmgr;
@synthesize spinner;
@synthesize moodThought;
@synthesize noteAdded;
@synthesize moodScoreValues;
@synthesize pickerView;
double moodScore;

- (void)saveThought:(NSString *)thought
{
    self.moodThought = thought;
    self.noteAdded.text = @"note added";
}

- (void) saveMood:(CLLocation *)l
{
    double lat = l.coordinate.latitude;
    double lon = l.coordinate.longitude;
    double h = l.horizontalAccuracy;
    double v = l.verticalAccuracy;
    double accuracy = sqrt(h*h+v*v);
    double mood_value = moodScore;
    
    if (mood_value > 0) { 
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
        
        //Store timezone
        NSTimeZone *lo = [NSTimeZone localTimeZone];
        NSString *timezone = lo.abbreviation;
        [mood setObject:timezone forKey:@"timezone"];
    
        [mood saveEventually];
    
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Mood tracked"
                                                          message:@"Your mood score has been tracked"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    
        [message show];

        self.noteAdded.text = nil;
        [self.spinner stopAnimating];
    } else {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"You didn't select a mood score"
                                                          message:@"So nothing was tracked"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];

	// Do any additional setup after loading the view, typically from a nib.
    locmgr = [[CLLocationManager alloc] init];
    locmgr.delegate = self; 
    locmgr.desiredAccuracy = kCLLocationAccuracyBest; 
    locmgr.distanceFilter = kCLDistanceFilterNone; 
    [locmgr startUpdatingLocation];
    
    self.moodScoreValues = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4",
                            @"5", @"6", @"7", @"8", @"9", @"10", nil];
    
    CGFloat margin = 20.0f;
	CGFloat width = (self.view.bounds.size.width - (margin * 2.0f));
	CGFloat pickerHeight = 55.0f;
	CGFloat x = margin;
	CGFloat y = 160.0f;
	CGRect tmpFrame = CGRectMake(x, y, width, pickerHeight);
    
    
	pickerView = [[V8HorizontalPickerView alloc] initWithFrame:tmpFrame];
	pickerView.backgroundColor   = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:1.0];
	pickerView.selectedTextColor = [UIColor colorWithRed:34.0/255.0 green:138.0/255.0 blue:255.0/255.0 alpha:1.0];
	pickerView.textColor   = [UIColor grayColor];
	pickerView.delegate    = self;
	pickerView.dataSource  = self;
	pickerView.elementFont = [UIFont fontWithName:@"TrebuchetMS" size:20.0f];
	pickerView.selectionPoint = CGPointMake(140, 0);
    
    [pickerView scrollToElement:4 animated:NO];
    
	// add carat or other view to indicate selected element
	UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator1"]];
	pickerView.selectionIndicatorView = indicator;
    
    //pickerView.indicatorPosition = V8HorizontalPickerIndicatorTop; // specify indicator's location
	
	// add gradient images to left and right of view if desired
    UIImageView *leftFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_fade_8"]];
    pickerView.leftEdgeView = leftFade;
    
    UIImageView *rightFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_fade_8"]];
    pickerView.rightEdgeView = rightFade;
    
	[self.view addSubview:pickerView];
    
}

#pragma mark - HorizontalPickerView DataSource Methods
- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
	return [moodScoreValues count];
}

#pragma mark - HorizontalPickerView Delegate Methods
- (NSString *)horizontalPickerView:(V8HorizontalPickerView *)picker titleForElementAtIndex:(NSInteger)index {
	return [moodScoreValues objectAtIndex:index];
}

- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index {
	CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
	NSString *text = [moodScoreValues objectAtIndex:index];
	CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
					   constrainedToSize:constrainedSize
						   lineBreakMode:UILineBreakModeWordWrap];
	return textSize.width + 40.0f; // 20px padding on each side
}

- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index {
	self.score.text = [NSString stringWithFormat:@"I'm feeling %d out of 10", index + 1];
    moodScore = index + 1;
}


- (void)viewDidUnload
{
    [self setScore:nil];
    [self setNoteAdded:nil];
    [self setScorePicker:nil];
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

//Mood Score Picker methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [self.moodScoreValues count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.moodScoreValues objectAtIndex:row];
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
