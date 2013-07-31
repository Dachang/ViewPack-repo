//
//  LDCRightViewController.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCModalSelectionDelegate.h"
#import "LDCColorPickerViewController.h"
#import "LDCWeaponSelectorImageView.h"
@class LDCViewModal;

@interface LDCRightViewController : UIViewController<LDCModalSelectionDelegate, UISplitViewControllerDelegate, LDCColorPickerDelegate,LDCWeaponSelectorDelegate>

@property (nonatomic, strong) LDCViewModal *modal;
@property (nonatomic, strong) UILabel *modalName;
@property (nonatomic, strong) UILabel *modalDescription;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) LDCWeaponSelectorImageView *weaponImageView;

@property (nonatomic, strong) UIPopoverController *popover;
@property (nonatomic, strong) IBOutlet UINavigationItem *navBarItem;

@property (nonatomic, strong) LDCColorPickerViewController *colorPicker;
@property (nonatomic, strong) UIPopoverController *colorPickerPopover;

-(IBAction)chooseColorButtonTapped:(id)sender;

@end
