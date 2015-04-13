//
//  DatePickerView.m
//  Glavhimchistka
//
//  Created by Admin on 13.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)actionOK2:(UIButton *)sender
{
    [self.delegate actionOK2];
}

- (IBAction)actionCancel2:(UIButton *)sender
{
    [self removeFromSuperview];
}
@end
