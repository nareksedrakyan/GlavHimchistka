//
//  LeftMenuViewController2.m
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "LeftMenuViewController2.h"
#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "ChatViewController.h"
@interface LeftMenuViewController2 ()
{
    NSMutableArray*titleArray;
    NSMutableArray*imageArray;
    UINavigationController*nvc;
    Class myClass;
    NSString*identity;
}
@end

@implementation LeftMenuViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     nvc=(UINavigationController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController];
    titleArray=[NSMutableArray arrayWithObjects:@"Задать вопрос",@"Контакты",@"Заказать выезд",@"Получить скидку",@"Услуги", nil];
    imageArray=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"question.png"],[UIImage imageNamed:@"map.png"],[UIImage imageNamed:@"delivery.png"],[UIImage imageNamed:@"sale.png"],[UIImage imageNamed:@"services_list.png"], nil];
    
    self.leftTableView2.delegate=self;
    self.leftTableView2.dataSource=self;
    self.leftTableView2.scrollEnabled=NO;
    self.leftTableView2.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    RootTableViewCell *cell = (RootTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RootTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        cell.backgroundColor=[UIColor colorWithRed:3.f/255 green:92.f/255 blue:125.f/255 alpha:1];
        
        
        //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
        cell.cellTextLabel.text=titleArray[indexPath.row];
        cell.cellImageView.image=imageArray[indexPath.row];
        
        
        
    }
    UIView *selectedView = [[UIView alloc]initWithFrame:cell.frame];
    selectedView.backgroundColor =[UIColor colorWithRed:30.f/255 green:192.f/255 blue:225.f/255 alpha:1];
    cell.selectedBackgroundView =  selectedView;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            myClass = NSClassFromString(@"ChatViewController");
            identity =@"ChatViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
            
            
        }
            break;
        case 1:
        {
            myClass = NSClassFromString(@"ContactsViewController");
            identity =@"ContactsViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
        
        case 2:
        {
            myClass = NSClassFromString(@"DepartureViewController");
            identity =@"DepartureViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
            
        case 3:
        {
            myClass = NSClassFromString(@"StockViewController");
            identity =@"StockViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
            
        case 4:
        {
            myClass = NSClassFromString(@"ServicesViewController");
            identity =@"ServicesViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

 
}


-(void)pushIfNoExistViewContrller:(Class)aClass andIdentity:(NSString*)identityString
{
    
    id vc = [self.storyboard instantiateViewControllerWithIdentifier:identityString];
    if ([nvc.visibleViewController isEqual:vc])
    {
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    }
    else
    {
        [(SlideNavigationController*)nvc popToRootAndSwitchToViewController:vc withCompletion:nil];
    }
    
    
//    BOOL b=NO;
//    id vc = [self.storyboard instantiateViewControllerWithIdentifier:identityString];
//    for (id controller in nvc.viewControllers)
//    {
//        if ((b=[controller isKindOfClass:[aClass class]]))
//        {
//            [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
//            [nvc popToViewController:controller animated:YES];
//            
//            //[(SlideNavigationController*)nvc popToRootAndSwitchToViewController:vc withCompletion:nil];
//            //            NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:nvc.viewControllers];
//            //            [allViewControllers removeObjectIdenticalTo:controller];
//            //            nvc.viewControllers = allViewControllers;
//            break;
//            
//            
//        }
//    }
//    if (!b)
//    {
//        [nvc pushViewController:vc animated:NO];
//    }
    
}
@end
