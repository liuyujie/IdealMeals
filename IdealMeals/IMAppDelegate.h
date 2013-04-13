//
//  IMAppDelegate.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 17/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMgrocery.h"
#import "IMrecipies.h"
#import "IMhome.h"
#import "IMProducts.h"
#import "IMmeals.h"
//#import "IMFirstViewController.h"
@interface IMAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabController;
@property(strong,nonatomic)IMhome *VChome;
@end
