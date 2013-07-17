//
//  LDCSettingsViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-17.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCSettingsViewController.h"

@interface LDCSettingsViewController ()

@end

@implementation LDCSettingsViewController
@synthesize navBar;

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
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 33)];
    [button setImage:[UIImage imageNamed:@"NavBarButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    navigationItem.rightBarButtonItem = rightBarButton;
    [self.navBar pushNavigationItem:navigationItem animated:NO];
    
    [self.view addSubview:navBar];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark
#pragma mark back button

- (void) backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
