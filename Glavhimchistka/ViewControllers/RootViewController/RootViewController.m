//
//  ViewController.m
//  Glavhimchistka
//
//  Created by Admin on 18.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "ServicesViewController.h"
#import "ChatViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
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
     NSLog(@"height=%f",self.rootTableView.bounds.size.height);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        case 1:
        {
            LoginViewController* lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:lvc animated:YES];
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
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}
@end
