//
//  RegistrationViewController.m
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "RegisterNewRequest.h"
#import "RegisterNewResponse.h"
#import "RegistrationViewController.h"
#import "RegistrationTableViewCell.h"
#import "LoginViewController.h"
@interface RegistrationViewController ()
{
    NSMutableArray*titleArray;
    UIButton*registrationButton;
    UIView*footerView;
    CGSize keyboardSize;
    CGSize size;
    UITextField *currentTextField;
    RegisterNewRequest *registerNewRequestObject;


}
@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     registerNewRequestObject=[[RegisterNewRequest alloc]init];
      self.closeKeyboardButton.hidden=YES;
    titleArray=[[NSMutableArray alloc] initWithObjects:@"Номер телефона",@"E-mail",@"Ф.И.О",@"Город",@"Улица",@"Дом",@"Корпус",
                                                       @"Квартира",@"Оффис",@"Комментарий",@"Промо-код",@"Адрес промо-код",nil];
    
  
    self.registrationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.registrationTableView.delegate=self;
    self.registrationTableView.dataSource=self;
  
   [self registerForKeyboardNotifications];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (titleArray.count+1);
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
   NSString* simpleTableIdentifier =[NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    
     RegistrationTableViewCell *cell = (RegistrationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
   
    if( cell==nil )
    {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RegistrationTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];

        
        
        if (indexPath.row==(titleArray.count-1))
        {
            cell.registrationTextField.returnKeyType=UIReturnKeyDone;
        }
        if (indexPath.row==(titleArray.count))
        {
                [cell.registrationTextField removeFromSuperview];
                registrationButton = [UIButton buttonWithType:UIButtonTypeSystem];
                registrationButton.backgroundColor=[UIColor colorWithRed:166.f/255 green:43.f/255 blue:42.f/255 alpha:1];
                [registrationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [registrationButton setTitle:@"Регистрироваться" forState:UIControlStateNormal];
            registrationButton.frame=CGRectMake(0, 0, tableView.frame.size.width, 44);
                [registrationButton addTarget:self action:@selector(registrationAction) forControlEvents:UIControlEventTouchUpInside];
           
                [cell addSubview:registrationButton];
            
        }
        else
        {
            
            cell.registrationTextField.placeholder=titleArray[indexPath.row];
            cell.registrationTextField.delegate=self;
            cell.registrationTextField.tag=100+indexPath.row;

        }
    }
    
return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    infoViewController* infoContorller = [self.storyboard instantiateViewControllerWithIdentifier:@"info"];
    //    [self.navigationController pushViewController:infoContorller animated:NO];
    //    infoContorller.id_mail = [[mailResponseObject.mail objectAtIndex:indexPath.row] id];
    //    infoContorller.titleText = [[mailResponseObject.mail objectAtIndex:indexPath.row] getTitle];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 50;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
//    registrationButton = [UIButton buttonWithType:0];
//    registrationButton.backgroundColor=[UIColor colorWithRed:166.f/255 green:43.f/255 blue:42.f/255 alpha:1];
//    [registrationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [registrationButton setTitle:@"Регистрироваться" forState:UIControlStateNormal];
//    registrationButton.frame=CGRectMake(5, 5,footerView.bounds.size.width-10,40);
//    [registrationButton addTarget:self action:@selector(registrationAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [footerView addSubview:registrationButton];
//    return footerView;
//
//   
//}

-(void)registrationAction
{
    [self requestRegisterNew];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger i=textField.tag;
    if (i==111)
    {
        [textField resignFirstResponder];
    }
    else
    {
       
        [[self.view viewWithTag:(i+1)] becomeFirstResponder];
        CGPoint bottomOffset = CGPointMake(0,(i-100)*44);
        
      
        if (bottomOffset.y<(self.registrationTableView.contentSize.height-self.registrationTableView.bounds.size.height))
        {
            [self.registrationTableView setContentOffset:bottomOffset animated:YES];

        }
        else if(self.registrationTableView.contentSize.height>self.registrationTableView.bounds.size.height)
        {
            CGPoint bottomOffset = CGPointMake(0, self.registrationTableView.contentSize.height - self.registrationTableView.bounds.size.height);
            [self.registrationTableView setContentOffset:bottomOffset animated:YES];
           
        }
      
    }

    return YES;
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
    self.closeKeyboardButton.hidden=NO;
    size=self.registrationTableView.contentSize;
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
   self.registrationTableView.contentSize=CGSizeMake(size.width,size.height-44+keyboardSize.height-self.buttonsView.frame.size.height);
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
   self.closeKeyboardButton.hidden=YES;
    self.registrationTableView.contentSize=size;
}
- (IBAction)closeKeyboard:(UIButton *)sender
{
    [currentTextField resignFirstResponder];
}




- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 100:
        {
          
            registerNewRequestObject.fone=textField.text;
        }
            break;
        case 101:
        {
           
            registerNewRequestObject.mail=textField.text;
        }
            break;
        case 102:
        {
        
            registerNewRequestObject.change_name=textField.text;
        }
            break;
        case 103:
        {
      
            registerNewRequestObject.city=textField.text;
        }
            break;
        case 104:
        {
           
            registerNewRequestObject.street=textField.text;
        }
            break;
        case 105:
        {
            
            registerNewRequestObject.house=textField.text;
        }
            break;
        case 106:
        {
           
            registerNewRequestObject.housing=textField.text;
        }
            break;
        case 107:
        {
           
            registerNewRequestObject.room=textField.text;
        }
            break;
        case 108:
        {
            
            registerNewRequestObject.office=textField.text;
        }
            break;
        case 109:
        {
        
            registerNewRequestObject.comment=textField.text;
        }
            break;
        case 110:
        {
        
            registerNewRequestObject.promocode=textField.text;
        }
            break;
        case 111:
        {
          
            registerNewRequestObject.working_address=textField.text;
        }
            break;
       
       
        default:
            break;
    }

}
-(void)requestRegisterNew
{
   [self.view addSubview:self.loader];
    NSString*jsons=[registerNewRequestObject toJSONString];
//   NSDictionary*dict=[[NSDictionary alloc]init];
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/RegistrNew=",encodeStr];
    
    
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
        RegisterNewResponse*registerNewResponseObject = [[RegisterNewResponse alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if ([registerNewResponseObject.error intValue]==0)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@ "" message:registerNewResponseObject.Msg preferredStyle:UIAlertControllerStyleAlert];
            
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
            [self showErrorAlertWithMessage:registerNewResponseObject.Msg];
        }

    }];
}
@end
