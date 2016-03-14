//
//  ReportTableViewCell.h
//  sales-force
//
//  Created by kiss on 2016/01/19.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DRAW_MANUALY    1

@interface ReportTableViewCell : UITableViewCell

#if !DRAW_MANUALY
@property (weak, nonatomic) IBOutlet UILabel     *_date;
@property (weak, nonatomic) IBOutlet UILabel     *_description;
@property (weak, nonatomic) IBOutlet UIImageView *_image;
#endif

@property (nonatomic, readonly) CGFloat height;

-(void) setReport:(NSDictionary *)report withSize:(BOOL)smallLayout;

@end
