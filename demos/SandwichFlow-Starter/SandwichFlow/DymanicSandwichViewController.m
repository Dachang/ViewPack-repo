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

@interface DymanicSandwichViewController () <UICollisionBehaviorDelegate>

@end

@implementation DymanicSandwichViewController
{
    NSMutableArray* _views;
    //UI Dynamics
    UIGravityBehavior* _gravity;
    UIDynamicAnimator* _animator;
    CGPoint _previousTouchPoint;
    BOOL _draggingView;
    UISnapBehavior* _snap;
    BOOL _viewDocked;
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
    
    boundaryStart = CGPointMake(0.0, 0.0);
    boundaryEnd = CGPointMake(self.view.bounds.size.width, 0.0);
    [collision addBoundaryWithIdentifier:@2 fromPoint:boundaryStart toPoint:boundaryEnd];
    collision.collisionDelegate = self;
    
    //apply some gravity
    [_gravity addItem:view];
    
    //UIDynamicItemBehaviour allows you to change the physical properties of a dynamic item
    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    [_animator addBehavior:itemBehaviour];
    
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
        [self tryDockView:draggedView];
        [self addVelocityToView:draggedView fromGesture:gesture];
        [_animator updateItemUsingCurrentState:draggedView];
        _draggingView = NO;
    }
}

#pragma mark - get itemBehaviour of the view
//this iterates over the behaviours until it finds the one with the correct UIDynamicItemBehaviour associated with the given view
- (UIDynamicItemBehavior*) itemBehaviourForView:(UIView*)view
{
    for(UIDynamicItemBehavior* behaviour in _animator.behaviors)
    {
        if(behaviour.class == [UIDynamicItemBehavior class] && [behaviour.items firstObject] == view)
        {
            return behaviour;
        }
    }
    return nil;
}

#pragma mark - add the velocity to the behaviour
- (void)addVelocityToView:(UIView*)view fromGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint vel = [gesture velocityInView:self.view];
    //remove the velocity on x direction
    vel.x = 0;
    UIDynamicItemBehavior* behaviour = [self itemBehaviourForView:view];
    [behaviour addLinearVelocity:vel forItem:view];
}

#pragma mark - snap Behaviour to 'dock' a view
- (void)tryDockView:(UIView*)view
{
    BOOL viewHasReachedDockLocation = view.frame.origin.y < 100.0;
    
    if(viewHasReachedDockLocation)
    {
        if(!_viewDocked)
        {
            _snap = [[UISnapBehavior alloc] initWithItem:view snapToPoint:self.view.center];
            [_animator addBehavior:_snap];
            [self setAlphaWhenViewDocked:view alpha:0.0];
            _viewDocked = YES;
        }
    }
    else
    {
        if(_viewDocked)
        {
            [_animator removeBehavior:_snap];
            [self setAlphaWhenViewDocked:view alpha:1.0];
            _viewDocked = NO;
        }
    }
}

//this is used to hide those non-docked views
- (void)setAlphaWhenViewDocked:(UIView*)view alpha:(CGFloat)alpha
{
    for (UIView* aView in _views)
    {
        if(aView != view)
        {
            aView.alpha = alpha;
        }
    }
}

#pragma mark - UICollision Behaviour delegate methods

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if([@2 isEqual:identifier])
    {
        UIView* view = (UIView*) item;
        [self tryDockView:view];
    }
}

@end
