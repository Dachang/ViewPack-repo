//
//  LDCControlPanelViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-20.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCSideMenuViewController.h"
@class GCDiscreetNotificationView;

@interface LDCControlPanelViewController : LDCSideMenuViewController<UIAlertViewDelegate>
{
    UISlider *slider;
    UILabel *sliderLabel;
    UISwitch *switchTest;
    UIImageView *imageView;
}

@property (nonatomic, retain) GCDiscreetNotificationView *notification;

@end
