//
//  WorkflowTableViewCell.m
//  sales-force
//
//  Created by kiss on 2016/01/19.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import "WorkflowTableViewCell.h"

#define DESCRIPTION_OFFSET  10
#define CELL_VERTICAL_MARGIN 5
#define CELL_LEFT_MARGIN 15
#define CELL_RIGHT_MARGIN 40

#define SMALL_DATE_FONT_SIZE  15
#define SMALL_DESCRIPTION_FONT_SIZE   13
#define LARGE_DATE_FONT_SIZE    17
#define LARGE_DESCRIPTION_FONT_SIZE 15

@interface WorkflowTableViewCell()

@property (copy, nonatomic) NSDictionary *_workflow;
@property (nonatomic)       BOOL      _smallLayout;

@end
@implementation WorkflowTableViewCell

@synthesize _workflow;
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

- (void)drawRect:(CGRect)rect
{
    int i;
    CGRect fromtoRect, commentRect, priceRect, consentRect;
    UIFont *dateFont = nil;
    UIFont *descriptionFont = nil;
    NSString *date = _workflow[@"date"];
    NSArray *array = _workflow[@"array"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:locale];
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
    consentRect = CGRectMake(CGRectGetMaxX(rect) - LARGE_DESCRIPTION_FONT_SIZE, rect.origin.y + ((rect.size.height - LARGE_DESCRIPTION_FONT_SIZE) / 2), LARGE_DESCRIPTION_FONT_SIZE, LARGE_DESCRIPTION_FONT_SIZE);
    rect.size.width -= LARGE_DESCRIPTION_FONT_SIZE;
    rect.origin.y += dateFont.lineHeight;
    rect.origin.x += DESCRIPTION_OFFSET;
    rect.size.width -= DESCRIPTION_OFFSET;
    rect.size.height -= dateFont.lineHeight;
    if(_smallLayout){
        fromtoRect = CGRectMake(rect.origin.x, rect.origin.y, (rect.size.width * 2) / 3, descriptionFont.lineHeight);
    }else{
        fromtoRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width / 3, descriptionFont.lineHeight);
    }
    priceRect = CGRectMake(CGRectGetMaxX(fromtoRect), rect.origin.y, 100, descriptionFont.lineHeight);
    commentRect = CGRectMake(CGRectGetMaxX(priceRect), rect.origin.y, rect.size.width - CGRectGetMaxX(priceRect), descriptionFont.lineHeight);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = NSTextAlignmentLeft;
    NSDictionary    *descriptionAttributes = [NSDictionary dictionaryWithObjectsAndKeys:descriptionFont, NSFontAttributeName, style, NSParagraphStyleAttributeName, nil];
    for(i = 0; i < [array count]; i++){
        NSString    *from = [[array objectAtIndex:i] objectForKey:@"from"];
        NSString    *to = [[array objectAtIndex:i] objectForKey:@"to"];
        NSNumber    *priceNumber = [[array objectAtIndex:i] objectForKey:@"price"];
        NSString    *price = [formatter stringFromNumber:priceNumber];
        NSString    *comment = [[array objectAtIndex:i] objectForKey:@"reason"];
        NSString    *fromto = [NSString stringWithFormat:@"%@〜%@", from, to];

        [fromto drawInRect:fromtoRect withAttributes:descriptionAttributes];
        [price drawInRect:priceRect withAttributes:descriptionAttributes];
        [comment drawInRect:commentRect withAttributes:descriptionAttributes];
        if(!_smallLayout){
            [comment drawInRect:commentRect withAttributes:descriptionAttributes];
        }
        fromtoRect.origin.y += descriptionFont.lineHeight;
        priceRect.origin.y += descriptionFont.lineHeight;
        commentRect.origin.y += descriptionFont.lineHeight;
    }
    if([_workflow[@"consent"] boolValue]){
        [@"済" drawInRect:consentRect withAttributes:descriptionAttributes];
    }
}

-(void) setWorkflow:(NSDictionary *)workflow withSize:(BOOL)smallLayout
{
    _workflow = workflow;
    _smallLayout = smallLayout;
}

-(CGFloat) height
{
    NSArray *array = _workflow[@"array"];
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
}
@end
