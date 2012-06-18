//
//  MoodTableViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoodTable.h"
#import "MoodLocationViewController.h"
#import <sqlite3.h>
#import "PullToRefreshView.h"
#import <Parse/Parse.h>

@interface MoodTable ()
@end

@implementation MoodTable

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithClassName:@"Mood"];
    self = [super initWithCoder:aDecoder];    
    if (self) {
        // This table displays items in the Todo class
        self.className = @"Mood";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFUser *currentuser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:currentuser];
    
    return query;
    
    // If no objects are loaded in memory, we look to the cache 
    // first to fill the table and then subsequently do a query
    // against the network.
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
}
     

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"LogCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Retrieve mood value and format to two decimal places
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    cell.textLabel.text = [formatter stringFromNumber:[object objectForKey:@"mood_value"]];
    
    // Retrieve timestamp and format
    NSDate *dateString = object.createdAt;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE d LLLL, h:mm a"];
    NSTimeZone *pst = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
    [dateFormat setTimeZone:pst];
    NSString *time = [dateFormat stringFromDate:dateString];
    cell.detailTextLabel.text = time;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"cellToLocation"])
    {
        MoodLocationViewController *mlvc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"indexpath: %d", indexPath.row);
        
        PFObject *data = [self.objects objectAtIndex:indexPath.row];
        
        // Retrieve mood value and format to two decimal places
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.maximumFractionDigits = 2;
        mlvc.moodScore = [formatter stringFromNumber:[data objectForKey:@"mood_value"]];
        
        // Retrieve timestamp and format
        NSDate *dateString = data.createdAt;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EE d LLLL, h:mm a"];
        NSTimeZone *pst = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
        [dateFormat setTimeZone:pst];
        mlvc.moodTime = [dateFormat stringFromDate:dateString];
        
        //Set co-ordinates
        mlvc.lat = [data objectForKey:@"lat"];
        mlvc.lon = [data objectForKey:@"lon"];

    }
}


@end
