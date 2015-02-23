//
//  LoginViewController.h
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"
#import "LabelUnderLine.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>
- (IBAction)switchOrderAction:(UISwitch *)sender;
- (IBAction)switchPhoneAction:(UISwitch *)sender;

- (IBAction)switchE_mailAction:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet LabelUnderLine *passwordRecoveryLabel;
- (IBAction)registrationAction:(UIButton *)sender;
- (IBAction)loginAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UISwitch *switchPhone;
@property (weak, nonatomic) IBOutlet UISwitch *switchOrder;
@property (weak, nonatomic) IBOutlet UISwitch *switchE_mail;

@end
