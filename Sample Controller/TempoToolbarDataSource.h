//
//  TempoToolbarDataSource.h
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TempoToolbar;

@protocol TempoToolbarDataSource <NSObject>

- (NSInteger)numberOfSectionsInToolbar:(TempoToolbar *)toolbar;
- (NSInteger)toolbar:(TempoToolbar *)toolbar numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)toolbar:(TempoToolbar *)toolbar cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
