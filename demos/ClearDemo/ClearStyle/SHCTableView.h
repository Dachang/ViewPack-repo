//
//  SHCTableView.h
//  ClearStyle
//
//  Created by 大畅 on 13-9-5.
//  Copyright (c) 2013年 RookSoft Pte. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SHCTableViewDataSource <NSObject>
//indicates the number of rows in the table
- (NSInteger)numberOfRows;
//obtains the cell for given row
- (UITableViewCell*)cellForRow:(NSInteger)row;

@end

@interface SHCTableView : UIView

@property (nonatomic, assign) id<SHCTableViewDataSource> dataSource;

@end
