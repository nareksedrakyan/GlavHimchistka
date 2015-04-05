//
//  EditUserView.h
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol EditViewDelegate

-(void)saveAction;
-(void)changePasswordAction;

@end
#import <UIKit/UIKit.h>

@interface EditUserView : UIView


- (IBAction)saveAction:(UIButton *)sender;
- (IBAction)changePasswordAction:(UITapGestureRecognizer *)sender;
@property(nonatomic,weak)id<EditViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *no2Button;
@property (weak, nonatomic) IBOutlet UIButton *yes2button;
@property (weak, nonatomic) IBOutlet UIButton *no1Button;
@property (weak, nonatomic) IBOutlet UIButton *yes1Button;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *sotTelTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextField;


@end
