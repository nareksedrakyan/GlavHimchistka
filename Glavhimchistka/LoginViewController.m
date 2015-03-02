//
//  LoginViewController.m
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "LoginRequestMail.h"
#import "LoginRequestOrder.h"
#import "LoginRequestPhone.h"
#import "loginResponse.h"
#import "ForgotPasswordViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "NSString+Hashes.h"
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


- (IBAction)registrationAction:(UIButton *)sender
{
    RegistrationViewController*rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationViewController"];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)loginAction:(UIButton *)sender
{
    [self loginRequest];
}

-(void)loginRequest
{
    NSString*urlString;
    [self.view addSubview:self.loader];
    if (self.switchE_mail.on)
    {
        LoginRequestMail*loginRequestMailObject=[[LoginRequestMail alloc]init];
        loginRequestMailObject.LoginMail=self.loginTextField.text;
        loginRequestMailObject.Password=self.PasswordTextField.text.sha1;
        NSString*jsons=[loginRequestMailObject toJSONString];
        // NSDictionary*dict=[[NSDictionary alloc]init];
        NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/LoginMail=",encodeStr];
    }
    else if (self.switchPhone.on)
    {
        LoginRequestPhone*loginRequestPhoneObject=[[LoginRequestPhone alloc]init];
        loginRequestPhoneObject.Fone=self.loginTextField.text;
        loginRequestPhoneObject.Password=self.PasswordTextField.text.sha1;
        NSString*jsons=[loginRequestPhoneObject toJSONString];
        // NSDictionary*dict=[[NSDictionary alloc]init];
        NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Login_con=",encodeStr];
    }
    else if (self.switchOrder.on)
    {
        LoginRequestOrder*loginRequestOrderObject=[[LoginRequestOrder alloc]init];
        loginRequestOrderObject.User=self.loginTextField.text;
        loginRequestOrderObject.Password=self.PasswordTextField.text.sha1;
        NSString*jsons=[loginRequestOrderObject toJSONString];
        // NSDictionary*dict=[[NSDictionary alloc]init];
        NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Login=",encodeStr];
    }
        
    
   
    
    NSURL* url = [NSURL URLWithString:urlString];
   // NSError* error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:&error];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:nil];
    request.timeoutInterval = 30;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data)
        {
            
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        loginResponse*loginResponseObject = [[loginResponse alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if ([loginResponseObject.error intValue]==0)
        {
            [[NSUserDefaults standardUserDefaults] setObject:loginResponseObject.Session_id forKey:@"Session_id"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [self showErrorAlertWithMessage:loginResponseObject.Msg];
        }
    }];
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
