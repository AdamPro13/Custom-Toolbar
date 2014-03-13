//
//  TempoToolbarTableViewCell.h
//  Sample Controller
//
//  Created by Adam Proschek on 3/11/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempoToolbarTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *viewTitleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height;

@end
