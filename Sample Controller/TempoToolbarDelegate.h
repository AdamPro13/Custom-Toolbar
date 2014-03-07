//
//  TempoToolbarDelegate.h
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TempoToolbar;

@protocol TempoToolbarDelegate <NSObject>

@optional

- (void)toolbar:(TempoToolbar *)toolbar didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
