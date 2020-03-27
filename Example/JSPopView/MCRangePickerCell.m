//
//  MCRangePickerCell.m
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "MCRangePickerCell.h"
#import "FSCalendarExtensions.h"
#import "UIColor+MCExtension.h"

@implementation MCRangePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer *selectionLayer = [[CALayer alloc] init];
        selectionLayer.backgroundColor = [UIColor mcColorWithHexString:@"#0DAF52"].CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        // Hide the default selection layer
        self.shapeLayer.hidden = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.selectionLayer.frame = self.contentView.bounds;
}

@end
