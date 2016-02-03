//
//  ReportTableViewCell.m
//  sales-force
//
//  Created by kiss on 2016/01/19.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "ReportTableViewCell.h"

#define DESCRIPTION_OFFSET  10
#define CELL_VERTICAL_MARGIN 5
#define CELL_LEFT_MARGIN 15
#define CELL_RIGHT_MARGIN 40

#define SMALL_DATE_FONT_SIZE  15
#define SMALL_DESCRIPTION_FONT_SIZE   13
#define LARGE_DATE_FONT_SIZE    17
#define LARGE_DESCRIPTION_FONT_SIZE 15

@interface ReportTableViewCell()

@property (copy, nonatomic) NSDictionary *_report;
@property (nonatomic)       BOOL      _smallLayout;

@end
@implementation ReportTableViewCell

#if !DRAW_MANUALY
@synthesize _date;
@synthesize _description;
@synthesize _image;
#endif
@synthesize _report;
@synthesize _smallLayout;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#if DRAW_MANUALY
- (void)drawRect:(CGRect)rect
{
    int i;
    CGRect customerRect, commentRect, chargeofRect;
    UIFont *dateFont = nil;
    UIFont *descriptionFont = nil;
    NSString *date = _report[@"date"];
    NSArray *array = _report[@"array"];
    
    if(_smallLayout){
        dateFont = [UIFont systemFontOfSize:SMALL_DATE_FONT_SIZE];
        descriptionFont = [UIFont systemFontOfSize:SMALL_DESCRIPTION_FONT_SIZE];
    }else{
        dateFont = [UIFont systemFontOfSize:LARGE_DATE_FONT_SIZE];
        descriptionFont = [UIFont systemFontOfSize:LARGE_DESCRIPTION_FONT_SIZE];
    }
    rect.origin.x += CELL_LEFT_MARGIN;
    rect.origin.y += CELL_VERTICAL_MARGIN;
    rect.size.width -= CELL_RIGHT_MARGIN + CELL_LEFT_MARGIN;
    rect.size.height -= CELL_VERTICAL_MARGIN * 2;
    [[UIColor blackColor] set];
    [date drawAtPoint:rect.origin withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:dateFont, NSFontAttributeName, nil]];
    rect.origin.y += dateFont.lineHeight;
    rect.origin.x += DESCRIPTION_OFFSET;
    rect.size.width -= DESCRIPTION_OFFSET;
    rect.size.height -= dateFont.lineHeight;
    if(_smallLayout){
        customerRect = CGRectMake(rect.origin.x, rect.origin.y, (rect.size.width * 2) / 3, descriptionFont.lineHeight);
    }else{
        customerRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width / 3, descriptionFont.lineHeight);
    }
    chargeofRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width / 3, descriptionFont.lineHeight);
    chargeofRect = CGRectMake(CGRectGetMaxX(customerRect), rect.origin.y, 100, descriptionFont.lineHeight);
    commentRect = CGRectMake(CGRectGetMaxX(chargeofRect), rect.origin.y, rect.size.width - CGRectGetMaxX(chargeofRect), descriptionFont.lineHeight);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = NSTextAlignmentLeft;
    NSDictionary    *descriptionAttributes = [NSDictionary dictionaryWithObjectsAndKeys:descriptionFont, NSFontAttributeName, style, NSParagraphStyleAttributeName, nil];
    for(i = 0; i < [array count]; i++){
        NSString    *customer = [[array objectAtIndex:i] objectForKey:@"customer"];
        NSString    *chargeof = [[array objectAtIndex:i] objectForKey:@"chargeof"];
        NSString    *comment = [[array objectAtIndex:i] objectForKey:@"comment"];
        [customer drawInRect:customerRect withAttributes:descriptionAttributes];
        [chargeof drawInRect:chargeofRect withAttributes:descriptionAttributes];
        if(!_smallLayout){
            [comment drawInRect:commentRect withAttributes:descriptionAttributes];
        }
        customerRect.origin.y += descriptionFont.lineHeight;
        chargeofRect.origin.y += descriptionFont.lineHeight;
        commentRect.origin.y += descriptionFont.lineHeight;
    }
}
#endif

-(void) setReport:(NSDictionary *)report withSize:(BOOL)smallLayout
{
    _report = report;
    _smallLayout = smallLayout;
#if !DRAW_MANUALY
    _date.text = _report[@"date"];
    NSArray *array = _report[@"array"];
    NSMutableParagraphStyle *tabStyle = [NSMutableParagraphStyle new];
    NSMutableAttributedString *detailString = [[NSMutableAttributedString alloc] init];
    int i;
    [tabStyle setTabStops:[NSArray array]];
    [tabStyle addTabStop:[[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentLeft location:20.0 options:[NSDictionary dictionary]]];
    for(i = 0; i < [array count]; i++){
        NSDictionary *item = [array objectAtIndex:i];
        if(i != 0){
            [detailString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        [detailString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\t%@", item[@"customer"], item[@"comment"]]]];
    }
    _description.attributedText = detailString;
    _description.numberOfLines = [array count];
    [_description sizeToFit];
#endif
}

-(CGFloat) height
{
#if DRAW_MANUALY
    NSArray *array = _report[@"array"];
    UIFont *descriptionFont = nil;
    UIFont *dateFont = nil;
    if(_smallLayout){
        dateFont = [UIFont systemFontOfSize:SMALL_DATE_FONT_SIZE];
        descriptionFont = [UIFont systemFontOfSize:SMALL_DESCRIPTION_FONT_SIZE];
    }else{
        dateFont = [UIFont systemFontOfSize:LARGE_DATE_FONT_SIZE];
        descriptionFont = [UIFont systemFontOfSize:LARGE_DESCRIPTION_FONT_SIZE];
    }
    return(ceil(dateFont.lineHeight +(descriptionFont.lineHeight * [array count])) + (CELL_VERTICAL_MARGIN * 2));
#else
    return(_date.bounds.size.height + _description.bounds.size.height + (CELL_VERTICAL_MARGIN * 2));
#endif
}
@end
