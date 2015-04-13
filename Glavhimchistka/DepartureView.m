//
//  DepartureView.m
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "DepartureView.h"

@implementation DepartureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)mySwitchAction:(UISwitch *)sender
{
    [self.delegate actionSwitch:(!sender.on)];
}
- (IBAction)toOrderAction:(UIButton *)sender
{
    [self.delegate actionToOrder];
}
- (IBAction)actionChooseRegion:(UIButton *)sender
{
     [self.delegate actionChooseRegion];
}
- (IBAction)actionChooseDate:(UIButton *)sender
{
     [self.delegate actionChooseDate];
}
- (IBAction)actionChooseTime:(UIButton *)sender
{
     [self.delegate actionChooseTime];
}
@end
