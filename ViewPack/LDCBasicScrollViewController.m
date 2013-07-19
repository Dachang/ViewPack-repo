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

@synthesize tabBar,navController,tabBarController,images,imageScrollView = _imageScrollView,ImageA,ImageB,ImageC,ImageD,imageE,modalTransitionStyle,MusicianImageScrollView;

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
    
    self.tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 1024 - 65, 768, 47)];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"TabBar.png"];
    [self.view addSubview:tabBar];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navBG.png"]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 51, 30)];
    [button setImage:[UIImage imageNamed:@"scrollViewBackButton.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //scrollView
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"poster1.png",@"Chords1.png",@"Chords2.png",@"poster4.png",@"Chords3.png", nil];
    images = imageArray;

    self.ImageA.image = [UIImage imageNamed:[images objectAtIndex:1]];
    self.imageE.image = [UIImage imageNamed:[images objectAtIndex:2]];
    self.ImageD.image = [UIImage imageNamed:[images objectAtIndex:4]];
    
    [_imageScrollView setDelegate:self];
    MusicianImageScrollView.delegate = self;
    MusicianImageScrollView.contentSize = CGSizeMake(2800, MusicianImageScrollView.frame.size.height);
    MusicianImageScrollView.showsHorizontalScrollIndicator = NO;
    for(int i = 0; i<10; i++)
    {
        NSMutableArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"Chopin.png",@"Bach.png",@"Beethoven.png",@"Hayden.png",@"Shubert.png",@"Chopin.png",@"Bach.png",@"Beethoven.png",@"Hayden.png",@"Shubert.png", nil];
        UIImageView *tempDetailImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
        tempDetailImage.frame = CGRectMake(i*280, 0, 280, 280);
        [MusicianImageScrollView addSubview:tempDetailImage];
    }
    
    //Timer - Debug
    //    NSTimer *timer = [NSTimer  scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(log) userInfo:nil repeats:YES];
    //    [timer fire];

}

- (void)log
{
    NSLog(@"x %f",_imageScrollView.contentSize.width);
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


- (void)dealloc {
    [MusicianImageScrollView release];
    [super dealloc];
}
@end
