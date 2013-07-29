//
//  LDCRightViewController.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCRightViewController.h"
#import "LDCViewModal.h"

@interface LDCRightViewController ()

@end

@implementation LDCRightViewController

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
    [self initModalView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModal:(LDCViewModal *)modal
{
    if (_modal != modal)
    {
        _modal = modal;
        [self initModalView];
    }
}

- (void)initModalView
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 95, 95)];
    _modalName = [[UILabel alloc] initWithFrame:CGRectMake(10+95+5, 10, 250, 45)];
    _modalName.font = [UIFont fontWithName:@"Helvetica Bold" size:36];
    _modalDescription = [[UILabel alloc] initWithFrame:CGRectMake(10+95+5, 10+45, 200, 31)];
    _modalDescription.font = [UIFont fontWithName:@"Helvetica" size:24];
    UILabel *weaponIntro = [[UILabel alloc] initWithFrame:CGRectMake(10+95+5, 10+45+50-31+20, 200, 31)];
    weaponIntro.text = @"Prefered Way To Kill:";
    _weaponImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+95+5+200+10, 10+45+50-31+20, 70, 70)];
    
    _modalName.text = _modal.name;
    _iconImageView.image = [UIImage imageNamed:_modal.iconName];
    _modalDescription.text = _modal.description;
    _weaponImageView.image = [_modal getWeaponImage];
    
    [self.view addSubview:_iconImageView];
    [self.view addSubview:_modalName];
    [self.view addSubview:_modalDescription];
    [self.view addSubview:weaponIntro];
    [self.view addSubview:_weaponImageView];
}

#pragma mark
#pragma mark delegate

- (void)selectedModal:(LDCViewModal *)newModal
{
    [self setModal:newModal];
}

@end
