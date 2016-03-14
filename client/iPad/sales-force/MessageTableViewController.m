//
//  MessageTableViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "MessageTableViewController.h"
#import "MessageTableViewCell.h"
#import "MessageViewController.h"
#import "AppDelegate.h"

@implementation MessageTableViewController

@synthesize _tableView;
@synthesize _category;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
    [self._tableView registerNib:nib forCellReuseIdentifier:@"messagesCell"];
}

-(void) setCategory:(NSInteger)category
{
    if(_category != category){
        _category = category;
        [_tableView reloadData];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDictionary *messageDictionary = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allMessageDictionary];
    MessageViewController *viewController = segue.destinationViewController;
    NSArray *_array = nil;
    NSDictionary    *_tableItem = nil;
    if(_category == 0){
        _array = messageDictionary[@"inbox"];
    }else if(_category == 1){
        _array = messageDictionary[@"outbox"];
    }else{
        _array = messageDictionary[@"draft"];
    }
    if([segue.identifier isEqual:@"showMessageSegue"]){
        _tableItem = [_array objectAtIndex:[_tableView indexPathForSelectedRow].row];
    }
    if(_tableItem == nil){
        _tableItem = [NSDictionary dictionary];
    }
    viewController.item = _tableItem;
}

#pragma mark Table View delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showMessageSegue" sender:self];
}

#pragma mark Table View Data Source delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = 0;
    NSDictionary *messageDictionary = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allMessageDictionary];
    if(_category == 0){
        ret = [messageDictionary[@"inbox"] count];
    }else if(_category == 1){
        ret = [messageDictionary[@"outbox"] count];
    }else{
        ret = [messageDictionary[@"draft"] count];
    }
    return(ret);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messagesCell"];
    NSDictionary *messageDictionary = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allMessageDictionary];
    NSDictionary *dictionary;
    if(_category == 0){
        dictionary = [messageDictionary[@"inbox"] objectAtIndex:indexPath.row];
    }else if(_category == 1){
        dictionary = [messageDictionary[@"outbox"] objectAtIndex:indexPath.row];
    }else if(_category == 2){
        dictionary = [messageDictionary[@"draft"] objectAtIndex:indexPath.row];
    }
    cell.sender.text = [NSString stringWithString:dictionary[@"from"]];
    cell.date.text = [NSString stringWithString:dictionary[@"date"]];
    cell.subject.text = [NSString stringWithString:dictionary[@"subject"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
