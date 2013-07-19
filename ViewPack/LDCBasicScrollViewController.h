//
//  LDCBasicScrollViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-18.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCBasicScrollViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *images;
    BOOL pageControlUsed;
    int currentPage;
    int pageToPush;
}

@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UITabBar *tabBar;

@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) IBOutlet UIImageView *ImageA;
@property (strong, nonatomic) IBOutlet UIImageView *ImageB;
@property (strong, nonatomic) IBOutlet UIImageView *ImageC;
@property (strong, nonatomic) IBOutlet UIImageView *ImageD;
@property (strong, nonatomic) IBOutlet UIImageView *imageE;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *MusicianImageScrollView;

@property (nonatomic, assign) UIModalTransitionStyle modalTransitionStyle;

//- (void)initScrollView;
//- (void)loadScrollViewWithPage:(int)page;
//- (void)scrollViewDidScroll:(UIScrollView *)sender;
//- (void)createAllEmptyPagesForScrollView:(int)pages;

@end
