//
//  IMrecipieList.h
//  IdealMeals
//
//  Created by Samar's Mac Mini on 08/02/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewcontroller.h"
#import "Flurry.h"

@interface IMrecipieList : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITabBarControllerDelegate>
{
    UIButton *backButton;
    UIButton *checkButton;
    UILabel * nameLabel;
    UITableView *recipeTable;
    NSString *name;
   // UIImageView *productImage;
    UILabel *productName;
    int buttonTag;
    BOOL tabbarItem;
    NSArray *allNames;
    NSArray *allImages;
    
    UISearchBar *searchBar;
    
    NSArray *phase1Names;
    NSArray *phase1Images;
    
    NSArray *phase3Names;
    NSArray *phase3Images;
    
    NSArray *healthNames;
    NSArray *healthImages;
    
    //DetailViewcontroller *dvController;
   // IMrecipieList *rvController;
    UIButton *forwardButton;
    
    
    NSMutableArray *copyRecipies;
     NSMutableArray *copyImages;
     NSMutableArray *count;
    
    int o;
    
    int cellNo;
    BOOL searching;
    BOOL letUserSelectRow;
}
@property(retain,nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;



@end
