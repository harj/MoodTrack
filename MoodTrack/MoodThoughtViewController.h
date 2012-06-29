//
//  MoodThoughtViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTTextView.h"

@protocol ThoughtDelegate <NSObject>
- (void)saveThought:(NSString *)thought;
@end


@interface MoodThoughtViewController : UIViewController
<UITextViewDelegate>
{
    id myDelegate;
}


@property (strong, nonatomic) IBOutlet KTTextView *textField;

@property (strong, nonatomic) id<ThoughtDelegate> myDelegate;

- (IBAction)closeThoughtView:(id)sender;
- (IBAction)saveThoughtPressed:(id)sender;




@end
