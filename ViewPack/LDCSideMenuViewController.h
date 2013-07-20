//
//  LDCPageViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface LDCSideMenuViewController : UIViewController

@property (strong, readonly, nonatomic) RESideMenu *sideMenu;
@property (strong, nonatomic) UIButton *startButton;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

- (void)showSideMenu;
- (void)pan: (UIPanGestureRecognizer*)gesture;

@end
