//
//  IMrecipieDescription.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 08/02/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Flurry.h"
@interface IMrecipieDescription : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITabBarControllerDelegate,UIAlertViewDelegate>
{
    UILabel *recipieName;
    NSString *name;
    int buttonTag;
    UILabel *nameLabel;
    UIScrollView *descriptionScroll;
    NSArray *nameArray;
    UIImageView *productImage;
    NSArray *quantityArray;
    NSMutableArray *ingrdArray;
    NSArray *instrArray;
    NSArray *groceryArray;
    
    NSString *type;
    
    sqlite3 *db;
   
    BOOL tabbarItem;
    
    NSDate *today;
    NSMutableDictionary *dictionaryRecipie;

    
    NSMutableArray *quantity;
    NSMutableArray *quantityName;
    
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
    


}

@end
