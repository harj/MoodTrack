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
                                 [UIImage imageNamed:@"weave.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"MoodTrack";
    [label sizeToFit];
    self.signUpView.logo = label; 
    
    self.signUpView.usernameField.backgroundColor = [UIColor grayColor];
    self.signUpView.passwordField.backgroundColor = [UIColor grayColor];
    self.signUpView.emailField.backgroundColor = [UIColor grayColor];
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
