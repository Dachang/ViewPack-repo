//
//  LDCShelfTableViewCell.m
//  ViewPack
//
//  Created by 大畅 on 13-7-17.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCShelfTableViewCell.h"

@implementation LDCShelfTableViewCell
@synthesize imageOnShelf;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShelfHolder.png"]];
        bgImageView.frame = CGRectMake(0, 100, 768, 79);
        [self addSubview:bgImageView];
        
        self.imageOnShelf = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
        self.imageOnShelf.frame = CGRectMake(334, 12, 100, 100);
        [self addSubview:imageOnShelf];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
