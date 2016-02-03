//
//  WorkflowTableViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/19.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkflowTableViewController : UITableViewController<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *_searchBar;
@property (weak, nonatomic) IBOutlet NSNumber    *_smallLayout;

- (IBAction)newAction:(id)sender;
- (IBAction)searchAction:(id)sender;

@end
