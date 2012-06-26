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
    
    NSTimeZone *lo = [NSTimeZone localTimeZone];
    NSLog(@" - current  local timezone  is  %@",lo.abbreviation);
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"blue_bg.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:50];
    label.textColor = [UIColor whiteColor];
    label.text = @"MoodTrack";
    [label sizeToFit];
    self.logInView.logo = label;
    
    self.logInView.usernameField.backgroundColor = [UIColor colorWithRed: 224.0/255.0 green: 238.0/255.0 blue:238.0/255.0 alpha: 1.0];
    self.logInView.passwordField.backgroundColor = [UIColor colorWithRed: 224.0/255.0 green: 238.0/255.0 blue:238.0/255.0 alpha: 1.0];
    
    self.logInView.usernameField.textColor = [UIColor darkGrayColor];
    self.logInView.passwordField.textColor = [UIColor darkGrayColor];
    
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
