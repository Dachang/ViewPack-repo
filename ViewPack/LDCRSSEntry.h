//
//  LDCRSSEntry.h
//  ViewPack
//
//  Created by 大畅 on 13-8-9.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDCRSSEntry : NSObject
{
    NSString *_blogTitle;
    NSString *_articleTitle;
    NSString *_articleUrl;
    NSDate *_articleDate;
}

@property (copy) NSString *blogTitle;
@property (copy) NSString *articleTitle;
@property (copy) NSString *articleUrl;
@property (copy) NSDate *articleDate;

- (id)initWithBlogTitle:(NSString*)blogTitle articleTitle:(NSString*)articleTitle articleUrl:(NSString*)articleUrl articleDate:(NSDate*)articleDate;

@end
