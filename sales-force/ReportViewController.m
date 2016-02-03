//
//  ReportViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/20.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportViewCustomerCell.h"
#import "AppDelegate.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

@synthesize _date;
@synthesize _numberOfVisit;
@synthesize _comment;
@synthesize _todo;
@synthesize _commentFromManager;
@synthesize _customerListView;
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINib *nib = [UINib nibWithNibName:@"ReportViewCustomerCell" bundle:nil];
    [_customerListView registerNib:nib forCellReuseIdentifier:@"reportCustomerCell"];
    _comment.layer.borderWidth = 1;
    _comment.layer.borderColor = [[UIColor grayColor] CGColor];
    _commentFromManager.layer.borderWidth = 1;
    _commentFromManager.layer.borderColor = [[UIColor grayColor] CGColor];
    _todo.layer.borderWidth = 1;
    _todo.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setItem:(NSDictionary *)_item
{
    item = _item;
}

- (void)viewWillAppear:(BOOL)animated
{
    _date.text = item[@"date"];
    _comment.text = item[@"commentOfToday"];
    _todo.text = item[@"todoTomorrow"];
    _commentFromManager.text = item[@"commentFromManager"];
    [super viewWillAppear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)sendButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)cancelButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return(1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return([item[@"array"] count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportViewCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reportCustomerCell" forIndexPath:indexPath];
    NSDictionary    *customer = [item[@"array"] objectAtIndex:indexPath.row];
    cell.customer = customer;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
