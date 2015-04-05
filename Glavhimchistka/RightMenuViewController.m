//
//  RightMenuViewController.m
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "OrdersViewController.h"
#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "RightMenuViewController.h"
#import "RightMenuTableViewCell.h"

@interface RightMenuViewController ()
{
    NSMutableArray*titArray;
    NSMutableArray*imageArray;
    UILabel*messagesCountLabel;
   
    UINavigationController*nvc;
    Class myClass;
    NSString*identity;
    BOOL ss;
    
}
@end

@implementation RightMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nvc=(UINavigationController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController];
   
    
    titArray=[NSMutableArray arrayWithObjects:@"UserName",@"Текущие заказы",@"История заказов",@"Моя Почта",@"Мои данные",@"Выход",nil];
    
    imageArray=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"right_menu_user.png"],[UIImage imageNamed:@"current_orders.png"],[UIImage imageNamed:@"order_history.png"],[UIImage imageNamed:@"message_icon.png"],[UIImage imageNamed:@"user_edit.png"],[UIImage imageNamed:@"logout.png"], nil];
    self.rightTableView.delegate=self;
    self.rightTableView.dataSource=self;
    self.rightTableView.scrollEnabled=NO;
    self.rightTableView.tableHeaderView.backgroundColor=[UIColor whiteColor];
    self.rightTableView.tableHeaderView.alpha=1.f;
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightTableView.tableHeaderView.backgroundColor=[UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rightMenuWillOpen:) name:SlideNavigationControllerDidReveal object:nil];
    
 
    // Do any additional setup after loading the view.
}

-(void)rightMenuWillOpen:(NSNotification*)note
{
    if ([note.userInfo[@"menu"] isEqualToString:@"right"])
    {
        NSLog(@"%@",USINFO.userName);
        [self.rightTableView reloadData];
    }
  
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
    
    RightMenuTableViewCell *cell = (RightMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        cell.backgroundColor=[UIColor colorWithRed:3.f/255 green:91.f/255 blue:124.f/255 alpha:1];
        
        
        //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
        if (!indexPath.row)
        {
             cell.cellTextLabel.text=USINFO.userName;
        }
//        else if (indexPath.row==3)
//        {
//            if (YES)
//            {
//                messagesCountLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-30, 18, 20, 20)];
//                messagesCountLabel.backgroundColor=[UIColor orangeColor];
//                messagesCountLabel.textColor=[UIColor whiteColor];
//                
//                messagesCountLabel.text=@"1";
//                
//                messagesCountLabel.layer.cornerRadius = 15;
//                messagesCountLabel.layer.borderWidth = 2;
//                messagesCountLabel.layer.borderColor=[UIColor clearColor].CGColor;
//                messagesCountLabel.layer.masksToBounds = YES;
//                [cell.underView addSubview:messagesCountLabel];
//            }
//            else
//            {
//                [messagesCountLabel removeFromSuperview];
//            }
//        }
        else
        {
             cell.cellTextLabel.text=titArray[indexPath.row];
        }
      
        cell.cellImageView.image=imageArray[indexPath.row];
        if (!indexPath.row)
        {
            cell.cellTextLabel.font=[UIFont boldSystemFontOfSize:20];
            cell.userInteractionEnabled=NO;
        }
    }
    UIView *selectedView = [[UIView alloc]initWithFrame:cell.frame];
    selectedView.backgroundColor =[UIColor colorWithRed:30.f/255 green:192.f/255 blue:225.f/255 alpha:1];
    cell.selectedBackgroundView =  selectedView;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
        {
            myClass = NSClassFromString(@"OrdersViewController");
            identity =@"OrdersViewController";
            ss=YES;
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
            
            
        }
            break;
        case 2:
        {
            ss=NO;
            myClass = NSClassFromString(@"OrdersViewController");
            identity =@"OrdersViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
            
        case 3:
        {
            myClass = NSClassFromString(@"MyMailViewController");
            identity =@"MyMailViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
            
        case 4:
        {
            myClass = NSClassFromString(@"PersonalCabinetViewController");
            identity =@"PersonalCabinetViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
        case 5:
        {
            myClass = NSClassFromString(@"RootViewController");
            identity =@"RootViewController";
            [self pushIfNoExistViewContrller:myClass andIdentity:identity];
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)] ;
           [headerView setBackgroundColor:[UIColor whiteColor]];
    headerView.alpha=1;
    return headerView;
}

-(void)pushIfNoExistViewContrller:(Class)aClass andIdentity:(NSString*)identityString
{
   
  
    
    
    
    
    
    BOOL b=NO;
    id vc = [self.storyboard instantiateViewControllerWithIdentifier:identityString];
    
    if ([identityString isEqualToString:@"RootViewController"])
    {
        [(SlideNavigationController*)nvc popToRootAndSwitchToViewController:vc withCompletion:nil];
        return;
    }
    if ([identityString isEqualToString:@"OrdersViewController"])
    {
        if (ss)
        {
            [(OrdersViewController*)vc setIsCurentOrders:YES];
        }
        else
        {
            [(OrdersViewController*)vc setIsCurentOrders:NO];
        }
    }
    for (id controller in nvc.viewControllers)
    {
        if ((b=[controller isKindOfClass:[aClass class]]))
        {
            if ([identityString isEqualToString:@"OrdersViewController"])
            {

                if (ss)
                {
                    [(OrdersViewController*)controller setIsCurentOrders:YES];
                }
                else
                {
                    [(OrdersViewController*)controller setIsCurentOrders:NO];
                }
               [(OrdersViewController*)controller viewDidAppear:NO];
            
            }
            [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
            [nvc popToViewController:controller animated:YES];
            
            //[(SlideNavigationController*)nvc popToRootAndSwitchToViewController:vc withCompletion:nil];
            //            NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:nvc.viewControllers];
            //            [allViewControllers removeObjectIdenticalTo:controller];
            //            nvc.viewControllers = allViewControllers;
            break;
            
            
        }
    }
    if (!b)
    {
        [nvc pushViewController:vc animated:NO];
    }
    
}


@end
