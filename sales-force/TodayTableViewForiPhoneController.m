//
//  TodayTableViewForiPhoneController.m
//  sales-force
//
//  Created by kiss on 2016/01/22.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "TodayTableViewForiPhoneController.h"
#import "ReportTableViewCell.h"
#import "WorkflowTableViewCell.h"
#import "AppDelegate.h"

@interface TodayTableViewForiPhoneController ()

@property (strong, nonatomic) ReportTableViewCell *_reportCalcCellHeight;
@property (strong, nonatomic) WorkflowTableViewCell *_workflowCalcCellHeight;

@end

@implementation TodayTableViewForiPhoneController

@synthesize _tableView;
@synthesize _reportCalcCellHeight;
@synthesize _workflowCalcCellHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    {
        UINib *nib = [UINib nibWithNibName:@"ReportTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"reportCell"];
        _reportCalcCellHeight = [[ReportTableViewCell alloc] init];
    }
    {
        UINib *nib = [UINib nibWithNibName:@"WorkflowTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"workflowCell"];
        _workflowCalcCellHeight = [[WorkflowTableViewCell alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *ret = @"";
    NSString *title[] = {@"Message", @"BBS", @"Report", @"Workflow"};
    if(section < (sizeof(title) / sizeof(title[0]))){
        ret = title[section];
    }
    return(ret);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = 0;
    switch(section){
        case 0:
            {
                NSDictionary *messageDictionary = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allMessageDictionary];
                ret = [messageDictionary[@"inbox"] count];
            }
            break;
        case 1:
            {
        
            }
            break;
        case 2:
            {
                
            }
            break;
        case 3:
            {
                
            }
            break;
            
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%d", [self tableView:tableView titleForHeaderInSection:indexPath.section], (int)indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
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
