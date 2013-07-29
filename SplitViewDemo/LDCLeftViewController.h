//
//  LDCLeftViewController.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCModalSelectionDelegate.h"

@interface LDCLeftViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *modals;
@property (nonatomic, assign) id<LDCModalSelectionDelegate> delegate;

@end
