//
//  SHCTableViewDragAddNew.m
//  ClearStyle
//
//  Created by 大畅 on 13-9-5.
//  Copyright (c) 2013年 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCTableViewDragAddNew.h"
#import "SHCTableViewCell.h"

@implementation SHCTableViewDragAddNew
{
    SHCTableViewCell* _placeholderCell;
    BOOL _pullDownInProgress;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _placeholderCell = [[SHCTableViewCell alloc] init];
        _placeholderCell.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
    if(_pullDownInProgress)
    {
        //add the placeholder
        [self insertSubview:_placeholderCell atIndex:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if(_pullDownInProgress && self.scrollView.contentOffset.y <= 0.0f)
    {
        _placeholderCell.frame = CGRectMake(0, -self.scrollView.contentOffset.y - SHC_ROW_HEIGHT, self.frame.size.width, SHC_ROW_HEIGHT);
        _placeholderCell.label.text = -self.scrollView.contentOffset.y > SHC_ROW_HEIGHT ?
        @"Release to Add Item" : @"Pull to Add Item";
        _placeholderCell.alpha = MIN(1.0f, -self.scrollView.contentOffset.y/SHC_ROW_HEIGHT);
    }
    else
    {
        _pullDownInProgress = false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(_pullDownInProgress && -self.scrollView.contentOffset.y > SHC_ROW_HEIGHT)
    {
        [self.dataSource itemAdded];
    }
    _pullDownInProgress = false;
    [_placeholderCell removeFromSuperview];
}

@end
