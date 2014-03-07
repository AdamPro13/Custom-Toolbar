//
//  TempoToolbar.h
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempoToolbarDataSource.h"
#import "TempoToolbarDelegate.h"

typedef enum ToolbarState : NSInteger ToolbarState;
enum ToolbarState : NSInteger
{
    OPEN,
    CLOSED
};

@interface TempoToolbar : UIView <UITableViewDataSource, UITableViewDelegate>

@property ToolbarState toolbarState;

@property (nonatomic, weak) id<TempoToolbarDataSource> dataSource;
@property (nonatomic, weak) id<TempoToolbarDelegate> delegate;

@property (strong, nonatomic) UIButton *expandButton;
@property (strong, nonatomic) UITableView *headerTableView;


- (void)shrinkToolbar;
- (void)expandToolbar;
- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
