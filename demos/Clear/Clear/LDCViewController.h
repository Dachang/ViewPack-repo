//
//  LDCViewController.h
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCTableViewCell.h"

@interface LDCViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, LDCTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
