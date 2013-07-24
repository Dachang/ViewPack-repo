//
//  LDCCustomGesture.m
//  ViewPack
//
//  Created by 大畅 on 13-7-22.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCCustomGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

#define REQUIRED_TICKLES 2
#define MOVE_AMT_PER_TICKLE 25

@implementation LDCCustomGesture

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.curTickleStart = [touch locationInView:self.view];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //minimum account of moves
    UITouch *touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self.view];
    CGFloat moveAmount = ticklePoint.x - self.curTickleStart.x;
    
    gestureDirection currentDirection;
    if(moveAmount < 0)
    {
        currentDirection = DIRECTION_LEFT;
    }
    else
    {
        currentDirection = DIRECTION_RIGHT;
    }
    if(ABS(moveAmount) < MOVE_AMT_PER_TICKLE) return;
    
    if(self.lastDirection == DIRECTION_UNKOWN||(self.lastDirection == DIRECTION_LEFT && currentDirection == DIRECTION_RIGHT)||(self.lastDirection == DIRECTION_RIGHT && currentDirection == DIRECTION_LEFT))
    {
        self.tickleCount++;
        self.curTickleStart = ticklePoint;
        self.lastDirection = currentDirection;


        if(self.state == UIGestureRecognizerStatePossible && self.tickleCount > REQUIRED_TICKLES)
        {
            [self setState:UIGestureRecognizerStateEnded];
        }
    }
}

 - (void)reset
{
    self.tickleCount = 0;
    self.curTickleStart = CGPointZero;
    self.lastDirection = DIRECTION_UNKOWN;
    if(self.state == UIGestureRecognizerStatePossible)
    {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reset];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reset];
}

@end
