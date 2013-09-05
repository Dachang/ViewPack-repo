//
//  SHCTableViewCell.h
//  ClearStyle
//
//  Created by Fahim Farook on 23/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCToDoItem.h"
#import "SHCTableViewCellDelegate.h"
#import "SHCStrikethroughLabel.h"

// A custom table cell that renders SHCToDoItem items.
@interface SHCTableViewCell : UITableViewCell<UITextFieldDelegate>

// The item that this cell renders
@property (nonatomic) SHCToDoItem *todoItem;
// The label used to render the to-do text
@property (nonatomic, strong, readonly) SHCStrikethroughLabel *label;

// The object that acts as delegate for this cell.
@property (nonatomic, assign) id<SHCTableViewCellDelegate> delegate;

@end
