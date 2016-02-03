//
//  WorkflowTableViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/19.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "WorkflowTableViewController.h"
#import "WorkflowTableViewCell.h"
#import "AppDelegate.h"

@interface WorkflowTableViewController ()

@property (strong, nonatomic) WorkflowTableViewCell *_calcCellHeight;
@property (strong, nonatomic) NSArray   *_searchResultArray;

@end

@implementation WorkflowTableViewController

@synthesize _tableView;
@synthesize _smallLayout;
@synthesize _calcCellHeight;
@synthesize _searchResultArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UINib *nib = [UINib nibWithNibName:@"WorkflowTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"workflowCell"];
    _calcCellHeight = [[WorkflowTableViewCell alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)newAction:(id)sender
{
    
}

- (IBAction)searchAction:(id)sender
{
    
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
        NSArray *workflowArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allWorkflowArray];
        result = [NSMutableArray array];
        for(i = 0; i < [workflowArray count]; i++){
            NSArray *array = [workflowArray[i] objectForKey:@"array"];
            BOOL found = false;
            for(j = 0; j < [array count]; j++){
                NSDictionary *item = array[j];
                if([item[@"from"] length] > 0){
                    if([item[@"from"] rangeOfString:searchText].location != NSNotFound){ found = true; break;}
                }
                if([item[@"to"] length] > 0){
                    if([item[@"to"] rangeOfString:searchText].location != NSNotFound){ found = true; break;}
                }
                if([item[@"reason"] length] > 0){
                    if([item[@"reason"] rangeOfString:searchText].location != NSNotFound){ found = true; break;}
                }
            }
            if(found){
                [result addObject:workflowArray[i]];
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
        NSArray *workflowArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allWorkflowArray];
        return([workflowArray count]);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkflowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workflowCell" forIndexPath:indexPath];
    NSDictionary    *_workfrow = nil;
    
    if(_searchResultArray != nil){
        _workfrow = [_searchResultArray objectAtIndex:indexPath.row];
    }else{
        NSArray *workflowArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allWorkflowArray];
        _workfrow = [workflowArray objectAtIndex:indexPath.row];
    }
    
    [cell setWorkflow:_workfrow withSize:_smallLayout.boolValue];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary    *_workfrow = nil;
    if(_searchResultArray != nil){
        _workfrow = [_searchResultArray objectAtIndex:indexPath.row];
    }else{
        NSArray *workflowArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allWorkflowArray];
        _workfrow = [workflowArray objectAtIndex:indexPath.row];
    }
    [_calcCellHeight setWorkflow:_workfrow withSize:_smallLayout.boolValue];
    return(_calcCellHeight.height);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showWorkflowSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
#if 0
    NSArray *workflowArray = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allWorkflowArray];
    ReportViewController *viewController = segue.destinationViewController;
    NSDictionary    *_tableItem = nil;
    if([segue.identifier isEqual:@"showWorkflowSegue"]){
        _tableItem = [reportArray objectAtIndex:[_tableView indexPathForSelectedRow].row];
    }
    if(_tableItem == nil){
        _tableItem = [NSDictionary dictionary];
    }
    viewController.item = _tableItem;
#endif
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
