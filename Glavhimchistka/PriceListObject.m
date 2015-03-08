//
//  PriceListObject.m
//  Glavhimchistka
//
//  Created by Admin on 08.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "PriceListObject.h"

@implementation PriceListObject
-(id) copyWithZone: (NSZone *) zone
{
    PriceListObject *priceListObjectcopy = [[PriceListObject allocWithZone: zone] init];
    
   
    
    priceListObjectcopy.name=[self.name copy];
    priceListObjectcopy.price=[self.price copy];
    priceListObjectcopy.unit=[self.unit copy];
    
    return priceListObjectcopy;
}
@end
