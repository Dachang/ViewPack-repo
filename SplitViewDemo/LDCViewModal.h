//
//  LDCViewModal.h
//  SplitViewDemo
//
//  Created by 大畅 on 13-7-29.
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
}Weapon;

@interface LDCViewModal : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign) Weapon weapon;

+(LDCViewModal *)newModalWithName:(NSString*)name description:(NSString*)description iconName:(NSString*)iconName weapon:(Weapon)weapon;

-(UIImage *)getWeaponImage;

@end
