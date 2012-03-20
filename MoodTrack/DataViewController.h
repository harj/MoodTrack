//
//  DataViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UITableViewController{
    NSMutableArray *moodInfo;
}

@property (nonatomic, strong) NSMutableArray *moodInfo;

- (NSMutableArray *) moodList;
@end
