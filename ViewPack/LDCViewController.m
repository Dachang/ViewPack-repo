//
//  LDCViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-16.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCViewController.h"
#import "LDCShelfViewController.h"
#import "LDCBasicScrollViewController.h"
#import "LDCSideMenuViewController.h"
#import "LDCWebViewController.h"
#import "LDCTableViewCellControlViewController.h"
#import "LDCTabBarViewController.h"
#import "LDCPickerTabViewController.h"
#import "LDCAnimationTabViewController.h"
#import "LDCGestureTabViewController.h"
#import "LDCSliderTabViewController.h"
#import "LDCPushViewController.h"
#import "LDCPageControlViewController.h"
#import "LDCMapViewController.h"
#import "LDCWeatherViewController.h"
#import "LDCCameraFilterViewController.h"
#import "LDCRSSViewController.h"
#import "LDCCollectionViewController.h"

@interface LDCViewController ()

@end

@implementation LDCViewController
@synthesize names,keys,tableViewA,imageA,list,navBar,navController,modalTransitionStyle;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RootVCTableViewASource" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.names = dict;
    NSArray *array = [[names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.keys = array;
    
    UITableView *TVA = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 768, 1024) style:UITableViewStyleGrouped];
    TVA.backgroundView = nil;
    self.tableViewA = TVA;
    
    [tableViewA setDelegate: self];
    [tableViewA setDataSource: self];
    
    //Navigation Bar
    //self.navController = [[UINavigationController alloc] initWithRootViewController:self];
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 33)];
    [button setImage:[UIImage imageNamed:@"NavBarButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myActionSettings) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    navigationItem.rightBarButtonItem = rightBarButton;
    [self.navBar pushNavigationItem:navigationItem animated:NO];
    
    
    [self.view addSubview:tableViewA];
    [self.view addSubview:navBar];
    
}

#pragma mark
#pragma mark - tableView Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keys count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([keys count] == 0) return 0;
    NSString *key = [keys objectAtIndex:section];
    NSArray *namesArray = [names objectForKey:key];
    return [namesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [keys objectAtIndex:section];
    self.list = [names objectForKey:key];
    
    static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionsTableIdentifier];
    }
    cell.textLabel.text = [self.list objectAtIndex:row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvectica" size:15.0];
    cell.textLabel.textColor = [UIColor darkTextColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    //add image
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:UITableViewCellSelectionStyleNone];

    if(row == 0 && section == 0)
    {
        UIViewController *vc = [[LDCShelfViewController alloc] init];
        
//        [UIView transitionWithView:self.view duration:0.5f options: UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            [self.view addSubview:vc.view];
//        } completion:NULL];
        
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 1 && section == 0)
    {
        UIViewController *vc = [[LDCBasicScrollViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 2 && section == 0)
    {
        UIViewController *vc = [[LDCSideMenuViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 3 && section == 0)
    {
        UIViewController *vc = [[LDCTableViewCellControlViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 0 && section == 1)
    {
        UIViewController *vc = [[LDCRSSViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 1 && section == 1)
    {
        NSMutableArray *tabViews = [[NSMutableArray alloc] init];
        LDCPickerTabViewController *firstTabView = [[LDCPickerTabViewController alloc] init];
        [tabViews addObject:firstTabView];
        LDCAnimationTabViewController *secondTabView =[[LDCAnimationTabViewController alloc] init];
        [tabViews addObject:secondTabView];
        LDCGestureTabViewController *thirdTabView = [[LDCGestureTabViewController alloc] init];
        [tabViews addObject:thirdTabView];
        LDCSliderTabViewController *fourthTabView = [[LDCSliderTabViewController alloc] init];
        [tabViews addObject:fourthTabView];
        LDCGestureTabViewController *fifthTabView = [[LDCGestureTabViewController alloc] init];
        [tabViews addObject:fifthTabView];
        
        LDCTabBarViewController *rootTabView = [[LDCTabBarViewController alloc] init];
        [rootTabView setTitle:@"TabBarController"];
        [rootTabView setViewControllers:tabViews];
        
        [self presentViewController:rootTabView animated:YES completion:NULL];
    }
    else if (row == 2 && section == 1)
    {
        UIViewController *vc = [[LDCPushViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 0 && section == 2)
    {
        UIViewController *vc = [[LDCPageControlViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if(row == 1 && section == 2)
    {
        UIViewController *vc = [[LDCWebViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if (row == 0 && section == 3)
    {
        UIViewController *vc = [[LDCCollectionViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if (row == 1 && section == 3)
    {
        UIViewController *vc = [[LDCMapViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if (row == 2 && section == 3)
    {
        UIViewController *vc = [[LDCWeatherViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else if (row == 3 && section == 3)
    {
        UIViewController *vc = [[LDCCameraFilterViewController alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
        [vc release];
    }
    else
    {
        NSString *settingSelected = [keys objectAtIndex:[indexPath row]];
        NSString *msg = [[NSString alloc] initWithFormat:@"Settings:%@",settingSelected];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Settings:" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark
#pragma mark Action - Settings
- (void) myActionSettings
{
    UIViewController *vc = [[UINavigationController alloc] initWithRootViewController:[[LDCShelfViewController alloc] init]];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
