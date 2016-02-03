//
//  ReportViewCustomerCell.h
//  sales-force
//
//  Created by kiss on 2016/01/21.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewCustomerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *_customer;
@property (weak, nonatomic) IBOutlet UILabel *_chargeof;
@property (weak, nonatomic) IBOutlet UILabel *_comment;

-(void) setCustomer:(NSDictionary *)customer;

@end
