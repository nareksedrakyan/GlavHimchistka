//
//  PersonalCabinetViewController.m
//  Glavhimchistka
//
//  Created by Admin on 04.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "NSString+Hashes.h"
#import "PersonalCabinetViewController.h"
#import "EditUserView.h"
#import "SaleView.h"
#import "BonusView.h"
#import "ResponseGetBonus.h"
#import "ResponseGetDeposit.h"
#import "RequestSaveInfo.h"
#import "ResponseSaveInfo.h"
#import "GetUserInformation.h"
#import "RequestSavePassword.h"
#import "ResponseSavePassword.h"

@interface PersonalCabinetViewController ()
{
    EditUserView*editUserView;
    SaleView*saleView;
    BonusView*bonusView;
    PersonalCabinetView*personalCabinetView;
    CGFloat yCoord;
    CGFloat y1;
    CGFloat w;
    
    CGSize keyboardSize;
    CGSize size;
    UITextField*currentTextField;
    BOOL isFirsCallDeposit;
    BOOL isFirsCallBonus;
    RequestSaveInfo*requestSaveInfoObjet;
    RequestSavePassword*requestSavePasswordObject;
}
@end

@implementation PersonalCabinetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    requestSaveInfoObjet=[[RequestSaveInfo alloc] init];
    requestSavePasswordObject=[[RequestSavePassword alloc]init];
    isFirsCallDeposit=YES;
    isFirsCallBonus=YES;
     [self registerForKeyboardNotifications];
     w=self.view.frame.size.width;
     self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    
   ///////////////////////Personal cabinet view////////////////////////
    
    NSArray *nib0 = [[NSBundle mainBundle] loadNibNamed:@"PersonalCabinetView" owner:self options:nil];
    personalCabinetView=[nib0 objectAtIndex:0];
   
    personalCabinetView.delegate=self;
   
    personalCabinetView.userNameTextField.text=USINFO.userName;
///////////////////////edit user view ////////////////////////
   
    NSArray *nib1 = [[NSBundle mainBundle] loadNibNamed:@"EditUserView" owner:self options:nil];
    editUserView=[nib1 objectAtIndex:0];
    editUserView.delegate=self;
    editUserView.numberTelTextField.delegate=
    personalCabinetView.userNameTextField.delegate=
    editUserView.sotTelTextField.delegate=
    editUserView.mailTextField.delegate=
    editUserView.addressTextField.delegate=self;
    editUserView.addressTextField.returnKeyType=UIReturnKeyDone;
    
    editUserView.numberTelTextField.text=USINFO.phone;
    editUserView.sotTelTextField.text=USINFO.phone_cell;
    editUserView.mailTextField.text=USINFO.email;
    editUserView.addressTextField.text=USINFO.address;
    
    if ([USINFO.agree_to_receive_sms intValue])
    {
        [editUserView.no1Button setBackgroundColor:[UIColor colorWithRed:183.f/255 green:183.f/255 blue:183.f/255 alpha:1.f]];
        [editUserView.yes1Button setBackgroundColor:[UIColor colorWithRed:3.f/255 green:153.f/255 blue:223.f/255 alpha:1.f]];
    }
    else
    {
        [editUserView.no1Button setBackgroundColor:[UIColor colorWithRed:3.f/255 green:153.f/255 blue:223.f/255 alpha:1.f]];
        [editUserView.yes1Button setBackgroundColor:[UIColor colorWithRed:183.f/255 green:183.f/255 blue:183.f/255 alpha:1.f]];
    }
    
    if ([USINFO.agree_to_receive_adv_sms intValue])
    {
        [editUserView.no2Button setBackgroundColor:[UIColor colorWithRed:183.f/255 green:183.f/255 blue:183.f/255 alpha:1.f]];
        [editUserView.yes2button setBackgroundColor:[UIColor colorWithRed:3.f/255 green:153.f/255 blue:223.f/255 alpha:1.f]];
    }
    else
    {
        [editUserView.no2Button setBackgroundColor:[UIColor colorWithRed:3.f/255 green:153.f/255 blue:223.f/255 alpha:1.f]];
        [editUserView.yes2button setBackgroundColor:[UIColor colorWithRed:183.f/255 green:183.f/255 blue:183.f/255 alpha:1.f]];
    }
///////////////////////Sale View////////////////////////
    
    
    NSArray *nib2 = [[NSBundle mainBundle] loadNibNamed:@"SaleView" owner:self options:nil];
    saleView=[nib2 objectAtIndex:0];
    
    NSArray *nib3 = [[NSBundle mainBundle] loadNibNamed:@"BonusView" owner:self options:nil];
    bonusView=[nib3 objectAtIndex:0];

