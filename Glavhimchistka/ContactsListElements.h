//
//  ContactsListElements.h
//  Glavhimchistka
//
//  Created by Admin on 28.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol ContactsListElements @end

#import "JSONModel.h"

@interface ContactsListElements : JSONModel

@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*working_hours;
@property(nonatomic,strong,getter=getAddress)NSString*address;

@end
