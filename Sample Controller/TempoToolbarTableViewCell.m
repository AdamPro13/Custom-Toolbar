//
//  TempoToolbarTableViewCell.m
//  Sample Controller
//
//  Created by Adam Proschek on 3/11/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "TempoToolbarTableViewCell.h"

@implementation TempoToolbarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGRect cellSize = self.frame;
        cellSize.size = CGSizeMake(self.frame.size.width, height);
        self.frame = cellSize;
        NSLog(@"Size: %f, %f", self.frame.size.width, self.frame.size.height);
        self.viewTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.origin.x + 50, self.frame.origin.y + (self.frame.size.height/2) - 20, 220, 40)];
        self.viewTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.viewTitleLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
