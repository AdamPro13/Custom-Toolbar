//
//  TempoToolbarController.h
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempoToolbarDataSource.h"
#import "TempoToolbarDelegate.h"

@class TempoToolbar;

@interface TempoToolbarController : UIViewController <TempoToolbarDataSource, TempoToolbarDelegate>

@property (strong, nonatomic) TempoToolbar *toolbar;

@end
