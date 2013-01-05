//
//  LayerFunViewController.m
//  LayerFun
//
//  Created by Rafael Veronezi on 04/01/13.
//  Copyright (c) 2013 Ravero. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LayerFunViewController.h"

@implementation LayerFunViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Sets the background and corner radius of the root UIView layer
    self.view.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.view.layer.cornerRadius = 20.0;
    
    // Adds a sublayer to the current layer, that will serve as a rounded corner
    //  rectangle to a image
    CALayer *sublayer = [CALayer layer];
    sublayer.backgroundColor = [UIColor blueColor].CGColor;
    sublayer.shadowOffset = CGSizeMake(0, 3);
    sublayer.shadowRadius = 5.0;
    sublayer.shadowColor = [UIColor blackColor].CGColor;
    sublayer.shadowOpacity = 0.8;
    sublayer.frame = CGRectMake(30, 30, 128, 192);
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth = 2.0;
    sublayer.cornerRadius = 10.0;
    [self.view.layer addSublayer:sublayer];

    // Adds an image layer above the previous layer
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = sublayer.bounds;
    imageLayer.cornerRadius = 10.0;
    imageLayer.contents = (id)[UIImage imageNamed:@"BattleMapSplashScreen.jpg"].CGImage;
    imageLayer.masksToBounds = YES;
    [sublayer addSublayer:imageLayer];
    
    // Adds a custom layer with a pattern
    CALayer *customDrawn = [CALayer layer];
    customDrawn.delegate = self;
    customDrawn.backgroundColor = [UIColor greenColor].CGColor;
    customDrawn.frame = CGRectMake(30, 250, 128, 40);
    customDrawn.shadowOffset = CGSizeMake(0, 3);
    customDrawn.shadowRadius = 5.0;
    customDrawn.shadowColor = [UIColor blackColor].CGColor;
    customDrawn.shadowOpacity = 0.8;
    customDrawn.cornerRadius = 10.0;
    customDrawn.borderColor = [UIColor blackColor].CGColor;
    customDrawn.borderWidth = 2.0;
    customDrawn.masksToBounds = YES;
    [self.view.layer  addSublayer:customDrawn];
    [customDrawn setNeedsDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Shrinks the frame of the View, so we take a small space around the edges of the frame
    // This is code is supposed to be in the viewDidLoad, but for some reason, it doesn't work
    //  when it's put there. This solution is suited for this demo, but changing parts of the
    //  frame in different parts of the code is not a acceptable solution for a production
    //  code. If you're planning on using this code on your App, you should review a better
    //  way to achieve this
    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);   
}

#pragma mark - Layer delegate methods

// This method allows for custom drawing of the layer
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL, layer.bounds, CGAffineTransformIdentity, 24, 24, kCGPatternTilingConstantSpacing, true, &callbacks);
    
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);
}

#pragma mark - Pattern Functions

// Declares the radians function, the original code doesn't includes this code
// This was generating the following warning 'mplicit declaration of function 'radians' is invalid in C99'
// I suppose this is something to do with changes in the compiler by the time the tutorial was first written
// This solution was proposed by the 'jdandrea' on the Forum post for the tutorial:
//  http://www.raywenderlich.com/forums/viewtopic.php?t=2&p=7385
//
// By the way, static functions in C, are functions visible only to the scope of the file where they are declared
// The inline keyword is a keyword for an optimization hint to the compiler, for small functions that may be
//  called several times
static inline double radians (double degrees) {return degrees * M_PI/180;}

// This code draws the black balls pattern 
void MyDrawColoredPattern(void *info, CGContextRef context)
{
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, radians(360), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, radians(360), 0);
    CGContextFillPath(context);
}

@end
