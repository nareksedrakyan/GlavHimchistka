//
//  ContactsViewController.m
//  Glavhimchistka
//
//  Created by Admin on 28.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "ContactsViewController.h"
#import "ResponseGetContactsList.h"
#import "ContactsCell.h"
#import "NSString+findHeightForText.h"
#import "MapViewController.h"

@interface ContactsViewController ()
{
    ResponseGetContactsList*responseGetContactsList;
}
@end

@implementation ContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    self.contacsTableView.delegate=self;
    self.contacsTableView.dataSource=self;
    self.contacsTableView.hidden=YES;
    self.contacsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    
    self.mapView=[[GMSMapView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
    self.mapView.camera=camera;
//    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) camera:camera];
    
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    
    
    [self requestGetContactsList];
    
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}
- (void)didReceiveMemoryWarning
{
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

-(IBAction)ActionSegmentedControl:(UISegmentedControl*)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
        {
            [self.mapView removeFromSuperview];
        }
            break;
            
        case 1:
        {
            [self.view addSubview:self.mapView];
            [self initializeMapView];
        }
        default:
            break;
    }
}
#pragma mark-Requests

-(void)requestGetContactsList
{
    [self.view addSubview:self.loader];
    
//    RequestPriceList*requestPriceListObject=[[RequestPriceList alloc]init];
//    
//    NSString*jsons=[requestPriceListObject toJSONString];
//    
//    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
   
    NSString*urlString=@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/ReceptionCenters";
    
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
        responseGetContactsList = [[ResponseGetContactsList alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        
        if ([responseGetContactsList.error intValue]==0)
        {
            [self filterArray];
            
            self.contacsTableView.hidden=NO;
            [self.contacsTableView reloadData];
        }
        else if (responseGetContactsList.Msg)
        {
            [self showErrorAlertWithMessage:responseGetContactsList.Msg];
        }
    }];

}

-(void)filterArray
{
    for (int i=0; i<responseGetContactsList.list.count; i++)
    {
        if ([[responseGetContactsList.list[i]getAddress]isEqualToString:@""])
        {
            [responseGetContactsList.list removeObjectAtIndex:i];
            i--;
        }
    }
}

#pragma mark-mapView initialization

-(void)initializeMapView
{
    
}

#pragma mark-tableView metods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return responseGetContactsList.list.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    ContactsCell *cell = (ContactsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ContactsCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        cell.nameLabel.text=[responseGetContactsList.list[indexPath.row] name];
        CGSize size=[NSString findWidthForText:cell.nameLabel.text havingHeight:20 andFont:cell.nameLabel.font];
        cell.nameLabelWidthConstraint.constant=size.width;
        cell.dateLabel.text=[responseGetContactsList.list[indexPath.row] working_hours];
        cell.addressLabel.text=[responseGetContactsList.list[indexPath.row] getAddress];
        // [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MapViewController*mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    mvc.addressName=[responseGetContactsList.list[indexPath.row] getAddress];
    [self.navigationController pushViewController:mvc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
