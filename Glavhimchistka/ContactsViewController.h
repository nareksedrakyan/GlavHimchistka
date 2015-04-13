//
//  ContactsViewController.h
//  Glavhimchistka
//
//  Created by Admin on 28.03.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ContactsViewController :BaseViewController <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControll;
@property (weak, nonatomic) IBOutlet UIView *buttonsView;

- (IBAction)ActionSegmentedControl:(UISegmentedControl *)sender;

@property (weak, nonatomic) IBOutlet UITableView *contacsTableView;
@property (strong, nonatomic) GMSMapView *mapView;

@end