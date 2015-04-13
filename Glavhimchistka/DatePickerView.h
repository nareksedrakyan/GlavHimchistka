//
//  DatePickerView.h
//  Glavhimchistka
//
//  Created by Admin on 13.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol DatePickerViewDelegate

- (void)actionOK2;

//- (void)actionCancel2;

@end
#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;
- (IBAction)actionOK2:(UIButton *)sender;

- (IBAction)actionCancel2:(UIButton *)sender;

@property(nonatomic,weak)id<DatePickerViewDelegate>delegate;
@end
