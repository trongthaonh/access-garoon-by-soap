//
//  MessageViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/21.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

@synthesize _date;
@synthesize _from;
@synthesize _to;
@synthesize _subject;
@synthesize _body;
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    _from.text = item[@"from"];
    _to.text = item[@"to"];
    _subject.text = item[@"subject"];
    _body.text = item[@"body"];
#if 0
    {
        CGRect frame = _body.frame;
        frame.size.height = _body.contentSize.height;
        _body.frame = frame;
    }
#endif
}

- (void)textViewDidChange:(UITextView *)textView
{
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
