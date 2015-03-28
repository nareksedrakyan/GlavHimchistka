//
//  ResponseGetContactsList.h
//  Glavhimchistka
//
//  Created by Admin on 28.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "ContactsListElements.h"
#import "JSONModel.h"

@interface ResponseGetContactsList : JSONModel

@property(strong,nonatomic)NSString*error;
@property(strong,nonatomic)NSString*Msg;
@property(strong,nonatomic)NSMutableArray<ContactsListElements>*list;

@end
