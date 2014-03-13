//
//  TempoToolbarController.m
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "TempoToolbarController.h"
#import "TempoToolbar.h"
#import "TempoToolbarTableViewCell.h"

@interface TempoToolbarController ()

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIViewController *oldController;


@end

@implementation TempoToolbarController

#pragma mark - Initializers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.toolbar = [[TempoToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    self.toolbar.dataSource = self;
    self.toolbar.delegate = self;
    CGRect preferredContentSize = CGRectMake(0, 64, 320, 568);
    self.contentView = [[UIView alloc] initWithFrame:preferredContentSize];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.preferredContentSize = preferredContentSize.size;
    
    [self.view addSubview:self.toolbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tempo toolbar data source

- (NSInteger)numberOfSectionsInToolbar:(TempoToolbar *)toolbar
{
    return 1;
}

- (NSInteger)toolbar:(TempoToolbar *)toolbar numberOfRowsInSection:(NSInteger)section
{
    return [self.childViewControllers count];
}

- (UITableViewCell *)toolbar:(TempoToolbar *)toolbar cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TempoToolbarTableViewCell *cell = (TempoToolbarTableViewCell *)[toolbar dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[TempoToolbarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell" height:toolbar.headerTableView.rowHeight];
    }
    
    cell.viewTitleLabel.text = [[self.childViewControllers objectAtIndex:indexPath.row] title];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - Tempo toolbar delegate

- (void)toolbar:(TempoToolbar *)toolbar didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controllerToPresent = [self.childViewControllers objectAtIndex:indexPath.row];
    [self presentViewController:controllerToPresent animated:YES completion:nil];
    [[self.toolbar.headerTableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

#pragma mark - Custom methods for viewControllers
- (void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];

    if ([self.childViewControllers count] == 1)
    {
        [self presentViewController:childController animated:YES completion:nil];
    }
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if (self.oldController != nil)
    {
        [self.oldController willMoveToParentViewController:nil];
        [self.oldController.view removeFromSuperview];
    }
    
    self.oldController = viewControllerToPresent;
    viewControllerToPresent.view.frame = self.contentView.frame;
    [self.view addSubview:viewControllerToPresent.view];
    [viewControllerToPresent didMoveToParentViewController:self];
    [self.view bringSubviewToFront:self.toolbar];
    self.toolbar.title.text = [viewControllerToPresent title];
}

@end
