//
//  CustomTextField.m
//  Glavhimchistka
//
//  Created by Admin on 15.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "AppDelegate.h"
#import "CustomTextField.h"
#import "ChatViewController.h"

@implementation CustomTextField
{
    UINavigationController*nvc;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    {
        //[self showTypesTable];
        nvc=(UINavigationController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController];
        [(ChatViewController*)nvc.visibleViewController showTypesTable];
    }
}

@end
