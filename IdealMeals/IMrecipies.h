//
//  IMrecipies.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 18/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "IMProductList.h"
@interface IMrecipies : UIViewController<UITabBarControllerDelegate>
{
    int cellNo;
}
@property (strong, nonatomic) IBOutlet UIButton *allRecipies;
@property (strong, nonatomic) IBOutlet UIButton *phase1Recipies;
@property (strong, nonatomic) IBOutlet UIButton *phase3Recipies;
@property (strong, nonatomic) IBOutlet UIButton *healthRecipies;

@end
