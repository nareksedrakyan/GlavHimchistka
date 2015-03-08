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
@interface MainViewController ()
{
    RootViewController*rvc;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    LeftMenuViewController2 *leftMenu = (LeftMenuViewController2*)[self.storyboard
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController2"];
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
        {
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
