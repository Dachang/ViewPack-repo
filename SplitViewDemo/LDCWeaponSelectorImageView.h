//
//  LDCWeaponSelectorImageView.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCWeaponInputViewController.h"
@class LDCWeapon;

@protocol LDCWeaponSelectorDelegate <NSObject>

- (void)selectedWeapon:(LDCWeapon *)weapon;

@end

@interface LDCWeaponSelectorImageView : UIImageView<LDCWeaponInputDelegate>

@property (nonatomic, strong) LDCWeapon *weapon;
@property (nonatomic, strong) LDCWeaponInputViewController *weaponInputViewController;
@property (nonatomic, strong) IBOutlet id<LDCWeaponSelectorDelegate> delegate;

@end
