//
//  LDCTabBarViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCTabBarViewController.h"
#import "LDCGraphicName.h"

@interface LDCTabBarViewController ()

@end

@implementation LDCTabBarViewController
@synthesize navBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
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
    
    [self initTabBarView];
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

#pragma mark
#pragma mark Custom TabBar View
- (void) initTabBarView
{
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 1024 - 49, 768, 49)];
    _tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TAB_BAR_BG]];
    [self.view addSubview:_tabBarView];
    _tabBarView.userInteractionEnabled = YES;
    
    NSArray *tabBarItem = @[@"TabButtonA.png",@"TabButtonB.png",@"TabButtonC.png",@"TabButtonD.png",@"TabButtonE.png"];
    NSArray *tabBarHighlightItem = @[@"TabButtonA_HL.png",@"TabButtonB_HL.png",@"TabButtonC_HL.png",@"TabButtonD_HL.png",@"TabButtonE_HL.png"];
    
    for (int i = 0; i<tabBarItem.count; i++)
    {
        NSString *tabButtonImage = tabBarItem[i];
        NSString *tabButtonHighlightImage = tabBarHighlightItem[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((153-31)/2 + (i*153), (49-31)/2, 31, 31);
        button.tag = i;
        [button setImage:[UIImage imageNamed:tabButtonImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:tabButtonHighlightImage] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabBarView addSubview:button];
    }
}

- (void)selectedTab:(id)sender
{
    UIButton *button = (UIButton*) sender;
    self.selectedIndex = button.tag;
}

@end
