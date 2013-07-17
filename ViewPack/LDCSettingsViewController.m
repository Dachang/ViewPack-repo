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
    
    [self.view addSubview:navBar];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark
#pragma mark back button

- (void) backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
