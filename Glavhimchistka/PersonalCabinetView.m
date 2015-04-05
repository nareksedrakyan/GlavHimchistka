//
//  PersonalCabinetView.m
//  Glavhimchistka
//
//  Created by Admin on 05.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "PersonalCabinetView.h"

@implementation PersonalCabinetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)editAction:(UIButton *)sender
{
    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 2;
    sender.layer.borderColor=[UIColor whiteColor].CGColor;
    sender.layer.masksToBounds = YES;
    
    self.saleButton.layer.cornerRadius=0;
    self.saleButton.layer.borderWidth=0;
    
    self.bonusButton.layer.cornerRadius=0;
    self.bonusButton.layer.borderWidth=0;
    [self.delegate edit];
  
}

- (IBAction)bonusAction:(UIButton *)sender
{
    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 2;
    sender.layer.borderColor=[UIColor whiteColor].CGColor;
    sender.layer.masksToBounds = YES;
    
    self.saleButton.layer.cornerRadius=0;
    self.saleButton.layer.borderWidth=0;
    
    self.editButton.layer.cornerRadius=0;
    self.editButton.layer.borderWidth=0;
    [self.delegate bonus];
   }

- (IBAction)saleAction:(UIButton *)sender
{
    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 2;
    sender.layer.borderColor=[UIColor whiteColor].CGColor;
    sender.layer.masksToBounds = YES;
    
    self.bonusButton.layer.cornerRadius=0;
    self.bonusButton.layer.borderWidth=0;
    
    self.editButton.layer.cornerRadius=0;
    self.editButton.layer.borderWidth=0;
    [self.delegate sale];
    
    }
@end
