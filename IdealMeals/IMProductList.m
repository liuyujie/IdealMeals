//
//  IMProductList.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 25/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMProductList.h"
#import "SVProgressHUD.h"
//#import "IMProducts.h"
@interface IMProductList ()

@end

@implementation IMProductList
@synthesize button2,button1,mealPicker,datePickerLabel,addToMeal,products;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString *)filePath{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    return[[paths objectAtIndex:0]stringByAppendingPathComponent:@"idealmeals.sql"];
    
}



-(void) openDB{
    if (sqlite3_open([[self filePath] UTF8String], &db)!= SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database Failed to Open");
        
    }else{
        //NSLog(@"Database Opened");
    }
}
-(void)createTable2:(NSString *)tableName

         withField1:(NSString *)date
         withField2:(NSString *)breakfast
         withField3:(NSString *)lunch
         withField4:(NSString *)dinner
         withField5:(NSString *)other{
    
    
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@'TEXT  PRIMARY KEY ,'%@' TEXT,'%@' TEXT ,'%@' TEXT,'%@' TEXT); ",tableName,date,breakfast,lunch,dinner,other];
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"could not create table");
        
    }else{
        //  NSLog(@"table created");
        
    }
    
}
-(void)showActivityIndicater
{
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
      [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
  
}

-(void)hideActivityIndicater
{
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated
{    [self.tabBarController setDelegate:self];
    NSArray *myArray=[[NSArray alloc]init];
    products=[[NSMutableArray alloc]init];
    myArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"productArray"];
   // NSLog(@"%@",myArray);
    products=[NSMutableArray arrayWithArray:myArray];
    //NSLog(@"%@",products);
    addToMeal.enabled=NO;
}
- (void)viewDidLoad
{
    today=[[NSDate alloc]initWithTimeIntervalSinceNow:1];
    
    [self showActivityIndicater];
    NSArray *myArray=[[NSArray alloc]init];
    products=[[NSMutableArray alloc]init];
    
    myArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"productArray"];
   // NSLog(@"%@",myArray);
    products=[NSMutableArray arrayWithArray:myArray];
    // NSLog(@"%@",products);
    addToMeal.enabled=NO;
    [self openDB];
[self createTable2:@"calendar" withField1:@"Date" withField2:@"Breakfast" withField3:@"Lunch" withField4:@"Dinner" withField5:@"Other"];
    
    cellNo=[[NSUserDefaults standardUserDefaults]integerForKey:@"cells"];
    matchString=[[NSUserDefaults standardUserDefaults]objectForKey:@"match"];
    meals=[[NSArray alloc]initWithObjects:@"Breakfast",@"Lunch",@"Dinner",@"Other", nil];
    
   
       //  NSLog(@"key is %@",matchString);
    
    puffsNames=[[NSArray alloc]initWithObjects:@"Apple & Cinnamon Soy Puffs*",@"Chocolate Soy Puffs*",@"Lemon Soy Puffs*",@"Peanut Soy Puffs*",nil];
   
    
    puffsImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"apple-cinnamon-soy-puffs_110x110.jpg"],
                   [UIImage imageNamed:@"chocolate-soy-puffs_110x110.jpg"], [UIImage imageNamed:@"lemon-soy-puffs_110x110.jpg"], [UIImage imageNamed:@"Peanut_Soy_Puffs_110x110.jpg"],
                   nil] ;
  
    
    
    chipsNames=[[NSArray alloc]initWithObjects:@"BBQ Ridges*",@"Dill Pickle Zippers*",@"Sea Salt & Vinegar Ridges*",@"Southwest Cheese Curls*",@"White Cheddar Ridges*", nil];
    
    chipsImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"bbq-ridges_110x110.jpg"],
                   [UIImage imageNamed:@"dill-pickle-zippers_110x110.jpg"], [UIImage imageNamed:@"salt-and-vinegar-ridges_110x110.jpg"], [UIImage imageNamed:@"southwest-cheese-curls_110x110.jpg"],[UIImage imageNamed:@"white-cheddar-ridges_110x110.jpg"],
                   nil] ;
             
    
    
    
    
    puddingsNames=[[NSArray alloc]initWithObjects:@"Banana Pudding",@"Blueberry Pudding",@"Butterscotch Pudding",@"Dark Chocolate Pudding",@"Lemon Pudding",@"Milk Chocolate Pudding",@"Strawberry Pudding",@"Vanilla Pudding", nil];
    
  
    puddingsImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"banana-pudding_110x110.jpg"],
                   [UIImage imageNamed:@"blueberry-pudding_110x110.jpg"], [UIImage imageNamed:@"butterscotch-pudding_110x110.jpg"], [UIImage imageNamed:@"dark-choco-pudding_110x110.jpg"],[UIImage imageNamed:@"lemon-pudding_110x110.jpg"], [UIImage imageNamed:@"milk-chocolate-pudding_110x110.jpg"], [UIImage imageNamed:@"strawberry-pudding_110x110.jpg"],[UIImage imageNamed:@"vanilla-pudding_110x110.jpg"],nil] ;
    
    
    barsNames=[[NSArray alloc]initWithObjects:@"Caramel Crunch Bar*",@"Caramel Nut Bar*",@"Choco Raspberry Bar*",@"Chocolate Peanut Butter Bar*",@"Cookies-N-Cream Bar*",@"Cran-Granata Protein Bar*",@"Double Chocolate Bar*",@"Lemon Poppy Seed Bar*",@"Peanut Butter Crunch Bar*",@"Vanilla Peanut Bar*",@"White Choco-Cinnamon Bar*", nil];
    
    barsImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"caramel-crunch_bar_110x110.jpg"],
                   [UIImage imageNamed:@"caramel-nut-bar_110x110.jpg"],
                   [UIImage imageNamed:@"choco-raspberry-bar_110x110.jpg"], [UIImage imageNamed:@"chocolate-peanut-butter-bar_110x110.jpg"], [UIImage imageNamed:@"cookies-and-cream-bar_110x110.jpg"], [UIImage imageNamed:@"Cran-Granata-Bar_110x110.jpg"], [UIImage imageNamed:@"double-choco-bar_110x110.jpg"], [UIImage imageNamed:@"lemon-poppyseed-bar_110x110.jpg"], [UIImage imageNamed:@"peanut-butter-crunch-bar_110x110.jpg"], [UIImage imageNamed:@"vanilla-peanut-bar_110x110.jpg"], [UIImage imageNamed:@"white-choco-cinnamon-bar_110x110.jpg"],nil] ;
    
    
    
    entreesNames=[[NSArray alloc]initWithObjects:@"Broccoli and Cheese Soup",@"Chicken a la King Pottage Mix",@"Chicken Flavored Patty Mix",@"Chicken Noodle Soup",@"Chicken Soup",@"Chocolate Pancake & Muffin*",@"Crispy Cereal",@"Fine Herb & Cheese Omelet",@"Leek Soup",@"Maple Oatmeal*",@"Mushroom Soup",@"Plain Omelet",@"Plain Pancake*",@"Rotini",@"Soy Patty Mix",@"Spaghetti Bolognese*",@"Tomato & Basil Rotini",@"Vegetable Chili*", nil];
    
    
    entreesImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"broccoli-cheese-soup_110x110.jpg"],
                   [UIImage imageNamed:@"chicken-a-la-king_110x110.jpg"], [UIImage imageNamed:@"Chicken-flavored-patty-mix_110x110.jpg"], [UIImage imageNamed:@"chick-noodle-soup_110x110.jpg"], [UIImage imageNamed:@"chicken-soup_110x110.jpg"], [UIImage imageNamed:@"Choco-Pancake_110x110.jpg"], [UIImage imageNamed:@"crispy-cereal_110x110.jpg"], [UIImage imageNamed:@"Fine-Herb-&-Cheese-Omelet_110x110.jpg"], [UIImage imageNamed:@"leek-soup_110x110.jpg"], [UIImage imageNamed:@"maple-oatmeal_110x110.jpg"], [UIImage imageNamed:@"mushroom-soup_110x110.jpg"], [UIImage imageNamed:@"plain-omelet_110x110.jpg"], [UIImage imageNamed:@"plain-pancake_110x110.jpg"], [UIImage imageNamed:@"Rotini_110x110.jpg"], [UIImage imageNamed:@"Soy-patty-mix_110x110.jpg"], [UIImage imageNamed:@"spaghetti-bolognese_110x110.jpg"],[UIImage imageNamed:@"Tomato-&-Basil-Rotini_110x110.jpg"],[UIImage imageNamed:@"vegetable-chili_110x110.jpg"],nil] ;

    
    
    
    
    
    
    drinksNames=[[NSArray alloc]initWithObjects:@"Blueberry Cran-Granata Drink",@"Peach Mango Drink",@"Cappuccino",@"Chocolate Drink (Cocoa)",@"Lemon Tea Drink",@"Orange Drink",@"Pina Colada Drink",@"Pineapple Banana Drink",@"Pink Lemonade",@"Ready Made Chocolate",@"Ready Made Vanilla",@"Ready Made Mango Yogurt",@"Ready Made Strawberry Banana",@"Vanilla Drink Mix",@"Wildberry Yogurt Drink", nil];
    
    
    drinksImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"blueberry-cran-granata-drink_110x110.jpg"],
                   [UIImage imageNamed:@"peach-mango-drink_110x110.jpg"], [UIImage imageNamed:@"cappuccino_110x110.jpg"], [UIImage imageNamed:@"chocolate-drink-mix_110x110.jpg"], [UIImage imageNamed:@"Lemon-Tea_110x110.jpg"], [UIImage imageNamed:@"orange-drink_110x110.jpg"], [UIImage imageNamed:@"pina-colada_110x110.jpg"], [UIImage imageNamed:@"pineapple-banana-drink_110x110.jpg"], [UIImage imageNamed:@"pink-lemonade_110x110.jpg"], [UIImage imageNamed:@"ready-made-chocolate_110x110.jpg"], [UIImage imageNamed:@"ready-made-vanilla_110x110.jpg"], [UIImage imageNamed:@"Ready-Made-Mango-Yogurt_110x110.jpg"], [UIImage imageNamed:@"Ready-Made-Straw-banana_110x110.jpg"], [UIImage imageNamed:@"vanilla-drink-mix_110x110.jpg"], [UIImage imageNamed:@"wildberry-yogurt_110x110.jpg"], nil] ;
    
    
    
    
    
    restrictedNames=[[NSArray alloc]initWithObjects:@"Apple & Cinnamon Soy Puffs*",@"Caramel Crunch Bar*", @"Chocolate Pancake*", @"BBQ Ridges*",@"BBQ Soy Nuts*", @"Caramel Nut Bar*", @"Choco Raspberry Bar*",@"Chocolate Chip Cookie*" ,@"Chocolate Pancake & Muffin*", @"Chocolate Peanut Butter Bar*", @"Chocolate Soy Puffs*", @"Cookies-N-Cream Bar*", @"Cran-Granata Protein Bar*", @"Dill Pickle Zippers*",@"Double Chocolate Bar*",
    @"Garlic & Onion Soy Nuts*", @"Lemon Poppy Seed Bar*", @"Lemon Soy Puffs*", @"Maple Oatmeal*", @"Peanut Butter Crunch Bar*", @"Peanut Soy Puffs*",
    @"Plain Pancake*",@"Sea Salt & Vinegar Ridges*",@"Southwest Cheese Curls*", @"Spaghetti Bolognese*", @"Strawberry Wafers*", @"Vanilla Crispy Square*", @"Vanilla Peanut Bar*", @"Vegetable Chili*", @"White Cheddar Ridges*", @"White Choco-Cinnamon Bar*", nil];
    
    restrictedImages = [NSArray arrayWithObjects:
                        [UIImage imageNamed:@"apple-cinnamon-soy-puffs_110x110.jpg"],[UIImage imageNamed:@"caramel-crunch_bar_110x110.jpg"],
                        [UIImage imageNamed:@"Choco-Pancake_110x110.jpg"], [UIImage imageNamed:@"bbq-ridges_110x110.jpg"], [UIImage imageNamed:@"bbq-soy-nuts_110x110.jpg"],[UIImage imageNamed:@"caramel-nut-bar_110x110.jpg"], [UIImage imageNamed:@"choco-raspberry-bar_110x110.jpg"], [UIImage imageNamed:@"chocolate-chip-cookie_110x110.jpg"],[UIImage imageNamed:@"Choco-Pancake_110x110.jpg"], [UIImage imageNamed:@"chocolate-peanut-butter-bar_110x110.jpg"], [UIImage imageNamed:@"chocolate-soy-puffs_110x110.jpg"],[UIImage imageNamed:@"cookies-and-cream-bar_110x110.jpg"], [UIImage imageNamed:@"Cran-Granata-Bar_110x110.jpg"], [UIImage imageNamed:@"dill-pickle-zippers_110x110.jpg"],[UIImage imageNamed:@"double-choco-bar_110x110.jpg"], [UIImage imageNamed:@"garlic-&-onion-soy-nuts_110x110.jpg"], [UIImage imageNamed:@"lemon-poppyseed-bar_110x110.jpg"],[UIImage imageNamed:@"lemon-soy-puffs_110x110.jpg"], [UIImage imageNamed:@"maple-oatmeal_110x110.jpg"], [UIImage imageNamed:@"peanut-butter-crunch-bar_110x110.jpg"],[UIImage imageNamed:@"Peanut_Soy_Puffs_110x110.jpg"], [UIImage imageNamed:@"plain-pancake_110x110.jpg"], [UIImage imageNamed:@"salt-and-vinegar-ridges_110x110.jpg"],[UIImage imageNamed:@"southwest-cheese-curls_110x110.jpg"], [UIImage imageNamed:@"spaghetti-bolognese_110x110.jpg"], [UIImage imageNamed:@"Strawberry-Wafers_110x110.jpg"],[UIImage imageNamed:@"Vanilla-Crispy-Square_110x110.jpg"], [UIImage imageNamed:@"vanilla-peanut-bar_110x110.jpg"], [UIImage imageNamed:@"vegetable-chili_110x110.jpg"],[UIImage imageNamed:@"white-cheddar-ridges_110x110.jpg"],[UIImage imageNamed:@"white-choco-cinnamon-bar_110x110.jpg"], nil] ;
    

    
    
    
    unrestrictedNames=[[NSArray alloc]initWithObjects:@"Banana Pudding",@"Cappuccino", @"Blueberry Cran-Granata Drink", @"Blueberry Pudding", @"Broccoli and Cheese Soup", @"Butterscotch Pudding", @"Chicken a la King Pottage Mix", @"Chicken Flavored Patty Mix", @"Chicken Noodle Soup Mix", @"Chicken Soup", @"Chocolate Drink (Cocoa)",@"Crispy Cereal",@"Dark Chocolate Pudding", @"Fine Herb & Cheese Omelet",@"Leek Soup", @"Lemon Pudding",@"Lemon Tea Drink", @"Milk Chocolate Pudding", @"Mushroom Soup", @"Orange Drink", @"Peach Mango Drink", @"Pina Colada Drink", @"Pineapple Banana Drink", @"Pink Lemonade", @"Plain Omelet", @"Potato Puree", @"Raspberry Jelly", @"Ready Made Chocolate", @"Ready Made Vanilla",@"Ready Made Mango Yogurt", @"Ready Made Strawberry Banana", @"Rotini",@"Soy Patty Mix", @"Strawberry Pudding", @"Tomato & Basil Soup", @"Vanilla Drink Mix", @"Vanilla Pudding", @"Wildberry Yogurt Drink", nil];
    
    
    unrestrictedImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"banana-pudding_110x110.jpg"],
                   [UIImage imageNamed:@"cappuccino_110x110.jpg"], [UIImage imageNamed:@"blueberry-cran-granata-drink_110x110.jpg"], [UIImage imageNamed:@"blueberry-pudding_110x110.jpg"],[UIImage imageNamed:@"broccoli-cheese-soup_110x110.jpg"], [UIImage imageNamed:@"butterscotch-pudding_110x110.jpg"],[UIImage imageNamed:@"chicken-a-la-king_110x110.jpg"], [UIImage imageNamed:@"Chicken-flavored-patty-mix_110x110.jpg"], [UIImage imageNamed:@"chick-noodle-soup_110x110.jpg"],[UIImage imageNamed:@"chicken-soup_110x110.jpg"], [UIImage imageNamed:@"chocolate-drink-mix_110x110.jpg"], [UIImage imageNamed:@"crispy-cereal_110x110.jpg"],[UIImage imageNamed:@"dark-choco-pudding_110x110.jpg"], [UIImage imageNamed:@"Fine-Herb-&-Cheese-Omelet_110x110.jpg"], [UIImage imageNamed:@"leek-soup_110x110.jpg"],[UIImage imageNamed:@"lemon-pudding_110x110.jpg"], [UIImage imageNamed:@"Lemon-Tea_110x110.jpg"], [UIImage imageNamed:@"milk-chocolate-pudding_110x110.jpg"],[UIImage imageNamed:@"mushroom-soup_110x110.jpg"], [UIImage imageNamed:@"orange-drink_110x110.jpg"], [UIImage imageNamed:@"peach-mango-drink_110x110.jpg"],[UIImage imageNamed:@"pina-colada_110x110.jpg"], [UIImage imageNamed:@"pineapple-banana-drink_110x110.jpg"], [UIImage imageNamed:@"pink-lemonade_110x110.jpg"],[UIImage imageNamed:@"plain-omelet_110x110.jpg"], [UIImage imageNamed:@"Potato-Puree_110x110.jpg"], [UIImage imageNamed:@"raspberry-jello_110x110.jpg"],[UIImage imageNamed:@"ready-made-chocolate_110x110.jpg"],[UIImage imageNamed:@"ready-made-vanilla_110x110.jpg"],[UIImage imageNamed:@"Ready-Made-Mango-Yogurt_110x110.jpg"], [UIImage imageNamed:@"Ready-Made-Straw-banana_110x110.jpg"],[UIImage imageNamed:@"Rotini_110x110.jpg"], [UIImage imageNamed:@"Soy-patty-mix_110x110.jpg"],[UIImage imageNamed:@"strawberry-pudding_110x110.jpg"], [UIImage imageNamed:@"tomato-basil-soup_110x110.jpg"],[UIImage imageNamed:@"vanilla-drink-mix_110x110.jpg"], [UIImage imageNamed:@"vanilla-pudding_110x110.jpg"],[UIImage imageNamed:@"wildberry-yogurt_110x110.jpg"],  nil] ;
    
    
    
    
    
    
    
    alphabeticalNames=[[NSArray alloc]initWithObjects:@"Apple & Cinnamon Soy Puffs*",
                       @"Banana Pudding",@"BBQ Ridges*",@"BBQ Soy Nuts*", @"Blueberry Cran-Granata Drink", @"Blueberry Pudding", @"Broccoli and Cheese Soup", @"Butterscotch Pudding",  @"Cappuccino", @"Caramel Crunch Bar*",@"Caramel Nut Bar*",@"Chicken a la King Pottage Mix",@"Chicken Flavored Patty Mix",@"Chicken Noodle Soup Mix", @"Chicken Soup",@"Choco Raspberry Bar*",@"Chocolate Chip Cookie*", @"Chocolate Drink (Cocoa)", @"Chocolate Pancake & Muffin *", @"Chocolate Peanut Butter Bar*", @"Chocolate Soy Puffs*", @"Cookies-N-Cream Bar*", @"Cran-Granata Protein Bar*", @"Crispy Cereal",@"Dark Chocolate Pudding", @"Dill Pickle Zippers*", @"Double Chocolate Bar*", @"Fine Herb & Cheese Omelet", @"Garlic & Onion Soy Nuts*",@"Leek Soup",@"Lemon Poppy Seed Bar*",@"Lemon Pudding", @"Lemon Soy Puffs*", @"Lemon Tea Drink", @"Maple Oatmeal*",@"Milk Chocolate Pudding", @"Mushroom Soup", @"Orange Drink", @"Peach Mango Drink", @"Peanut Butter Crunch Bar*", @"Peanut Soy Puffs*", @"Pina Colada Drink", @"Pineapple Banana Drink", @"Pink Lemonade", @"Plain Omelet",@"Plain Pancake*",  @"Potato Puree",@"Raspberry Jelly",@"Ready Made Drink Chocolate",@"Ready Made Drink Vanilla", @"Ready Made Mango Yogurt", @"Ready Made Strawberry Banana", @"Rotini",@"Sea Salt & Vinegar Ridges*", @"Southwest Cheese Curls*", @"Soy Patty Mix", @"Spaghetti Bolognese*", @"Strawberry Pudding", @"Strawberry Wafers*", @"Tomato & Basil Rotini", @"Tomato & Basil Soup", @"Vanilla Crispy Square*", @"Vanilla Drink Mix", @"Vanilla Peanut Bar*", @"Vanilla Pudding", @"Vegetable Chili*", @"White Cheddar Ridges*", @"White Choco-Cinnamon Bar*", @"Wildberry Yogurt Drink", nil];
    
    
    alphabeticalImages = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"apple-cinnamon-soy-puffs_110x110.jpg"],
                   [UIImage imageNamed:@"banana-pudding_110x110.jpg"], [UIImage imageNamed:@"bbq-ridges_110x110.jpg"], [UIImage imageNamed:@"bbq-soy-nuts_110x110.jpg"], [UIImage imageNamed:@"blueberry-cran-granata-drink_110x110.jpg"],  [UIImage imageNamed:@"blueberry-pudding_110x110.jpg"],[UIImage imageNamed:@"broccoli-cheese-soup_110x110.jpg"], [UIImage imageNamed:@"butterscotch-pudding_110x110.jpg"], [UIImage imageNamed:@"cappuccino_110x110.jpg"], [UIImage imageNamed:@"caramel-crunch_bar_110x110.jpg"], [UIImage imageNamed:@"caramel-nut-bar_110x110.jpg"],[UIImage imageNamed:@"chicken-a-la-king_110x110.jpg"], [UIImage imageNamed:@"Chicken-flavored-patty-mix_110x110.jpg"],  [UIImage imageNamed:@"chick-noodle-soup_110x110.jpg"], [UIImage imageNamed:@"chicken-soup_110x110.jpg"], [UIImage imageNamed:@"choco-raspberry-bar_110x110.jpg"],[UIImage imageNamed:@"chocolate-chip-cookie_110x110.jpg"], [UIImage imageNamed:@"chocolate-drink-mix_110x110.jpg"], [UIImage imageNamed:@"Choco-Pancake_110x110.jpg"], [UIImage imageNamed:@"chocolate-peanut-butter-bar_110x110.jpg"], [UIImage imageNamed:@"chocolate-soy-puffs_110x110.jpg"], [UIImage imageNamed:@"cookies-and-cream-bar_110x110.jpg"], [UIImage imageNamed:@"Cran-Granata-Bar_110x110.jpg"], [UIImage imageNamed:@"crispy-cereal_110x110.jpg"], [UIImage imageNamed:@"dark-choco-pudding_110x110.jpg"], [UIImage imageNamed:@"dill-pickle-zippers_110x110.jpg"], [UIImage imageNamed:@"double-choco-bar_110x110.jpg"], [UIImage imageNamed:@"Fine-Herb-&-Cheese-Omelet_110x110.jpg"], [UIImage imageNamed:@"garlic-&-onion-soy-nuts_110x110.jpg"], [UIImage imageNamed:@"leek-soup_110x110.jpg"], [UIImage imageNamed:@"lemon-poppyseed-bar_110x110.jpg"], [UIImage imageNamed:@"lemon-pudding_110x110.jpg"], [UIImage imageNamed:@"lemon-soy-puffs_110x110.jpg"], [UIImage imageNamed:@"Lemon-Tea_110x110.jpg"], [UIImage imageNamed:@"maple-oatmeal_110x110.jpg"], [UIImage imageNamed:@"milk-chocolate-pudding_110x110.jpg"], [UIImage imageNamed:@"mushroom-soup_110x110.jpg"], [UIImage imageNamed:@"orange-drink_110x110.jpg"], [UIImage imageNamed:@"peach-mango-drink_110x110.jpg"], [UIImage imageNamed:@"peanut-butter-crunch-bar_110x110.jpg"], [UIImage imageNamed:@"Peanut_Soy_Puffs_110x110.jpg"], [UIImage imageNamed:@"pina-colada_110x110.jpg"], [UIImage imageNamed:@"pineapple-banana-drink_110x110.jpg"], [UIImage imageNamed:@"pink-lemonade_110x110.jpg"], [UIImage imageNamed:@"plain-omelet_110x110.jpg"], [UIImage imageNamed:@"plain-pancake_110x110.jpg"], [UIImage imageNamed:@"Potato-Puree_110x110.jpg"], [UIImage imageNamed:@"raspberry-jello_110x110.jpg"], [UIImage imageNamed:@"ready-made-chocolate_110x110.jpg"], [UIImage imageNamed:@"ready-made-vanilla_110x110.jpg"], [UIImage imageNamed:@"Ready-Made-Mango-Yogurt_110x110.jpg"], [UIImage imageNamed:@"Ready-Made-Straw-banana_110x110.jpg"], [UIImage imageNamed:@"Rotini_110x110.jpg"], [UIImage imageNamed:@"salt-and-vinegar-ridges_110x110.jpg"], [UIImage imageNamed:@"southwest-cheese-curls_110x110.jpg"], [UIImage imageNamed:@"Soy-patty-mix_110x110.jpg"], [UIImage imageNamed:@"spaghetti-bolognese_110x110.jpg"], [UIImage imageNamed:@"strawberry-pudding_110x110.jpg"], [UIImage imageNamed:@"Strawberry-Wafers_110x110.jpg"], [UIImage imageNamed:@"Tomato-&-Basil-Rotini_110x110.jpg"], [UIImage imageNamed:@"tomato-basil-soup_110x110.jpg"], [UIImage imageNamed:@"Vanilla-Crispy-Square_110x110.jpg"], [UIImage imageNamed:@"vanilla-drink-mix_110x110.jpg"], [UIImage imageNamed:@"vanilla-peanut-bar_110x110.jpg"], [UIImage imageNamed:@"vanilla-pudding_110x110.jpg"], [UIImage imageNamed:@"vegetable-chili_110x110.jpg"], [UIImage imageNamed:@"white-cheddar-ridges_110x110.jpg"], [UIImage imageNamed:@"white-choco-cinnamon-bar_110x110.jpg"],[UIImage imageNamed:@"wildberry-yogurt_110x110.jpg"],
                   nil] ;
    

    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
         listTable =[[UITableView alloc]initWithFrame:CGRectMake(15, 74, 296, 379)];
        
    }
    else
        
    {
        listTable =[[UITableView alloc]initWithFrame:CGRectMake(15, 66, 299, 320)]; 
    }
    
    
   
    [listTable setBackgroundColor:[UIColor clearColor]];
    listTable.delegate=self;
    listTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    listTable.dataSource=self;
    //[listTable setShowsVerticalScrollIndicator:NO ];
    [self.view addSubview:listTable];
   [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
     [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer2:) userInfo:nil repeats:YES];

    if( !Bool ) Bool =[[NSMutableArray alloc]init];
    NSLog(@"count=%d",cellNo);
    for(int i=0;i< cellNo ;i++)
    {
        [Bool addObject:@"0"];
    }
    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        UIImageView *topimage=[[UIImageView alloc]initWithFrame:CGRectMake(13   ,69, 284, 388)];
        [topimage setImage:[UIImage imageNamed:@"IM_i5_products_list-overlay.png"] ];
        [self.view addSubview:topimage];
    }
    else
    {
    UIImageView *topimage=[[UIImageView alloc]initWithFrame:CGRectMake(13   ,64, 284, 325)];
    [topimage setImage:[UIImage imageNamed:@"IM_iP4_PRODUCTS_box-frame.png"] ];
    [self.view addSubview:topimage];
    }
    [super viewDidLoad];

    [self hideActivityIndicater];
}

