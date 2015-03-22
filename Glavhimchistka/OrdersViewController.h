//
//  OrdersViewController.h
//  Glavhimchistka
//
//  Created by Admin on 20.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"

@interface OrdersViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *emtyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstraint;

- (IBAction)actionSegmentedControl:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *ordersTableView;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property(nonatomic,assign)BOOL isCurentOrders;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
