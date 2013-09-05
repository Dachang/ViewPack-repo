//
//  SHCTableView.h
//  ClearStyle
//
//  Created by 大畅 on 13-9-5.
//  Copyright (c) 2013年 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCTableViewCell.h"

@protocol SHCTableViewDataSource <NSObject>
//indicates the number of rows in the table
- (NSInteger)numberOfRows;
//obtains the cell for given row
- (UITableViewCell*)cellForRow:(NSInteger)row;

@end

@interface SHCTableView : UIView<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
}
@property (nonatomic, assign) id<SHCTableViewDataSource> dataSource;
@property (nonatomic, assign, readonly) UIScrollView *scrollView;

//dequeues a cell that can be reused
- (UIView*)dequeueReusableCell;
//register a class for use as new cells
- (void)registerClassForCells:(Class)cellClass;
//an array of cells that are currently visible, sorted from top to bottom
- (NSArray*)visibleCells;
//forces the table to dispose of all cells and re-build the table
- (void)reloadData;

@end
