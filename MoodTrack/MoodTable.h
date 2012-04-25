//
//  MoodTableViewController.h
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"

@interface MoodTable : UITableViewController <PullToRefreshViewDelegate>

@property (nonatomic, strong) NSMutableArray *moods;

- (void) reloadTableData;
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
- (void)selectMoods;

@end
