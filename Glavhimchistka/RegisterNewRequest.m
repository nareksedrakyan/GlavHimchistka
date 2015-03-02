//
//  RegisterNewRequest.m
//  Glavhimchistka
//
//  Created by Admin on 27.02.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "RegisterNewRequest.h"

@implementation RegisterNewRequest
-(instancetype)init
{
    self=[super init];
    if (self)
    {
        self.Source=@"IOS";
        self.fone=@"";
        self.mail=@"";
        self.change_name=@"";
        self.city=@"";
        self.street=@"";
        self.house=@"";
        self.housing=@"";
        self.room=@"";
        self.office=@"";
        self.comment=@"";
        self.promocode=@"";
        self.working_address=@"";
    }
    return self;
}
@end
