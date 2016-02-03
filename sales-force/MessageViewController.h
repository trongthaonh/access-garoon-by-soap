//
//  MessageViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/21.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *_date;
@property (weak, nonatomic) IBOutlet UITextField *_from;
@property (weak, nonatomic) IBOutlet UITextField *_to;
@property (weak, nonatomic) IBOutlet UITextField *_subject;
@property (weak, nonatomic) IBOutlet UITextView *_body;
@property (strong, nonatomic) NSDictionary *item;

@end
