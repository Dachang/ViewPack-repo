//
//  LDCWeapon.m
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCWeapon.h"

@implementation LDCWeapon

+ (LDCWeapon *) newWeaponOfType:(WeaponType)weaponType
{
    LDCWeapon *weapon = [[LDCWeapon alloc] init];
    weapon.weaponType = weaponType;
    return weapon;
}

- (UIImage *)getWeaponImage
{
    switch (self.weaponType) {
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
            
        default:
            return nil;
            break;
    }
}

@end
