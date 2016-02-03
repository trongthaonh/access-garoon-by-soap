//
//  MessageTableViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/15.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (nonatomic) NSInteger _category;

-(void) setCategory:(NSInteger)category;

@end
