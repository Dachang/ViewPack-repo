//
//  LDCBasicScrollViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-18.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCBasicScrollViewController.h"

@interface LDCBasicScrollViewController ()

@end

@implementation LDCBasicScrollViewController

@synthesize tabBar,navController,tabBarController,images,imageScrollView,ImageA,ImageB,ImageC,modalTransitionStyle;

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
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //navigation Controller
    //    self.navController = [[UINavigationController alloc] init];
    //    [self.view addSubview:self.navController.view];
    //tabBar Controller
    //    self.tabBarController = [[UITabBarController alloc] init];
    //    [self.view addSubview:self.tabBarController.view];
    
    self.tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 1024 - 65, 768, 47)];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"TabBar.png"];
    [self.view addSubview:tabBar];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shelfBG.png"]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 51, 30)];
    [button setImage:[UIImage imageNamed:@"scrollViewBackButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *lightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Light.png"]];
    lightImage.frame = CGRectMake(0, 0, 768, 203);
    lightImage.alpha = 0.65;
    [self.view addSubview:lightImage];
    
    //scrollView
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"poster1.png",@"poster2.png",@"poster3.png", nil];
    images = imageArray;
    
    self.ImageA.image = [UIImage imageNamed:[images objectAtIndex:0]];
    self.ImageB.image = [UIImage imageNamed:[images objectAtIndex:1]];
    self.ImageC.image = [UIImage imageNamed:[images objectAtIndex:2]];
    
    imageScrollView.contentSize = CGSizeMake((ImageA.frame.size.width + 24) * images.count - 24, imageScrollView.frame.size.height);
    [imageScrollView setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark back button

- (void) backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//#pragma mark
//#pragma mark scrollView
//- (void) createAllEmptyPagesForScrollView:(int)pages
//{
//    if(pages < 0)
//    {
//        return;
//    }
//    for (int page = 0; page<pages; page++)
//    {
//        CGRect frame = mainScrollView.frame;
//        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        detailButton.frame = CGRectMake(frame.size.width * page + 80, 0, 400, 600);
//        [detailButton addTarget:self action:@selector(detailButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        [mainScrollView addSubview:detailButton];
//    }
//}
//
//- (void)loadScrollViewWithPage:(int)page
//{
//    if(page < 0 || page >= numOfPages)
//    {
//        return;
//    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImageView *tempImageView = [[UIImageView alloc] init];
//        tempImageView.image = [UIImage imageNamed:[images objectAtIndex:page]];
//        if((NSNull *)tempImageView == [NSNull null])
//        {
//            UIImage *image = [UIImage imageNamed:[images objectAtIndex:page]];
//            tempImageView = [[UIImageView alloc] initWithImage:image];
//            [images replaceObjectAtIndex:page withObject:tempImageView];
//        }
//        if(tempImageView)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if(nil == tempImageView.superview)
//                {
//                    CGRect frame = imageScrollView.frame;
//                    frame.origin.x = frame.size.width * page;
//                    frame.origin.y = 0;
//                    tempImageView.frame = CGRectMake(frame.size.width * page + 80, 0, 400, 600);
//                    [imageScrollView addSubview:tempImageView];
//                }
//            });
//        }
//    });
//    
//}
//
//- (void)initScrollView
//{
//    NSMutableArray *views = [[NSMutableArray alloc] init];
//    for(unsigned i = 0; i<numOfPages;i++)
//    {
//        [views addObject:[NSNull null]];
//    }
//    self.images = views;
//    imageScrollView.pagingEnabled = YES;
//    imageScrollView.clipsToBounds = NO;
//    imageScrollView.scrollsToTop = NO;
//    [imageScrollView setDelegate:self];
//    imageScrollView.contentSize = CGSizeMake(imageScrollView.frame.size.width * numOfPages, imageScrollView.frame.size.height);
//    currentPage = 0;
//    [self createAllEmptyPagesForScrollView:numOfPages];
//    [imageScrollView addSubview:activeImage];
//    [self loadScrollViewWithPage:0];
//    [self loadScrollViewWithPage:1];
//    [imageScrollView setContentOffset:CGPointMake(0, 0)];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)sender
//{
//    CGFloat pageWidth = self.imageScrollView.frame.size.width;
//    int page = floor((self.imageScrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
//    if(page<0||page>numOfPages)
//    {
//        return;
//    }
//    if(pageControlUsed)
//    {
//        return;
//    }
//}


@end
