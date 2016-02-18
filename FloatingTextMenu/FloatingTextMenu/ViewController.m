//
//  ViewController.m
//  FloatingTextMenu
//
//  Created by Vaghula krishnan on 17/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initViewElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Custom Methods

-(void) initViewElements{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.title=@"Floating Fields";
    CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, [UIScreen mainScreen].bounds.size.height -60, 44, 44);
    
    VKFloatingActionText *floatButton = [[VKFloatingActionText alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus"] andPressedImage:[UIImage imageNamed:@"cross"] andBlurType:Dark];
    floatButton.delegate=self;
    floatButton.menuButttonImages = @[@"fb-icon",@"twitter-icon",@"google-icon",@"linkedin-icon"];
    floatButton.menuTextFieldDesc = @[@"Facebook",@"Twitter",@"Google Plus",@"Linked in"];
    
    [self.view addSubview:floatButton];
    
}

#pragma mark - Delegate Methods

-(void)didClickOnMenuAtIndex:(NSInteger)index andValue:(NSString *)value
{
    if(value.length>0){
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.label.text = [NSString stringWithFormat:@"index %ld with value %@",index,value];
    hud.tintColor=[UIColor blackColor];
    hud.margin = 10.f;
    hud.yOffset =self.view.frame.size.height-30;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:3];
    }
}

@end
