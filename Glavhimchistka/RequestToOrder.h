//
//  RequestToOrder.h
//  Glavhimchistka
//
//  Created by Admin on 15.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface RequestToOrder : JSONModel

@property(nonatomic,strong)NSString*date;
@property(nonatomic,strong)NSString*hr;
@property(nonatomic,strong)NSString*address;
@property(nonatomic,strong)NSString*region_id;

@end
