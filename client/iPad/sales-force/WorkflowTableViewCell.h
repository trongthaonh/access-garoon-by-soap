//
//  WorkflowTableViewCell.h
//  sales-force
//
//  Created by kiss on 2016/01/19.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkflowTableViewCell : UITableViewCell

@property (nonatomic, readonly) CGFloat height;

-(void) setWorkflow:(NSDictionary *)workflow withSize:(BOOL)smallLayout;

@end
