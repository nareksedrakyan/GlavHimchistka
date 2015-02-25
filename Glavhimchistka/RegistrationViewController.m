//
//  RegistrationViewController.m
//  Glavhimchistka
//
//  Created by Admin on 22.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RegistrationTableViewCell.h"
@interface RegistrationViewController ()
{
    NSMutableArray*titleArray;
    UIButton*registrationButton;
    UIView*footerView;
    CGSize keyboardSize;
    CGSize size;
    UITextField *currentTextField;
}
@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.closeKeyboardButton.hidden=YES;
    titleArray=[[NSMutableArray alloc] initWithObjects:@"Номер телефона",@"E-mail",@"Ф.И.О",@"Адрес",@"Город",@"Улица",@"Дом",@"Корпус",
                                                       @"Квартира",@"Оффис",@"Комментарий",@"Промо-код",@"Адрес промо-код",nil];
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
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    RegistrationTableViewCell *cell = (RegistrationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RegistrationTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
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
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger i=textField.tag;
    if (i==112)
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
        else
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
   self.registrationTableView.contentSize=CGSizeMake(size.width,size.height+keyboardSize.height-self.buttonsView.frame.size.height);
    
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

@end
