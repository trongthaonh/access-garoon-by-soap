//
//  ReportQuotaPerProductView.m
//  sales-force
//
//  Created by kiss on 2016/02/01.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "ReportQuotaPerProductView.h"

#define CELL_FONT_SIZE  15

@implementation ReportQuotaPerProductView

@synthesize quotaPerProduct;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    rect = CGRectInset(rect, 8, 8);
    UIBezierPath *frame = [UIBezierPath bezierPathWithRect:rect];
    [frame stroke];
    if(quotaPerProduct != nil){
        int x, y;
        int lines = (int)[quotaPerProduct count];
        double  height = CGRectGetHeight(rect) / (lines + 1);
        double  width = CGRectGetWidth(rect) / 4;
        NSMutableParagraphStyle *headerStyle = [[NSMutableParagraphStyle alloc] init];
        NSMutableParagraphStyle *titleStyle = [[NSMutableParagraphStyle alloc] init];
        NSMutableParagraphStyle *numberStyle = [[NSMutableParagraphStyle alloc] init];
        NSParagraphStyle *style;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.negativeFormat = @"0.00";
        formatter.positiveFormat = @"0.00";
        headerStyle.alignment = NSTextAlignmentCenter;
        titleStyle.alignment = NSTextAlignmentLeft;
        numberStyle.alignment = NSTextAlignmentRight;

        for(y = 1; y < (lines + 1); y++){
            UIBezierPath *line = [UIBezierPath bezierPath];
            [line moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect) + (y * height))];
            [line addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect) + (y * height))];
            [line stroke];
        }
        for(x = 1; x < 4; x++){
            UIBezierPath *line = [UIBezierPath bezierPath];
            [line moveToPoint:CGPointMake(CGRectGetMinX(rect) + (x * width), CGRectGetMinY(rect))];
            [line addLineToPoint:CGPointMake(CGRectGetMinX(rect) + (x * width), CGRectGetMaxY(rect))];
            [line stroke];
        }
        for(y = 0; y < lines + 1; y++){
            NSString *keys[] = {@"title", @"plan", @"result", @"rate"};
            NSDictionary *item = nil;
            if(y == 0){
                item = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"title", NSLocalizedString(@"Plan", nil), @"plan", NSLocalizedString(@"Result", nil), @"result", NSLocalizedString(@"Rate", nil), @"rate", nil];
            }else{
                item = quotaPerProduct[y - 1];
            }
            for(x = 0; x < 4; x++){
                CGRect cell = CGRectMake(CGRectGetMinX(rect) + (width * x), CGRectGetMinY(rect) + (height * y), width, height);
                cell = CGRectInset(cell, 8, 8);
                NSString *string = nil;
                if(y == 0){
                    string = item[keys[x]];
                    style = headerStyle;
                }else{
                    if(x == 0){
                        string = item[keys[x]];
                        style = titleStyle;
                    }else if(x == 3){
                        string = [formatter stringFromNumber:item[keys[x]]];
                        style = numberStyle;
                    }else{
                        string = [NSNumberFormatter localizedStringFromNumber:item[keys[x]] numberStyle:NSNumberFormatterDecimalStyle];
                        style = numberStyle;
                    }
                }
                [string drawInRect:cell withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:style, NSParagraphStyleAttributeName, nil]];
            }
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)setQuotaPerProduct:(NSArray *)_quotaPerProduct
{
    quotaPerProduct = _quotaPerProduct;
    [self setNeedsDisplay];
}

@end
