//
//  LDCControlPanelViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCControlPanelViewController.h"
#import "LDCViewController.h"

@interface LDCControlPanelViewController ()

@end

@implementation LDCControlPanelViewController

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
    self.view.backgroundColor = [UIColor grayColor];
    [self.startButton removeFromSuperview];
    
    UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 920, 53, 30)];
    [returnButton setImage:[UIImage imageNamed:@"scrollViewBackButton.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(returnToRootView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Action

- (void) returnToRootView
{
    [self.navigationController pushViewController:[[LDCSideMenuViewController alloc] init] animated:YES];
}

@end
