//
//  OrdersElements.h
//  Glavhimchistka
//
//  Created by Admin on 21.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol OrdersElements @end

#import "JSONModel.h"

@interface OrdersElements : JSONModel

@property(nonatomic,strong)NSString*dor_id;
@property(nonatomic,strong)NSString*doc_num;
@property(nonatomic,strong)NSString*kredit;
@property(nonatomic,strong)NSString*debet;
@property(nonatomic,strong)NSString*doc_date;
@property(nonatomic,strong)NSString*date_out;
@property(nonatomic,strong)NSString*status;
@property(nonatomic,strong)NSString*photo_exist;
@property(nonatomic,strong)NSString*discount;
@property(nonatomic,strong)NSString*sclad_name;
@property(nonatomic,strong)NSString*sclad_adr;
@property(nonatomic,strong)NSString*sclad_hours;

@end
