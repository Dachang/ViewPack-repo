//
//  LDCViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-16.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate>
{
    NSDictionary *names;
    NSArray *keys;
    UITableView *tableViewA;
    UIImageView *imageA;
    UINavigationBar *navBar;
    UINavigationController *navController;
}

@property (strong, nonatomic) NSDictionary *names;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) UITableView *tableViewA;
@property (strong, nonatomic) UIImageView *imageA;
@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) NSMutableArray *list;

@property (nonatomic, assign) UIModalTransitionStyle modalTransitionStyle;

@end
