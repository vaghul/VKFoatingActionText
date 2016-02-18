//
//  VCFloatingActionButton.h
//  starttrial
//
//  Created by Giridhar on 25/03/15.
//  Copyright (c) 2015 Giridhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatTableCell.h"

@class VKFloatingActionButtonClass;

@protocol VKFloatingTextFieldDelegate

@required
-(void)didClickOnMenuAtIndex:(NSInteger)index andValue:(NSString*)value;

@end

typedef enum {
    Dark,
    Light,
    ExtraLight
} BlurType;


@interface VKFloatingActionText : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,FloatTableCellClassDelegate>

@property NSArray      *menuButttonImages,*menuTextFieldDesc;
@property UITableView  *menuTable;
@property UIView       *buttonView;
@property BOOL isMenuVisible;
@property UIView *windowView;

@property (nonatomic, assign) id<VKFloatingTextFieldDelegate> delegate;
@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) UIImageView *normalImageView,*pressedImageView;
@property (strong,nonatomic) UIWindow *mainWindow;
@property (strong,nonatomic) UIImage *pressedImage, *normalImage;
@property (strong,nonatomic) NSDictionary *menuItemSet;


-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)passiveImage andPressedImage:(UIImage*)activeImage andBlurType:(BlurType) type;


@end
