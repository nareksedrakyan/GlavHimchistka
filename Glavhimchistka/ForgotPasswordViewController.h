//
//  ForgotPasswordViewController.h
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgotPasswordViewController : BaseViewController<UITextFieldDelegate>
- (IBAction)actionPhone:(UISwitch *)sender;

- (IBAction)actionEmail:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switch_Phone;
@property (weak, nonatomic) IBOutlet UISwitch *switch_Email;
@property (weak, nonatomic) IBOutlet UITextField *recoverTextField;
- (IBAction)recoverButton:(UIButton *)sender;

@end
