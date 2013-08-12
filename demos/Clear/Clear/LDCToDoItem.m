//
//  LDCToDoItem.m
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCToDoItem.h"

@implementation LDCToDoItem

- (id)initWithText:(NSString *)text
{
    if(self = [super init])
    {
        self.text = text;
    }
    return self;
}
+ (id)toDoItemWithText:(NSString *)text
{
    return [[LDCToDoItem alloc] initWithText:text];
}

@end
