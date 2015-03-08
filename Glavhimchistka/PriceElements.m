//
//  PriceElements.m
//  Glavhimchistka
//
//  Created by Admin on 07.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "PriceElements.h"

@implementation PriceElements
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    
    return YES;
    
}
-(id) copyWithZone: (NSZone *) zone
{
    PriceElements *priceElementsCopy = [[PriceElements allocWithZone: zone] init];
    
    priceElementsCopy.code=[self.code copy];
    priceElementsCopy.name=[self.name copy];
    priceElementsCopy.unit=[self.unit copy];
    priceElementsCopy.price=[self.price copy];
    priceElementsCopy.group_p=[self.group_p copy];
    priceElementsCopy.group_c=[self.group_c copy];
    
    priceElementsCopy.price_id=[self.price_id copy];
    priceElementsCopy.top_parent=[self.top_parent copy];
    priceElementsCopy.order_addon_pack_id=[self.order_addon_pack_id copy];
    
    return priceElementsCopy;
}
@end
