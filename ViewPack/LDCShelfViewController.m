//
//  LDCSettingsViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-17.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCShelfViewController.h"
#import "LDCShelfTableViewCell.h"

@interface LDCShelfViewController ()

@end

@implementation LDCShelfViewController
@synthesize navBar,shelfView,modalTransitionStyle,imageList,numOfSections,numOfRows,contentInSections;

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
    
    //Navigation Bar
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [button setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    navigationItem.leftBarButtonItem = leftBarButton;
    [self.navBar pushNavigationItem:navigationItem animated:NO];
    
    //Image DataSource
    NSMutableArray *tmpImageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++)
    {
        NSString *imageUrl = [[NSString alloc] initWithFormat:@"%i.png",i];
        UIImage *image = [UIImage imageNamed:imageUrl];
        [tmpImageArray addObject:image];
    }
    self.imageList = [tmpImageArray copy];
    
    //TableView
    
    numOfSections = [[NSMutableArray alloc] initWithObjects:@"0", nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RootVCTableViewASource" ofType:@"plist"];
    contentInSections = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    UITableView *shelfTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, 768, 1400) style:UITableViewStylePlain];
    shelfTV.backgroundView = nil;
    shelfTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.shelfView = shelfTV;
    
    shelfView.backgroundColor = [UIColor clearColor];
    shelfView.scrollEnabled = YES;
    [shelfView setDelegate:self];
    [shelfView setDataSource:self];
//    [shelfView setEditing:YES animated:YES];
    
    [self.view addSubview:shelfView];
    [self.view addSubview:navBar];
}

#pragma mark
#pragma mark back button

- (void) backButtonPressed
{
//    [UIView transitionWithView:self.view duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
//        [self.view removeFromSuperview];
//    } completion:NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark
#pragma mark table View Data Source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return numOfSections.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(numOfSections.count == 0) return 0;
    NSString *key = [numOfSections objectAtIndex:section];
    numOfRows = [contentInSections objectForKey:key];
    return numOfRows.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    static NSString *cellIdentifier = @"LDCShelfTableViewCell";
    LDCShelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[LDCShelfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageOnShelf.image = [imageList objectAtIndex:row];
    return cell;
}

#pragma mark
#pragma mark table View Delegate

//add ## Check this part in LDCTableViewCellControlViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
