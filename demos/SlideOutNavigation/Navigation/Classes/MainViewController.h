//
//  MainViewController.h
//  Navigation
//
//  Created by Tammy Coron on 1/19/13.
//  Copyright (c) 2013 Tammy L Coron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"
#import "LeftPanelViewController.h"
#import "RightPanelViewController.h"

@interface MainViewController : UIViewController <UIGestureRecognizerDelegate,CenterViewControllerDelegate>

@property (nonatomic,strong) CenterViewController *centerViewController;
@property (nonatomic,strong) LeftPanelViewController *leftPanelViewController;
@property (nonatomic,strong) RightPanelViewController *rightPanelViewController;
@property (nonatomic,assign) BOOL showingLeftPanel;
@property (nonatomic,assign) BOOL showingRightPanel;


@end
