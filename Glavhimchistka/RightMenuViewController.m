//
//  RightMenuViewController.m
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "RightMenuViewController.h"
#import "RightMenuTableViewCell.h"
@interface RightMenuViewController ()
{
    NSMutableArray*titleArray;
    NSMutableArray*imageArray;
}
@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightTableView.delegate=self;
    self.rightTableView.dataSource=self;
    titleArray=[NSMutableArray arrayWithObjects:@"Mike Tevan",@"Текущие заказы",@"История заказов",@"Моя Почта",@"Мои данные",@"Выход", nil];
    imageArray=[NSMutableArray arrayWithObjects:[UIImage imageNamed:@"right_menu_user.png"],[UIImage imageNamed:@"current_orders.png"],[UIImage imageNamed:@"order_history.png"],[UIImage imageNamed:@"message_icon.png"],[UIImage imageNamed:@"user_edit.png"],[UIImage imageNamed:@"logout.png"], nil];
    self.rightTableView.scrollEnabled=NO;
    self.rightTableView.tableHeaderView.backgroundColor=[UIColor whiteColor];
    self.rightTableView.tableHeaderView.alpha=1.f;
    self.rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.rightTableView.tableHeaderView.backgroundColor=[UIColor whiteColor];
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
    
    RightMenuTableViewCell *cell = (RightMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if( cell == nil )
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RightMenuTableViewCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        cell.backgroundColor=[UIColor colorWithRed:3.f/255 green:91.f/255 blue:124.f/255 alpha:1];
        
        
        //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
        cell.cellTextLabel.text=titleArray[indexPath.row];
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
    //    infoViewController* infoContorller = [self.storyboard instantiateViewControllerWithIdentifier:@"info"];
    //    [self.navigationController pushViewController:infoContorller animated:NO];
    //    infoContorller.id_mail = [[mailResponseObject.mail objectAtIndex:indexPath.row] id];
    //    infoContorller.titleText = [[mailResponseObject.mail objectAtIndex:indexPath.row] getTitle];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)] ;
           [headerView setBackgroundColor:[UIColor whiteColor]];
    headerView.alpha=1;
    return headerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
