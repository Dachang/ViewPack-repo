//
//  LDCPushViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-27.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCPushViewController.h"
#import "LDCShelfTableViewCell.h"
#import "LDCGraphicName.h"

@interface LDCPushViewController ()

@end

@implementation LDCPushViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initBackground];
    [self initButton];
    [self initPushView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBackground
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initButton
{
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, (SCREEN_HEIGHT - 100)/2, 150, 100)];
    [tempButton setImage:[UIImage imageNamed:PUSH_BUTTON] forState:UIControlStateNormal];
    _button = tempButton;
    [_button addTarget:self action:@selector(pushButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 964, 51, 30)];
    [BackButton setImage:[UIImage imageNamed:BACK_BUTTON] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackButton];
}

- (void)initPushView
{
    _pushView = [[LDCShelfTableViewCell alloc] init];
    _pushView.frame = CGRectMake(768, 0, 768, 1024);
    [self.view addSubview:_pushView];
    [_pushView setHidden:YES];
}

#pragma mark
#pragma mark target

- (void)pushButtonPressed
{
    [self pushViewAnimation:_pushView willHidden:NO];
}

- (void)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark
#pragma mark push viewController methods

- (void) pushViewAnimation:(UIView *)view willHidden:(BOOL)hidden
{
    [UIView animateWithDuration:1.0 animations:^{
        if(hidden)
        {
            view.frame = CGRectMake(768, 0, 768, 1024);
        }
        else
        {
            [view setHidden:hidden];
            view.frame = CGRectMake(100, 0, 768, 1024);
        }
    }completion:^(BOOL finished){
        [view setHidden:hidden];
    }];
}

@end
