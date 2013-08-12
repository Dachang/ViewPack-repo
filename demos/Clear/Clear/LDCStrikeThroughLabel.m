//
//  LDCStrikeThroughLabel.m
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LDCStrikeThroughLabel.h"

@implementation LDCStrikeThroughLabel
{
    bool _strikeThrough;
    CALayer* _strikeThroughLayer;
}

const float STRIKEOUT_THICKNESS = 2.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _strikeThroughLayer = [CALayer layer];
        _strikeThroughLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        _strikeThroughLayer.hidden = YES;
        [self.layer addSublayer:_strikeThroughLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self resizeStrikeThrough];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self resizeStrikeThrough];
}

- (void)resizeStrikeThrough
{
    CGSize textSize = [self.text sizeWithFont:self.font];
    _strikeThroughLayer.frame = CGRectMake(0, self.bounds.size.height/2, textSize.width, STRIKEOUT_THICKNESS);
}

- (void)setStirkeThrough:(bool)stirkeThrough
{
    _strikeThrough = stirkeThrough;
    _strikeThroughLayer.hidden = !stirkeThrough;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
