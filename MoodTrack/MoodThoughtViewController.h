//
//  MoodThoughtViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThoughtDelegate <NSObject>
- (void)saveThought:(NSString *)thought;
@end


@interface MoodThoughtViewController : UIViewController
{
    id myDelegate;
}


@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) id<ThoughtDelegate> myDelegate;

- (IBAction)closeThoughtView:(id)sender;
- (IBAction)saveThoughtPressed:(id)sender;




@end
