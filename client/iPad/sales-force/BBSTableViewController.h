//
//  BBSTableViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (weak, nonatomic) NSDictionary *folder;

-(void) setFolder:(NSDictionary *)_folder;

@end
