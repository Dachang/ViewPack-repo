//
//  LDCWeapon.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-31.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Blowgun = 0,
    NinjaStar,
    Fire,
    Sword,
    Smoke,
}WeaponType;

@interface LDCWeapon : NSObject

@property (nonatomic, assign) WeaponType weaponType;

+ (LDCWeapon *) newWeaponOfType: (WeaponType) weaponType;

- (UIImage *) getWeaponImage;

@end
