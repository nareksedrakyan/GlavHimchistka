//
//  AddressView.h
//  Glavhimchistka
//
//  Created by Admin on 12.04.15.
//  Copyright (c) 2015 NSedrakyan. All rights reserved.
//
@protocol AddressViewDelegate

- (void)okAction;
//- (void)cancelAction;

@end

#import <UIKit/UIKit.h>

@interface AddressView : UIView
- (IBAction)okAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;



@property(nonatomic,weak)id<AddressViewDelegate>delegate;

@end
