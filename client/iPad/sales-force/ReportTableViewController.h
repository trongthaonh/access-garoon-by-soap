//
//  ReportTableViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTableViewController : UITableViewController<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (weak, nonatomic) IBOutlet NSNumber    *_smallLayout;

@end
