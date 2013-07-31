//
//  LDCWeaponInputViewController.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCWeaponInputViewController.h"

@interface LDCWeaponInputViewController ()

@end

@implementation LDCWeaponInputViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark IBAction

- (IBAction)closeTapped
{
    if(_delegate != nil)
    {
        [_delegate closeTapped];
    }
}

- (IBAction)weaponButtonTapped:(UIButton *)sender
{
    WeaponType selectedWeaponType;
    
    if(sender == _blowgunButton)
    {
        selectedWeaponType = Blowgun;
    }
    else if (sender == _fireButton)
    {
        selectedWeaponType = Fire;
    }
    else if (sender == _ninjistarButton)
    {
        selectedWeaponType = NinjaStar;
    }
    else if (sender == _smokeButton)
    {
        selectedWeaponType = Smoke;
    }
    else if (sender == _swordButton)
    {
        selectedWeaponType = Sword;
    }
    else
    {
        NSLog(@"Err");
    }
    
    if(_delegate != nil)
    {
        [_delegate selectWeaponType:selectedWeaponType];
    }

}

@end
