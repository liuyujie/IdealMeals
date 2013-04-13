//
//  IMProductList.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 25/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h" 
#import "Flurry.h"
@interface IMProductList : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITabBarControllerDelegate,UIAlertViewDelegate>
{
   IBOutlet UIScrollView *scrollview;

     sqlite3 *db;
    
    BOOL tabBarItem;
    
    UIImageView *productImage;
    UILabel *productName;

    NSString *matchString;
    NSString *puffs;

    NSDate *today;
    UITableView *listTable;
   
      NSMutableArray *Bool;

    UIButton *checkButton;
    
    
    NSArray *puffsNames;
    NSArray *puffsImages;
    
    NSArray *chipsNames;
    NSArray *chipsImages;
    
    NSArray *puddingsNames;
    NSArray *puddingsImages;
    
    NSArray *barsNames;
    NSArray *barsImages;
    
    NSArray *entreesNames;
    NSArray *entreesImages;
    
    NSArray *drinksNames;
    NSArray *drinksImages;
    
    NSArray *restrictedNames;
    NSArray *restrictedImages;
    
    NSArray *unrestrictedNames;
    NSArray *unrestrictedImages;
    
    NSArray *alphabeticalNames;
    NSArray *alphabeticalImages;
    
    NSMutableArray *products;

    NSInteger cellNo;
    
    
    UIImageView *selection;
    UIButton *selectADate;
    UIButton *selectAMeal;
    UIButton * pickerBackButton;
    UILabel *datePickerLabel;
    UILabel *mealPicker;
    UIImageView *inputAccView;
    UIImageView *pickerBase;
    UIButton *doneButton;
    UIDatePicker *datePicker;
    NSArray *meals;
    UIPickerView *cityPicker;
    
    
    UIButton *addtoDB;
    
    UIButton *forwardButton;
    
}
@property(strong,nonatomic) UILabel *datePickerLabel;
@property(strong,nonatomic)UILabel *mealPicker;
@property(strong,nonatomic)UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *addToMeal;
@property(strong,nonatomic)UIButton *button2;
@property (strong,nonatomic)    NSMutableArray *products;

@end
