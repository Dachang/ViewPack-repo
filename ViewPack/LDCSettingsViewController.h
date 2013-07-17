//
//  LDCSettingsViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-17.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCSettingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UINavigationBar *navBar;
    UITableView *shelfView;
}

@property (strong, nonatomic) UINavigationBar *navBar;
@property (nonatomic, strong) UITableView *shelfView;

@property (nonatomic, assign) UIModalTransitionStyle modalTransitionStyle;

@end
