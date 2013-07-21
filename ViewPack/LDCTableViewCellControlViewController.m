//
//  LDCTableViewCellControlViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCTableViewCellControlViewController.h"
#import "LDCGraphicName.h"

@interface LDCTableViewCellControlViewController ()

@end

@implementation LDCTableViewCellControlViewController
@synthesize numOfSections,numOfRows,TableView,doneButton,deleteButton,navBar,navItem;

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
//    _deleteButtonIsPressed = NO;
    _doneButtonIsPressed = NO;
    
    //Navigation Bar
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 768, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    self.navItem = navigationItem;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [button setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navItem.leftBarButtonItem = leftBarButton;

    //TableView Set DataSource
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"AudioToolbox",@"AVFoundation",@"QuartzCore",@"UIKit",@"Foundation",@"Core Graphics",@"UIMotionEffect",@"UIDynamics",@"UIFont",@"OpenGL ES",@"MapKit",@"Core Motion", nil];
    self.numOfRows = array;
    self.numOfSections = [[NSMutableArray alloc] initWithObjects:(NSMutableArray*)numOfRows, nil];
    self.TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, 768, 1024)];
    [self.TableView setDelegate:self];
    [self.TableView setDataSource:self];
    [self.TableView setEditing:NO animated:YES];
    [self.view addSubview:self.TableView];
    //Delete Button
    UIButton *tempDeleteButton = [[UIButton alloc] initWithFrame:CGRectMake(720, 0, 51, 30)];
    [tempDeleteButton setImage:[UIImage imageNamed:EDIT_BUTTON] forState:UIControlStateNormal];
    [tempDeleteButton addTarget:self action:@selector(editButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton = tempDeleteButton;
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.deleteButton];
    self.navItem.rightBarButtonItem = rightBarButton;
    [self.navBar pushNavigationItem:self.navItem animated:NO];
    [self.view addSubview:self.navBar];
    //Done Button
    UIButton *tempDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(720, 0, 51, 30)];
    [tempDoneButton setImage:[UIImage imageNamed:DONE_BUTTON] forState:UIControlStateNormal];
    [tempDoneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.doneButton = tempDoneButton;
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
#pragma mark delete button

- (void) editButtonPressed
{
    self.TableView.editing = YES;
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.doneButton];
    self.navItem.rightBarButtonItem = doneBarButton;
    [self.navBar removeFromSuperview];
    [self.navBar pushNavigationItem:self.navItem animated:NO];
    [self.view addSubview:self.navBar];
}

#pragma mark
#pragma mark delete button

- (void) doneButtonPressed
{
    self.TableView.editing = NO;
    UIBarButtonItem *deleteBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.deleteButton];
    self.navItem.rightBarButtonItem = deleteBarButton;
    [self.navBar removeFromSuperview];
    [self.navBar pushNavigationItem:self.navItem animated:NO];
    [self.view addSubview:self.navBar];
}

#pragma mark 
#pragma mark Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numOfSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numOfRows.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewIdentifier = @"TableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.numOfRows objectAtIndex:row];
    cell.detailTextLabel.text = @"CreateByOcean";
    return cell;
}

#pragma mark
#pragma mark Table View Delegate

//Select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Delete & Insert cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger _row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.numOfRows removeObjectAtIndex:_row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:indexPath, nil];
        [self.numOfRows insertObject:@"New Cell" atIndex:_row];
        [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        //add
    }
}

//Move cell
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_deleteButtonIsPressed)
    {
        return UITableViewCellEditingStyleDelete;
    }
    else
    {
        return UITableViewCellEditingStyleInsert;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [self.numOfRows objectAtIndex:fromRow];
    [self.numOfRows removeObjectAtIndex:fromRow];
    [self.numOfRows insertObject:object atIndex:toRow];
}

@end
