//
//  IMProducts.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 18/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
@interface IMProducts : UIViewController
{
    NSMutableArray * products;
}
@property (strong, nonatomic) IBOutlet UIButton *ALphaPL;
@property (strong, nonatomic) IBOutlet UIButton *UnrestrictedPL;
@property (strong, nonatomic) IBOutlet UIButton *RestrictedPL;
@property (strong, nonatomic) IBOutlet UIButton *drinksPL;
@property (strong, nonatomic) IBOutlet UIButton *entreesPL;
@property (strong, nonatomic) IBOutlet UIButton *barsPl;
@property (strong, nonatomic) IBOutlet UIButton *puddingsPL;
@property (strong, nonatomic) IBOutlet UIButton *chipsPL;
@property (strong, nonatomic) IBOutlet UIButton *puffsPL;

@end
