//
//  CalenderViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/18.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "CalenderViewController.h"

@implementation CalenderViewController

@synthesize _calenderView;
@synthesize _scheduleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark Table View Data Source delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return(10);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"schedule-%d", (int)indexPath.row];
    return cell;
}
@end
