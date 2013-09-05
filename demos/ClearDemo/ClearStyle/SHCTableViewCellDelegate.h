//
//  SHCTableViewCellDelegate.h
//  ClearStyle
//
//  Created by Fahim Farook on 23/9/12.
//  Copyright (c) 2012 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCToDoItem.h"
@class SHCTableViewCell;
// A protocol that the SHCTableViewCell uses to inform of state change
//
@protocol SHCTableViewCellDelegate <NSObject>

// indicates that the given item has been deleted
- (void) toDoItemDeleted:(SHCToDoItem*) todoItem;

//Indicates that the edit process has begun for given cell
- (void)cellDidBeginEditing:(SHCTableViewCell*)editingCell;
//Indicates that the edit process has committed for the given cell
- (void)cellDidEndEditing:(SHCTableViewCell*)editingCell;
@end
