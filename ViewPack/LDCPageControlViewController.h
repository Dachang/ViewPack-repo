//
//  LDCPageControlViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCPageControlViewController : UIViewController<UIScrollViewDelegate>
{
    int _timeCount;
    int _pageCount;
}

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIPageControl *myPageControl;

@end
