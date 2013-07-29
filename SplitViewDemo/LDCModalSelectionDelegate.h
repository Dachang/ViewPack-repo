//
//  LDCModalSelectionDelegate.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LDCViewModal;

@protocol LDCModalSelectionDelegate <NSObject>

@required
- (void)selectedModal: (LDCViewModal *)newModal;

@end
