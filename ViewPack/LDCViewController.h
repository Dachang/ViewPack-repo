//
//  LDCViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-16.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *names;
    NSArray *keys;
    UITableView *tableViewA;
    UIImageView *imageA;
    UINavigationBar *navBar;
}

@property (strong, nonatomic) NSDictionary *names;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) UITableView *tableViewA;
@property (strong, nonatomic) UIImageView *imageA;
@property (strong, nonatomic) UINavigationBar *navBar;
@end
