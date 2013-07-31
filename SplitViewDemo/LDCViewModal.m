//
//  LDCViewModal.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCViewModal.h"

@implementation LDCViewModal

+(LDCViewModal*)newModalWithName:(NSString *)name description:(NSString *)description iconName:(NSString *)iconName weapon:(LDCWeapon *)weapon
{
    LDCViewModal *modal = [[LDCViewModal alloc] init];
    modal.name = name;
    modal.description = description;
    modal.iconName = iconName;
    modal.weapon = weapon;
    
    return modal;
}

@end