-(void) onTimer:(NSTimer *)timer1{
    [listTable flashScrollIndicators];
    
//    if (products.count>0) {
//        addToMeal.enabled=YES;
//    }
//    else
//    {
//        addToMeal.enabled=NO;
//    }
    
    //[scrollview2 flashScrollIndicators];
   // [scrollview3 flashScrollIndicators];
}
-(void) onTimer2:(NSTimer *)timer1{
    //[listTable flashScrollIndicators];
    
    if (products.count>0) {
        addToMeal.enabled=YES;
    }
    else
    {
        addToMeal.enabled=NO;
    }
    
    //[scrollview2 flashScrollIndicators];
    // [scrollview3 flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

    
}


    
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    return cellNo;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    
 
    UIImageView *  divider2=[[UIImageView alloc]initWithFrame:CGRectMake(0  , 0, 278, 80)];
    [divider2 setImage:[UIImage imageNamed:@"image.jpg"]];
    [divider2 setTag:1];
    [cell.contentView addSubview:divider2];
    
    
    productName=[[UILabel alloc]initWithFrame:CGRectMake(70, 5 ,170,70 )];
   
    productName.backgroundColor=[UIColor clearColor];
    productName.numberOfLines=3;
    productName.adjustsFontSizeToFitWidth=YES;
    productName.minimumFontSize=10.0;
    productName.textColor = [UIColor blackColor];
    productName.font=[UIFont systemFontOfSize:19];
    [cell.contentView addSubview:productName];
    
    productImage=[[UIImageView alloc]initWithFrame:CGRectMake(8    , 10, 55, 55)];
    //[productImage setBackgroundColor:[UIColor grayColor]];
    //
    [cell.contentView addSubview:productImage];
    
    
    if ([matchString isEqualToString:@"puffs"]) {
        
         [productName setText:[puffsNames objectAtIndex:indexPath.row]];
        [productImage setImage:[puffsImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"chips"])
    {
        [productName setText:[chipsNames objectAtIndex:indexPath.row]];
        [productImage setImage:[chipsImages objectAtIndex:indexPath.row]];
    }
    
    
    else if ([matchString isEqualToString:@"puddings"])
    {
         [productName setText:[puddingsNames objectAtIndex:indexPath.row]];
        [productImage setImage:[puddingsImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"bars"])
    {
         [productName setText:[barsNames objectAtIndex:indexPath.row]];
        [productImage setImage:[barsImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"entrees"])
    {
         [productName setText:[entreesNames objectAtIndex:indexPath.row]];
        [productImage setImage:[entreesImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"drinks"])
    {
         [productName setText:[drinksNames objectAtIndex:indexPath.row]];
        [productImage setImage:[drinksImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"restricted"])
    {
         [productName setText:[restrictedNames objectAtIndex:indexPath.row]];
        [productImage setImage:[restrictedImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"unrestricted"])
    {
         [productName setText:[unrestrictedNames objectAtIndex:indexPath.row]];
        [productImage setImage:[unrestrictedImages objectAtIndex:indexPath.row]];
    }
    else if ([matchString isEqualToString:@"alphabetical"])
    {
         [productName setText:[alphabeticalNames objectAtIndex:indexPath.row]];
        [productImage setImage:[alphabeticalImages objectAtIndex:indexPath.row]];
    }
    


   

   

    
      
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    UIImage *image;
	if([[Bool objectAtIndex:indexPath.row]isEqualToString:@"0"])
        image = [UIImage imageNamed:@"IM_checkbox_OFF.png"];
    
    
    else
    
        image = [UIImage imageNamed:@"IM_checkbox_ON.png"];
    
    
    
    
    
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame=CGRectMake(245, 27.5, 25   , 25);
    [checkButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [checkButton setImage:image forState:UIControlStateNormal];
    [checkButton setTag:((indexPath.section & 0xFFFF) << 16) |
     (indexPath.row & 0xFFFF)];
    [cell.contentView addSubview:checkButton];
    
    
    forwardButton=[[UIButton alloc]initWithFrame:CGRectMake(3, 3 ,270,69)];
    [forwardButton setTag:indexPath.row];
    [forwardButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [forwardButton setBackgroundColor:[UIColor clearColor]];
    [cell.contentView addSubview:forwardButton];


    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)buttonTapped:(UIButton *)sender
{
   // NSIndexPath *indexPath;
    //NSUInteger section = ((sender.tag >> 16) & 0xFFFF);
    NSUInteger row     = (sender.tag & 0xFFFF);
    if ([matchString isEqualToString:@"puffs"]) {
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[puffsNames objectAtIndex:row]];
            
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            //NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[puffsNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //NSLog(@"array is %@",products);
        }
    }
        
        
    
    else if ([matchString isEqualToString:@"chips"])
    {
        
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[chipsNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[chipsNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
          //  NSLog(@"array is %@",products);
    
    }
    
    }
    else if ([matchString isEqualToString:@"puddings"])
    {
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[puddingsNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[puddingsNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
            
        }

    }
    else if ([matchString isEqualToString:@"bars"])
    {
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[barsNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
          //  NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[barsNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
            
        }

    }
    else if ([matchString isEqualToString:@"entrees"])
    {
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[entreesNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[entreesNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //NSLog(@"array is %@",products);
            
        }

    }
    else if ([matchString isEqualToString:@"drinks"])
    {
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[drinksNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[drinksNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
            
        }

    
    }
    else if ([matchString isEqualToString:@"restricted"])
    {
        
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[restrictedNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[restrictedNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
          //  NSLog(@"array is %@",products);
            
        }
        

    }
    else if ([matchString isEqualToString:@"unrestricted"])
    {
        
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[unrestrictedNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[unrestrictedNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
            
        }
        

    }
    else if ([matchString isEqualToString:@"alphabetical"])
    {
        
        if([[Bool objectAtIndex:row]isEqualToString:@"0"])
        {
            
            [Bool replaceObjectAtIndex:row withObject:@"1"];
            [products addObject:[alphabeticalNames objectAtIndex:row]];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
        }
        else
        {
            [products removeObject:[alphabeticalNames objectAtIndex:row]];
            [Bool replaceObjectAtIndex:row withObject:@"0"];
            [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
            [[NSUserDefaults standardUserDefaults]synchronize];
           // NSLog(@"array is %@",products);
            
        }
        

    }
    
    
    
    
     [Flurry logEvent:@"CheckMark Button Pressed"];
   

    [listTable reloadData];
}

-(void)viewDidUnload
{
    [self setAddToMeal:nil];
    NSMutableArray *puffsNamesArray=[NSMutableArray arrayWithArray:puffsNames];
    [puffsNamesArray removeAllObjects];
    NSMutableArray *puffsImagesArray=[NSMutableArray arrayWithArray:puffsImages];
    [puffsImagesArray removeAllObjects];
    
    NSMutableArray *chipsNamesArray=[NSMutableArray arrayWithArray:chipsNames];
    [chipsNamesArray removeAllObjects];
    NSMutableArray *chipsImagesArray=[NSMutableArray arrayWithArray:chipsImages];
    [chipsImagesArray removeAllObjects];
    
    NSMutableArray *puddingsNamesArray=[NSMutableArray arrayWithArray:puddingsNames];
    [puddingsNamesArray removeAllObjects];
    NSMutableArray *puddingsImagesArray=[NSMutableArray arrayWithArray:puddingsImages];
    [puddingsImagesArray removeAllObjects];
    
    NSMutableArray *barsNamesArray=[NSMutableArray arrayWithArray:barsNames];
    [barsNamesArray removeAllObjects];
    NSMutableArray *barsImagesArray=[NSMutableArray arrayWithArray:barsImages];
    [barsImagesArray removeAllObjects];
    
    NSMutableArray *entreesNamesArray=[NSMutableArray arrayWithArray:entreesNames];
    [entreesNamesArray removeAllObjects];
    NSMutableArray *entreesImagesArray=[NSMutableArray arrayWithArray:entreesImages];
    [entreesImagesArray removeAllObjects];
    
    NSMutableArray *drinksNamesArray=[NSMutableArray arrayWithArray:drinksNames];
    [drinksNamesArray removeAllObjects];
    NSMutableArray *drinksImagesArray=[NSMutableArray arrayWithArray:drinksImages];
    [drinksImagesArray removeAllObjects];
    
    NSMutableArray *restrictedNamesArray=[NSMutableArray arrayWithArray:restrictedNames];
    [restrictedNamesArray removeAllObjects];
    NSMutableArray *restrictedImagesArray=[NSMutableArray arrayWithArray:restrictedImages];
    [restrictedImagesArray removeAllObjects];
    
    NSMutableArray *unrestrictedNamesArray=[NSMutableArray arrayWithArray:unrestrictedNames];
    [unrestrictedNamesArray removeAllObjects];
    NSMutableArray *unrestrictedImagesArray=[NSMutableArray arrayWithArray:unrestrictedImages];
    [unrestrictedImagesArray removeAllObjects];
    
    NSMutableArray *alphabeticalNamesArray=[NSMutableArray arrayWithArray:alphabeticalNames];
    [alphabeticalNamesArray removeAllObjects];
    NSMutableArray *alphabeticalImagesArray=[NSMutableArray arrayWithArray:alphabeticalImages];
    [alphabeticalImagesArray removeAllObjects];

}

- (IBAction)addToCalander:(id)sender {
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"mealSelector"]==NO) {
        
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568)
        {
            
            selection=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
            [selection setImage:[UIImage imageNamed:@"IM_i5_add-meal-no-buttons.jpg"]];
            selection.userInteractionEnabled=YES;
            
            
            selectADate=[[UIButton alloc]initWithFrame:CGRectMake(20, 135, 120    , 32)];
            [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_set-date.png"]forState:UIControlStateNormal];
            [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-date-press.png"]forState:UIControlStateHighlighted];
            [selectADate addTarget:self action:@selector(initialiseDatePicker) forControlEvents:UIControlEventTouchUpInside];
            [selection addSubview:selectADate];
            
            selectAMeal=[[UIButton alloc]initWithFrame:CGRectMake(20, 179, 120    , 32)];
            [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal.png"]forState:UIControlStateNormal];
            [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal-press.png"]forState:UIControlStateHighlighted];
            [selectAMeal addTarget:self action:@selector(initialiseMealPicker) forControlEvents:UIControlEventTouchUpInside];
            [selection addSubview:selectAMeal];
            
            
            pickerBackButton=[[UIButton alloc]initWithFrame:CGRectMake(6, 5, 58, 33)];
            // [saveButton setBackgroundColor:[UIColor yellowColor]];
            // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button.png"]forState:UIControlStateNormal];
            [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button-press.png"]forState:UIControlStateHighlighted];
            [pickerBackButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            // saveButton.userInteractionEnabled=YES;
            [selection addSubview:pickerBackButton];
            
            datePickerLabel =[[UILabel alloc]initWithFrame:CGRectMake(160, 135, 135, 30)];
            datePickerLabel.textAlignment=UITextAlignmentCenter ;
            [datePickerLabel setBackgroundColor:[UIColor clearColor]];
            NSString *newString=[[NSUserDefaults standardUserDefaults]objectForKey:@"datePickerDate"];
            
            datePickerLabel.text=newString;
            
            
            [selection addSubview:datePickerLabel];
            
            mealPicker =[[UILabel alloc]initWithFrame:CGRectMake(160, 179, 135, 30)];
            [mealPicker setBackgroundColor:[UIColor clearColor]];
            mealPicker.textAlignment=UITextAlignmentCenter ;
            // NSString *newString1=[[NSUserDefaults standardUserDefaults]objectForKey:@"meal"];
            mealPicker.text=@"Breakfast";
            
            [selection addSubview:mealPicker];
            
            addtoDB=[[UIButton alloc]initWithFrame:CGRectMake(110, 245, 100, 35)];
            // [saveButton setBackgroundColor:[UIColor yellowColor]];
            // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [addtoDB setImage:[UIImage imageNamed:@"IM_addmeal-button.png"]forState:UIControlStateNormal];
            [addtoDB setImage:[UIImage imageNamed:@"IM_addmeal-button-press.png"]forState:UIControlStateHighlighted];
            [addtoDB addTarget:self action:@selector(addToDatabase) forControlEvents:UIControlEventTouchUpInside];
            // saveButton.userInteractionEnabled=YES;
            [selection addSubview:addtoDB];
            
            [Flurry logEvent:@"Add to Meals(products) Button Pressed"];
            [self.view addSubview:selection];

            
        }
        else
        {
            
        

        
        selection=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
        [selection setImage:[UIImage imageNamed:@"IM_add-meal-short_bg.jpg"]];
        selection.userInteractionEnabled=YES;
        
        
        selectADate=[[UIButton alloc]initWithFrame:CGRectMake(20, 113, 120    , 32)];
        [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_set-date.png"]forState:UIControlStateNormal];
        [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-date-press.png"]forState:UIControlStateHighlighted];
        [selectADate addTarget:self action:@selector(initialiseDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [selection addSubview:selectADate];
        
        selectAMeal=[[UIButton alloc]initWithFrame:CGRectMake(20, 157, 120    , 32)];
        [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal.png"]forState:UIControlStateNormal];
        [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal-press.png"]forState:UIControlStateHighlighted];
        [selectAMeal addTarget:self action:@selector(initialiseMealPicker) forControlEvents:UIControlEventTouchUpInside];
        [selection addSubview:selectAMeal];
        
        
        pickerBackButton=[[UIButton alloc]initWithFrame:CGRectMake(6, 5, 58, 33)];
        // [saveButton setBackgroundColor:[UIColor yellowColor]];
        // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button.png"]forState:UIControlStateNormal];
        [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button-press.png"]forState:UIControlStateHighlighted];
        [pickerBackButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // saveButton.userInteractionEnabled=YES;
        [selection addSubview:pickerBackButton];
        
        datePickerLabel =[[UILabel alloc]initWithFrame:CGRectMake(160, 113, 135, 30)];
        datePickerLabel.textAlignment=UITextAlignmentCenter ;
        [datePickerLabel setBackgroundColor:[UIColor clearColor]];
        NSString *newString=[[NSUserDefaults standardUserDefaults]objectForKey:@"datePickerDate"];
       
            datePickerLabel.text=newString;
       
       
        [selection addSubview:datePickerLabel];
        
        mealPicker =[[UILabel alloc]initWithFrame:CGRectMake(160, 157, 135, 30)];
        [mealPicker setBackgroundColor:[UIColor clearColor]];
        mealPicker.textAlignment=UITextAlignmentCenter ;
       // NSString *newString1=[[NSUserDefaults standardUserDefaults]objectForKey:@"meal"];
        mealPicker.text=@"Breakfast";
        
        [selection addSubview:mealPicker];
        
        addtoDB=[[UIButton alloc]initWithFrame:CGRectMake(110, 220, 100, 35)];
        // [saveButton setBackgroundColor:[UIColor yellowColor]];
        // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [addtoDB setImage:[UIImage imageNamed:@"IM_addmeal-button.png"]forState:UIControlStateNormal];
        [addtoDB setImage:[UIImage imageNamed:@"IM_addmeal-button-press.png"]forState:UIControlStateHighlighted];
        [addtoDB addTarget:self action:@selector(addToDatabase) forControlEvents:UIControlEventTouchUpInside];
        // saveButton.userInteractionEnabled=YES;
        [selection addSubview:addtoDB];
        
        [Flurry logEvent:@"Add to Meals(products) Button Pressed"];
        [self.view addSubview:selection];
        }
    }
    else{
        NSString * latestDate=[[NSString alloc]initWithFormat:@"%@",  [[NSUserDefaults standardUserDefaults]objectForKey:@"latest"] ];
        NSString * latestMeal=[[NSString alloc]initWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"meal"]];
        
        //NSLog(@"%@",latestDate);
         //NSLog(@"%@",latestMeal);
        datePickerLabel=[[UILabel alloc]init];
        mealPicker=[[UILabel alloc]init];
        [mealPicker setText:latestMeal];
         [datePickerLabel setText:latestDate];
        
        // NSLog(@"%@",datePickerLabel.text);
         [Flurry logEvent:@"Add to Meals(products) Button Pressed"];
        [self addToDatabase];
    }
    
   
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"mealSelector"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

    
}

-(void)createInputAccessoryView
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        inputAccView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 263, 320, 40)];
        [inputAccView setImage:[UIImage imageNamed:@"datepicker_bar-bg.png"]];
        
        doneButton=[[UIButton alloc]initWithFrame:CGRectMake(260, 5, 50    , 30)];
        // [doneButton setBackgroundColor:[UIColor yellowColor]];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"datepicker_done-bt.png"]forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"datepicker_done-bt_press.png"]forState:UIControlStateHighlighted];
        [doneButton addTarget:self action:@selector(removePicker) forControlEvents:UIControlEventTouchUpInside];
        [inputAccView addSubview:doneButton];
        
        inputAccView.userInteractionEnabled=YES;
        [self.view addSubview:inputAccView];
        
        
    }
    else
    {
        inputAccView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 174, 320, 40)];
        [inputAccView setImage:[UIImage imageNamed:@"datepicker_bar-bg.png"]];
        
        doneButton=[[UIButton alloc]initWithFrame:CGRectMake(260, 5, 50    , 30)];
        // [doneButton setBackgroundColor:[UIColor yellowColor]];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"datepicker_done-bt.png"]forState:UIControlStateNormal];
        [doneButton setBackgroundImage:[UIImage imageNamed:@"datepicker_done-bt_press.png"]forState:UIControlStateHighlighted];
        [doneButton addTarget:self action:@selector(removePicker) forControlEvents:UIControlEventTouchUpInside];
        [inputAccView addSubview:doneButton];
        
        inputAccView.userInteractionEnabled=YES;
        [self.view addSubview:inputAccView];
    }
}

-(void)initialiseDatePicker
{
    tabBarItem=YES;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        pickerBase=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
        [pickerBase setImage:[UIImage imageNamed:@"IM_screen-darkener.png"]];
        pickerBase.userInteractionEnabled=YES;
        [self.view addSubview:pickerBase];
        
        
        [self createInputAccessoryView];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MMM d, yyyy"];
        datePickerLabel.text = [NSString stringWithFormat:@"%@",
                                [df stringFromDate:[NSDate date]]];
        
        
        
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 303, 320, 250)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.hidden = NO;
        datePicker.date = [NSDate date];
        
        NSLocale *uk = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSCalendar *cal = [NSCalendar currentCalendar];
        [cal setLocale:uk];
        [datePicker setCalendar:cal];
        [datePicker addTarget:self
                       action:@selector(LabelChange:)
             forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:datePicker];
        
        
    }
    else
    {
        
        
        pickerBase=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        [pickerBase setImage:[UIImage imageNamed:@"IM_screen-darkener.png"]];
        pickerBase.userInteractionEnabled=YES;
        [self.view addSubview:pickerBase];
        
        
        [self createInputAccessoryView];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MMM d, yyyy"];
        datePickerLabel.text = [NSString stringWithFormat:@"%@",
                                [df stringFromDate:[NSDate date]]];
        
        
        
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 214, 320, 250)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.hidden = NO;
        datePicker.date = [NSDate date];
        
        NSLocale *uk = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSCalendar *cal = [NSCalendar currentCalendar];
        [cal setLocale:uk];
        [datePicker setCalendar:cal];
        [datePicker addTarget:self
                       action:@selector(LabelChange:)
             forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:datePicker];
        
    }
    
    
    
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabBarItem==YES) {
        return NO;
    }
    
    tabBarItem=NO;
    
    return YES;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return meals.count;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [meals objectAtIndex:row];
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *newString=[[NSString alloc]initWithFormat:@"%@",[meals objectAtIndex:row] ];
    mealPicker.text=newString;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.text = [NSString stringWithFormat:@"%@",[meals objectAtIndex:row]];
    label.textAlignment = UITextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:18] ;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}
- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM d, yyyy"];
    if ( [ datePicker.date timeIntervalSinceNow ] < 0 )
        datePicker.date = today;
    datePickerLabel.text = [NSString stringWithFormat:@"%@",
                            [df stringFromDate:datePicker.date]];
}

-(void)removePicker
{
    tabBarItem=NO;

   
    [pickerBase removeFromSuperview];
    [datePicker removeFromSuperview];
    [inputAccView removeFromSuperview];
    [cityPicker removeFromSuperview];
}
-(void)initialiseMealPicker
{ tabBarItem=YES;
    pickerBase=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
    [pickerBase setImage:[UIImage imageNamed:@"IM_screen-darkener.png"]];
    pickerBase.userInteractionEnabled=YES;
    [self.view addSubview:pickerBase];
    [self createInputAccessoryView];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        cityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 303, 320, 250)];
    }else{
        cityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 214, 320, 250)];
    }
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [cityPicker setShowsSelectionIndicator:YES];
    
    
    // NSString *firstRow=[NSString alloc]initWithFormat:@"%@"[cityPicker
    
    [self.view addSubview:cityPicker];
    
}



-(void)addToDatabase
{
    
    NSString *arrayString=[products componentsJoinedByString:@","];
   // NSLog(@"%@",arrayString);
    
    if ([mealPicker.text isEqualToString:@"Breakfast"]){
        
        NSString *sql=[NSString stringWithFormat:@"INSERT INTO calendar('Date','Breakfast')VALUES ('%@','%@')",[datePickerLabel text],arrayString];
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            
            
            
            NSString *field3Str;
            NSString *sql5=[NSString stringWithFormat:@"SELECT  *  FROM calendar WHERE Date IS ('%@')",[datePickerLabel text]];
            sqlite3_stmt  *statement5;
            
            
            if (sqlite3_prepare(db, [sql5 UTF8String], -1, &statement5, nil)==SQLITE_OK) {
                while (sqlite3_step(statement5)==SQLITE_ROW) {
                    
                    
                    char *field3=(char *) sqlite3_column_text(statement5, 1);
                    field3Str= field3 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field3];
                    
                    
                }}
            //NSLog(@"%@",field3Str);
            if (field3Str.length==0) {
                
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Breakfast =('%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
                
                
            }
            
            else
            {
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Breakfast =(Breakfast||','||'%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
                
            }
            
        }
    }
    
    
    else if ([mealPicker.text isEqualToString:@"Lunch"]){
        
        NSString *sql=[NSString stringWithFormat:@"INSERT INTO calendar('Date','Lunch')VALUES ('%@','%@')",[datePickerLabel text],arrayString];
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            
            //sqlite3_close(db);
            //NSAssert(0, @"could not update table");
            NSString *field3Str;
            NSString *sql5=[NSString stringWithFormat:@"SELECT  *  FROM calendar WHERE Date IS ('%@')",[datePickerLabel text]];
            sqlite3_stmt  *statement5;
            
            
            if (sqlite3_prepare(db, [sql5 UTF8String], -1, &statement5, nil)==SQLITE_OK) {
                while (sqlite3_step(statement5)==SQLITE_ROW) {
                    
                    
                    char *field3=(char *) sqlite3_column_text(statement5, 2);
                    field3Str= field3 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field3];
                    
                    
                }}
            //NSLog(@"%@",field3Str);
            if (field3Str.length==0) {
                
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Lunch = ('%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
                
                
                
                
                
            }
            else{
                
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Lunch =(Lunch||','||'%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
                
            }
            
        }
    }
    
    else if ([mealPicker.text isEqualToString:@"Dinner"]){
        
        NSString *sql=[NSString stringWithFormat:@"INSERT INTO calendar('Date','Dinner')VALUES ('%@','%@')",[datePickerLabel text],arrayString];
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            
            //sqlite3_close(db);
            //NSAssert(0, @"could not update table");
            
            NSString *field3Str;
            NSString *sql5=[NSString stringWithFormat:@"SELECT  *  FROM calendar WHERE Date IS ('%@')",[datePickerLabel text]];
            sqlite3_stmt  *statement5;
            
            
            if (sqlite3_prepare(db, [sql5 UTF8String], -1, &statement5, nil)==SQLITE_OK) {
                while (sqlite3_step(statement5)==SQLITE_ROW) {
                    
                    
                    char *field3=(char *) sqlite3_column_text(statement5, 3);
                    field3Str= field3 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field3];
                    
                    
                }}
            // NSLog(@"%@",field3Str);
            if (field3Str.length==0) {
                
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Dinner = ('%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
                
                
                
            }
            else
            {
                
                
                
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Dinner = (Dinner||','||'%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
            }
            
            
            
        }
    }
    
    else if ([mealPicker.text isEqualToString:@"Other"]){
        
        NSString *sql=[NSString stringWithFormat:@"INSERT INTO calendar('Date','Other')VALUES ('%@','%@')",[datePickerLabel text],arrayString];
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            
            //sqlite3_close(db);
            //NSAssert(0, @"could not update table");
            
            NSString *field3Str;
            NSString *sql5=[NSString stringWithFormat:@"SELECT  *  FROM calendar WHERE Date IS ('%@')",[datePickerLabel text]];
            sqlite3_stmt  *statement5;
            
            
            if (sqlite3_prepare(db, [sql5 UTF8String], -1, &statement5, nil)==SQLITE_OK) {
                while (sqlite3_step(statement5)==SQLITE_ROW) {
                    
                    
                    char *field3=(char *) sqlite3_column_text(statement5, 4);
                    field3Str= field3 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field3];
                    
                    
                }}
            //NSLog(@"%@",field3Str);
            if (field3Str.length==0) {
                
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Other =('%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
                
                
            }
            else{
                NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Other =(Other||','||'%@') WHERE Date IS ('%@')",arrayString,[datePickerLabel text]];
                sqlite3_stmt  *statement1;
                
                
                
                const char *insert_stmt = [insertSQL UTF8String];
                sqlite3_prepare_v2(db, insert_stmt,
                                   -1, &statement1, NULL);
                if (sqlite3_step(statement1) == SQLITE_DONE)
                {
                    // NSLog(@"%@",@"contact added");
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",@"failed");
                    
                }
            }
            
            
            
        }
    }
    for(int i=0;i< cellNo ;i++)
    {
        [Bool replaceObjectAtIndex:i withObject:@"0"];
    }
    products=[[NSMutableArray alloc]init];
     [listTable reloadData];
    [selection removeFromSuperview];
    [products removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:products forKey:@"productArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];

      //[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
   // [self.navigationController dismissModalViewControllerAnimated:NO];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ADDED" message:@"Product added to calendar." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.
    
    if (buttonIndex == 0) {
        
        [self popUpOK];
        
        
    }
    
    
    
}
-(void)popUpOK
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    for(int i=0;i< cellNo ;i++)
    {
        [Bool replaceObjectAtIndex:i withObject:@"0"];
    }
    [listTable reloadData];
}
-(void)back
{
    [selection removeFromSuperview];
}



@end
