//
//  floatTableViewCell.m
//  floatingButtonTrial
//
//  Created by Giridhar on 26/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import "FloatTableCell.h"

@implementation FloatTableCell
@synthesize imgView, title,overlay;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(180, 10, 45, 45)];
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        self.title=[[UITextField alloc]initWithFrame:CGRectMake(60, 20, 110, 25)];
        self.title.borderStyle = UITextBorderStyleRoundedRect;
        self.title.autocorrectionType = UITextAutocorrectionTypeNo;
        self.title.keyboardType = UIKeyboardTypeDefault;
        self.title.returnKeyType = UIReturnKeyDone;
        self.title.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.title.delegate=self;

        self.imgView.userInteractionEnabled=YES;
        overlay = [UIView new];
        overlay.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [title addSubview:overlay];
        self.imgView.layer.cornerRadius = self.imgView.frame.size.height/2;
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.borderWidth=0;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclickedImage)];
        singleTap.numberOfTapsRequired = 1;
        [self.imgView setUserInteractionEnabled:YES];
        [self.imgView addGestureRecognizer:singleTap];

        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.title];
        self.contentView.transform = CGAffineTransformMakeRotation(-M_PI);
       
        
    }
    return self;
}

#pragma mark - Custom Methods

-(void) setPlaceHolderValue:(NSString *)value
{
    self.title.placeholder=value;
}

#pragma mark - TextFields Delegate

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    [self endEditing:YES];
    textField.text=@"";
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.delegate onopenkeyboard:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

    [self.delegate onclosekeyboard:textField];
}

#pragma mark - Custom Delegates

-(void)onclickedImage{

    [self endEditing:YES];
    [self.imgView.layer setBackgroundColor:[UIColor blackColor].CGColor];
    [self.imgView.layer setOpacity:0.4];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC/4), dispatch_get_main_queue(), ^{
         [self.imgView.layer setBackgroundColor:[UIColor clearColor].CGColor];
        [self.imgView.layer setOpacity:1];

              [self.delegate onclicksubmited:self.title];
        self.title.text=@"";
    });

    
}

@end
