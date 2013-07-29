//
//  LDCLeftViewController.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCLeftViewController.h"
#import "LDCViewModal.h"

@interface LDCLeftViewController ()

@end

@implementation LDCLeftViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        _modals = [NSMutableArray array];
        
        [_modals addObject:[LDCViewModal newModalWithName:@"Cat-Bot" description:@"MEE-OW" iconName:@"meetcatbot.png" weapon:Sword]];
        [_modals addObject:[LDCViewModal newModalWithName:@"Dog-Bot" description:@"BOW-WOW" iconName:@"meetdogbot.png" weapon:Blowgun]];
        [_modals addObject:[LDCViewModal newModalWithName:@"Explode-Bot" description:@"Tick, tick, BOOM" iconName:@"meetexplodebot.png" weapon:Smoke]];
        [_modals addObject:[LDCViewModal newModalWithName:@"Fire-Bot" description:@"Will Make Your Steamed" iconName:@"meetfirebot.png" weapon:NinjaStar]];
        [_modals addObject:[LDCViewModal newModalWithName:@"Ice-Bot" description:@"Have a Chilling Effect" iconName:@"meeticebot.png" weapon:Fire]];
        [_modals addObject:[LDCViewModal newModalWithName:@"Mini-Tomato-Bot" description:@"Exteremely Handsome" iconName:@"meetminitomatobot.png" weapon:NinjaStar]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_modals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    LDCViewModal* viewModal = _modals[indexPath.row];
    cell.textLabel.text = viewModal.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDCViewModal *selectedModal = [_modals objectAtIndex:indexPath.row];
    if(_delegate)
    {
        [_delegate selectedModal:selectedModal];
    }
}

@end
