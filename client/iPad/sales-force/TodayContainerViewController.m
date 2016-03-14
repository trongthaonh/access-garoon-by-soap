//
//  TodayContainerViewController.m
//  sales-force
//
//  Created by kiss on 2016/02/03.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "TodayContainerViewController.h"
#import "AppDelegate.h"
#import "MessageTableViewController.h"
#import "BBSTableViewController.h"
#import "ReportTableViewController.h"
#import "WorkflowTableViewController.h"

@interface TodayContainerViewController ()

@property (weak, nonatomic) IBOutlet MessageTableViewController *message;
@property (weak, nonatomic) IBOutlet BBSTableViewController *bbs;
@property (weak, nonatomic) IBOutlet ReportTableViewController *report;
@property (weak, nonatomic) IBOutlet WorkflowTableViewController *workflow;

@end

@implementation TodayContainerViewController

@synthesize message;
@synthesize bbs;
@synthesize report;
@synthesize workflow;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"embedMessage"]) {
        message = (MessageTableViewController *)[destination visibleViewController];
    }else if([segue.identifier isEqualToString:@"embedReport"]) {
        report = (ReportTableViewController *)[destination visibleViewController];
    }else if([segue.identifier isEqualToString:@"embedWorkflow"]) {
        workflow = (WorkflowTableViewController *)[destination visibleViewController];
    }else if([segue.identifier isEqualToString:@"embedBBS"]) {
        bbs = (BBSTableViewController *)[destination visibleViewController];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [bbs setFolder:[(AppDelegate *)[[UIApplication sharedApplication] delegate] allUnreadArticlesFolder]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
