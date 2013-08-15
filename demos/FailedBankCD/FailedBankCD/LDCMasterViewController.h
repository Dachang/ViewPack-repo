//
//  LDCMasterViewController.h
//  FailedBankCD
//
//  Created by 大畅 on 13-8-15.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCMasterViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSArray *failedBankInfos;

@end
