//
//  DepartureViewController.m
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "DepartureViewController.h"
#import "ResponseGetRegions.h"

@interface DepartureViewController ()
{
    CGFloat height;
    CGFloat w;
    DepartureView*departureView;
    AddressView*addressView;
    DatePickerView*datePickerView;
    
    NSDateFormatter *df;
    ResponseGetRegions*responseGetRegionsObject;
    NSUInteger flag;
    NSString*selectedRow1;
}
@end

@implementation DepartureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    height=0;
    w=self.view.frame.size.width;
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    
    NSArray *nib1 = [[NSBundle mainBundle] loadNibNamed:@"DepartureView" owner:self options:nil];
    departureView=[nib1 objectAtIndex:0];
    
    departureView.delegate=self;
    
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
    
    if (self.rightMenuButton.hidden)
    {
        departureView.heightSwitch.constant=0;
        departureView.heightSwitchLabel.constant=0;
    }
    else
    {
        departureView.heightSwitch.constant=31;
        departureView.heightSwitchLabel.constant=20;
    }
   
     [self fillScrollView];

}

#pragma mark-myCustomView Delegate Methods

-(void)actionSwitch:(BOOL)isOn
{
    
}

-(void)actionToOrder
{
    
}

-(void)actionChooseTime
{
    
}
-(void)actionChooseDate
{
    
}
-(void)actionChooseRegion
{
    [self.view addSubview:addressView];
    addressView.titLabel.text=@"Выберите регион";
    addressView.pickerView.delegate=self;
    addressView.pickerView.dataSource=self;
    flag=1;
}

- (void)okAction //picker
{
    if (selectedRow1==nil)
    {
        selectedRow1=[[responseGetRegionsObject.regions objectAtIndex:0] name];
    }
    [departureView.chooseRegionButton setTitle:[NSString stringWithFormat:@"Выбранный регион - %@", selectedRow1] forState:UIControlStateNormal];
    [addressView removeFromSuperview];
}

- (void)actionOK2 //datePicker
{
    
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
    else if(YES)
    {
        
    }
        return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(flag==1)
    {
    
    return [[responseGetRegionsObject.regions objectAtIndex:row] name];
    }
    else return @"hajoxik";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    if(flag==1)
     {
     
    label.backgroundColor = [UIColor clearColor];
         label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    //label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    label.text = [[responseGetRegionsObject.regions objectAtIndex:row] name];
   
     }
     return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     if(flag==1)
     {
    selectedRow1=[[responseGetRegionsObject.regions objectAtIndex:row] name];
     }
}
@end
