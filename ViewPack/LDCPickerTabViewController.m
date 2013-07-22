//
//  LDCFirstTabViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCPickerTabViewController.h"

@interface LDCPickerTabViewController ()

@end

@implementation LDCPickerTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBG_A.png"]];
    [self initPickerButton];
    [self initPickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initPickerButton
{
    UIButton *pickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pickerButton setImage:[UIImage imageNamed:@"PickerButton.png"] forState:UIControlStateNormal];
    pickerButton.frame = CGRectMake((768 - 173)/2, 200, 173, 57);
    [pickerButton addTarget:self action:@selector(pickerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _pickerButton = pickerButton;
    [self.view addSubview:_pickerButton];
}

- (void) initPickerView
{
    _pickerView = [[UIDatePicker alloc] init];
    _pickerView.frame = CGRectMake(0, 1024, 768, 460);
    [self.view addSubview:_pickerView];
    [self.view bringSubviewToFront:_pickerView];
    [_pickerView setHidden:YES];
}

- (void) pickerViewAnimation:(UIView *)view willHidden:(BOOL)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        if(hidden)
        {
            view.frame = CGRectMake(0, 1024, 768, 460);
        }
        else
        {
            [view setHidden:hidden];
            view.frame = CGRectMake(0, 740, 768, 460);
        }
    }completion:^(BOOL finished){
        [view setHidden:hidden];
    }];
}

#pragma mark
#pragma mark Target Action

- (void) pickerButtonPressed
{
    [self pickerViewAnimation:_pickerView willHidden:NO];
}

@end
