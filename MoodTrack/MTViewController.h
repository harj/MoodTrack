//
//  MTViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *slider; 
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonPressed:(id)sender;
- (void)execSQL:(NSString *)s;

@end
