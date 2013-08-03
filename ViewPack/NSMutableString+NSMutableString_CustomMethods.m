//
//  NSMutableString+NSMutableString_CustomMethods.m
//  ViewPack
//
//  Created by 大畅 on 13-8-3.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "NSMutableString+NSMutableString_CustomMethods.h"

@implementation NSMutableString (NSMutableString_CustomMethods)

- (void)deleteAll:(NSString *)string
{
    NSRange substr;
    substr = [self rangeOfString:string];
    
    while (substr.location!=NSNotFound)
    {
        [self deleteCharactersInRange:substr];
        substr = [self rangeOfString:string];
    }
}

- (void)replace:(NSString *)oldString withNewString:(NSString *)newString
{
    NSRange substr;
    substr = [self rangeOfString:oldString];
    if(substr.location != NSNotFound)
    {
        [self replaceCharactersInRange:substr withString:newString];
    }
    else
    {
        NSLog(@"Error when replace %@ cannot be found.", oldString);
    }
}

- (void)replaceAll:(NSString *)oldString withNewString:(NSString *)newString
{
    NSRange substr;
    substr = [self rangeOfString:oldString];
    
    while (substr.location!=NSNotFound)
    {
        [self replaceCharactersInRange:substr withString:newString];
        substr = [self rangeOfString:oldString];
    }
}

@end
