//
//  LDCVolumnViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCHomeViewController.h"

@interface LDCHomeViewController ()

@end

@implementation LDCHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelfBG.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
