//
//  LDCFourthTabViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-24.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCSliderTabViewController.h"
#import "LDCGraphicName.h"
#import "VolumeBar.h"

@interface LDCSliderTabViewController ()
{
    UILabel *_label;
}
@end

@implementation LDCSliderTabViewController

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
	[self initBackground];
    [self initVolumnBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBackground
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:SHELF_BG]];
}

- (void)initVolumnBar
{
    CGRect frame = CGRectMake(SCREEN_WIDTH/2 - 75, SCREEN_HEIGHT/2 - 200, 0, 0);
//    NSLog(@"%f, %f", SCREEN_HEIGHT,SCREEN_WIDTH);
    VolumeBar *bar = [[VolumeBar alloc] initWithFrame:frame minimumVolume:0 maximumVolume:10];
    
    [bar addTarget:self action:@selector(onVolumnBarChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:bar];
    bar.currentVolume = 4;
    
    frame = bar.frame;
    frame.origin.y += frame.size.height+10;
    frame.size.height = 30;
    
    _label = [[UILabel alloc] initWithFrame:frame];
    [_label setTextAlignment:NSTextAlignmentCenter];
    [_label setBackgroundColor:[UIColor clearColor]];
    [_label setTextColor:[UIColor whiteColor]];
    
    [_label setText:[NSString stringWithFormat:@"Volume: %d", bar.currentVolume]];
    [self.view addSubview:_label];
}

- (void)onVolumnBarChange:(id)sender
{
    VolumeBar *bar = sender;
    [_label setText:[NSString stringWithFormat:@"Volumn: %d", bar.currentVolume]];
}

@end
