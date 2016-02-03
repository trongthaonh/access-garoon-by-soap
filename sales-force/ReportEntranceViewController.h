//
//  ReportEntranceViewController.h
//  sales-force
//
//  Created by kiss on 2016/02/01.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportQuotaPerProductView.h"

@interface ReportEntranceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *_quata_for_me_title;
@property (weak, nonatomic) IBOutlet UILabel *_quata_for_me_sales_volumes;
@property (weak, nonatomic) IBOutlet UILabel *_quata_for_me_gross_profit_rate;
@property (weak, nonatomic) IBOutlet UILabel *_quata_for_me_gross_profit;
@property (weak, nonatomic) IBOutlet UIProgressView *_quata_for_me_sales_volumes_progress;
@property (weak, nonatomic) IBOutlet UIProgressView *_quata_for_me_gross_profit_progress;
@property (weak, nonatomic) IBOutlet UITextView *_quata_for_me_comment;
@property (weak, nonatomic) IBOutlet UILabel *_quata_for_us_sales_volumes;
@property (weak, nonatomic) IBOutlet UILabel *_quata_for_us_gross_profit_rate;
@property (weak, nonatomic) IBOutlet UILabel *_quata_for_us_gross_profit;
@property (weak, nonatomic) IBOutlet UIProgressView *_quata_for_us_sales_volumes_progress;
@property (weak, nonatomic) IBOutlet UIProgressView *_quata_for_us_gross_profit_progress;
@property (weak, nonatomic) IBOutlet UITextView *_quata_for_us_comment;
@property (weak, nonatomic) IBOutlet ReportQuotaPerProductView *_per_product_view;

@end
