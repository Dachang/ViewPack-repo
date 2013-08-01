//
//  LDCPageControlViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCPageControlViewController.h"

@interface LDCPageControlViewController ()

@end

@implementation LDCPageControlViewController
@synthesize myScrollView = _myScrollView;
@synthesize myPageControl = _myPageControl;

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
//    self.view.backgroundColor = [UIColor whiteColor];
    [self initScrollView];
    [self initTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadScrollViewWithPage:(UIView *)page
{
    int pageCount = [[_myScrollView subviews] count];
    
    CGRect bounds = _myScrollView.bounds;
    bounds.origin.x = bounds.size.width * pageCount;
    bounds.origin.y = 0;
    page.frame = bounds;
    [_myScrollView addSubview:page];
}

- (void)createPages
{
    CGRect pageRect = _myScrollView.frame;
    
    //create pages
    UIView *page1 = [[UIView alloc] initWithFrame:pageRect];
    page1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PageControlA.png"]];
    UIView *page2 = [[UIView alloc] initWithFrame:pageRect];
    page2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PageControlB.png"]];
    UIView *page3 = [[UIView alloc] initWithFrame:pageRect];
    page3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"PageControlC.png"]];
    
    //add to scrollView
    [self loadScrollViewWithPage:page1];
    [self loadScrollViewWithPage:page2];
    [self loadScrollViewWithPage:page3];
    
    [page1 release];
    [page2 release];
    [page3 release];
}

- (void)initScrollView
{
    float pageControlHeight = 18.0;
    int pageCount = 3;
    
    CGRect scrollViewRect = [self.view bounds];
    //scrollViewRect.size.height -= pageControlHeight;
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width*pageCount, 1);
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.delegate = self;
    
    CGRect pageViewRect = [self.view bounds];
    pageViewRect.size.height = pageControlHeight;
    pageViewRect.origin.y = scrollViewRect.size.height - pageControlHeight;
    
    _myPageControl = [[UIPageControl alloc] initWithFrame:pageViewRect];
    //_myPageControl.backgroundColor = [UIColor blackColor];
    _myPageControl.numberOfPages = pageCount;
    _myPageControl.currentPage = 0;
    [_myPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    _myPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _myPageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self createPages];
    
    [self.view addSubview:_myScrollView];
    [self.view addSubview:_myPageControl];
    
    //add release
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    //计算距离以返回current page index （向下取整）
    int page = floor((sender.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    _myPageControl.currentPage = page;
}

- (void)changePage:(id)sender
{
    int page = _myPageControl.currentPage;
    
    //update the scrollView to the appropriate page
    CGRect frame = _myScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    [_myScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark
#pragma mark auto page control

- (void)initTimer
{
    _timeCount = 0;
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)autoScroll
{
    _timeCount++;
    _pageCount = 3;
    
    CGRect scrollViewRect = [self.view bounds];
    
    if(_timeCount == _pageCount)
    {
        _timeCount = 0;
    }
    [_myScrollView scrollRectToVisible:CGRectMake(_timeCount * scrollViewRect.size.width, 0, 768, 1024) animated:YES];
}


@end
