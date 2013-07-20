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
#import "LDCHomeViewController.h"
#import "LDCControlPanelViewController.h"

@interface LDCSideMenuViewController ()

@end

@implementation LDCSideMenuViewController
@synthesize sideMenu = _sideMenu, startButton;

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
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 53, 30)];
    [tempButton setImage:[UIImage imageNamed:@"scrollViewBackButton.png"] forState:UIControlStateNormal];
    [tempButton addTarget:self action:@selector(showSideMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tempButton];
    [tempButton release];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelfBG.png"]];
    //Side Menu Button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 400, 220, 64)];
    [button setImage:[UIImage imageNamed:@"startButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showSideMenu) forControlEvents:UIControlEventTouchUpInside];
    self.startButton = button;
    [self.view addSubview:startButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 964, 53, 30)];
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
            LDCHomeViewController *startViewController = [[LDCHomeViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:startViewController];
            [menu setRootViewController:navigationController];
        }];
        
        RESideMenuItem *volumnItem = [[RESideMenuItem alloc] initWithTitle:@"ControlPanel" action:^(RESideMenu *menu, RESideMenuItem *item){
            LDCControlPanelViewController *controlPanelViewController = [[LDCControlPanelViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controlPanelViewController];
            [menu setRootViewController:navigationController];
        }];
        
        RESideMenuItem *animateItem = [[RESideMenuItem alloc] initWithTitle:@"Animation" action:^(RESideMenu *menu, RESideMenuItem *item){
            LDCControlPanelViewController *controlPanelViewController = [[LDCControlPanelViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controlPanelViewController];
            [menu setRootViewController:navigationController];
        }];
        
        RESideMenuItem *netItem = [[RESideMenuItem alloc] initWithTitle:@"Network" action:^(RESideMenu *menu, RESideMenuItem *item){
            LDCControlPanelViewController *controlPanelViewController = [[LDCControlPanelViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controlPanelViewController];
            [menu setRootViewController:navigationController];
        }];
        
        RESideMenuItem *AccountItem = [[RESideMenuItem alloc] initWithTitle:@"Account" action:^(RESideMenu *menu, RESideMenuItem *item){
            [menu hide];
        }];
        RESideMenuItem *helpItem = [[RESideMenuItem alloc] initWithTitle:@"Help" action:^(RESideMenu *menu, RESideMenuItem *item){
            [menu hide];
        }];
        
        RESideMenuItem *itemWithSubItems = [[RESideMenuItem alloc] initWithTitle:@"Extension >" action:^(RESideMenu *menu, RESideMenuItem *item){
            //add
        }];
        itemWithSubItems.subItems = @[AccountItem, helpItem];
        
        
        _sideMenu = [[RESideMenu alloc] initWithItems:@[homeItem,volumnItem,animateItem,netItem,itemWithSubItems]];
        _sideMenu.verticalOffset = 210;
        _sideMenu.hideStatusBarArea = YES;
    }

    [_sideMenu show];
}

@end
