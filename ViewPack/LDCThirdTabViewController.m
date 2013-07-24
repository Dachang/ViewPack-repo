//
//  LDCThirdTabViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCThirdTabViewController.h"
#import "LDCCustomGesture.h"
#import "LDCSoundManager.h"

#define MAX_TIME_INTERVAL 10

@interface LDCThirdTabViewController ()

@end

@implementation LDCThirdTabViewController
@synthesize tickleGesture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBackground];
    [self timerStart];
    [self initGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBackground
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBG_D.png"]];
}

- (void)initGesture
{
    self.tickleGesture = [[LDCCustomGesture alloc] initWithTarget:self action:@selector(tickleGestureFired)];
    [self.view addGestureRecognizer:self.tickleGesture];
}

- (void)tickleGestureFired
{
    if(_timeCount < MAX_TIME_INTERVAL)
    {
        if(self.tickleGesture.state == UIGestureRecognizerStateEnded)
        {
            [[LDCSoundManager sharedManager] playSoundEffectWithFileName:@"laugh"];
            NSLog(@"laugh");
            _timeCount = 0;
        }
    }
    else
    {
        if(self.tickleGesture.state == UIGestureRecognizerStateEnded)
        {
            _timeCount = 0;
            NSLog(@"Reset");
        }
    }
}

- (void)timerStart
{
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAccumulate) userInfo:nil repeats:YES];
}

- (void)timerAccumulate
{
    _timeCount++;
    NSLog(@"%d",_timeCount);
    if(_timeCount >= MAX_TIME_INTERVAL + 20)
    {
        _timeCount = 0;
    }
}

//- (void)timerAdvanced:(NSTimer *)timer
//{
//    int mTimer = 0;
//    if(mTimer == 0)
//    {
//        [timer invalidate];
//        [self timerStart];
//    }
//    mTimer++;
//    if(mTimer >= MAX_TIME_INTERVAL)
//    {
//        NSLog(@"%d",mTimer);
//        [self initGesture];
//    }
//    else
//        mTimer = 0;
//}



@end
