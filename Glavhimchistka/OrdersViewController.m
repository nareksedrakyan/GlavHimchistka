//
//  OrdersViewController.m
//  Glavhimchistka
//
//  Created by Admin on 20.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "NSString+findHeightForText.h"
#import "RequestCurentOrders.h"
#import "RequestOrdersHistory.h"
#import "ResponseOrders.h"
#import "OrdersViewController.h"
#import "RequestServices.h"
#import "ResponseServices.h"
#import "OrdersCell.h"
@interface OrdersViewController ()
{
    ResponseServices*responseServicesObject;
    ResponseOrders*responseOrdersObject;
    RequestOrdersHistory*requestOrdersHistoryObject;
    RequestServices*requestServicesObject;
    NSInteger indexOfSelectedCell;
    NSMutableArray*arr;
}
@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    self.ordersTableView.delegate=self;
    self.ordersTableView.dataSource=self;
    indexOfSelectedCell=-1;
    requestServicesObject=[[RequestServices alloc]init];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     arr=[[NSMutableArray alloc] init];
    if (self.isCurentOrders)
    {
        self.titleLabel.text=@"Текущие заказы";
        self.tableTopConstraint.constant=0;
        self.segmentedControl.hidden=YES;
        [self requestCurentOrders];
        
    }
    else
    {
        self.titleLabel.text=@"История заказов";
        self.tableTopConstraint.constant=30;
         self.segmentedControl.hidden=NO;
         requestOrdersHistoryObject=[[RequestOrdersHistory alloc]init];
        [self requestOrdersHistory];
    }
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

