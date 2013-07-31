//
//  LDCWeaponInputViewController.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCWeapon.h"

@protocol LDCWeaponInputDelegate <NSObject>

@required
- (void)selectWeaponType:(WeaponType)weaponType;
- (void)closeTapped;

@end

@interface LDCWeaponInputViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *blowgunButton;
@property (nonatomic, weak) IBOutlet UIButton *fireButton;
@property (nonatomic, weak) IBOutlet UIButton *ninjistarButton;
@property (nonatomic, weak) IBOutlet UIButton *smokeButton;
@property (nonatomic, weak) IBOutlet UIButton *swordButton;
@property (nonatomic, weak) id<LDCWeaponInputDelegate> delegate;

- (IBAction)weaponButtonTapped:(UIButton *)sender;
- (IBAction)closeTapped;
@end
