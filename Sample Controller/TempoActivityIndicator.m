//
//  TempoActivityIndicator.m
//  Sample Controller
//
//  Created by Adam Proschek on 3/11/14.
//  Copyright (c) 2014 Adam Proschek. All rights reserved.
//

#import "TempoActivityIndicator.h"

@interface TempoActivityIndicator ()

@property (strong, nonatomic) UIView *outerCircle;
@property (strong, nonatomic) UIView *innerCircle;

@end

@implementation TempoActivityIndicator

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    self.outerCircle = [[UIView alloc] initWithFrame:CGRectMake(-35.0, -35.0, 70, 70)];
    self.outerCircle.layer.cornerRadius = 35.0;
    self.outerCircle.backgroundColor = [UIColor tempoRunTeal];
    
    self.innerCircle = [[UIView alloc] initWithFrame:CGRectInset(self.outerCircle.frame, 5.0, 5.0)];
    self.innerCircle.layer.cornerRadius = 30.0;
    self.innerCircle.backgroundColor = [UIColor whiteColor];
    
    UIImage *tempoRunFoot = [UIImage imageNamed:@"TempoRunFoot_White"];
    UIImageView *footView = [[UIImageView alloc] initWithImage:tempoRunFoot];
    footView.center = self.bounds.origin;
    
    [self addSubview:self.outerCircle];
    [self addSubview:self.innerCircle];
    [self addSubview:footView];
}

- (void)startAnimating
{
    [UIView animateWithDuration:0.75 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        self.outerCircle.transform = CGAffineTransformScale(self.outerCircle.transform, 0.90, 0.90);
        self.outerCircle.backgroundColor = [UIColor blackColor];
    } completion:nil];
}

@end
