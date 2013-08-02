//
//  LDCMapViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-8-2.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCMapViewController.h"
#import "LDCGraphicName.h"


@interface LDCMapViewController ()

@end

@implementation LDCMapViewController

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
	[self initMap];
    [self initButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Map

- (void) initMap
{
    //Use a coordinate to init
    CLLocation *location = [[CLLocation alloc] initWithLatitude:39.135 longitude:117.178];
    //Set span range
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    
    //Set visible area
    MKCoordinateRegion region;
    region.center = location.coordinate;
    region.span = span;
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    
    [self.view addSubview:_mapView];
    [_mapView setRegion:region animated:NO];
    [location release];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [_mapView addGestureRecognizer:tapGesture];
}

#pragma mark
#pragma mark Target Action

- (void)tapPress:(UIGestureRecognizer *)sender
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    CGPoint touchPoint = [sender locationInView:_mapView];
    CLLocationCoordinate2D touchLocation = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    NSLog(@"Latitude--->%f",touchLocation.latitude);
    NSLog(@"longtitude--->%f",touchLocation.longitude);
    
    [self createAnnotation:touchLocation];
}

#pragma mark
#pragma mark Create Annotation

- (void)createAnnotation:(CLLocationCoordinate2D) locationCoordinate
{
    MKPointAnnotation *pointAnnotation;
    
    pointAnnotation = [[[MKPointAnnotation alloc] init] autorelease];
    pointAnnotation.coordinate = locationCoordinate;
    pointAnnotation.title = @"Current Location:";
    pointAnnotation.subtitle = [NSString stringWithFormat:@"%f %f",locationCoordinate.latitude,locationCoordinate.longitude];
    
    //adjust visible area due to current Location
    MKCoordinateRegion region;
    region.center = locationCoordinate;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    [_mapView setRegion:region animated:YES];
    
    [_mapView addAnnotation:pointAnnotation];
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
