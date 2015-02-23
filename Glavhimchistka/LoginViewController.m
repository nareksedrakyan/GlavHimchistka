//
//  LoginViewController.m
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "ForgotPasswordViewController.h"
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.passwordRecoveryLabel.userInteractionEnabled=YES;
    self.loginTextField.placeholder=@"E-Mail";
    self.PasswordTextField.placeholder=@"PassWord";
    
    self.loginTextField.returnKeyType=UIReturnKeyNext;
    self.PasswordTextField.returnKeyType=UIReturnKeyDone;
    self.loginTextField.delegate=self;
    self.PasswordTextField.delegate=self;
    UITapGestureRecognizer*tapGestureRecoveryPassword=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoveryPassWordAction)];
    [self.passwordRecoveryLabel addGestureRecognizer:tapGestureRecoveryPassword];
    // Do any additional setup after loading the view.
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)recoveryPassWordAction
{
    ForgotPasswordViewController* fpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:fpvc animated:YES];
}


- (IBAction)registrationAction:(UIButton *)sender {
}

- (IBAction)loginAction:(UIButton *)sender
{

}
- (IBAction)switchOrderAction:(UISwitch *)sender
{
    if (!sender.on)
    {
        [sender setOn:YES animated:YES];
    }
    else
    {
        self.loginTextField.placeholder=@"Номер заказа";
//         self.loginTextField.keyboardType=UIKeyboardTypePhonePad;
        [self.switchPhone setOn:NO animated:YES];
        [self.switchE_mail setOn:NO animated:YES];
    }
}

- (IBAction)switchPhoneAction:(UISwitch *)sender
{
    if (!sender.on)
    {
        [sender setOn:YES animated:YES];
    }
    else
    {
         self.loginTextField.placeholder=@"Номер телефона";
//         self.loginTextField.keyboardType=UIKeyboardTypePhonePad;
        [self.switchOrder setOn:NO animated:YES];
        [self.switchE_mail setOn:NO animated:YES];
    }
}

- (IBAction)switchE_mailAction:(UISwitch *)sender
{
    if (!sender.on)
    {
        [sender setOn:YES animated:YES];
    }
    else
    {
         self.loginTextField.placeholder=@"E-mail";
//        self.loginTextField.keyboardType=UIKeyboardTypeEmailAddress;
        [self.switchOrder setOn:NO animated:YES];
        [self.switchPhone setOn:NO animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([textField isEqual:self.loginTextField])
    {
        
        [self.loginTextField resignFirstResponder];
        [self.PasswordTextField becomeFirstResponder];
        
    }
    
    
    if ([textField isEqual:self.PasswordTextField])
    {
    [self.PasswordTextField resignFirstResponder];
    }
    
    return YES;
}

@end
