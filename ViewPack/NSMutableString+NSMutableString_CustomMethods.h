//
//  NSMutableString+NSMutableString_CustomMethods.h
//  ViewPack
//
//  Created by 大畅 on 13-8-3.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (NSMutableString_CustomMethods)

- (void)deleteAll:(NSString*)string;
- (void)replace:(NSString*)oldString withNewString:(NSString*)newString;
- (void)replaceAll:(NSString*)oldString withNewString:(NSString*)newString;

@end
