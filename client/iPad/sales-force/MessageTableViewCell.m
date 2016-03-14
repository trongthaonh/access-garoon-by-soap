//
//  MessageTableViewCell.m
//  sales-force
//
//  Created by kiss on 2016/02/02.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

@synthesize subject;
@synthesize date;
@synthesize sender;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
