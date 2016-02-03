//
//  ReportTableViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "ReportTableViewController.h"
#import "ReportTableViewCell.h"
#import "ReportViewController.h"
#import "AppDelegate.h"

@interface ReportTableViewController()

@property (strong, nonatomic) NSArray   *_searchResultArray;
@property (strong, nonatomic) ReportTableViewCell *_calcCellHeight;

@end

@implementation ReportTableViewController

@synthesize _tableView;
@synthesize _smallLayout;
@synthesize _searchResultArray;
@synthesize _calcCellHeight;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UINib *nib = [UINib nibWithNibName:@"ReportTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"reportCell"];
#if DRAW_MANUALY
    _calcCellHeight = [[ReportTableViewCell alloc] init];
#else
    _calcCellHeight = [_tableView dequeueReusableCellWithIdentifier:@"reportCell"];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search Bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length <= 0){
        _searchResultArray = nil;
        [_tableView reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    int i, j;
    NSMutableArray *result = nil;
    NSString    *searchText = searchBar.text;
    
    if(searchText.length > 0){
        NSArray *reportArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allReportArray];
        result = [NSMutableArray array];
        for(i = 0; i < [reportArray count]; i++){
            NSArray *array = [reportArray[i] objectForKey:@"array"];
            BOOL found = false;
            for(j = 0; j < [array count]; j++){
                NSDictionary *item = array[j];
                if([item[@"customer"] length] > 0){
                    if([item[@"customer"] rangeOfString:searchText].location != NSNotFound){ found = true; break;}
                }
                if([item[@"chargeof"] length] > 0){
                    if([item[@"chargeof"] rangeOfString:searchText].location != NSNotFound){ found = true; break;}
                }
                if([item[@"comment"] length] > 0){
                    if([item[@"comment"] rangeOfString:searchText].location != NSNotFound){ found = true; break;}
                }
            }
            if(found){
                [result addObject:reportArray[i]];
            }
        }
    }
    _searchResultArray = result;
    [_tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return(1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_searchResultArray != nil){
        return([_searchResultArray count]);
    }else{
        NSArray *reportArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allReportArray];
        return([reportArray count]);
    }
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     ReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportCell" forIndexPath:indexPath];
     NSDictionary *_tableItem = nil;

     if(_searchResultArray != nil){
         _tableItem = [_searchResultArray objectAtIndex:indexPath.row];
     }else{
         NSArray *reportArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allReportArray];
         _tableItem = [reportArray objectAtIndex:indexPath.row];
     }

     [cell setReport:_tableItem withSize:_smallLayout.boolValue];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
     return cell;
 }

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *_tableItem = nil;
    if(_searchResultArray != nil){
        _tableItem = [_searchResultArray objectAtIndex:indexPath.row];
    }else{
        NSArray *reportArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allReportArray];
        _tableItem = [reportArray objectAtIndex:indexPath.row];
    }
    [_calcCellHeight setReport:_tableItem withSize:_smallLayout.boolValue];
    return(_calcCellHeight.height);
}

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showReportSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ReportViewController *viewController = segue.destinationViewController;
    NSDictionary    *_tableItem = nil;
    if([segue.identifier isEqual:@"showReportSegue"]){
        if(_searchResultArray != nil){
            _tableItem = [_searchResultArray objectAtIndex:[_tableView indexPathForSelectedRow].row];
        }else{
            NSArray *reportArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allReportArray];
            _tableItem = [reportArray objectAtIndex:[_tableView indexPathForSelectedRow].row];
        }
    }
    if(_tableItem == nil){
        _tableItem = [NSDictionary dictionary];
    }
    viewController.item = _tableItem;
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
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
