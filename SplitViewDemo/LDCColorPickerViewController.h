//
//  LDCColorPickerViewController.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-30.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDCColorPickerDelegate <NSObject>

@required
- (void)selectedColor:(UIColor *)newColor;

@end

@interface LDCColorPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *colorNames;
@property (nonatomic, weak) id<LDCColorPickerDelegate> delegate;

@end
