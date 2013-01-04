//
//  LayerFunViewController.m
//  LayerFun
//
//  Created by Rafael Veronezi on 04/01/13.
//  Copyright (c) 2013 Ravero. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LayerFunViewController.h"

@interface LayerFunViewController ()

@end

@implementation LayerFunViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.view.layer.cornerRadius = 20.0;
    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
