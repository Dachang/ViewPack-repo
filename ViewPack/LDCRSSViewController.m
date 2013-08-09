//
//  LDCRSSViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-8-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCRSSViewController.h"
#import "LDCRSSEntry.h"

@interface LDCRSSViewController ()

@end

@implementation LDCRSSViewController
@synthesize allEntries = _allEntries;
@synthesize feeds = _feeds;
@synthesize queue = _queue;

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
	
    self.title = @"Feeds";
    self.allEntries = [NSMutableArray array];
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [tv setDelegate:self];
    [tv setDataSource:self];
    self.tableView = tv;
    [self.view addSubview:self.tableView];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.feeds = [NSArray arrayWithObjects:@"http://feeds.feedburner.com/RayWenderlich",
                  @"http://feeds.feedburner.com/vmwstudios",
                  @"http://idtypealittlefaster.blogspot.com/feeds/posts/default",
                  @"http://www.71squared.com/feed/",
                  @"http://cocoawithlove.com/feeds/posts/default",
                  @"http://feeds2.feedburner.com/brandontreb",
                  @"http://feeds.feedburner.com/CoryWilesBlog",
                  @"http://geekanddad.wordpress.com/feed/",
                  @"http://iphonedevelopment.blogspot.com/feeds/posts/default",
                  @"http://karnakgames.com/wp/feed/",
                  @"http://kwigbo.com/rss",
                  @"http://shawnsbits.com/feed/",
                  @"http://pocketcyclone.com/feed/",
                  @"http://www.alexcurylo.com/blog/feed/",
                  @"http://feeds.feedburner.com/maniacdev",
                  @"http://feeds.feedburner.com/macindie",
                  nil];
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRows
{
    LDCRSSEntry *entry1 = [[LDCRSSEntry alloc] initWithBlogTitle:@"1" articleTitle:@"1" articleUrl:@"1" articleDate:[NSDate date]];
    LDCRSSEntry *entry2 = [[LDCRSSEntry alloc] initWithBlogTitle:@"2" articleTitle:@"2" articleUrl:@"2" articleDate:[NSDate date]];
    LDCRSSEntry *entry3 = [[LDCRSSEntry alloc] initWithBlogTitle:@"3" articleTitle:@"3" articleUrl:@"3" articleDate:[NSDate date]];
    
    [_allEntries insertObject:entry1 atIndex:0];
    [_allEntries insertObject:entry2 atIndex:0];
    [_allEntries insertObject:entry3 atIndex:0];
}

// the refresh method loops through the list of feeds, and calls ASIHTTPRequest requestWithURL for each URL to create a request that will download the data, and queues it up to run at some point by adding it to the operation queue

- (void)refresh
{
    for(NSString *feed in _feeds)
    {
        NSURL *url = [NSURL URLWithString:feed];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate: self];
        [_queue addOperation:request];
    }
}

#pragma mark - tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allEntries count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    LDCRSSEntry *entry = [_allEntries objectAtIndex:indexPath.row];
    
    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *articleDateString = [dateFormatter stringFromDate:entry.articleDate];
    
    cell.textLabel.text = entry.articleTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, entry.blogTitle];
    
    return cell;
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    LDCRSSEntry *entry = [[LDCRSSEntry alloc] initWithBlogTitle:request.url.absoluteString articleTitle:request.url.absoluteString articleUrl:request.url.absoluteString articleDate:[NSDate date]];
    int insertIndex = 0;
    [_allEntries insertObject:entry atIndex:insertIndex];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error: %@",error);
}

- (void)dealloc
{
    [_queue release];
    _queue = nil;
    [_feeds release];
    _feeds = nil;
    [super dealloc];
}


@end
