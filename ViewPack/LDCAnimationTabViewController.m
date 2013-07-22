//
//  LDCSecondTabViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-21.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCAnimationTabViewController.h"
#import <QuartzCore/CAAnimation.h>

@interface LDCAnimationTabViewController ()

@end

@implementation LDCAnimationTabViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBG_B.png"]];
    
    [self initImageView];
    [self initSwitchButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initImageView
{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomImage.png"]];
    _imageView.frame = CGRectMake(10, 53, 353, 198);
    [self.view addSubview:_imageView];
    _imageView.alpha = 1;
    [_imageView setHidden:YES];
}

- (void) initSwitchButton
{
    UIButton *pickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pickerButton setImage:[UIImage imageNamed:@"SwitchButton.png"] forState:UIControlStateNormal];
    pickerButton.frame = CGRectMake(30, 73, 49, 49);
    [pickerButton addTarget:self action:@selector(imageAnimation) forControlEvents:UIControlEventTouchUpInside];
    _pickerButton = pickerButton;
    [self.view addSubview:_pickerButton];
}

#pragma mark
#pragma mark Animation

- (void)imageAnimation
{
    [_imageView setHidden:NO];
    
    CGPoint fromPoint = _imageView.center;
    
    //Path
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(768 - 353, 1004 - 198 - 49);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(300, 0)];
    
    //keyFrame
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    
    //Alpha
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    //integrating
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim,opacityAnim, nil];
    animGroup.duration = 1;
    [_imageView.layer addAnimation:animGroup forKey:nil];
    
    _imageView.frame = CGRectMake(768 - 353 - 353/2, 1004 - 198 - 49 - 198/2, 353, 198);
    [_pickerButton setUserInteractionEnabled:NO];
}

@end
