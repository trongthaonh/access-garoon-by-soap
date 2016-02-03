//
//  ReportViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/20.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *_date;
@property (weak, nonatomic) IBOutlet UILabel *_numberOfVisit;
@property (weak, nonatomic) IBOutlet UITableView *_customerListView;
@property (weak, nonatomic) IBOutlet UITextView *_comment;
@property (weak, nonatomic) IBOutlet UITextView *_todo;
@property (weak, nonatomic) IBOutlet UITextView *_commentFromManager;

@property (strong, nonatomic) NSDictionary *item;

-(IBAction)sendButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;

@end
