//
//  DataViewController.m
//  MoodTrack
//
//  Created by Harjeet Taggar on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataViewController.h"
#import "MoodData.h"
#import <sqlite3.h>

@interface DataViewController ()

@end

@implementation DataViewController

@synthesize moodInfo;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self moodInfo];
    [super viewDidLoad];
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
    return [self.moodInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoodDataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int rowCount = indexPath.row;
    
    MoodData *moodData = [self.moodInfo objectAtIndex:rowCount];
    cell.textLabel.text = moodData.mood_value;
    
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

- (NSMutableArray *)moodList
{
    moodInfo = [[NSMutableArray alloc] init];
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc] initWithString:
                              [docsDir stringByAppendingPathComponent: @"moodtrack.db"]];
    
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3 *db;
    
    if (sqlite3_open(dbpath, &db) != SQLITE_OK) {
        NSLog(@"Error opening sqlite KVDB.");
    }
    
    char *errMsg;
    const char *sql_stmt = "SELECT * FROM mood";
    sqlite3_stmt *sqlStatement;
    if (sqlite3_exec(db, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
        NSLog(@"Error executing sqlite statement");
    } else {
        MoodData *moodData = [[MoodData alloc] init];
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            
            moodData.mood_value = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
            moodData.ts = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
            moodData.lat = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
            moodData.lon = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
            
            [moodInfo addObject:moodData];
        }
    }
    sqlite3_close(db);
    return moodInfo;
}

@end
