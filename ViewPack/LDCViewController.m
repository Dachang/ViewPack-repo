//
//  LDCViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-16.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCViewController.h"

@interface LDCViewController ()

@end

@implementation LDCViewController
@synthesize names,keys,tableViewA,imageA;

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
    
    UITableView *TVA = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024) style:UITableViewStyleGrouped];
    TVA.backgroundView = nil;
    self.tableViewA = TVA;
    
    [tableViewA setDelegate: self];
    [tableViewA setDataSource: self];
    [self.view addSubview:tableViewA];
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
    NSArray *nameSection = [names objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    
    static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionsTableIdentifier];
    }
    cell.textLabel.text = [nameSection objectAtIndex:row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvectica" size:15.0];
    cell.textLabel.textColor = [UIColor darkTextColor];
    
    return cell;
    //add image
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
