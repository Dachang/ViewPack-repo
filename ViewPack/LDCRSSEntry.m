//
//  LDCRSSEntry.m
//  ViewPack
//
//  Created by 大畅 on 13-8-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCRSSEntry.h"

@implementation LDCRSSEntry
@synthesize blogTitle = _blogTitle;
@synthesize articleTitle = _articleTitle;
@synthesize articleUrl = _articleUrl;
@synthesize articleDate = _articleDate;

- (id)initWithBlogTitle:(NSString *)blogTitle articleTitle:(NSString *)articleTitle articleUrl:(NSString *)articleUrl articleDate:(NSDate *)articleDate
{
    if ((self = [super init]))
    {
        _blogTitle = [blogTitle copy];
        _articleTitle = [articleTitle copy];
        _articleUrl = [articleUrl copy];
        _articleDate = [articleDate copy];
    }
    return self;
}

- (void)dealloc
{
    [_blogTitle release];
    _blogTitle = nil;
    [_articleTitle release];
    _articleTitle  = nil;
    [_articleUrl release];
    _articleUrl = nil;
    [_articleDate release];
    _articleDate = nil;
    [super dealloc];
}

@end