- (IBAction)actionSegmentedControl:(UISegmentedControl *)sender
{
    requestOrdersHistoryObject.mon=[NSString stringWithFormat:@"%ld",(long)sender.selectedSegmentIndex];
    [self requestOrdersHistory];
}
#pragma mark-Requests
-(void)requestOrdersHistory
{
    self.ordersTableView.hidden=NO;
    [self.view addSubview:self.loader];
  
    NSString*jsons=[requestOrdersHistoryObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/OrdersHistory=",encodeStr,@"&SessionID=",USINFO.sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    // NSError* error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    NSMutableURLRequest* request1 = [NSMutableURLRequest requestWithURL:url];
    [request1 setURL:url];
    [request1 setHTTPMethod:@"GET"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request1 setHTTPBody:nil];
    request1.timeoutInterval = 30;
    
    
    
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data)
        {
            
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        responseOrdersObject = [[ResponseOrders alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if ([responseOrdersObject.error intValue]==0)
        {
            if (responseOrdersObject.orders.count)
            {
                self.ordersTableView.hidden=NO;
                self.emtyLabel.hidden=YES;
                [self.ordersTableView reloadData];
            }
            else
            {
                self.ordersTableView.hidden=YES;
                self.emtyLabel.hidden=NO;
            }
           
        }
        else if(responseOrdersObject.Msg)
        {
            [self showErrorAlertWithMessage:responseOrdersObject.Msg];
        }
        
    }];
}

-(void)requestServices
{
   
    NSString*jsons=[requestServicesObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Services=",encodeStr,@"&SessionID=",USINFO.sessionID];
    
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
    
    NSURLResponse* response;
    NSError* error = nil;
    
    NSData*data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    
    NSLog(@"responseString:%@",responseString);
    responseServicesObject = [[ResponseServices alloc] initWithString:responseString error:nil];
    
    if ([responseServicesObject.error intValue]==0)
    {
       // [self.ordersTableView reloadData];
    }
    else if(responseServicesObject.Msg)
    {
        [self showErrorAlertWithMessage:responseServicesObject.Msg];
    }

    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if (!data)
//        {
//            
//            
//        }
//        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
//        
//        NSLog(@"responseString:%@",responseString);
//        responseServicesObject = [[ResponseServices alloc] initWithString:responseString error:nil];
//        
//        if ([responseServicesObject.error intValue]==0)
//        {
//            //[self.ordersTableView reloadData];
//        }
//        else if(responseServicesObject.Msg)
//        {
//            [self showErrorAlertWithMessage:responseServicesObject.Msg];
//        }
//        
//    }];

}
-(void)requestCurentOrders
{
    self.ordersTableView.hidden=NO;
    [self.view addSubview:self.loader];
    RequestCurentOrders*requestCurentOrdersObject=[[RequestCurentOrders alloc]init];
    NSString*jsons=[requestCurentOrdersObject toJSONString];
    
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/Orders=",encodeStr,@"&SessionID=",USINFO.sessionID];
    
    NSURL* url = [NSURL URLWithString:urlString];
    // NSError* error;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    NSMutableURLRequest* request1 = [NSMutableURLRequest requestWithURL:url];
    [request1 setURL:url];
    [request1 setHTTPMethod:@"GET"];
    [request1 setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request1 setHTTPBody:nil];
    request1.timeoutInterval = 30;
    
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data)
        {
            
            
        }
        NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString*responseString=[[jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        
        NSLog(@"responseString:%@",responseString);
        responseOrdersObject = [[ResponseOrders alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if ([responseOrdersObject.error intValue]==0)
        {
            if (responseOrdersObject.orders.count)
            {
                self.ordersTableView.hidden=NO;
                self.emtyLabel.hidden=YES;
                [self.ordersTableView reloadData];
            }
            else
            {
                self.ordersTableView.hidden=YES;
                self.emtyLabel.hidden=NO;
            }
            
        }
        else if(responseOrdersObject.Msg)
        {
            [self showErrorAlertWithMessage:responseOrdersObject.Msg];
        }
        
    }];
}

#pragma mark-TableView initialization

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.ordersTableView])
    {
        return responseOrdersObject.orders.count;
    }
    else
    {
        return responseServicesObject.order_servises.count;
    }
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    if ([tableView isEqual:self.ordersTableView])
    {
        
        NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
        
        OrdersCell *cell = (OrdersCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        if( cell == nil )
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrdersCell" owner:self options:nil];
            cell =[nib objectAtIndex:0];
            //cell.backgroundColor=[UIColor colorWithRed:30.f/255 green:192.f/255 blue:225.f/255 alpha:1];
            
            //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
            cell.orderNumberLabel.text=[responseOrdersObject.orders[indexPath.row]doc_num];
            cell.priceLabel.text=[NSString stringWithFormat:@"%@ руб.",[responseOrdersObject.orders[indexPath.row]kredit]];
            cell.date1Label.text=[responseOrdersObject.orders[indexPath.row]doc_date];
            cell.paidPrice.text=[NSString stringWithFormat:@"%@ руб.",[responseOrdersObject.orders[indexPath.row]debet]];
            CGSize size=[NSString findWidthForText:cell.paidPrice.text havingHeight:20 andFont:cell.paidPrice.font];
            cell.paidPriceLabelWidthConstraint.constant=size.width;
            cell.date2.text=[responseOrdersObject.orders[indexPath.row]date_out];
            cell.sklad_nameAndAdr.text=[NSString stringWithFormat:@"%@  %@",
                [responseOrdersObject.orders[indexPath.row]sclad_name],
                [responseOrdersObject.orders[indexPath.row]sclad_adr]];
            
            [responseOrdersObject.orders[indexPath.row]doc_date];
            
            if (indexPath.row==indexOfSelectedCell)
            {
                cell.upOrDownImageView.image=[UIImage imageNamed:@"up.png"];
            }
            else
            {
                cell.upOrDownImageView.image=[UIImage imageNamed:@"down.png"];
            }
            
            
            
            
        }
    
        return cell;
    }
    else
    {
        NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if( cell == nil )
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"- %@",[responseServicesObject.order_servises[indexPath.row] service]];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines=2;
        cell.userInteractionEnabled=NO;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.ordersTableView])
    {
        if (indexPath.row==indexOfSelectedCell)
        {
            return (179+20*responseServicesObject.order_servises.count);
        }
        else
        {
            return 179;
        }
    }
    else
    {
        return 20;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.ordersTableView])
    {
        if (indexOfSelectedCell==indexPath.row)
        {
            indexOfSelectedCell=-1;
            //titleGrupArray=nil;
          arr=[NSMutableArray arrayWithObjects:indexPath, nil];
            [self.ordersTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            requestServicesObject.dor_id=[responseOrdersObject.orders[indexPath.row] dor_id];
            [self requestServices];
            indexOfSelectedCell=indexPath.row;
            
            if (![arr containsObject:indexPath]) {
                [arr addObject:indexPath];
            }
            
            [self.ordersTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            
            [(OrdersCell*)[self.ordersTableView cellForRowAtIndexPath:indexPath]servicesTableView].scrollEnabled=NO;
            [(OrdersCell*)[self.ordersTableView cellForRowAtIndexPath:indexPath]servicesTableView].delegate=self;
            [(OrdersCell*)[self.ordersTableView cellForRowAtIndexPath:indexPath]servicesTableView].dataSource=self;
            [[(OrdersCell*)[self.ordersTableView cellForRowAtIndexPath:indexPath]servicesTableView]reloadData];
        }
        
    }
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
