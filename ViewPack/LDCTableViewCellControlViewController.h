//
//  LDCTableViewCellControlViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCTableViewCellControlViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _deleteButtonIsPressed;
    BOOL _doneButtonIsPressed;
}

@property (strong, nonatomic) NSMutableArray *numOfSections;
@property (strong, nonatomic) NSMutableArray *numOfRows;
@property (strong, nonatomic) UITableView *TableView;
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) UINavigationItem *navItem;

@end
