//
//  LDCViewController.m
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCViewController.h"
#import "LDCToDoItem.h"


@interface LDCViewController ()
@end

@implementation LDCViewController
{
    NSMutableArray *_toDoItems;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        _toDoItems = [[NSMutableArray alloc] init];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Feed the cat"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Buy eggs"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Pack bag for WWDC"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Rule the web"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Buy a new phone"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Find missing socks"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Write a new tutorial"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Master Objective-C"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Remember your wedding aniversary"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Drink less beer"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Learn to draw"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Make an UI kit"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Take car to the garage"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Sell things on ebay"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Learn to juggle"]];
        [_toDoItems addObject:[LDCToDoItem toDoItemWithText:@"Give up"]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView registerClass:[LDCTableViewCell class] forCellReuseIdentifier:@"cell"];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor*)colorForIndex:(NSInteger)index
{
    NSUInteger itemCount = _toDoItems.count - 1;
    float val = ((float)index/(float)itemCount)*0.6;
    return [UIColor colorWithRed:1.0 green:val blue:0.0 alpha:1.0];
}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_toDoItems count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    LDCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    int index = [indexPath row];
    LDCToDoItem *item = _toDoItems[index];
    cell.todoItem = item;
//    cell.textLabel.text = item.text;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [self colorForIndex:indexPath.row];
}

#pragma mark - LDCTableViewCellDelegate

- (void)toDoItemDeleted:(LDCToDoItem *)todoItem
{
    NSUInteger index = [_toDoItems indexOfObject:todoItem];
    [self.tableView beginUpdates];
    [_toDoItems removeObject:todoItem];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end
