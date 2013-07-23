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
    if(self.tickleGesture.state == UIGestureRecognizerStateEnded)
    {
        [[LDCSoundManager sharedManager] playSoundEffectWithFileName:@"laugh"];
        NSLog(@"laugh");
    }
    else
        NSLog(@"NULL");
}

@end
