//
//  LDCViewModal.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LDCWeapon;
@interface LDCViewModal : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) LDCWeapon *weapon;

+(LDCViewModal *)newModalWithName:(NSString*)name description:(NSString*)description iconName:(NSString*)iconName weapon:(LDCWeapon *)weapon;

@end
