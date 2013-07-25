//
//  LDCThirdTabViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCGestureTabViewController.h"
#import "LDCSoundManager.h"

#define MAX_TIME_INTERVAL 10

@interface LDCGestureTabViewController ()

@end

@implementation LDCGestureTabViewController
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
    self.tickleGesture.tickleDelegate = self;
    [self.tickleGesture changeStringForKVO:@"TestValueA"];
    NSLog(@"The Original Value is %@",[self.tickleGesture valueForKey:@"testForKVO"]);
    [self.tickleGesture setValue:@"TestValueB" forKey:@"testForKVO"];
    [self testKVO];
    [self testKVC];
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
    [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAccumulate:) userInfo:nil repeats:YES];
}

- (void)timerAccumulate:(NSTimer*) timer
{
    _timeCount++;
//    NSLog(@"%d",_timeCount);
    if(_timeCount >= MAX_TIME_INTERVAL + 20)
    {
        //[timer invalidate];
        _timeCount = 0;
    }
}

#pragma mark
#pragma mark tickle delegate

- (void)testMethod
{
    NSLog(@"Custom tickle Gesture Delegate");
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

#pragma mark
#pragma mark Test KVC

- (void) testKVC
{
    [self.tickleGesture setValue:@"Success" forKey:@"testForKVC"];
    NSString *name = [self.tickleGesture valueForKey:@"testForKVC"];
    NSLog(@"Test For KVC: %@",name);
}

#pragma mark
#pragma mark Test KVO

- (void) testKVO
{
    [self.tickleGesture addObserver:self forKeyPath:@"testForKVO" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

//只有通过键值编码(KVC)改变的值，才会回调观察者注册的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"testForKVO"])
    {
        NSLog(@"Test String for KVO has been changed:");
        NSLog(@"The New Value is:%@ The Old Value is:%@", [change objectForKey:@"new"],[change objectForKey:@"old"]);
    }
}


@end
