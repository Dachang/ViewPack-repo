//
//  LDCSecondTabViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCSecondTabViewController.h"

@interface LDCSecondTabViewController ()

@end

@implementation LDCSecondTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:2];
        self.tabBarItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
