//
//  AddressView.m
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "AddressView.h"

@implementation AddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)okAction:(UIButton *)sender
{
    [self.delegate okAction];
}

- (IBAction)cancelAction:(UIButton *)sender
{
    [self removeFromSuperview];
}
@end
