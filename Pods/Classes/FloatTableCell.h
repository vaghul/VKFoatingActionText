//
//  floatTableViewCell.h
//  floatingButtonTrial
//
//  Created by Giridhar on 26/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FloatTableCellClass;

// define the protocol for the delegate
@protocol FloatTableCellClassDelegate

// define protocol functions that can be used in any class using this delegate
-(void)onopenkeyboard:(UITextField *)textfield;
-(void)onclosekeyboard:(UITextField *)textfield;
-(void)onclicksubmited:(UITextField*)textfield;
@end

@interface FloatTableCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, assign) id<FloatTableCellClassDelegate> delegate;
@property (strong, nonatomic)  UIImageView *imgView;
@property (strong, nonatomic)  UITextField *title;
@property (strong,nonatomic) UIView *overlay;
-(void)setPlaceHolderValue:(NSString *)value;
@end
