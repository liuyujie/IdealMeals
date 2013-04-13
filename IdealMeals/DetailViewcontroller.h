//
//  DetailViewcontroller.h
//  NewApp
//
//  Created by Inext Sol on 30/11/12.
//  Copyright 2012 stsemadmin@inextsoluons.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMrecipieList.h"

@class IMrecipieList;

@interface DetailViewcontroller : UIViewController
{
    IMrecipieList *rvController;
}
@property (nonatomic, retain) IMrecipieList *rvController;

@end
