//
//  PriceListViewController.h
//  Glavhimchistka
//
//  Created by Admin on 08.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"
#import "PriceListObject.h"
#import "PriceElements.h"
@interface PriceListViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *priceListTableView;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property(nonatomic,strong)NSMutableArray<PriceElements>*myArray;

@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)PriceListObject*priceListObject;
@property(nonatomic,strong)NSMutableArray<PriceListObject>*objectArray;
@end
