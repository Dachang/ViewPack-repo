//
//  LDCTableViewCell.h
//  Clear
//
//  Created by 大畅 on 13-8-12.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCToDoItem.h"

@protocol LDCTableViewCellDelegate <NSObject>

- (void) toDoItemDeleted: (LDCToDoItem *)todoItem;

@end


@interface LDCTableViewCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (nonatomic) LDCToDoItem *todoItem;
@property (nonatomic, assign) id<LDCTableViewCellDelegate> delegate;

@end
