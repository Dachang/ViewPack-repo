//
//  LDCColorPickerViewController.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-30.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCColorPickerViewController.h"

@interface LDCColorPickerViewController ()

@end

@implementation LDCColorPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if([super initWithStyle:style] != nil)
    {
        _colorNames = [NSMutableArray array];
        
        [_colorNames addObject:@"Red"];
        [_colorNames addObject:@"Green"];
        [_colorNames addObject:@"Blue"];
        [_colorNames addObject:@"Gray"];
        
        //Make row selection persist
        self.clearsSelectionOnViewWillAppear = NO;
        
        //Calculate how tall the view should be by multiplying
        //the individual row height by the total number of rows
        NSInteger rowCount = [_colorNames count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowHeight = rowCount * singleRowHeight;
        
        //Claculate how wide the view should be by finding how
        //wide each string is expected to be
        CGFloat largestLabelWidth = 0;
        for (NSString *colorName in _colorNames)
        {
            CGSize labelSize = [colorName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if(labelSize.width > largestLabelWidth)
            {
                largestLabelWidth = labelSize.width;
            }
        }
        CGFloat popoverWidth = largestLabelWidth + 100;
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowHeight);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_colorNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        //the reuse identifier is not referenced within the storyboard, so simply use dequeReuseableCellWithIdentifer: without referencing the index path
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_colorNames objectAtIndex:indexPath.row];
    
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
    NSString *selectedColorName = [_colorNames objectAtIndex:indexPath.row];
    
    UIColor *color = [UIColor orangeColor];
    
    if([selectedColorName isEqualToString:@"Red"])
    {
        color = [UIColor redColor];
    }
    else if([selectedColorName isEqualToString:@"Green"])
    {
        color = [UIColor greenColor];
    }
    else if ([selectedColorName isEqualToString:@"Blue"])
    {
        color = [UIColor blueColor];
    }
    else if ([selectedColorName isEqualToString:@"Gray"])
    {
        color = [UIColor grayColor];
    }
    
    //用委托传值
    if(_delegate != nil)
    {
        [_delegate selectedColor:color];
    }
}

@end
