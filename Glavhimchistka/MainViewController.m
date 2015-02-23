//
//  MainViewController.m
//  Glavhimchistka
//
//  Created by Admin on 20.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "RootViewController.h"
#import "MainViewController.h"

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
    //    infoViewController* infoContorller = [self.storyboard instantiateViewControllerWithIdentifier:@"info"];
    //    [self.navigationController pushViewController:infoContorller animated:NO];
    //    infoContorller.id_mail = [[mailResponseObject.mail objectAtIndex:indexPath.row] id];
    //    infoContorller.titleText = [[mailResponseObject.mail objectAtIndex:indexPath.row] getTitle];
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
