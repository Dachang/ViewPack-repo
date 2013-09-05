//
//  SHCTableView.m
//  ClearStyle
//
//  Created by 大畅 on 13-9-5.
//  Copyright (c) 2013年 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCTableView.h"

const float SHC_ROW_HEIGHT = 50.0f;

@implementation SHCTableView
{
    UIScrollView *_scrollView;
    NSMutableSet *_reuseCells; // a set of cells that are reuseable
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectNull];
        _reuseCells = [[NSMutableSet alloc] init];
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    _scrollView.frame = self.frame;
    [self refreshView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)refreshView
{
    //set the scroll height
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, [_dataSource numberOfRows] * SHC_ROW_HEIGHT);
    
    //add the cells
    for(int row = 0; row < [_dataSource numberOfRows]; row++)
    {
        //obtain a cell
        UIView *cell = [_dataSource cellForRow:row];
        //set its location
        float topEdgeForRow = row * SHC_ROW_HEIGHT;
        CGRect frame = CGRectMake(0, topEdgeForRow, _scrollView.frame.size.width, SHC_ROW_HEIGHT);
        cell.frame = frame;
        //add to the view
        [_scrollView addSubview:cell];
    }
}

#pragma mark - property setters
- (void)setDataSource:(id<SHCTableViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self refreshView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
