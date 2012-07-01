//
//  StatsViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface StatsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *AverageScore;
@property (strong, nonatomic) IBOutlet UILabel *Average3Days;
@property (strong, nonatomic) IBOutlet UILabel *Average7Days;
@property (strong, nonatomic) IBOutlet UILabel *AverageAM;
@property (strong, nonatomic) IBOutlet UILabel *AveragePM;

- (IBAction)Refresh:(id)sender;

@end
