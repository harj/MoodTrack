//
//  MoodThoughtViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoodThoughtViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MoodThoughtViewController ()

@end

@implementation MoodThoughtViewController
@synthesize textField;
@synthesize myDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"whitey.png"]];
    
    [self.textField setPlaceholderText:@"Click to add a note"];
    
    CALayer *layer = [self.textField layer];
    [layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [layer setBorderWidth:0.75];
    layer.cornerRadius = 5;
    self.textField.clipsToBounds = YES;
    
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

//Hiding keyboard when not focused on textview anymore

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.textField isFirstResponder] && [touch view] != self.textField) {
        [self.textField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)closeThoughtView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)saveThoughtPressed:(id)sender {
    NSLog(@"%@", self.myDelegate);
    NSString *thought = textField.text;
    [self.myDelegate saveThought:thought];
    [self dismissModalViewControllerAnimated:YES];
}

@end
