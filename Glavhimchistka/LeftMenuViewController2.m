//
//  LeftMenuViewController2.m
//  Glavhimchistka
//
//  Created by Admin on 21.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "LeftMenuViewController2.h"

@interface LeftMenuViewController2 ()
{
    NSMutableArray*titleArray;
    NSMutableArray*imageArray;
}
@end

@implementation LeftMenuViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
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
    //    infoViewController* infoContorller = [self.storyboard instantiateViewControllerWithIdentifier:@"info"];
    //    [self.navigationController pushViewController:infoContorller animated:NO];
    //    infoContorller.id_mail = [[mailResponseObject.mail objectAtIndex:indexPath.row] id];
    //    infoContorller.titleText = [[mailResponseObject.mail objectAtIndex:indexPath.row] getTitle];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
