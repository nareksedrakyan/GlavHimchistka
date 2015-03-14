//
//  GetUserInformation.h
//  Glavhimchistka
//
//  Created by Admin on 14.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "JSONModel.h"

@interface GetUserInformation : JSONModel

@property(nonatomic,strong)NSString*error;
@property(nonatomic,strong)NSString*Msg;
@property(nonatomic,strong)NSString*contr_id;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*fone;
@property(nonatomic,strong)NSString*fone_cell;
@property(nonatomic,strong)NSString*email;
@property(nonatomic,strong)NSString*agree_to_receive_sms;
@property(nonatomic,strong)NSString*agree_to_receive_adv_sms;
@property(nonatomic,strong)NSString*address;

@property(nonatomic,strong)NSString*barcode;
@property(nonatomic,strong)NSString*discount;
@property(nonatomic,strong)NSString*registered;
@property(nonatomic,strong)NSString*save_token_pay;
@property(nonatomic,strong)NSString*is_confirmed_email;
@property(nonatomic,strong)NSString*order_not_pay;
@property(nonatomic,strong)NSString*order_count;

@end
