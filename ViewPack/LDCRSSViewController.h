//
//  LDCRSSViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-8-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@class LDCRSSDetailViewController;

@interface LDCRSSViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,ASIHTTPRequestDelegate>
{
    NSMutableArray *_allEntries;
    
    NSOperationQueue *_queue;
    NSArray *_feeds;
    
    NSString *_articleDateString;
    
    LDCRSSDetailViewController *_detailViewController;
}

@property (strong, nonatomic) UITableView *tableView;

@property (retain) NSMutableArray *allEntries;

@property (retain) NSOperationQueue *queue;
@property (retain) NSArray *feeds;

@property (retain) LDCRSSDetailViewController *detailViewController;

@end
