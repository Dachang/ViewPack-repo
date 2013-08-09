//
//  NSArray+Extras.m
//  ViewPack
//
//  Created by 大畅 on 13-8-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "NSArray+Extras.h"

@implementation NSArray (Extras)

//binary search
-(NSUInteger)indexForInsertingObject:(id)anObject sortedUsingBlock:(compareBlock)compare
{
    NSUInteger index = 0;
    NSUInteger topIndex = [self count];
    while (index < topIndex)
    {
        NSUInteger midIndex = (index + topIndex)/2;
        id testObject = [self objectAtIndex:midIndex];
        if(compare(anObject, testObject)<0)
        {
            index = midIndex + 1;
        }
        else
        {
            topIndex = midIndex;
        }
    }
    return index;
}

@end
