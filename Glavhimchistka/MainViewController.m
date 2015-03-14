//
//  MainViewController.m
//  Glavhimchistka
//
//  Created by Admin on 20.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "RootViewController.h"
#import "MainViewController.h"
#import "ServicesViewController.h"
#import "ChatViewController.h"
#import "GetUserInformation.h"

@interface MainViewController ()
{
    RootViewController*rvc;
    BOOL isFirsCall;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirsCall=YES;
    rvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    [self.navigationController pushViewController:rvc animated:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    LeftMenuViewController2 *leftMenu =[self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuViewController2"];
  
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    if (isFirsCall)
    {
         [self getUserInformation];
    }
   
}

-(void)getUserInformation
{
 
       

    
        NSString*urlString=[NSString stringWithFormat:@"%@%@",@"http://xn--80aafc1aaodm5cl5a2a.xn--p1ai/api/v1/restAPI/ContrInfo&SessionID=",[UserInfo sharedUserInfo].sessionID];
        
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
        GetUserInformation*getUserInformationObject = [[GetUserInformation alloc] initWithString:responseString error:nil];
        
        if ([getUserInformationObject.error intValue]==0)
        {
            isFirsCall=NO;
            USINFO.userName=getUserInformationObject.name;
        }
       
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row){
        case 0:
        {
            ChatViewController* chvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"];
            [self.navigationController pushViewController:chvc animated:YES];
        }
            break;
        case 4:
        {
            ServicesViewController* svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServicesViewController"];
            [self.navigationController pushViewController:svc animated:YES];
        }
    break;
        }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}

@end
