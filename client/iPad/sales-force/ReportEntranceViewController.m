//
//  ReportEntranceViewController.m
//  sales-force
//
//  Created by kiss on 2016/02/01.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "ReportEntranceViewController.h"
#import "AppDelegate.h"

@interface ReportEntranceViewController ()

@end

@implementation ReportEntranceViewController

@synthesize _quata_for_me_title;
@synthesize _quata_for_me_sales_volumes;
@synthesize _quata_for_me_gross_profit_rate;
@synthesize _quata_for_me_gross_profit;
@synthesize _quata_for_me_sales_volumes_progress;
@synthesize _quata_for_me_gross_profit_progress;
@synthesize _quata_for_me_comment;
@synthesize _quata_for_us_sales_volumes;
@synthesize _quata_for_us_gross_profit_rate;
@synthesize _quata_for_us_gross_profit;
@synthesize _quata_for_us_sales_volumes_progress;
@synthesize _quata_for_us_gross_profit_progress;
@synthesize _quata_for_us_comment;
@synthesize _per_product_view;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSDictionary *userProfile = [(AppDelegate *)[[UIApplication sharedApplication] delegate] userProfile];
    NSDictionary *forMe = userProfile[@"sales_quota"][@"for_me"];
    NSDictionary *forUs = userProfile[@"sales_quota"][@"for_us"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.negativeFormat = @"0.00";
    formatter.positiveFormat = @"0.00";

    _quata_for_me_title.text = [NSString stringWithFormat:NSLocalizedString(@"Quata to %@", nil), userProfile[@"family_name"]];
    _quata_for_me_sales_volumes.text = [NSString stringWithFormat:NSLocalizedString(@"Sales volumes are %@/%@(k JPY)", nil), [NSNumberFormatter localizedStringFromNumber:forMe[@"sales_volumes_until_today"] numberStyle:NSNumberFormatterDecimalStyle], [NSNumberFormatter localizedStringFromNumber:forMe[@"annual_sales"] numberStyle:NSNumberFormatterDecimalStyle]];
    _quata_for_me_gross_profit_rate.text = [NSString stringWithFormat:NSLocalizedString(@"Gross profits rate is %@%%/%@%%", nil), [formatter stringFromNumber:forMe[@"gross_profit_until_today_rate"]], [formatter stringFromNumber:forMe[@"annual_gross_profit_rate"]]];
    _quata_for_me_gross_profit.text = [NSString stringWithFormat:NSLocalizedString(@"Gross profits are %@/%@(k JPY)", nil), [NSNumberFormatter localizedStringFromNumber:forMe[@"gross_profit_until_today"] numberStyle:NSNumberFormatterDecimalStyle], [NSNumberFormatter localizedStringFromNumber:forMe[@"annual_gross_profit"] numberStyle:NSNumberFormatterDecimalStyle]];
    _quata_for_me_sales_volumes_progress.progress = [forMe[@"sales_volumes_until_today"] doubleValue] / [forMe[@"annual_sales"] doubleValue];
    _quata_for_me_gross_profit_progress.progress = [forMe[@"gross_profit_until_today"] doubleValue] / [forMe[@"annual_gross_profit"] doubleValue];
    _quata_for_me_comment.text = forMe[@"comment"];
    _quata_for_us_sales_volumes.text = [NSString stringWithFormat:NSLocalizedString(@"Sales volumes are %@/%@(k JPY)", nil), [NSNumberFormatter localizedStringFromNumber:forUs[@"sales_volumes_until_today"] numberStyle:NSNumberFormatterDecimalStyle], [NSNumberFormatter localizedStringFromNumber:forUs[@"annual_sales"] numberStyle:NSNumberFormatterDecimalStyle]];
    _quata_for_us_gross_profit_rate.text = [NSString stringWithFormat:NSLocalizedString(@"Gross profits rate is %@%%/%@%%", nil), [formatter stringFromNumber:forUs[@"gross_profit_until_today_rate"]], [formatter stringFromNumber:forUs[@"annual_gross_profit_rate"]]];
    _quata_for_us_gross_profit.text = [NSString stringWithFormat:NSLocalizedString(@"Gross profits are %@/%@(k JPY)", nil), [NSNumberFormatter localizedStringFromNumber:forUs[@"gross_profit_until_today"] numberStyle:NSNumberFormatterDecimalStyle], [NSNumberFormatter localizedStringFromNumber:forUs[@"annual_gross_profit"] numberStyle:NSNumberFormatterDecimalStyle]];
    _quata_for_us_sales_volumes_progress.progress = [forUs[@"sales_volumes_until_today"] doubleValue] / [forUs[@"annual_sales"] doubleValue];
    _quata_for_us_gross_profit_progress.progress = [forUs[@"gross_profit_until_today"] doubleValue] / [forUs[@"annual_gross_profit"] doubleValue];
    _quata_for_us_comment.text = forUs[@"comment"];
    _per_product_view.quotaPerProduct =userProfile[@"sales_quota"][@"per_product"];
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
