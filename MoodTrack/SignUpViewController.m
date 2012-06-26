//
//  SignUpViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithPatternImage: 
                                 [UIImage imageNamed:@"white_blue_fade.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:50];
    label.textColor = [UIColor colorWithRed: 54.0/255.0 green: 100.0/255.0 blue:200.0/255.0 alpha: 1.0];
    label.text = @"MoodTrack";
    [label sizeToFit];
    self.signUpView.logo = label;
    
    self.signUpView.usernameField.backgroundColor = [UIColor colorWithRed: 224.0/255.0 green: 238.0/255.0 blue:238.0/255.0 alpha: 1.0];
    self.signUpView.passwordField.backgroundColor = [UIColor colorWithRed: 224.0/255.0 green: 238.0/255.0 blue:238.0/255.0 alpha: 1.0];
    self.signUpView.emailField.backgroundColor = [UIColor colorWithRed: 224.0/255.0 green: 238.0/255.0 blue:238.0/255.0 alpha: 1.0];
    
    self.signUpView.usernameField.textColor = [UIColor darkGrayColor];
    self.signUpView.passwordField.textColor = [UIColor darkGrayColor];
    self.signUpView.emailField.textColor = [UIColor darkGrayColor];
    
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
