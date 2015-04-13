//
//  PriceListViewController.m
//  Glavhimchistka
//
//  Created by Admin on 08.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "PriceListCell.h"
#import "PriceListViewController.h"

@interface PriceListViewController ()

@end

@implementation PriceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightMenuButton.hidden=self.isRightMenuButtonHidden;
    self.headerLabel.text=self.title;
    self.objectArray=(NSMutableArray<PriceListObject>*)[[NSMutableArray alloc]init];
    self.priceListObject=[[PriceListObject alloc] init];
    [self calculateObjectArray];
    self.priceListTableView.delegate=self;
    self.priceListTableView.dataSource=self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)calculateObjectArray
{
    for (PriceElements*object in self.myArray)
    {
        if ((![self.objectArray containsObject:self.priceListObject])&&[object.group_c isEqualToString:self.title])
        {
            self.priceListObject.name=[object.name copy];
            self.priceListObject.price=[object.price copy];
            self.priceListObject.unit=[object.unit copy];
            
            [self.objectArray addObject:[self.priceListObject copy]];
            
        }
    }
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return !self.rightMenuButton.hidden;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
        return (self.objectArray.count+1);
   
    
    
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
   NSString* simpleTableIdentifier = [NSString stringWithFormat:@"SimpleTableViewCell_%ld" , (long)indexPath.row];
        
        PriceListCell *cell = (PriceListCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        if( cell == nil )
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PriceListCell" owner:self options:nil];
            cell =[nib objectAtIndex:0];
          //        [cell  setValue:simpleTableIdentifier forKey:@"reuseIdentifier"];
           
            if (indexPath.row==0)
            {
                cell.titLabel.text=@"Название издателя";
                cell.titLabel.textColor=[UIColor whiteColor];
                cell.titLabel.backgroundColor=[UIColor colorWithRed:163.f/255 green:21.f/255 blue:21.f/255 alpha:1];
               
                cell.priceLabel.text=[NSString stringWithFormat:@"Цена ( 1 %@. )",[(PriceListObject*)self.objectArray[0]unit]];
                cell.priceLabel.textColor=[UIColor whiteColor];
                cell.priceLabel.backgroundColor=[UIColor colorWithRed:163.f/255 green:21.f/255 blue:21.f/255 alpha:1];
            }
            else
            {
                cell.titLabel.text=[(PriceListObject*)self.objectArray[indexPath.row-1]name];

                cell.titLabel.textColor=[UIColor blackColor];
                cell.titLabel.backgroundColor=[UIColor whiteColor];
                cell.titLabel.font=[UIFont systemFontOfSize:15];
                
                cell.priceLabel.text=[(PriceListObject*)self.objectArray[indexPath.row-1]price];
                cell.priceLabel.textColor=[UIColor blackColor];
                cell.priceLabel.backgroundColor=[UIColor whiteColor];
                cell.priceLabel.font=[UIFont systemFontOfSize:15];
            }
           
            
        }
        
      
    cell.userInteractionEnabled=NO;
        return cell;

  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 57;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}
@end
