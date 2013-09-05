//
//  SHCViewController.m
//  ClearStyle
//
//  Created by Fahim Farook on 22/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCViewController.h"
#import "SHCToDoItem.h"
#import "SHCTableViewCell.h"

@implementation SHCViewController {
    // a array of to-do items
    NSMutableArray *_toDoItems;
    float _editingOffset;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // create a dummy todo list
        _toDoItems = [[NSMutableArray alloc] init];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Feed the cat"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Buy eggs"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Pack bags for WWDC"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Rule the web"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Buy a new iPhone"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Find missing socks"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Write a new tutorial"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Master Objective-C"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Remember your wedding anniversary!"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Drink less beer"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Learn to draw"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Take the car to the garage"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Sell things on eBay"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Learn to juggle"]];
        [_toDoItems addObject:[SHCToDoItem toDoItemWithText:@"Give up"]];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.dataSource = self;
    [self.tableView registerClassForCells:[SHCTableViewCell class]];
    self.tableView.backgroundColor = [UIColor blackColor];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger itemCount = _toDoItems.count - 1;
    float val = ((float)index / (float)itemCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}

#pragma mark - UITableViewDataSource protocol methods
- (NSInteger)numberOfRows
{
    return _toDoItems.count;
}

- (UITableViewCell*)cellForRow:(NSInteger)row
{
//    NSString *ident = @"cell";
    SHCTableViewCell *cell = (SHCTableViewCell*)[self.tableView dequeueReusableCell];
    SHCToDoItem *item = _toDoItems[row];
    item.onEditing = NO;
    cell.todoItem = item;
    cell.delegate = self;
    cell.backgroundColor = [self colorForIndex:row];
    return cell;
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

#pragma mark - SHCTableViewCellDelegate

-(void)toDoItemDeleted:(SHCToDoItem *)todoItem
{
    float delay = 0.0;
    
    //remove the model object
    [_toDoItems removeObject:todoItem];
    
    //find the visible cells
    NSArray* visibleCells = [self.tableView visibleCells];
    
    UIView *lastView = [visibleCells lastObject];
    bool startAnimating = false;
    
    //iterate over all of the cells
    for (SHCTableViewCell* cell in visibleCells)
    {
        if(startAnimating)
        {
            [UIView animateWithDuration:0.1 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
            } completion:^(BOOL finished){
                if(cell == lastView)
                {
                    //reloadData forces the UITableView to 'dispose' of all of the cells and re-query thedatasource
                    [self.tableView reloadData];
                }
            }];
            delay += 0.1;
        }
        
        //if reach the item that was deleted, start animating
        if(cell.todoItem == todoItem)
        {
            startAnimating = true;
            cell.hidden = YES;
            
            if(cell == lastView)
            {
                [self.tableView reloadData];
            }
        }
    }
}

- (void)cellDidBeginEditing:(SHCTableViewCell *)editingCell
{
    self.tableView.scrollView.scrollEnabled = NO;
    _editingOffset = _tableView.scrollView.contentOffset.y - editingCell.frame.origin.y;
    for(SHCTableViewCell* cell in [_tableView visibleCells])
    {
        if(cell != editingCell)
        {
            cell.userInteractionEnabled = NO;
        }
        [UIView animateWithDuration:0.3 animations:^{
            cell.frame = CGRectOffset(cell.frame, 0, _editingOffset);
            if(cell != editingCell)
            {
                cell.alpha = 0.3;
            }
        }];
    }
}

- (void)cellDidEndEditing:(SHCTableViewCell *)editingCell
{
    self.tableView.scrollView.scrollEnabled = YES;
    for(SHCTableViewCell* cell in [_tableView visibleCells])
    {
        cell.userInteractionEnabled = YES;
        [UIView animateWithDuration:0.3 animations:^{
            cell.frame = CGRectOffset(cell.frame, 0, -_editingOffset);
            if(cell != editingCell)
            {
                cell.alpha = 1.0;
            }
        }];
    }
}

@end























