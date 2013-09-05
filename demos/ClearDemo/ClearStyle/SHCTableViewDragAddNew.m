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
    SHCTableView* _tableView;
}

- (id)initWithTableView:(SHCTableView *)tableView
{
    self = [super init];
    if(self)
    {
        _placeholderCell = [[SHCTableViewCell alloc] init];
        _placeholderCell.backgroundColor = [UIColor redColor];
        _tableView = tableView;
        _tableView.delegate = self;
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
        [_tableView insertSubview:_placeholderCell atIndex:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_pullDownInProgress && _tableView.scrollView.contentOffset.y <= 0.0f)
    {
        _placeholderCell.frame = CGRectMake(0, -_tableView.scrollView.contentOffset.y - SHC_ROW_HEIGHT, _tableView.frame.size.width, SHC_ROW_HEIGHT);
        _placeholderCell.label.text = -_tableView.scrollView.contentOffset.y > SHC_ROW_HEIGHT ?
        @"Release to Add Item" : @"Pull to Add Item";
        _placeholderCell.alpha = MIN(1.0f, -_tableView.scrollView.contentOffset.y/SHC_ROW_HEIGHT);
    }
    else
    {
        _pullDownInProgress = false;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(_pullDownInProgress && -_tableView.scrollView.contentOffset.y > SHC_ROW_HEIGHT)
    {
        [_tableView.dataSource itemAdded];
    }
    _pullDownInProgress = false;
    [_placeholderCell removeFromSuperview];
}

@end