//*********** edit button ********************//
  
    personalCabinetView.editButton.layer.cornerRadius = 4;
    personalCabinetView.editButton.layer.borderWidth = 2;
    personalCabinetView.editButton.layer.borderColor=[UIColor whiteColor].CGColor;
    personalCabinetView.editButton.layer.masksToBounds = YES;
    
    personalCabinetView.saleButton.layer.cornerRadius=0;
    personalCabinetView.saleButton.layer.borderWidth=0;
    
    personalCabinetView.bonusButton.layer.cornerRadius=0;
    personalCabinetView.bonusButton.layer.borderWidth=0;
    
    [saleView removeFromSuperview];
    [bonusView removeFromSuperview];
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    personalCabinetView.frame=CGRectMake(0, 0, w, 250);
    [self.scrollView addSubview:personalCabinetView];
   y1=yCoord=250;
    self.scrollView.contentSize=CGSizeMake(w, yCoord);
    saleView.frame=bonusView.frame=self.scrollView.bounds;
    
    editUserView.frame=CGRectMake(0, yCoord, w, 500);
    yCoord=yCoord+500;
    [self.scrollView addSubview:editUserView];
    self.scrollView.contentSize=CGSizeMake(w, yCoord);
    
    saleView.frame=CGRectMake(0, y1, w, 80);
    bonusView.frame=CGRectMake(0, y1, w, 80);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return !self.rightMenuButton.hidden;
}



- (void)edit
{
  
    [saleView removeFromSuperview];
    [bonusView removeFromSuperview];
    
    [self.scrollView addSubview:editUserView];
    self.scrollView.contentSize=CGSizeMake(w, y1+500);
}

- (void)bonus
{
   
    [saleView removeFromSuperview];
    [editUserView removeFromSuperview];
    
   [self getDepositAndBonus:@"Bonus"];
    
     [self.scrollView addSubview:bonusView];
     self.scrollView.contentSize=CGSizeMake(w, y1+80);
}

- (void)sale
{
    [bonusView removeFromSuperview];
    [editUserView removeFromSuperview];
    
    [self getDepositAndBonus:@"Deposit"];
    
    [self.scrollView addSubview:saleView];
    self.scrollView.contentSize=CGSizeMake(w, y1+80);
  
}

-(void)getDepositAndBonus:(NSString*)requestName
{
    if (([requestName isEqualToString:@"Deposit"]&& isFirsCallDeposit)||
        ([requestName isEqualToString:@"Bonus"]&& isFirsCallBonus))
   {
        

    [self.view addSubview:self.loader];
    
    
    NSString*urlString=[NSString stringWithFormat:@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/%@&SessionID=%@",requestName,[UserInfo sharedUserInfo].sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:nil];
    request.timeoutInterval = 30;
    

    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
           if (!data)
           {
               
               
           }

    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
    NSLog(@"responseString:%@",responseString);
   if ([requestName isEqualToString:@"Deposit"])
   {
       
       ResponseGetDeposit*responseGetDepositObject=[[ResponseGetDeposit alloc] initWithString:responseString error:nil];
       if (responseGetDepositObject&&[responseGetDepositObject.error intValue]==0)
       {
           isFirsCallDeposit=NO;
           saleView.depositLabel.text=[NSString stringWithFormat:@"%@ руб.",responseGetDepositObject.deposit_rest];
       }
       else if (responseGetDepositObject.Msg)
       {
           [self showErrorAlertWithMessage:responseGetDepositObject.Msg];
       }


   }
    else
    {
        ResponseGetBonus*responseGetBonusObject=[[ResponseGetBonus alloc] initWithString:responseString error:nil];
        if (responseGetBonusObject&&[responseGetBonusObject.error intValue]==0)
        {
            isFirsCallBonus=NO;
            bonusView.bonusLabel.text=[NSString stringWithFormat:@"%@ руб.",responseGetBonusObject.bonus_rest];
        }
        else if (responseGetBonusObject.Msg)
        {
            [self showErrorAlertWithMessage:responseGetBonusObject.Msg];
        }

    }
        [self.loader removeFromSuperview];
    }];
 }
}




- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    size=self.scrollView.contentSize;
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.scrollView.contentSize=CGSizeMake(size.width,size.height+keyboardSize.height-self.buttonsView.frame.size.height);
    
    
    [self scrollToTextField:currentTextField andPosition:0];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
   self.scrollView.contentSize=size;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger i=textField.tag;
    if (i==1004||i==2000)
    {
        [textField resignFirstResponder];
    }
    else
    {
        
        [[self.view viewWithTag:(i+1)] becomeFirstResponder];
        [self scrollToTextField:textField andPosition:80];
    }
    
    return YES;
}

