//
//  ReportViewCustomerCell.m
//  sales-force
//
//  Created by kiss on 2016/01/21.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "ReportViewCustomerCell.h"

@implementation ReportViewCustomerCell

@synthesize _customer;
@synthesize _chargeof;
@synthesize _comment;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setCustomer:(NSDictionary *)customer
{
    _customer.text = customer[@"customer"];
    _chargeof.text = customer[@"chargeof"];
    _comment.text = customer[@"comment"];
}

@end
