//
//  LDCCollectionViewController.h
//  ViewPack
//
//  Created by 大畅 on 13-8-15.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flickr.h"

@class MBProgressHUD;

@interface LDCCollectionViewController : UIViewController<UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, FlickrDelegate>

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, weak) MBProgressHUD *progressHUD;

@end
