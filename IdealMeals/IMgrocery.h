//
//  IMSecondViewController.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 17/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import <MessageUI/MessageUI.h>
#import "Flurry.h"
#import "IMProductList.h"
@interface IMgrocery : UIViewController<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,UITextViewDelegate,UITabBarControllerDelegate>
{
    
    BOOL tabbarItem;
    UITableView *listTable;
    UIButton  *checkbox;
    IBOutlet UIView *menuView;
    sqlite3 *db;
    UIImageView *fadeScreen;
    int i;
   // int j;
    UIButton *fullButton;
    UIImageView *frame;
    NSMutableArray *done;
    NSMutableArray *doneQty;
    NSMutableArray *doneNo;
    
    NSMutableArray *vegetarian;
    NSMutableArray *vegetarianqty;
     NSMutableArray *vegetarianNo;
    
    NSMutableArray *deli;
    NSMutableArray *deliqty;
     NSMutableArray *deliNo;
    
    NSMutableArray *seasoning;
    NSMutableArray *seasoningqty;
    NSMutableArray *seasoningNo;
    
    NSMutableArray *produce;
    NSMutableArray *produceqty;
    NSMutableArray *produceNo;
    
    NSMutableArray *baking;
    NSMutableArray *bakingqty;
     NSMutableArray *bakingNo;
    
    NSMutableArray *iwm;
    NSMutableArray *iwmqty;
     NSMutableArray *iwmNo;
    
    NSMutableArray *dairy;
    NSMutableArray *dairyqty;
    NSMutableArray *dairyNo;
    
    NSMutableArray *protein;
    NSMutableArray *proteinqty;
    NSMutableArray *proteinNo;
    
    NSMutableArray *grains;
    NSMutableArray *grainsqty;
     NSMutableArray *grainsNo;
    
    NSMutableArray *toppings;
    NSMutableArray *toppingsqty;
    NSMutableArray *toppingsNo;
    
    NSMutableArray *meat;
    NSMutableArray *meatqty;
    NSMutableArray *meatNo;
    
    NSMutableArray *ethnic;
    NSMutableArray *ethnicqty;
    NSMutableArray *ethnicNo;
    
    NSMutableArray *nuts;
    NSMutableArray *nutsqty;
     NSMutableArray *nutsNo;
    
    NSMutableArray *sauces;
    NSMutableArray *saucesqty;
     NSMutableArray *saucesNo;
    
    NSMutableArray *seafood;
    NSMutableArray *seafoodqty;
     NSMutableArray *seafoodNo;
    
    NSMutableArray *condimentsqty;
    NSMutableArray *condiments;
    NSMutableArray *condimentsNo;
    
    NSMutableArray *freezer;
    NSMutableArray *freezerqty;
    NSMutableArray *freezerNo;
    
    NSMutableArray *health;
    NSMutableArray *healthqty;
    NSMutableArray *healthNo;
    
    NSMutableArray *water;
    NSMutableArray *waterqty;
    NSMutableArray *waterNo;
    
    NSMutableArray *tea;
    NSMutableArray *teaqty;
    NSMutableArray *teaNo;
    
    
    NSMutableArray *waldenfarms;
    NSMutableArray *waldenfarmsqty;
     NSMutableArray *waldenfarmsNo;
    
    NSMutableArray *canned;
    NSMutableArray *cannedqty;
    NSMutableArray *cannedNo;
    
    
    NSMutableArray *other;
    NSMutableArray *otherqty;
     NSMutableArray *otherNo;
    
    NSMutableArray *breakfast;
    NSMutableArray *breakfastqty;
    NSMutableArray *breakfastNo;
    
    NSMutableArray *dressing;
    NSMutableArray *dressingqty;
    NSMutableArray *dressingNo;
    
    NSMutableArray *frozen;
    NSMutableArray *frozenqty;
     NSMutableArray *frozenNo;
    
    
    NSMutableArray *pasta;
    NSMutableArray *pastaqty;
    NSMutableArray *pastaNo;
    
    NSMutableArray *broth;
    NSMutableArray *brothqty;
    NSMutableArray *brothNo;
    
    NSMutableArray *nameArray;
    UIImageView *bigImage;
    
    NSMutableArray *products;
    NSMutableArray *productsQty;
    NSMutableArray *productsNo;
   
    
    NSMutableArray *allArray;
    NSMutableArray *allArrayNo;
    NSMutableArray *allQuantityArray;
    UITextView *compare;
    UITextView *compareQty;
    
    NSMutableArray *array;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *sectionArray;
    
    NSMutableDictionary *arrayDictionary1;
    NSMutableDictionary *arrayDictionary2;
    NSMutableDictionary *arrayDictionary3;
    NSMutableDictionary *arrayDictionary4;
    NSMutableDictionary *arrayDictionary5;
    NSMutableDictionary *arrayDictionary6;
    NSMutableDictionary *arrayDictionary7;
    NSMutableDictionary *arrayDictionary8;
    NSMutableDictionary *arrayDictionary9;
    NSMutableDictionary *arrayDictionary10;
    NSMutableDictionary *arrayDictionary11;
    NSMutableDictionary *arrayDictionary12;
    NSMutableDictionary *arrayDictionary13;
    NSMutableDictionary *arrayDictionary14;
    NSMutableDictionary *arrayDictionary15;
    NSMutableDictionary *arrayDictionary16;
    NSMutableDictionary *arrayDictionary17;
    NSMutableDictionary *arrayDictionary18;
    NSMutableDictionary *arrayDictionary19;
    NSMutableDictionary *arrayDictionary20;
    NSMutableDictionary *arrayDictionary21;
    NSMutableDictionary *arrayDictionary22;
    NSMutableDictionary *arrayDictionary23;
    NSMutableDictionary *arrayDictionary24;
    NSMutableDictionary *arrayDictionary25;
    NSMutableDictionary *arrayDictionary26;
    NSMutableDictionary *arrayDictionary27;
    NSMutableDictionary *arrayDictionary28;
    NSMutableDictionary *doneDictionary;
    
    UIButton *checkbutton;
    UIButton *checkButtonDone;
    UIButton *saveButton;
    UIButton *backButton;
    NSMutableArray *productArray;
    NSMutableArray *quantityArray;
    
    UILabel *productName;
    UILabel *productQty;
    UILabel *nameOfIngridient;
    UILabel *ingridientQuantity;
    
    NSTimer *labeltimer;
    NSTimer *labeltimer2;
      NSTimer *labeltimer3;
    UIImageView *base;
    
    NSString *emailBody;
        int x;
    NSMutableArray *emailArray;
    UIImageView *clearImage;
    UIButton *clearYes;
    UIButton *clearNo;
    
}
@property (strong, nonatomic) IBOutlet UIButton *emailButtonGrocery;
@property (strong, nonatomic) IBOutlet UIButton  *fullButton;;
@property (strong, nonatomic) IBOutlet UIButton *clearButtonGrocery;
@property (strong, nonatomic) IBOutlet UIButton *addButtonGrocery;
@property(nonatomic,retain)  UILabel *nameOfIngridient;
@property(nonatomic,retain)   UIButton  *checkbox;
@property(nonatomic,retain)  UIView *menuView;
@property(nonatomic,retain) UILabel *ingridientQuantity;
@property(nonatomic,retain)UIButton *saveButton;
@property(nonatomic,retain) NSMutableArray *Bool;

@end
