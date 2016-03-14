//
//  BBSTableViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "BBSTableViewController.h"
#import "BBSViewController.h"
#import "MessageTableViewCell.h"

@implementation BBSTableViewController

@synthesize _tableView;
@synthesize folder;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
    [self._tableView registerNib:nib forCellReuseIdentifier:@"messagesCell"];
}

-(void) setFolder:(NSDictionary *)_folder
{
    folder =_folder;
    if(folder[@"title"] != nil){
        self.navigationItem.title = folder[@"title"];
    }
    [_tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSDictionary    *item;
    if([folder[@"folder"] count] > 0){
        if((item = [folder[@"folder"] objectAtIndex:0]) != nil){
            if(item[@"should_modal"] != nil){
                [self performSegueWithIdentifier:@"presidentSegue" sender:self];
            }
        }
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    BOOL    ret = NO;
    NSDictionary    *_tableItem = [folder[@"folder"] objectAtIndex:[_tableView indexPathForSelectedRow].row];
    if(_tableItem[@"article"] != nil){
        ret = YES;
    }
    if([identifier isEqualToString:@"presidentSegue"]){
        ret = YES;
    }
    return(ret);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BBSViewController *viewController = segue.destinationViewController;
    NSDictionary    *_tableItem = [folder[@"folder"] objectAtIndex:[_tableView indexPathForSelectedRow].row];
    if([segue.identifier isEqualToString:@"presidentSegue"]){
        _tableItem = [folder[@"folder"] objectAtIndex:0];
    }
    viewController.item = _tableItem;
}

#pragma mark Table View delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[folder[@"folder"] objectAtIndex:indexPath.row] objectForKey:@"folder"] != nil){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BBSTableViewController *destinationViewController = [storyboard instantiateViewControllerWithIdentifier:@"BBSTableView"];
        NSDictionary    *_tableItem = [folder[@"folder"] objectAtIndex:indexPath.row];
        destinationViewController.folder = _tableItem;
        [self.navigationController pushViewController:destinationViewController animated:YES];
    }else{
        [self performSegueWithIdentifier:@"showArticleSegue" sender:self];
    }
}

#pragma mark Table View Data Source delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return([folder[@"folder"] count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary    *item = [folder[@"folder"] objectAtIndex:indexPath.row];
    UITableViewCell *ret = nil;
    if(item[@"folder"] != nil){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bbsCell"];
        cell.textLabel.text = item[@"title"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        ret = cell;
    }else{
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagesCell"];
        cell.date.text = item[@"date"];
        cell.sender.text = item[@"writtenby"];
        cell.subject.text = item[@"title"];
        if(item[@"article"] != nil){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        ret = cell;
    }
    
    return ret;
}

@end
