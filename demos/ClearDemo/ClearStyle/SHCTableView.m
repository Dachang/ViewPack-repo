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
    Class _cellClass;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectNull];
        _scrollView.delegate = self;
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

//based on the current scroll location, recycles off-screen cells and creates new ones to fill the empty space
- (void)refreshView
{
    if(CGRectIsNull(_scrollView.frame))
    {
        return;
    }
    //set the scrollview height
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width, [_dataSource numberOfRows] * SHC_ROW_HEIGHT);
    //remove cells that are no longer visible
    for(UIView *cell in [self cellSubviews])
    {
        //is the cell off the top of the scrollview?
        if(cell.frame.origin.y + cell.frame.size.height < _scrollView.contentOffset.y)
        {
            [self recycleCell: cell];
        }
        //is the cell off the bottom of the scrollview?
        if(cell.frame.origin.y > _scrollView.contentOffset.y + _scrollView.frame.size.height)
        {
            [self recycleCell: cell];
        }
    }
    
    //make sure have a cell for each row
    int firstVisibleIndex = MAX(0, floor(_scrollView.contentOffset.y / SHC_ROW_HEIGHT));
    int lastVisibleIndex = MIN([_dataSource numberOfRows], firstVisibleIndex + 1 + ceil(_scrollView.frame.size.height/SHC_ROW_HEIGHT));
    for (int row = firstVisibleIndex; row < lastVisibleIndex; row++)
    {
        UIView *cell = [self cellForRow: row];
        if(!cell)
        {
            //create a new cell and add to the scrollview
            UIView *cell = [_dataSource cellForRow:row];
            float topEdgeForRow = row * SHC_ROW_HEIGHT;
            cell.frame = CGRectMake(0, topEdgeForRow, _scrollView.frame.size.width, SHC_ROW_HEIGHT);
            [_scrollView insertSubview:cell atIndex:0];
        }
    }
}

//the scrollview subviews that are cells
- (NSArray*)cellSubviews
{
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (UIView *subview in _scrollView.subviews)
    {
        //Since the subviews property of a UIscrollview not only expose the views that added by yourself, but also returns the two UIImageview instance that render the scroll indicators
        if([subview isKindOfClass:[SHCTableViewCell class]])
        {
            [cells addObject:subview];
        }
    }
    return cells;
}

- (void)recycleCell:(UIView*)cell
{
    [_reuseCells addObject:cell];
    [cell removeFromSuperview];
}

- (UIView*)cellForRow: (NSInteger)row
{
    float topEdgeForRow = row * SHC_ROW_HEIGHT;
    for (UIView *cell in [self cellSubviews])
    {
        if(cell.frame.origin.y == topEdgeForRow)
        {
            return cell;
        }
    }
    return nil;
}

- (void)registerClassForCells:(Class)cellClass
{
    _cellClass = cellClass;
}

- (UIView*)dequeueReusableCell
{
    //first obtain a cell from the reuse pool
    UIView *cell = [_reuseCells anyObject];
    if(cell)
    {
        NSLog(@"Returning a cell from the pool");
        [_reuseCells removeObject:cell];
    }
    if(!cell)
    {
        NSLog(@"Creating a new cell");
        cell = [[_cellClass alloc] init];
    }
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshView];
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
