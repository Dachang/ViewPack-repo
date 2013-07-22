//
//  LDCFirstTabViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCPickerTabViewController : UIViewController
{
    UIButton *_pickerButton;
}

@property (retain, nonatomic) UIDatePicker *pickerView;
@property (nonatomic, retain) NSString *string;

@end
