//
//  DepartureViewController.m
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "DepartureViewController.h"
#import "ResponseGetRegions.h"
#import "ResponseGetAddressList.h"
#import "RequestGetTimeList.h"
#import "ResponseGetTimeList.h"
#import "RequestToOrder.h"
#import "ResponseToOrder.h"

@interface DepartureViewController ()
{
    CGFloat height;
    CGFloat w;
   
    DepartureView*departureView;
    AddressView*addressView;
    DatePickerView*datePickerView;
    
    NSDateFormatter *df;
    
    ResponseGetRegions*responseGetRegionsObject;
    ResponseGetAddressList*responseGetAddressListObject;
    ResponseGetTimeList*responseGetTimeListObject;
    NSUInteger flag;
    
    NSString*selectedRegion;
    NSString*selectedRegionID;
    NSString*selectedAddress;
    NSString*selectedDate;
    NSString*selectedTime;
    
    CGSize keyboardSize;
    CGSize size;
}
@end

@implementation DepartureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    height=0;
    w=self.view.frame.size.width;
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    
    NSArray *nib1 = [[NSBundle mainBundle] loadNibNamed:@"DepartureView" owner:self options:nil];
    departureView=[nib1 objectAtIndex:0];
    
    departureView.delegate=self;
    departureView.addressTextField.delegate=self;
    
    departureView.frame=CGRectMake(0, 0, w, 400);
    
  
    
//    [departureView.datePicker setDate:[NSDate date] animated:YES];
//    departureView.datePicker.datePickerMode = UIDatePickerModeDate;
    df = [[NSDateFormatter alloc] init];
    df.dateStyle =NSDateFormatterMediumStyle;
    [df setDateFormat:@"yyyy-MM-dd"];
    
    
    NSArray *nib2 = [[NSBundle mainBundle] loadNibNamed:@"AddressView" owner:self options:nil];
    addressView=[nib2 objectAtIndex:0];
    addressView.frame=self.view.bounds;
    addressView.delegate=self;
    addressView.pickerView.delegate=self;
    addressView.pickerView.dataSource=self;
    
    NSArray *nib3 = [[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil];
    datePickerView=[nib3 objectAtIndex:0];
    datePickerView.frame=self.view.bounds;
    datePickerView.delegate=self;
   
    [self requestGetRegions];
  
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if (self.rightMenuButton.hidden)
//    {
//        departureView.heightSwitch.constant=0;
//        departureView.mySwitch.hidden=YES;
//        departureView.heightSwitchLabel.constant=0;
//    }
//    else
//    {
//        departureView.heightSwitch.constant=31;
//        departureView.heightSwitchLabel.constant=20;
//    }
   
     [self fillScrollView];

}

#pragma mark-myCustomView Delegate Methods

-(void)actionSwitch:(BOOL)isOn
{
    if (isOn)
    {
        departureView.addressTextField.userInteractionEnabled=NO;
        departureView.switchLabel.text=@"Выбрать из имеющихся";
       
            [self requestGetAddressList];
        
    }
    else
    {
        selectedAddress=nil;
        departureView.switchLabel.text=@"Введите новый адрес";
        departureView.addressTextField.text=@"";
        departureView.addressTextField.userInteractionEnabled=YES;
    }
}

-(void)showAddressList
{
    flag=2;
    [self.view addSubview:addressView];
    addressView.titLabel.text=@"Выберите адрес";
    [addressView.pickerView reloadAllComponents];
}

-(void)actionToOrder
{
    [self requestToOrder];
  
}

-(void)actionChooseTime
{
    [self requestGetTimeList];
}

-(void)showTimeList
{
    flag=3;
    [self.view addSubview:addressView];
    addressView.titLabel.text=@"Выберите время";
    [addressView.pickerView reloadAllComponents];
}
-(void)actionChooseDate
{
       [self.view addSubview:datePickerView];
    //[datePickerView.datePicker setDate:[NSDate date] animated:YES];
       datePickerView.titLabel.text=@"Выберите дату";
}

-(void)actionChooseRegion
{
    [self.view addSubview:addressView];
    flag=1;
    addressView.titLabel.text=@"Выберите регион";
    [addressView.pickerView reloadAllComponents];
 
    
}

