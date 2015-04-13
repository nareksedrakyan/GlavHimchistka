//
//  DepartureViewController.h
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
#import "DepartureView.h"
#import "AddressView.h"
#import "DatePickerView.h"
#import "BaseViewController.h"

@interface DepartureViewController : BaseViewController<DepartureViewDelegate,AddressViewDelegate,DatePickerViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
