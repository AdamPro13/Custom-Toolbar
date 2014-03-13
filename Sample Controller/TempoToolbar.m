//
//  TempoToolbar.m
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "TempoToolbar.h"
#import "TempoToolbarTableViewCell.h"

@interface TempoToolbar ()

@property CGRect originalToolbarFrame;
@property CGRect originalTitleFrame;
@property CGRect originalExpandButtonFrame;
@property CGRect originalHeaderTableViewFrame;

@end

@implementation TempoToolbar

+ (CGFloat)getDefaultHeight
{
    return 64.0;
}

+ (CGFloat)getDefaultWidth
{
    return 320.0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect titleFrame = CGRectMake(frame.origin.x + 50, frame.origin.y + frame.size.height - 40, 220, 40);
        self.originalTitleFrame = titleFrame;
        self.title = [[UILabel alloc] initWithFrame:titleFrame];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor whiteColor];
        self.toolbarState = CLOSED;
        self.originalToolbarFrame = frame;
        self.backgroundColor = [UIColor transparentTempoRunTeal];
        CGRect expandButtonFrame = CGRectMake(frame.origin.x + 5, frame.origin.y + frame.size.height - 35, 30, 30);
        self.originalExpandButtonFrame = expandButtonFrame;
        self.expandButton = [[UIButton alloc] initWithFrame:expandButtonFrame];
        self.expandButton.backgroundColor = [UIColor redColor];
        [self.expandButton addTarget:self action:@selector(expandButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        CGRect tableViewFrame = CGRectMake(0, 20, frame.size.width, 0);
        self.originalHeaderTableViewFrame = tableViewFrame;
        self.headerTableView = [[UITableView alloc] initWithFrame:tableViewFrame];
        self.headerTableView.backgroundColor = [UIColor clearColor];
        self.headerTableView.dataSource = self;
        self.headerTableView.delegate = self;
        
        [self addSubview:self.title];
        [self addSubview:self.expandButton];
        [self addSubview:self.headerTableView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    CGFloat locations[2] = {0.0, 0.25};
    
    NSArray *colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor transparentTempoRunTeal].CGColor];
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, locations);
    
    CGPoint startPoint, endPoint;
    startPoint.x = 0.0;
    startPoint.y = 0.0;
    endPoint.x = 0.0;
    endPoint.y = 100.0;
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
}

#pragma mark - Event handlers

- (void)expandButtonPressed:(UIButton *)sender
{
    if (self.toolbarState == OPEN)
    {
        [self shrinkToolbar];
    }
    else if (self.toolbarState == CLOSED)
    {
        [self expandToolbar];
    }
}

- (void)shrinkToolbar
{
    [UIView beginAnimations:@"animateShrink" context:nil];
    [UIView setAnimationDuration:0.5];
    [self setFrame:self.originalToolbarFrame];
    [self.title setFrame:self.originalTitleFrame];
    [self.expandButton setFrame:self.originalExpandButtonFrame];
    [self.headerTableView setFrame:self.originalHeaderTableViewFrame];
//    self.headerTableView.transform = CGAffineTransformScale(self.headerTableView.transform, 0.0, 0);
    [UIView commitAnimations];
    self.toolbarState = CLOSED;
}

- (void)expandToolbar
{
    [UIView beginAnimations:@"animateExpand" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self setFrame:CGRectMake(0, 0, 320, 300)];
    [self.title setFrame:CGRectMake(50, 260, 220, 40)];
    [self.expandButton setFrame:CGRectMake(5, 265, 30, 30)];
    [self.headerTableView setFrame:CGRectMake(0, 20, 320, 240)];
    [self.headerTableView reloadData];

    [UIView commitAnimations];
    self.toolbarState = OPEN;
}

#pragma mark - Helper methods

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    UITableViewCell *cell = [self.headerTableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource numberOfSectionsInToolbar:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [self.dataSource toolbar:self numberOfRowsInSection:section];
    self.headerTableView.rowHeight = self.headerTableView.frame.size.height/numberOfRows;;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource toolbar:self cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate toolbar:self didSelectRowAtIndexPath:indexPath];
    TempoToolbarTableViewCell *selectedCell = (TempoToolbarTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    self.title.text = [[selectedCell viewTitleLabel] text];
    
    UILabel *newHeaderLabel = [[UILabel alloc] initWithFrame:selectedCell.viewTitleLabel.frame];
    newHeaderLabel.text = [selectedCell.viewTitleLabel text];
    newHeaderLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:newHeaderLabel];
    
    [UIView beginAnimations:@"moveTitle" context:NULL];
    [UIView setAnimationDuration:0.5];
    newHeaderLabel.frame = self.title.frame;
    newHeaderLabel.textColor = [UIColor whiteColor];
    self.title.hidden = YES;
    self.title = newHeaderLabel;
    
    [UIView commitAnimations];
    
    [self shrinkToolbar];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    [cell setBounds:CGRectMake(0, 0, 320, 0)];
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [cell setBounds:CGRectMake(0, 0, 320, cell.frame.size.height)];
    [UIView commitAnimations];
}

@end