- (void)okAction //picker
{
    if (flag==1)
    {
        if (selectedRegion==nil)
        {
            selectedRegion=[[responseGetRegionsObject.regions  objectAtIndex:[addressView.pickerView selectedRowInComponent:0]]name];
            //[[responseGetRegionsObject.regions objectAtIndex:0] name];
            selectedRegionID=[[responseGetRegionsObject.regions  objectAtIndex:[addressView.pickerView selectedRowInComponent:0]]getId];
        }
        [departureView.chooseRegionButton setTitle:[NSString stringWithFormat:@"Выбранный регион - %@", selectedRegion] forState:UIControlStateNormal];
        [addressView removeFromSuperview];
    }
    else if (flag==2)
    {
        if (selectedAddress==nil)
        {
            selectedAddress= [[responseGetAddressListObject.address_contr objectAtIndex:[addressView.pickerView selectedRowInComponent:0]]name];
          //  [[responseGetRegionsObject.regions objectAtIndex:0] name];
        }
        departureView.addressTextField.text=selectedAddress;
        [addressView removeFromSuperview];

    }
    else if (flag==3)
    {
        if (selectedTime==nil)
        {
           selectedTime=[[responseGetTimeListObject.trips objectAtIndex:[addressView.pickerView selectedRowInComponent:0]]getHour];
            //[[responseGetTimeListObject.trips objectAtIndex:0] getHour];
        }
        [departureView.chooseTimeButton setTitle:[NSString stringWithFormat:@"Выбранное время - %@", selectedTime] forState:UIControlStateNormal];
        [addressView removeFromSuperview];
    }
}

- (void)actionOK2 //datePicker
{
    selectedDate=[self TimeFormat:datePickerView.datePicker.date];
    
    [departureView.chooseDateButton setTitle:[NSString stringWithFormat:@"Выбранная дата - %@",selectedDate] forState:UIControlStateNormal];
    departureView.chooseTimeButton.enabled=YES;
    [datePickerView removeFromSuperview];

}


-(NSString*)TimeFormat:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
   
    /////////convert nsdata To NSString ////////////////////////////////////
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    if(date==nil) return @"";
    
    return [dateFormatter stringFromDate:date];
    
}

#pragma mark-Menus Delegate Methods

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return !self.rightMenuButton.hidden;
}

#pragma mark-

-(void)fillScrollView
{
    [self.scrollView addSubview:departureView];
    self.scrollView.contentSize=CGSizeMake(w, 400);
    height+=400;
//    departureView.regionPickerView.delegate=self;
//    departureView.regionPickerView.dataSource=self;
    
}

#pragma mark-Requests


-(void)requestToOrder
{
    [self.view addSubview:self.loader];
    
    RequestToOrder*requestToOrderObject=[[RequestToOrder alloc]init];
    requestToOrderObject.date=selectedDate;
    requestToOrderObject.hr=selectedTime;
    if (selectedAddress)
    {
        requestToOrderObject.address=selectedAddress;
    }
    else
    {
        requestToOrderObject.address=departureView.addressTextField.text;
    }
    requestToOrderObject.region_id=selectedRegionID;
    
    
    
    NSString*jsons=[requestToOrderObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/TripOrder=%@&SessionID=%@",encodeStr,USINFO.sessionID];
    
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
        ResponseToOrder*responseToOrderObject = [[ResponseToOrder alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if (responseToOrderObject&&[responseToOrderObject.error intValue]==0)
        {
            [self showErrorAlertWithMessage:responseToOrderObject.Msg];
        }
        else
        {
            [self showErrorAlertWithMessage:responseToOrderObject.Msg];
        }
    }];

}

-(void)requestGetTimeList
{
    
    [self.view addSubview:self.loader];
    
    RequestGetTimeList*requestGetTimeListObject=[[RequestGetTimeList alloc]init];
    requestGetTimeListObject.date=selectedDate;
    [requestGetTimeListObject setID:selectedRegionID];
    NSString*jsons=[requestGetTimeListObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Trips=%@",encodeStr];
    
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
        responseGetTimeListObject = [[ResponseGetTimeList alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if (responseGetTimeListObject&&[responseGetTimeListObject.error intValue]==0)
        {
            [self filterArray];
            [self showTimeList];
        }
        else
        {
            [self showErrorAlertWithMessage:responseGetTimeListObject.Msg];
        }
    }];

}

-(void)filterArray
{
    for (int i=0; i<responseGetTimeListObject.trips.count; i++)
    {
        if ([[responseGetTimeListObject.trips[i]engaged]isEqualToString:@"1"])
        {
            [responseGetTimeListObject.trips removeObjectAtIndex:i];
            i--;
        }
    }
}

-(void)requestGetAddressList
{
    [self.view addSubview:self.loader];
    
    
    NSString*urlString=[NSString stringWithFormat:@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/AddressContr&SessionID=%@",[UserInfo sharedUserInfo].sessionID];
    
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
    responseGetAddressListObject = [[ResponseGetAddressList alloc] initWithString:responseString error:nil];
    
    if (responseGetAddressListObject && [responseGetAddressListObject.error intValue]==0)
    {
        if (responseGetAddressListObject.address_contr.count)
        {
            
            [self showAddressList];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@ "" message:@"Ваш список адресов пуст" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction*cancel = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                        [departureView.mySwitch setOn:NO animated:YES];
                                        departureView.switchLabel.text=@"Введите новый адрес";
                                        departureView.addressTextField.text=@"";
                                        departureView.addressTextField.userInteractionEnabled=YES;
                                    }];
            
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];

            
        }
    }
    else
    {
        
        [self showErrorAlertWithMessage:responseGetAddressListObject.Msg];
    }

    [self.loader removeFromSuperview];

}

