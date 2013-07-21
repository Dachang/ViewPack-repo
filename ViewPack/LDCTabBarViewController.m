//
//  LDCTabBarViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCTabBarViewController.h"

@interface LDCTabBarViewController ()

@end

@implementation LDCTabBarViewController
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, 768, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [button setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    navigationItem.leftBarButtonItem = leftBarButton;
    [self.navBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:self.navBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark back button

- (void) backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
