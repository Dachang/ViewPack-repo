//
//  LDCViewModal.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCViewModal.h"

@implementation LDCViewModal

+(LDCViewModal*)newModalWithName:(NSString *)name description:(NSString *)description iconName:(NSString *)iconName weapon:(Weapon)weapon
{
    LDCViewModal *modal = [[LDCViewModal alloc] init];
    modal.name = name;
    modal.description = description;
    modal.iconName = iconName;
    modal.weapon = weapon;
    
    return modal;
}

-(UIImage*)getWeaponImage
{
    switch (self.weapon) {
        case Blowgun:
            return [UIImage imageNamed:@"blowgun.png"];
            break;
            case Fire:
            return [UIImage imageNamed:@"fire.png"];
            break;
            case NinjaStar:
            return [UIImage imageNamed:@"ninjastar.png"];
            break;
            case Smoke:
            return [UIImage imageNamed:@"smoke.png"];
            break;
            case Sword:
            return [UIImage imageNamed:@"sword.png"];
            break;
        default:
            return nil;
            break;
    }
}

@end
