//
//  DymanicSandwichViewController.m
//  SandwichFlow
//
//  Created by 大畅 on 13-9-24.
//  Copyright (c) 2013年 Colin Eberhardt. All rights reserved.
//

#import "DymanicSandwichViewController.h"
#import "SandwichViewController.h"
#import "AppDelegate.h"

@interface DymanicSandwichViewController ()

@end

@implementation DymanicSandwichViewController
{
    NSMutableArray* _views;
    //UI Dynamics
    UIGravityBehavior* _gravity;
    UIDynamicAnimator* _animator;
    CGPoint _previousTouchPoint;
    BOOL _draggingView;
}

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
	
    //background image
    UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-LowerLayer.png"]];
    [self.view addSubview:backgroundImageView];
    //Header logo
    UIImageView* header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sarnie.png"]];
    header.center = CGPointMake(160, 150);
    [self.view addSubview:header];
    //create the animator,dynamic behaviour and its properties
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] init];
    [_animator addBehavior:_gravity];
    _gravity.magnitude = 4.0f;
    
    //add sandwiches table
    _views = [NSMutableArray new];
    float offset = 250.0f;
    for (NSDictionary* sandwich in [self sandwiches])
    {
        [_views addObject:[self addRecipeAtOffset:offset forSandwich:sandwich]];
        offset -= 50.0f;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//A simple method for retrieving the sandwiches from yje app delegate
- (NSArray*)sandwiches
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.sandwiches;
}

- (UIView*)addRecipeAtOffset:(float)offset forSandwich:(NSDictionary*)sandwich
{
    CGRect frameForView = CGRectOffset(self.view.bounds, 0.0, self.view.bounds.size.height - offset);
    
    //create the view controller
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SandwichViewController* viewController = [mystoryboard instantiateViewControllerWithIdentifier:@"SandwichVC"];
    
    //set the frame and provide some data
    UIView *view = viewController.view;
    view.frame = frameForView;
    viewController.sandwich = sandwich;
    
    //add as a child
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    //add a gesture recognizer
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [viewController.view addGestureRecognizer:pan];
    
    //create a collision
    UICollisionBehavior* collision = [[UICollisionBehavior alloc] initWithItems:@[view]];
    [_animator addBehavior:collision];
    
    //lower boundary, where the tab rests
    float boundary = view.frame.origin.y + view.frame.size.height + 1;
    CGPoint boundaryStart = CGPointMake(0.0, boundary);
    CGPoint boundaryEnd = CGPointMake(self.view.bounds.size.width,boundary);
    [collision addBoundaryWithIdentifier:@1 fromPoint:boundaryStart toPoint:boundaryEnd];
    
    //apply some gravity
    [_gravity addItem:view];
    
    return view;
}

#pragma mark - Pan Gesture Handler
- (void)handlePan:(UIPanGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:self.view];
    UIView* draggedView = gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        //was the pan initiated from the top of the recipe?
        UIView* draggedView = gesture.view;
        CGPoint dragStartLocation = [gesture locationInView:draggedView];
        if (dragStartLocation.y < 200.0f)
        {
            _draggingView = YES;
            _previousTouchPoint = touchPoint;
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged && _draggingView)
    {
        //handle dragging, use the offset on the y direction of touchpoint to change the view's center
        float yOffset = _previousTouchPoint.y - touchPoint.y; gesture.view.center = CGPointMake(draggedView.center.x, draggedView.center.y - yOffset);
        _previousTouchPoint = touchPoint;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded && _draggingView)
    {
        //the gesture has ended
        [_animator updateItemUsingCurrentState:draggedView];
        _draggingView = NO;
    }
}

@end
