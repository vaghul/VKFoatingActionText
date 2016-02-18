//
//  VCFloatingActionButton.m
//  starttrial
//
//  Created by Giridhar on 25/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import "VKFloatingActionText.h"
#import "FloatTableCell.h"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height
#define KEYBOARD_ANIMATION_DURATION  0.3
#define MINIMUM_SCROLL_FRACTION 0.2
#define MAXIMUM_SCROLL_FRACTION  0.8
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT  162

CGFloat animationTime = 0.55;
CGFloat rowHeight = 60.f;
NSInteger noOfRows = 0;
NSInteger tappedRow;
CGFloat previousOffset;
CGFloat buttonToScreenHeight;

CGFloat animatedDistance;

@implementation VKFloatingActionText


@synthesize windowView;


-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)passiveImage andPressedImage:(UIImage*)activeImage andBlurType:(BlurType)type
{
    self = [super initWithFrame:frame];
    if (self)
    {
        windowView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _mainWindow = [UIApplication sharedApplication].keyWindow;
        _buttonView = [[UIView alloc]initWithFrame:frame];
        _buttonView.backgroundColor = [UIColor clearColor];
        _buttonView.userInteractionEnabled = YES;

        buttonToScreenHeight = SCREEN_HEIGHT - CGRectGetMaxY(self.frame);
        
        _menuTable = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, 0.75*SCREEN_WIDTH,SCREEN_HEIGHT - (SCREEN_HEIGHT - CGRectGetMaxY(self.frame)) )];
        _menuTable.scrollEnabled = NO;
        
        
        _menuTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, CGRectGetHeight(frame))];
        
        _menuTable.delegate = self;
        _menuTable.dataSource = self;
        _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTable.backgroundColor = [UIColor clearColor];
        _menuTable.transform = CGAffineTransformMakeRotation(-M_PI); //Rotate the table
        _pressedImage = activeImage;
        _normalImage = passiveImage;
        [self setupButton:type];
        
    }
    return self;
}

#pragma  mark - Custom Methods

-(UIBlurEffect *) setBlurEffectWithType:(BlurType)type
{
    UIBlurEffect *blreffect;
    switch (type) {
        case ExtraLight:
            blreffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            break;
        case Light:
            blreffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            break;
        default:
            blreffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            break;
            
    }
    return blreffect;
}
-(void) setupButton:(BlurType)type
{
    _isMenuVisible = false;
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:buttonTap];
    
    
    UITapGestureRecognizer *buttonTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    
    [_buttonView addGestureRecognizer:buttonTap3];
    
    
    UIBlurEffect *blur = [self setBlurEffectWithType:type];
    UIVisualEffectView *vsview = [[UIVisualEffectView alloc]initWithEffect:blur];
    

    _bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    _bgView.alpha = 0;
    _bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *buttonTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];

    buttonTap2.cancelsTouchesInView = YES;
    vsview.frame = _bgView.bounds;
    _bgView = vsview;
    [_bgView addGestureRecognizer:buttonTap2];
    
    
    _normalImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _normalImageView.userInteractionEnabled = YES;
    _normalImageView.contentMode = UIViewContentModeScaleAspectFit;
    _normalImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _normalImageView.layer.shadowRadius = 5.f;
    _normalImageView.layer.shadowOffset = CGSizeMake(-10, -10);


    
    _pressedImageView  = [[UIImageView alloc]initWithFrame:self.bounds];
    _pressedImageView.contentMode = UIViewContentModeScaleAspectFit;
    _pressedImageView.userInteractionEnabled = YES;
    
    
    _normalImageView.image = _normalImage;
    _pressedImageView.image = _pressedImage;
    
    
    [_bgView addSubview:_menuTable];
    
    [_buttonView addSubview:_pressedImageView];
    [_buttonView addSubview:_normalImageView];
    [self addSubview:_normalImageView];

}

-(void)handleTap:(id)sender //Show Menu
{
    if (_isMenuVisible)
    {
        
     [self dismissMenu:nil];
    }
    else
    {
        [windowView addSubview:_bgView];
        [windowView addSubview:_buttonView];
        [_mainWindow addSubview:windowView];
        [self showMenu:nil];
    }
    _isMenuVisible  = !_isMenuVisible;
    
    
}




#pragma mark - ButtonTap Animation Show

-(void) showMenu:(id)sender
{
    
    self.pressedImageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.pressedImageView.alpha = 0.0; //0.3
    [UIView animateWithDuration:animationTime/2 animations:^
     {
         self.bgView.alpha = 1;
         
        
         self.normalImageView.transform = CGAffineTransformMakeRotation(-M_PI);
         self.normalImageView.alpha = 0.0; //0.7

         
         self.pressedImageView.transform = CGAffineTransformIdentity;
         self.pressedImageView.alpha = 1;
         noOfRows = _menuButttonImages.count;
         [_menuTable reloadData];

     }
         completion:^(BOOL finished)
     {
     }];

}

#pragma mark - ButtonTap Animation Dismiss

-(void) dismissMenu:(id) sender

{
    [UIView animateWithDuration:animationTime/2 animations:^
     {
         self.bgView.alpha = 0;
         self.pressedImageView.alpha = 0.f;
         self.pressedImageView.transform = CGAffineTransformMakeRotation(-M_PI);
         self.normalImageView.transform = CGAffineTransformMakeRotation(0);
         self.normalImageView.alpha = 1.f;
     } completion:^(BOOL finished)
     {
         noOfRows = 0;
         [_bgView removeFromSuperview];
         [windowView removeFromSuperview];
         [_mainWindow removeFromSuperview];
         
     }];
}




#pragma mark - Tableview Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return noOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"VKCell";
   FloatTableCell *cell = [_menuTable dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
         cell = [[NSClassFromString(@"FloatTableCell")alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate=self;
    }
    
    cell.imgView.image=[UIImage imageNamed:[_menuButttonImages objectAtIndex:indexPath.row]];
    cell.title.tag=indexPath.row;
    [cell setPlaceHolderValue:[_menuTextFieldDesc objectAtIndex:indexPath.row]];
    return cell;
    
}


#pragma mark - Custom Delegates

-(void)onopenkeyboard:(UITextField *)textField{
    
    CGRect textFieldRect =
    [self.window convertRect:textField.bounds fromView:self.menuTable];
    CGRect viewRect =
    [self.window convertRect:self.bounds fromView:textField];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =midline - viewRect.origin.y- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
   {
       heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.menuTable.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.menuTable setFrame:viewFrame];
    
    [UIView commitAnimations];

}

-(void)onclosekeyboard:(UITextField *)textField{
    
    CGRect viewFrame = self.menuTable.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.menuTable setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(void) onclicksubmited:(UITextField *)textfield
{
    [self handleTap:nil];
    [self.delegate didClickOnMenuAtIndex:textfield.tag andValue:textfield.text];
}

@end
