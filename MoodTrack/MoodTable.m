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

{
    PullToRefreshView *pull;
}

@synthesize moods = _moods;

- (void)selectMoods
{
    _moods = [[NSMutableArray alloc] init];
    
    PFUser *currentuser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    query.cachePolicy = kPFCachePolicyCacheOnly; 
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:currentuser];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [_moods addObject:object];
            }
            
            NSLog(@"success with parse! %d objects, %d mood objects", objects.count, _moods.count);
            // [self.tableView reloadData];
        } else {
            NSLog(@"parse has failed me!");
        }
    }];
    
}

- (void)refreshMoods
{
    _moods = [[NSMutableArray alloc] init];
    
    PFUser *currentuser = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Mood"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache; 
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"user" equalTo:currentuser];
    
    /* removed performing query in background as the _moods variable becomes empty
     
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                [_moods addObject:object];
            }
            
            NSLog(@"success with parse refresh! %d objects, %d mood objects", objects.count, _moods.count);
            // [self.tableView reloadData];
        } else {
            NSLog(@"parse has failed me!");
        }
    }];
    */
    
    
    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        [_moods addObject:object];
    }
    
}



- (void) reloadTableData
{
    [self refreshMoods];    
    [self.tableView reloadData];
    [pull finishedLoading];
}

- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self performSelector:@selector(reloadTableData) withObject:nil afterDelay:1.0];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"cellToLocation"])
    {
        MoodLocationViewController *mlvc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"indexpath: %d", indexPath.row);
        
        PFObject *data = [_moods objectAtIndex:indexPath.row];
        
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Mood Log";
    
    pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.tableView];
    [pull setDelegate:self];
    [self.tableView addSubview:pull];
    
    [self selectMoods];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_moods count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"LogCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    PFObject *data = [_moods objectAtIndex:indexPath.row];
    
    // Retrieve mood value and format to two decimal places
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 2;
    cell.textLabel.text = [formatter stringFromNumber:[data objectForKey:@"mood_value"]];
    
    // Retrieve timestamp and format
    NSDate *dateString = data.createdAt;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EE d LLLL, h:mm a"];
    NSTimeZone *pst = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
    [dateFormat setTimeZone:pst];
    NSString *time = [dateFormat stringFromDate:dateString];
    cell.detailTextLabel.text = time;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}




@end
