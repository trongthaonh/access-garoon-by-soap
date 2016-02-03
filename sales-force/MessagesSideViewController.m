//
//  MessagesSideViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "MessagesSideViewController.h"
#import "MessageBBSContainerViewController.h"
#import "AppDelegate.h"

@interface MessagesSideViewController()

@property (nonatomic, weak) MessageBBSContainerViewController *containerViewController;

@end
@implementation MessagesSideViewController

@synthesize _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;
    }
}

#pragma mark Table View delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        [self.containerViewController swapViewController:TargetMessgae option:[NSNumber numberWithInteger:indexPath.row]];
    }else if(indexPath.section == 1){
        NSDictionary *bbsFolder = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allBBSFolder];
        [self.containerViewController swapViewController:TargetBBS option:[bbsFolder[@"folder"] objectAtIndex:indexPath.row]];
    }
}

#pragma mark Table View Data Source delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return(2);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return(3);
    }else{
        NSDictionary *bbsFolder = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allBBSFolder];
        return([bbsFolder[@"folder"] count]);
    }
    return(0);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return(NSLocalizedString(@"Message", nil));
    }else{
        return(NSLocalizedString(@"BBS", nil));
    }
    return(@"");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageSideCell"];
    

    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = NSLocalizedString(@"Inbox", nil);
        }else if(indexPath.row == 1){
            cell.textLabel.text = NSLocalizedString(@"Outbox", nil);
        }else{
            cell.textLabel.text = NSLocalizedString(@"Draft", nil);
        }
    }else{
        NSDictionary *bbsFolder = [(AppDelegate *)[[UIApplication sharedApplication] delegate] allBBSFolder];
        cell.textLabel.text = [[bbsFolder[@"folder"] objectAtIndex:indexPath.row] objectForKey:@"title"];
    }
    return cell;
}

@end
