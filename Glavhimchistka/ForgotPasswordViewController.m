//
//  ForgotPasswordViewController.m
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "RememberPasswordRequestEmail.h"
#import "RememberPasswordRequestPhone.h"
#import "RememberPasswordResponse.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recoverTextField.returnKeyType=UIReturnKeyDone;
    self.recoverTextField.placeholder=@"E-mail";
   self.recoverTextField.delegate=self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
        [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)recoverButton:(UIButton *)sender
{
    [self requestForgotPassWord];
}


-(void)requestForgotPassWord
{
    NSString*jsons;
    [self.view addSubview:self.loader];
    if (self.switch_Email.on)
    {
        RememberPasswordRequestEmail*rememberPasswordRequestEmailObject=[[RememberPasswordRequestEmail alloc]init];
        rememberPasswordRequestEmailObject.mail=self.recoverTextField.text;
        
        jsons=[rememberPasswordRequestEmailObject toJSONString];
      
      
    }
    else if (self.switch_Phone.on)
    {
        RememberPasswordRequestPhone*rememberPasswordRequestPhoneObject=[[RememberPasswordRequestPhone alloc]init];
        rememberPasswordRequestPhoneObject.fone=self.recoverTextField.text;
        
       jsons=[rememberPasswordRequestPhoneObject toJSONString];
   
    
    }

    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Remember_pas=",encodeStr];
    
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
        RememberPasswordResponse*rememberPasswordResponseObject = [[RememberPasswordResponse alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if ([rememberPasswordResponseObject.error intValue]==0)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@ "" message:rememberPasswordResponseObject.Msg preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction*cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }];
            
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

        }
        else
        {
            [self showErrorAlertWithMessage:rememberPasswordResponseObject.Msg];
        }
    }];

    
}

- (IBAction)actionPhone:(UISwitch *)sender
{
    if (!sender.on)
    {
        [sender setOn:YES animated:YES];
    }
    else
    {
        self.recoverTextField.placeholder=@"Номер телефона";
        [self.switch_Email setOn:NO animated:YES];
    }
   
}

- (IBAction)actionEmail:(UISwitch *)sender
{
    if (!sender.on)
    {
        [sender setOn:YES animated:YES];
    }
    else
    {
        self.recoverTextField.placeholder=@"E-mail";
        [self.switch_Phone setOn:NO animated:YES];
    }

}
@end
