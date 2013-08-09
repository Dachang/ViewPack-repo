//
//  LDCRSSDetailViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-8-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDCRSSEntry;

@interface LDCRSSDetailViewController : UIViewController
{
    UIWebView *_webView;
    LDCRSSEntry *_entry;
}

@property (retain) IBOutlet UIWebView *webView;
@property (retain) LDCRSSEntry *entry;

@end
