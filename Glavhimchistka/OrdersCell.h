//
//  OrdersCell.h
//  Glavhimchistka
//
//  Created by Admin on 21.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *paidPriceLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet UITableView *servicesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDownImageView;

@property (weak, nonatomic) IBOutlet UILabel *sklad_nameAndAdr;
@property (weak, nonatomic) IBOutlet UILabel *date2;
@property (weak, nonatomic) IBOutlet UILabel *paidPrice;
@property (weak, nonatomic) IBOutlet UILabel *date1Label;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;

@end
