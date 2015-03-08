//
//  CustomLabel.m
//  CityMobilDriver
//
//  Created by Intern on 11/6/14.
//  Copyright (c) 2014 Davit Baghdagyulyan. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}
-(void)drawTextInRect:(CGRect)rect

{
    UIEdgeInsets insets = {5, 10, 5, 10};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
@end
