//
//  RegistrationViewController.h
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"

@interface RegistrationViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeKeyboardButton;
- (IBAction)closeKeyboard:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (strong, nonatomic) IBOutlet UITableView *registrationTableView;

@end