-(void)scrollToTextField:(UITextField*)textField andPosition:(CGFloat)position
{
    CGPoint bottomOffset = CGPointMake(0,textField.frame.origin.y+position);
    
    
    if (bottomOffset.y<(self.scrollView.contentSize.height-self.scrollView.bounds.size.height))
    {
        [self.scrollView setContentOffset:bottomOffset animated:YES];
        
    }
    else if(self.scrollView.contentSize.height>self.scrollView.bounds.size.height)
    {
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
        [self.scrollView setContentOffset:bottomOffset animated:YES];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
}

-(void)saveAction
{
    requestSaveInfoObjet.Name=personalCabinetView.userNameTextField.text;
    requestSaveInfoObjet.Fone=editUserView.numberTelTextField.text;
    requestSaveInfoObjet.Teleph_cell=editUserView.sotTelTextField.text;
    requestSaveInfoObjet.Email=editUserView.mailTextField.text;
    requestSaveInfoObjet.Address=editUserView.addressTextField.text;
    [self requestSaveInfo];
}
-(void)changePasswordAction
{
        UIAlertController * alert=[UIAlertController
        alertControllerWithTitle:@""
         message:@"Хотите изменить пароль?"
        preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Изменить пароль" style:UIAlertActionStyleDefault
         handler:^(UIAlertAction * action)
            {
                requestSavePasswordObject.old=[[alert.textFields objectAtIndex:0] text].sha1;
                [requestSavePasswordObject setNew:[[alert.textFields objectAtIndex:0] text]];
                [self requestSavePassword];
            }];
    
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Отмена" style:UIAlertActionStyleDefault
          handler:^(UIAlertAction * action)
    {
                    [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];

        [alert addAction:ok];
        [alert addAction:cancel];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Старый пароль";
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Новый пароль";
        //textField.secureTextEntry = YES;
        }];
        [self presentViewController:alert animated:YES completion:nil];
}


-(void)requestSavePassword
{
    [self.view addSubview:self.loader];
    NSString*jsons=[requestSavePasswordObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/SavePass=",encodeStr,@"&SessionID=",[UserInfo sharedUserInfo].sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    // NSError* error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
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
        
        ResponseSavePassword*responseSavePasswordObject = [[ResponseSavePassword alloc] initWithString:responseString error:nil];
        
        if (responseSavePasswordObject&&[responseSavePasswordObject.error intValue]==0)
        {
            
        }
        if (responseSavePasswordObject.Msg)
        {
            [self showErrorAlertWithMessage:responseSavePasswordObject.Msg];
        }
        
        
        [self.loader removeFromSuperview];
    }];

}


-(void)requestSaveInfo
{
    [self.view addSubview:self.loader];
    NSString*jsons=[requestSaveInfoObjet toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/SaveInfo=",encodeStr,@"&SessionID=",[UserInfo sharedUserInfo].sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    // NSError* error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
   NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
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
        
       ResponseSaveInfo*responseSaveInfoObject = [[ResponseSaveInfo alloc] initWithString:responseString error:nil];
        
        if (responseSaveInfoObject&&[responseSaveInfoObject.error intValue]==0)
        {
            [self getUserInformation];
        }
        if (responseSaveInfoObject.Msg)
        {
            [self showErrorAlertWithMessage:responseSaveInfoObject.Msg];
        }

        
        [self.loader removeFromSuperview];
    }];

}
-(void)getUserInformation
{
    [self.view addSubview:self.loader];
    
    
    NSString*urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/ContrInfo&SessionID=",[UserInfo sharedUserInfo].sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:nil];
    request.timeoutInterval = 30;
    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData*data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString*responseString=[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"responseString:%@",responseString);
    GetUserInformation*getUserInformationObject = [[GetUserInformation alloc] initWithString:responseString error:nil];
    
    if ([getUserInformationObject.error intValue]==0)
    {
        USINFO.userName=[getUserInformationObject.name stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        USINFO.phone=getUserInformationObject.fone;
        USINFO.phone_cell=getUserInformationObject.fone_cell;
        USINFO.email=getUserInformationObject.email;
        USINFO.agree_to_receive_sms=getUserInformationObject.agree_to_receive_sms;
        USINFO.agree_to_receive_adv_sms=getUserInformationObject.agree_to_receive_adv_sms;
        USINFO.card_code=getUserInformationObject.barcode;
        USINFO.address=getUserInformationObject.address;
        USINFO.discount=getUserInformationObject.discount;
    }
    [self.loader removeFromSuperview];
    
}

@end
