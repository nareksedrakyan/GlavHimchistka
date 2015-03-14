//
//  LabelUnderLine.m
//  CityMobilDriver
//
//  Created by Intern on 11/17/14.
//  Copyright (c) 2014 Davit Baghdagyulyan. All rights reserved.
//

#import "LabelUnderLine.h"

@implementation LabelUnderLine

- (void)drawRect:(CGRect)rect {

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 68.f/255, 148.f/255, 217.f/255, 1.0f); // RGBA
    CGContextSetLineWidth(ctx, 1.0f);
    
    CGContextMoveToPoint(ctx, 5, self.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.bounds.size.width-7, self.bounds.size.height);
    
    CGContextStrokePath(ctx);
    
    [super drawRect:rect];
}

@end
