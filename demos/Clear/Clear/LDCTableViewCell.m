//
//  LDCTableViewCell.m
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LDCTableViewCell.h"
#import "LDCStrikeThroughLabel.h"

const float LABEL_LEFT_MARGIN = 15.0f;
const float UI_CUES_MARGIN = 10.0f;
const float UI_CUES_WIDTH = 50.0f;

@implementation LDCTableViewCell
{
    CAGradientLayer *_gardientLayer;
    CGPoint _originalCenter;
    BOOL _deleteOnDragRelease;
    BOOL _completeOnDragRelease;
    LDCStrikeThroughLabel *_label;
    CALayer *_itemCompleteLayer;
    UILabel *_tickLabel;
    UILabel *_crossLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tickLabel = [self createCueLabels];
        _tickLabel.text = @"\u2713";
        _tickLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tickLabel];
        _crossLabel = [self createCueLabels];
        _crossLabel.text = @"\u2717";
        _crossLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_crossLabel];
        
        _label = [[LDCStrikeThroughLabel alloc] initWithFrame:CGRectNull];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont boldSystemFontOfSize:16];
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _gardientLayer = [CAGradientLayer layer];
        _gardientLayer.frame = self.bounds;
        _gardientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gardientLayer.locations = @[@0.00f,@0.01f,@0.95f,@1.00f];
        [self.layer insertSublayer:_gardientLayer atIndex:0];
        
        _itemCompleteLayer = [CALayer layer];
        _itemCompleteLayer.backgroundColor = [[[UIColor alloc] initWithRed:0.0 green:0.6 blue:0.0 alpha:1.0] CGColor];
        _itemCompleteLayer.hidden = YES;
        [self.layer insertSublayer:_itemCompleteLayer atIndex:0];
        
        //create gesture
        UIGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer: recognizer];
    }
    return self;
}

//This is important - ensure the layers occupies the full bounds
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _gardientLayer.frame = self.bounds;
    _itemCompleteLayer.frame = self.bounds;
    _label.frame = CGRectMake(LABEL_LEFT_MARGIN, 0, self.bounds.size.width - LABEL_LEFT_MARGIN, self.bounds.size.height);
    [self bringSubviewToFront:_label];
    _tickLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0, UI_CUES_WIDTH, self.bounds.size.height);
    _crossLabel.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0, UI_CUES_WIDTH, self.bounds.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - gesture target

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    //check for horizontal gesture
    if(fabsf(translation.x)>fabsf(translation.y))
    {
        return YES;
    }
    return NO;
}

- (void)handlePan:(UIPanGestureRecognizer*)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        //if the gesture has just started, record the current center locations
        _originalCenter = self.center;
    }
    
    if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        //translate the center
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(_originalCenter.x + translation.x, _originalCenter.y);
        //determine whether the items has been dragged far enough tp initiate a delete/complete
        _deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width/2;
        _completeOnDragRelease = self.frame.origin.x > self.frame.size.width/2;
        
        float cueAlpha = fabsf(self.frame.origin.x)/(self.frame.size.width/2);
        _tickLabel.alpha = cueAlpha;
        _crossLabel.alpha = cueAlpha;
        
        _tickLabel.textColor = _completeOnDragRelease ? [UIColor greenColor]:[UIColor whiteColor];
        _crossLabel.textColor = _deleteOnDragRelease ? [UIColor redColor]:[UIColor whiteColor];
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
        if(!_deleteOnDragRelease)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.frame = originalFrame;
            }];
        }
        if (_completeOnDragRelease)
        {
            self.todoItem.completed = YES;
            _itemCompleteLayer.hidden = NO;
            _label.stirkeThrough = YES;
        }
        if (_deleteOnDragRelease)
        {
            [self.delegate toDoItemDeleted:self.todoItem];
        }
    }
}

#pragma mark - setter
//this is important, since it directly get the REFs from todoItems, meanwhile updates all the visual state associated with the model item
- (void)setTodoItem:(LDCToDoItem *)todoItem
{
    _todoItem = todoItem;
    _label.text = todoItem.text;
    _label.stirkeThrough = todoItem.completed;
    _itemCompleteLayer.hidden = !todoItem.completed;
}

#pragma mark - Contextual Cues

- (UILabel*)createCueLabels
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:32.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

@end
