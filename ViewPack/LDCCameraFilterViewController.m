//
//  LDCCameraFilterViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-8-4.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCCameraFilterViewController.h"
#import "GPUImage.h"
#import "LDCGraphicName.h"

@interface LDCCameraFilterViewController ()

@end

@implementation LDCCameraFilterViewController

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
	[self initCamera];
    [self initButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - camera filter

- (void)initCamera
{
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    GPUImageSketchFilter *motionBlurFilter = [[GPUImageSketchFilter alloc] init];
    GPUImageView *filteredVideoView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:filteredVideoView];
    
    [videoCamera addTarget:motionBlurFilter];
    [motionBlurFilter addTarget:filteredVideoView];
    
    [videoCamera startCameraCapture];
}


#pragma mark
#pragma mark back button

- (void)initButton
{
    UIButton *BackButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 51, 30)];
    [BackButton setImage:[UIImage imageNamed:BACK_BUTTON] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:BackButton];
}

- (void)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
