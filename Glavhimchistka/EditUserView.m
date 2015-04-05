//
//  EditUserView.m
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "EditUserView.h"

@implementation EditUserView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)saveAction:(UIButton *)sender
{
    [self.delegate saveAction];
}

- (IBAction)changePasswordAction:(UITapGestureRecognizer *)sender
{
    [self.delegate changePasswordAction];
}

- (IBAction)no2Action:(UIButton *)sender
{

}

- (IBAction)yes2Action:(UIButton *)sender
{
  
}

- (IBAction)no1Action:(UIButton *)sender
{

}

- (IBAction)yes1Action:(UIButton *)sender
{
    

}
@end
