//
//  BBSViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/26.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *_date;
@property (weak, nonatomic) IBOutlet UITextField *_from;
@property (weak, nonatomic) IBOutlet UITextField *_subject;
@property (weak, nonatomic) IBOutlet UITextView *_body;
@property (weak, nonatomic) IBOutlet UIButton *_close;
@property (strong, nonatomic) NSDictionary *item;

- (IBAction)closeAction:(id)sender;

@end
