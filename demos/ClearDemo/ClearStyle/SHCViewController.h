//
//  SHCViewController.h
//  ClearStyle
//
//  Created by Fahim Farook on 22/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCTableView.h"
#import "SHCTableViewDragAddNew.h"
#import "SHCTableViewCellDelegate.h"

@interface SHCViewController : UIViewController <SHCTableViewDataSource, SHCTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet SHCTableView *tableView;

@end
