//
//  LDCSettingsViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-17.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCSettingsViewController.h"
#import "LDCShelfTableViewCell.h"

@interface LDCSettingsViewController ()

@end

@implementation LDCSettingsViewController
@synthesize navBar,shelfView,modalTransitionStyle;

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
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelfBG.png"]];
    
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [button setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    navigationItem.leftBarButtonItem = leftBarButton;
    [self.navBar pushNavigationItem:navigationItem animated:NO];
    
    UITableView *shelfTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, 768, 1400) style:UITableViewStylePlain];
    shelfTV.backgroundView = nil;
    shelfTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shelfView = shelfTV;
    
    shelfView.backgroundColor = [UIColor clearColor];
    shelfView.scrollEnabled = NO;
    [shelfView setDelegate:self];
    [shelfView setDataSource:self];
    
    [self.view addSubview:shelfView];
    [self.view addSubview:navBar];
}

#pragma mark
#pragma mark back button

- (void) backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark
#pragma mark table View
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LDCShelfTableViewCell";
    LDCShelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[LDCShelfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
