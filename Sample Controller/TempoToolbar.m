//
//  TempoToolbar.m
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "TempoToolbar.h"

@interface TempoToolbar ()

@property CGRect originalToolbarFrame;
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
    if (self) {
        self.toolbarState = CLOSED;
        self.originalToolbarFrame = frame;
        self.backgroundColor = [UIColor blueColor];
        CGRect expandButtonFrame = CGRectMake(frame.origin.x + 5, frame.origin.y + frame.size.height - 35, 30, 30);
        self.originalExpandButtonFrame = expandButtonFrame;
        self.expandButton = [[UIButton alloc] initWithFrame:expandButtonFrame];
        self.expandButton.backgroundColor = [UIColor redColor];
        [self.expandButton addTarget:self action:@selector(expandButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        CGRect tableViewFrame = CGRectMake(0, 20, 320, 0);
        self.originalHeaderTableViewFrame = tableViewFrame;
        self.headerTableView = [[UITableView alloc] initWithFrame:tableViewFrame];
        self.headerTableView.backgroundColor = self.backgroundColor;
        self.headerTableView.dataSource = self;
        self.headerTableView.delegate = self;
        
        [self addSubview:self.expandButton];
        [self addSubview:self.headerTableView];
    }
    return self;
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
    [UIView setAnimationDuration:0.25];
    [self setFrame:self.originalToolbarFrame];
    [self.expandButton setFrame:self.originalExpandButtonFrame];
    [self.headerTableView setFrame:self.originalHeaderTableViewFrame];
    [UIView commitAnimations];
    self.toolbarState = CLOSED;
}

- (void)expandToolbar
{
    [UIView beginAnimations:@"animateExpand" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [self setFrame:CGRectMake(0, 0, 320, 300)];
    [self.expandButton setFrame:CGRectMake(5, 265, 30, 30)];
    [self.headerTableView setFrame:CGRectMake(0, 20, 320, 240)];
    [self.headerTableView reloadData];
    
//    [UIView beginAnimations:@"bounceUp" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [self setFrame:CGRectMake(0, 0, 320, 295)];
//    [self.expandButton setFrame:CGRectMake(5, 260, 30, 30)];
//    [self.headerTableView setFrame:CGRectMake(0, 15, 320, 235)];
//    [self.headerTableView reloadData];
    
//    [UIView beginAnimations:@"bounceDown" context:nil];
//    [UIView setAnimationDuration:0.25];
//    [self setFrame:CGRectMake(0, 0, 320, 300)];
//    [self.expandButton setFrame:CGRectMake(5, 265, 30, 30)];
//    [self.headerTableView setFrame:CGRectMake(0, 20, 320, 240)];
//    [self.headerTableView reloadData];

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
    [self shrinkToolbar];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;
//    rotation = CATransform3DMakeRotation( (0.5*M_PI), 0.0, 0.7, 0.4);
//    rotation = CATransform3DMakeTranslation(4.0, 4.0, 0.1);
//    rotation = CATransform3DMakeAffineTransform(CGAff)
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
//    cell.layer.transform = rotation;
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
