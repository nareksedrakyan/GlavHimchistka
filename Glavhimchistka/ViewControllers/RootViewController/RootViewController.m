//
//  ViewController.m
//  Glavhimchistka
//
//  Created by Admin on 18.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "MapViewController.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import "ServicesViewController.h"
#import "ChatViewController.h"
#import "ContactsViewController.h"
#import "StockViewController.h"
#import "DepartureViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
     [UserInfo setUserInfo:nil];
    [super viewDidLoad];
   

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isRightMenuButtonHidden=YES;
     NSLog(@"height=%f",self.rootTableView.bounds.size.height);
   // LeftMenuViewController1 *leftMenu =[[LeftMenuViewController1 alloc] init];
//    [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuViewController1"];
    
    [SlideNavigationController sharedInstance].leftMenu = APPMENU.leftMenu1;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row)
    {
        case 0:
        case 1:
        case 3:
        {
            LoginViewController* lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:lvc animated:YES];
        }
            break;
        case 2:
        {
            ContactsViewController* cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactsViewController"];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
            
//        case 3:
//        {
//            DepartureViewController* dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DepartureViewController"];
//            [self.navigationController pushViewController:dvc animated:YES];
//        }
//            break;
            
        case 4:
        {
            StockViewController* svc = [self.storyboard instantiateViewControllerWithIdentifier:@"StockViewController"];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
            
        case 5:
        {
            ServicesViewController* svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ServicesViewController"];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
//{
//    return NO;
//}



//- (BOOL)slideNavigationControllerShouldDisplayRightMenu
//{
//    return !self.rightMenuButton.hidden;
//}
@end
