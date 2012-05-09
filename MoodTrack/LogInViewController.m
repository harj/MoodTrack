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
                                 [UIImage imageNamed:@"black_tile.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"MoodTrack";
    [label sizeToFit];
    self.logInView.logo = label;
    
    self.logInView.usernameField.backgroundColor = [UIColor whiteColor];
    self.logInView.passwordField.backgroundColor = [UIColor whiteColor];
    
    self.logInView.usernameField.textColor = [UIColor blackColor];
    self.logInView.passwordField.textColor = [UIColor blackColor];
        
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
