//
//  LDCToDoItem.h
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCToDoItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL completed;

- (id)initWithText:(NSString *)text;
+ (id)toDoItemWithText:(NSString *)text;

@end
