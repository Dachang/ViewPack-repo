//
//  LDCThirdTabViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDCCustomGesture;

@interface LDCGestureTabViewController : UIViewController
{
    NSTimer *_timer;
    NSInteger _timeCount;
}

@property (strong, nonatomic) LDCCustomGesture *tickleGesture;

//- (void)timerAdvanced:(NSTimer *) timer;

@end
