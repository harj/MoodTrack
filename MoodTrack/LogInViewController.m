//
//  LogInViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"blue_bg.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:50];
    label.textColor = [UIColor whiteColor];
    label.text = @"Mood Track";
    [label sizeToFit];
    self.logInView.logo = label;
    
    self.logInView.usernameField.backgroundColor = [UIColor colorWithRed: 54.0/255.0 green: 100.0/255.0 blue:139.0/255.0 alpha: 1.0];
    self.logInView.passwordField.backgroundColor = [UIColor colorWithRed: 54.0/255.0 green: 100.0/255.0 blue:139.0/255.0 alpha: 1.0];
    
    self.logInView.usernameField.textColor = [UIColor whiteColor];
    self.logInView.passwordField.textColor = [UIColor whiteColor];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
