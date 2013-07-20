//
//  LDCPageViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCSideMenuViewController.h"
#import "LDCShelfViewController.h"
#import "LDCBasicScrollViewController.h"


@interface LDCSideMenuViewController ()

@end

@implementation LDCSideMenuViewController
@synthesize sideMenu = _sideMenu;

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelfBG.png"]];
    //Side Menu Button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 400, 220, 64)];
    [button setImage:[UIImage imageNamed:@"startButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showSideMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 53, 30)];
    [backButton setImage:[UIImage imageNamed:@"scrollViewBackButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark
#pragma mark Side Menu

- (void) showSideMenu
{
    if(!_sideMenu)
    {
        RESideMenuItem *homeItem = [[RESideMenuItem alloc] initWithTitle:@"Home" action:^(RESideMenu *menu, RESideMenuItem *item){
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
            [menu setRootViewController:navigationController];
        }];
        
        _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem]];
        _sideMenu.verticalOffset = 110;
        _sideMenu.hideStatusBarArea = YES;
    }

    [_sideMenu show];
}

@end
