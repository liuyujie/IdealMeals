//
//  IMFirstViewController.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 17/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "IMpicker.h"
//#import "IMdayview.h"
#import "sqlite3.h"
#import "Flurry.h"
#import <MessageUI/MessageUI.h>

@interface IMmeals : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,MFMailComposeViewControllerDelegate,UIGestureRecognizerDelegate,UITabBarControllerDelegate>
{
    sqlite3 *db;
   
    BOOL tabBarItem;
    UIImageView *fadeScreen;
    
    IBOutlet UIView *calView;
	IBOutlet UILabel *monthTitle;
    IBOutlet UIButton *left;
    IBOutlet UIButton *right;
	IBOutlet UIView *bottomViewRight;
    IBOutlet UIView *bottomView;
    UIImageView *dayImageView;
    NSString *dateString;
    NSString *string ;
    NSMutableArray *dayArray;
    UIImageView *imageMeal;
    UIImageView *monthImage;
    UIPickerView *cityPicker;
    UIImageView *selection;
   // IMdayview *newView;
    UIButton *monthButton;
    UIButton *mailButton;
    UILabel *dateLabel;
    UIButton *addAMeal;
    UIButton *doneButton;
    
    UIButton *selectADate;
     UIButton *selectAMeal;
     UIButton *selfAdd;
     UIButton *selectFromRecipies;
     UIButton *selectFromProducts;
     UIButton *pickerBackButton;
    
     UIImageView *inputAccView;
    
    UILabel *datePickerLabel;
    UILabel *mealPicker;
    
    IBOutlet UIButton *accessory1;
   IBOutlet UIButton *deleteButton1;
    
    IBOutlet UIButton *accessory2;
    IBOutlet UIButton *deleteButton2;
    
    IBOutlet UIButton *accessory3;
    IBOutlet UIButton *deleteButton3;
    
    IBOutlet UIButton *accessory4;
    IBOutlet UIButton *deleteButton4;
    
    
    UIButton *removeDelete1;
    UIButton *removeDelete2;
    UIButton *removeDelete3;
    UIButton *removeDelete4;
    

    
    UILabel *breakfastLabel;
    UILabel *lunchLabel;
    UILabel *dinnerLabel;
    UILabel *otherLabel;
    UIImageView *breakfastImage;
    UIImageView *lunchImage;
    UIImageView *dinnerImage;
    UIImageView *otherImage;
    
    NSString *dateForDatabase;
     NSString *dateForPicker;
    
    
    UITextView *compare;
    
    UIImageView *base;
    UIImageView *pickerBase;
    
    UIButton *saveButton;
    UIButton *backButton;
    
    NSString *breakfastString;
    NSString *lunchString;
    NSString *dinnerString;
    NSString *otherString;
    
    
    NSMutableArray *emailArray;
      NSMutableArray *tagArray;
    
    NSArray *meals;
    
    UISwipeGestureRecognizer *LeftGesturesRecognizer;
     UISwipeGestureRecognizer *LeftGesturesRecognizer1;
     UISwipeGestureRecognizer *LeftGesturesRecognizer2;
     UISwipeGestureRecognizer *LeftGesturesRecognizer3;
    
    
    UIImageView *savePopUp;
    UIButton *clearNo;
    UIButton *clearYes;
    IBOutlet UIDatePicker *datePicker;
    
    
@private
	NSCalendar *calendar;
	NSDate *currentDate;
	NSDate *today;

}
@property(strong,nonatomic)UIButton *left;
@property(nonatomic,retain) UIDatePicker *datePicker;
@property(nonatomic) CGAffineTransform transform;  
@property(nonatomic,retain)UIButton *accessory1;
@property(nonatomic,retain) UIButton *deleteButton1;
@property(nonatomic,retain) UIButton *mailButton;

@property(nonatomic,retain)UIButton *accessory2;
@property(nonatomic,retain) UIButton *deleteButton2;

@property(nonatomic,retain)UIButton *accessory3;
@property(nonatomic,retain) UIButton *deleteButton3;

@property(nonatomic,retain)UIButton *accessory4;
@property(nonatomic,retain) UIButton *deleteButton4;

@property(retain,nonatomic)UIView *calView;
@property(retain,nonatomic)UIView *bottomView;
@property(retain,nonatomic)UIView *bottomViewLeft;
@property(retain,nonatomic)UILabel *monthTitle;
@property(strong,nonatomic)UIButton *saveButton;
@property(strong,nonatomic)UIButton *right;
@property(strong,nonatomic)UIButton *monthButton;
@property(retain,nonatomic)NSDate *currentDate;
@property(retain,nonatomic) UILabel *dateLabel;
@property(retain,nonatomic) UIButton *addAMeal;
- (IBAction)nextMonth:(id)action;
- (IBAction)prevMonth:(id)action;

- (void)fillCalendar;
- (void)currentDateHasChanged;
- (void)reloadCalendar;

- (UIButton*)createBtn:(int)day orgx:(CGFloat)orgx orgy:(CGFloat)orgy;
- (UIColor*)getColorByRed:(float)r green:(float)g blue:(float)b;
@end
