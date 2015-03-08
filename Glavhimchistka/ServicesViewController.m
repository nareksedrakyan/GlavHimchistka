//
//  ServicesViewController.m
//  Glavhimchistka
//
//  Created by Admin on 07.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "ServicesViewController.h"
#import "ServicesCellTableViewCell.h"
#import "RequestPriceList.h"
#import "ResponsePriceList.h"
#import "PriceElements.h"
#import "PriceListViewController.h"
@interface ServicesViewController ()
{
    NSMutableArray*titleServicesArray;
    NSMutableArray*titleGrupArray;
    NSInteger indexOfSelectedCell;
    ResponsePriceList*responsePriceListObject;
    BOOL mustOpen;
    NSMutableArray*arr;
}
@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr=[[NSMutableArray alloc] init];
      indexOfSelectedCell=-1;
    mustOpen=NO;
    self.servicesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.servicesTableView.rowHeight = UITableViewAutomaticDimension;
   // self.servicesTableView.estimatedRowHeight = 57;
    [self requestPriceList];

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

-(void)requestPriceList
{

    [self.view addSubview:self.loader];
    
    RequestPriceList*requestPriceListObject=[[RequestPriceList alloc]init];
        
    NSString*jsons=[requestPriceListObject toJSONString];
        
    NSString *encodeStr =[jsons stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeStr=[encodeStr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSString*urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/PriceList=",encodeStr];
    
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
        responsePriceListObject = [[ResponsePriceList alloc] initWithString:responseString error:nil];
        [self.loader removeFromSuperview];
        if ([responsePriceListObject.error intValue]==0)
        {
           titleServicesArray=[self calculatetitleServicesArray];
            
            self.servicesTableView.delegate=self;
            self.servicesTableView.dataSource=self;
            [ self.servicesTableView reloadData];
        }
        else
        {
            [self showErrorAlertWithMessage:responsePriceListObject.Msg];
        }
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.servicesTableView])
    {
         return titleServicesArray.count;
    }
    else
    {
         return titleGrupArray.count;
    }
   
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    if ([tableView isEqual:self.servicesTableView])
    {
    
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    ServicesCellTableViewCell *cell = (ServicesCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ServicesCellTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        //cell.backgroundColor=[UIColor colorWithRed:30.f/255 green:192.f/255 blue:225.f/255 alpha:1];
        
        //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
        cell.titLabel.text=titleServicesArray[indexPath.row];
        if (indexPath.row==indexOfSelectedCell)
        {
            cell.servicesImageView.image=[UIImage imageNamed:@"gone1.png"];
        }
        else
        {
            cell.servicesImageView.image=[UIImage imageNamed:@"gone.png"];
        }
        
        
        
        
    }
        
    UIView *selectedView = [[UIView alloc]initWithFrame:cell.frame];
    selectedView.backgroundColor = [UIColor colorWithRed:3.f/255 green:92.f/255 blue:125.f/255 alpha:1];
    cell.selectedBackgroundView =  selectedView;

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
        
        
        cell.textLabel.text = [titleGrupArray objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines=2;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if ([tableView isEqual:self.servicesTableView])
    {
        if (indexPath.row==indexOfSelectedCell)
        {
            return (57+57*titleGrupArray.count);
        }
        else
        {
        return 57;
        }
    }
    else
    {
        return 57;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.servicesTableView])
    {
        if (indexOfSelectedCell==indexPath.row)
        {
            indexOfSelectedCell=-1;
            titleGrupArray=nil;
            NSArray*arr=[NSArray arrayWithObjects:indexPath, nil];
            [self.servicesTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
        indexOfSelectedCell=indexPath.row;
     
        titleGrupArray=[self calculatetitleGrupArray:titleServicesArray[indexPath.row]];
       
            if (![arr containsObject:indexPath]) {
                [arr addObject:indexPath];
            }
        
        [self.servicesTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            
        [(ServicesCellTableViewCell*)[self.servicesTableView cellForRowAtIndexPath:indexPath]servicesGrupTableView].scrollEnabled=NO;
        [(ServicesCellTableViewCell*)[self.servicesTableView cellForRowAtIndexPath:indexPath]servicesGrupTableView].delegate=self;
        [(ServicesCellTableViewCell*)[self.servicesTableView cellForRowAtIndexPath:indexPath]servicesGrupTableView].dataSource=self;
        [[(ServicesCellTableViewCell*)[self.servicesTableView cellForRowAtIndexPath:indexPath]servicesGrupTableView]reloadData];
        }
        
    }
    else
    {
        PriceListViewController*pvc=[self.storyboard instantiateViewControllerWithIdentifier:@"PriceListViewController"];
        pvc.headerLabel.text=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        pvc.title=[tableView cellForRowAtIndexPath:indexPath].textLabel.text;;
        pvc.myArray=[[NSMutableArray alloc] initWithArray:responsePriceListObject.price_list];
        [self.navigationController pushViewController:pvc animated:YES];
    }
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}
-(NSMutableArray*)calculatetitleGrupArray:(NSString*)title
{
    NSMutableArray*array=[[NSMutableArray alloc]init];
    for (PriceElements*object in responsePriceListObject.price_list)
    {
        if ((![array containsObject:object.group_c])&&[object.group_p isEqualToString:title])
        {
            [array addObject:object.group_c];
        }
    }
    
    return array;
}
-(NSMutableArray*)calculatetitleServicesArray
{
    NSMutableArray*array=[[NSMutableArray alloc]init];
    
    for (PriceElements*object in responsePriceListObject.price_list)
    {
        if (![array containsObject:object.group_p])
        {
            [array addObject:object.group_p];
        }
    }
    
    
    return array;

}

@end
