//
//  ViewController.m
//  Sample Controller
//
//  Created by Adam Proschek on 3/6/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
    firstViewController.title = @"First View";
    SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:[NSBundle mainBundle]];
    secondViewController.title = @"Second View";
    [self addChildViewController:firstViewController];
    [self addChildViewController:secondViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
