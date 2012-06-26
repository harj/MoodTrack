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
    [query whereKey:@"user" equalTo:currentuser];
    
    // If no objects are loaded in memory, we look to the cache 
    // first to fill the table and then subsequently do a query
    // against the network.
    
    if (self.objects.count == 0) {
        NSLog(@"loaded?");
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
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
    formatter.maximumFractionDigits = 1;
    cell.textLabel.text = [formatter stringFromNumber:[object objectForKey:@"mood_value"]];
    
    // Retrieve timestamp and format
    NSDate *dateString = object.createdAt;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE d LLLL, h:mm a"];
    
    //Dealing with mood entries that don't have a timezone since I only just started recording it
    NSString *tz = [[NSString alloc] init];
    if ([object objectForKey:@"timezone"] == NULL) {
        tz = @"PDT";
    } else {
        tz = [object objectForKey:@"timezone"];
    }
    
    NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:tz];
    [dateFormat setTimeZone:zone];
    NSString *time = [dateFormat stringFromDate:dateString];
    
    //Retrieve whether there's a thought
    NSString *thought = [[NSString alloc] init];
    if ([object objectForKey:@"thought"] == NULL) {
        thought = @"";
    } else {
        thought = @", Note added";
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@", time, thought];
    
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
        
        //Dealing with mood entries that don't have a timezone since I only just started recording it
        NSString *tz = [[NSString alloc] init];
        if ([data objectForKey:@"timezone"] == NULL) {
            tz = @"PDT";
        } else {
            tz = [data objectForKey:@"timezone"];
        }
        
        NSTimeZone *zone = [NSTimeZone timeZoneWithAbbreviation:tz];
        [dateFormat setTimeZone:zone];
        mlvc.moodTime = [dateFormat stringFromDate:dateString];
        
        //Set co-ordinates
        mlvc.lat = [data objectForKey:@"lat"];
        mlvc.lon = [data objectForKey:@"lon"];
        
        //Thought
        mlvc.moodThought = [data objectForKey:@"thought"];

    }
}


@end
