//
//  LDCRightViewController.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCRightViewController.h"
#import "LDCViewModal.h"

@interface LDCRightViewController ()

@end

@implementation LDCRightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initModalView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModal:(LDCViewModal *)modal
{
    if (_modal != modal)
    {
        _modal = modal;
        [self initModalView];
    }
}

- (void)initModalView
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 95, 95)];
    _modalName = [[UILabel alloc] initWithFrame:CGRectMake(10+95+5, 50, 250, 45)];
    _modalName.font = [UIFont fontWithName:@"Helvetica Bold" size:36];
    _modalDescription = [[UILabel alloc] initWithFrame:CGRectMake(10+95+5, 10+45+40, 200, 31)];
    _modalDescription.font = [UIFont fontWithName:@"Helvetica" size:24];
    UILabel *weaponIntro = [[UILabel alloc] initWithFrame:CGRectMake(10+95+5, 10+45+50-31+20+40, 200, 31)];
    weaponIntro.text = @"Prefered Way To Kill:";
    _weaponImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10+95+5+200+10, 10+45+50-31+20+40, 70, 70)];
    
    _modalName.text = _modal.name;
    _iconImageView.image = [UIImage imageNamed:_modal.iconName];
    _modalDescription.text = _modal.description;
    _weaponImageView.image = [_modal getWeaponImage];
    
    [self.view addSubview:_iconImageView];
    [self.view addSubview:_modalName];
    [self.view addSubview:_modalDescription];
    [self.view addSubview:weaponIntro];
    [self.view addSubview:_weaponImageView];
}

#pragma mark
#pragma mark leftView delegate

- (void)selectedModal:(LDCViewModal *)newModal
{
    [self setModal:newModal];
    if(_popover != nil)
    {
        [_popover dismissPopoverAnimated:YES];
    }
}

#pragma mark
#pragma mark IBAction

- (IBAction)chooseColorButtonTapped:(id)sender
{
    if(_colorPicker ==  nil)
    {
        _colorPicker = [[LDCColorPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        //Set this very VC as the delegate
        _colorPicker.delegate = self;
    }
    if(_colorPickerPopover == nil)
    {
        _colorPickerPopover = [[UIPopoverController alloc] initWithContentViewController:_colorPicker];
        [_colorPickerPopover presentPopoverFromBarButtonItem:(UIBarButtonItem*)sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    //实现再点击一下视图收回的效果（用于NavBarButton）
    else
    {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

#pragma mark
#pragma mark colorPicker delegate

- (void)selectedColor:(UIColor *)newColor
{
    _modalName.textColor = newColor;
    
    if(_colorPickerPopover)
    {
        [_colorPickerPopover dismissPopoverAnimated:YES];
        _colorPickerPopover = nil;
    }
}

#pragma mark
#pragma marl split view delegate

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    NSLog(@"Will hide left side");
    self.popover = pc;
    barButtonItem.title = @"Modal";
    //UINavigationItem *navItem = [self navigationItem];
    [_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
    
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"Will show left side");
    //UINavigationItem *navItem = [self navigationItem];
    [_navBarItem setLeftBarButtonItem:nil animated:YES];
    _popover = nil;
}

@end