-(void)requestGetRegions
{
    self.scrollView.userInteractionEnabled=NO;
    [self.view addSubview:self.loader];

    NSString*urlString=@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Regions";
    
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
              self.scrollView.userInteractionEnabled=YES;
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        
        responseGetRegionsObject = [[ResponseGetRegions alloc] initWithString:responseString error:nil];
        
        if (responseGetRegionsObject && [responseGetRegionsObject.error intValue]==0)
        {
           
        }
        else
        {
            [self showErrorAlertWithMessage:responseGetRegionsObject.Msg];
        }
        [self.loader removeFromSuperview];
        self.scrollView.userInteractionEnabled=YES;
    }];

}

#pragma mark-UIPickerView Delegate And DataSource Methods


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(flag==1)
    {
      
        return responseGetRegionsObject.regions.count;
    }
    else if(flag==2)
    {
        return responseGetAddressListObject.address_contr.count;
    }
     else
     {
         return responseGetTimeListObject.trips.count;
     }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(flag==1)
    {
    return [[responseGetRegionsObject.regions objectAtIndex:row] name];
    }
    else if(flag==2)
    {
        return [[responseGetAddressListObject.address_contr objectAtIndex:row]name];
    }

    else
    {
        return [[responseGetTimeListObject.trips objectAtIndex:row]getHour];
        
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    if(flag==1)
     {
    //label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    label.text = [[responseGetRegionsObject.regions objectAtIndex:row] name];
     }
    else if(flag==2)
    {
        label.text=[[responseGetAddressListObject.address_contr objectAtIndex:row]name];
    }
    else
    {
        label.text=[[responseGetTimeListObject.trips objectAtIndex:row]getHour];
    }

     return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     if(flag==1)
     {
       selectedRegion=[[responseGetRegionsObject.regions objectAtIndex:row] name];
        selectedRegionID=[[responseGetRegionsObject.regions objectAtIndex:0] getId];
     }
     else if(flag==2)
     {
       selectedAddress=[[responseGetAddressListObject.address_contr objectAtIndex:row]name];
     }
    else
    {
        selectedTime=[[responseGetTimeListObject.trips objectAtIndex:row]getHour];
    }

}

#pragma mark-Keyboard notification methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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

    size=self.scrollView.contentSize;
    NSDictionary* info = [aNotification userInfo];
    keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.scrollView.contentSize=CGSizeMake(size.width,size.height+keyboardSize.height-self.buttonsView.frame.size.height);
    
    CGPoint bottomOffset = CGPointMake(0,CGRectGetMinY(departureView.addressTextField.frame));
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.scrollView.contentSize=size;
}

@end
