//
//  LDCWeaponSelectorImageView.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCWeaponSelectorImageView.h"
#import "LDCWeapon.h"

@implementation LDCWeaponSelectorImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark
#pragma mark Override Setters

- (void)setWeapon:(LDCWeapon *)weapon
{
    if(_weapon != weapon)
    {
        _weapon = weapon;
        self.image = [_weapon getWeaponImage];
    }
}

#pragma mark
#pragma mark SuperClass overrides

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputView
{
    if(_weaponInputViewController == nil)
    {
        _weaponInputViewController = [[LDCWeaponInputViewController alloc] initWithNibName:nil bundle:nil];
        _weaponInputViewController.delegate = self;
    }
    return _weaponInputViewController.view;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(![self isFirstResponder])
    {
        [self becomeFirstResponder];
    }
}

#pragma mark
#pragma mark WeaponInput delegate

- (void)closeTapped
{
    [self resignFirstResponder];
}

//delegate 嵌套
- (void)selectWeaponType:(WeaponType)weaponType
{
    [self setWeapon:[LDCWeapon newWeaponOfType:weaponType]];
    [self resignFirstResponder];
    
    if(_delegate != nil)
    {
        [_delegate selectedWeapon:_weapon];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
