//
//  IMrecipieList.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 08/02/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMrecipieList.h"
#import "SVProgressHUD.h"
@interface IMrecipieList ()

@end

@implementation IMrecipieList
{
    DetailViewcontroller *dvController;
}
@synthesize searchBar,searchButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
{
    [self.tabBarController setDelegate:self];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    tabbarItem=[[NSUserDefaults standardUserDefaults]boolForKey:@"tabItem"];
    if (tabbarItem==YES) {
        return NO;
    }
    
    //tabbarItem=NO;
    
    return YES;
}
- (void)viewDidLoad
{
   
    
    o=0;
    copyRecipies=[[NSMutableArray alloc]init];
     count=[[NSMutableArray alloc]init];
    copyImages=[[NSMutableArray alloc]init];
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320,44)];
    searchBar.delegate = self;
    searchBar.barStyle=UIBarStyleBlack;
    searchBar.showsCancelButton=YES;
    searchBar.placeholder=@"Search";
    searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    searchBar.backgroundColor=[UIColor blackColor];
    searchBar.hidden=YES;
    [self.view addSubview:searchBar];
    
    
    searching=NO;
    letUserSelectRow=YES;

    
    [self showActivityIndicater];
    
    name=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
   // NSLog(@"name is %@",name );
    cellNo=[[NSUserDefaults standardUserDefaults]integerForKey:@"cell"];
    
    allNames=[[NSArray alloc]initWithObjects:
              @"A-Spare Me some Garlic",
              @"Almost Deep Fat Fried Cauliflower",
              @"American Pancakes",
              @"Apple Cinnamon Steel Cut Oats, slow cooker",
              @"Apple Jacks Cereal",
              @"Asian Ground Turkey Wraps",
              
              @"Baby Bok Choy & Mushrooms",
              @"Bacon Bruschetta Stuffed Chicken Breast, slow cooker",
              @"Baked Parmesan Tomatoes",
              @"Baked Rhubarb Dessert",
              @"Baked Tomato Turkey",
              @"Banana Oat Breakfast Cookie",
              @"Banana Split Breakfast",
              @"Bang Bang Shrimp",
              @"Barely There Meringues",
              @"BBQ Chicken, slow cooker",
              @"Berry Crumble, slow cooker",
              @"Berry Muffins",
              @"Black-Thai Affair Salad Dressing",
              @"Boost Me Up Granola",
              @"Braised Zucchini and Sun Gold Cherry Tomatoes",
              @"Broccoli Pesto Veggie Dip",
              @"Broccoli Slaw Meatballs",
              @"Brussels Sprouts Tomato Salad",
              @"Buffalo Chicken Meatballs",
              @"Cabbage Chicken Salad",
              @"Cabbage Roll Casserole",
              @"Casserole for Dummies",
              @"Cauli-Rice",
              @"Cauliflower Mashed Potatoes",
               @"Cauliflower Pizza Crust",
              @"Cauliflower Poppers",
             
              
              @"Cauliflower Tater Tots",
              
              @"Ceviche",
              @"Champion Chicken",
              @"Chargin’ Chicken, Slow Cooker",
              @"Chicken Adobo , Slow Cooker",
              @"Chicken, Pork and Shrimp Pancit",
              @"Chili-Lime Pork Chops",
              @"Chocolate Berry Drink",
              @"Chocolate Covered Banana Milkshake",
              @"Chocolate Fudgesicles",
              @"Chocolate Peanut Butter Milkshake",
              @"Chocolate Raspberry Dessert",
              @"Chocolate Soufflé",
              @"Cilantro-Garlic Sauce",
              @"Cilantro-Lime Chicken, Slow Cooker",
              @"Cinnamon Bun Pancakes",
              @"Cinnamon Faux Apples",
              @"Cinnamon Maple Oatmeal Muffins",
              @"Cinnamon Mochachino",
              @"Cod with Spinach and Tomatoes",
              @"Cookies & Cream Delight",
              @"Creamy Cauliflower Soup",
              @"Cucumber-Lime Salad",
              @"Cucumber, Onion & Tomato Salad",
              @"Curried Okra",
              @"Dreamsicle Delight Drink",
              @"Easy Teriyaki Salmon",
              @"Easy Tomato-Cucumber Salad",
              @"Egg-A-Licious Salad",
              @"Eggplant and Chard Salad",
              @"Eggplant Bruschetta",
              @"Eggs for Dinner",
              @"Energy Breakfast Cookie",
              @"Exotic Teahouse Chai Pudding",
              @"Faux Choco Eggs",
              @"Faux Potato Salad",
              @"Fit in Your Caprese Salad",
              @"Fresh Herb Dressing",
              @"Fresh Vinaigrette Dressing",
              @"Fried Rice",
              @"Fruit Smoothie",
              @"Garlic Spinach",
              @"Gar-licking Good Brussels Sprouts",
              @"Gilligan’s Island Chicken",
              @"Greek Goddess Dressing",
              @"Grilled Eggplant and Zucchini Salad",
              @"Guiltless Ratatouille",
              @"Halibut with Picante Sauce",
              @"Herb Rubbed Turkey Breast, slow cooker",
              @"Herb Your Enthusiasm Veggies",
              @"Holiday Green Beans",
              @"Hole in One",
              @"Home Skillet Turnip Fries",
              @"Homemade Natural Pizza Sauce",
              @"I’m Having PIE for breakfast",
              @"“I’m Not Cajun Around” Steak, Slow Cooker",
              @"“I’m So Stuffed!” Peppers",
              @"Incredible Hulk Smoothie",
              @"Italian Chicken in the Slow Cooker",
              @"It’s a Date!  Creamy Smoothie",
              @"It’s Lemon-Thyme Chicken, Slow Cooker",
              @"It’s Shredding Zucchini Thyme",
              @"Japanese Ginger Salad Dressing",
              @"Just like Carrot Cake",
              @"Kale and Avocado Salad",
              @"Kale Berry Smoothie",
              @"Key West Shrimp",
              @"Kickin’ Collard Greens",
              @"Legal Hash Brownies",
              @"Legal Lemon Noodles",
              @"Lem Me Some Chicken, Slow Cooker",
              @"Lemon Cabbage Wedge",
              @"Lemon Pepper Zucchini",
              @"Lemon Rosemary Broiled Salmon",
              @"Lemon Zest Tofu",
              @"Light and Fresh Marinade",
              @"Lime Coleslaw",
              @"LimeLIGHT Dressing",
              @"Magic Sauce",
              @"MaMaws Chicken ‘n’ Dumplings",
              @"Maple Dressing",
              @"“Mazing Marinade”",
              @"Mi-So Cute Cucumber Salad",
              @"Mongolian Beef Goulash, Slow Coo",
              @"Must Try Roasted Fennel Root",
              @"No-Fail Kale Chips",
              @"No Fluke Zuke, Slow Cooker",
              @"No time to cook, Chicken Crockpot dinner",
              @"Oatmeal Cookies",
              @"Oatmeal Zucchini Muffins",
              @"Old School Oatmeal",
              @"Once upon a Thyme Zucchini",
              @"Paprika Chicken, Slow Cooker",
              @"Paradise Stir Fry",
              @"Peach and Mango Salsa",
              @"Pepperoni Pizza Casserole",
              @"Perfect Potato Rolls",
              @"Pizza-Stuffed Zucchini Boats",
              @"Pumpkin Pie",
              @"Put a Lime with your Coconut-Trout",
              @"Poppy Seed Dressing",
              @"Portobello Steaks",
              @"Put a Pork in it Dinner, Slow Cooker",
              @"Quick Chicken Teriyaki",
              @"Quick Quiche Cups",
              @"Quinoa and Black Beans",
              @"Quinoa Berry Crunch",
              @"Raspberry Cream",
              @"Raspberry-Lemon Breakfast Cheesecake",
              @"Raspberry-Lime Smoothie",
              @"Raspberry Smoothie",
              @"Refreshing Cucumber-Dill Salad",
              @"Rice Crispy Cereal Cakes",
              @"Roasted Veggies, Slow Cooker",
              @"Roasted Watermelon Radishes",
              @"Rockin’ Zucchini Lasagna",
              @"Rollin’ in Cabbage",
              @"Rosie’s One Dish Dinner",
              @"Rotini Pasta and Vegetables",
              @"Salmon & Broccoli Scramble",
              @"Sautéed Snow Peas with Lemon & Parsley",
              @"Savory Pork Chops",
              @"Scrambling for Energy Meal",
              @"Sesame-Soy Crusted Pork Tenderloin",
              @"Sesame Soy Dressing",
              @"Shrimp Skimpy",
              @"Shroom Burgers",
              @"Simple Pork Loin Chops",
              @"Simple Skinny Dressing",
              @"Simply Italian Dressing",
              @"Sinless Scallops and Spinach",
              @"Skinny Cookie Dough",
              @"So Orzo Side Dish",
               @"Southwestern Spicy Pork, Slow Cooker",
              @"Southwest Roasted Veggies",
              @"Spice Up Your Life Latin Soup",
              @"Spicy Pork, Slow Cooker",
              @"Spicy Sausage, Peppers and Onions",
              @"Stewed Okra & Tomatoes",
              @"Stir-Fry Bok Choy",
              @"Strawberry Oat Bars",
              @"Sugar Sheriff Onion Dressing",
              @"Summer Lime Celery Salad",
              @"Sunflower-Parm Crackers",
              @"Strawberry Colada Drink",
              @"Strawberry Creamsicles",
              @"Super Low Carb Pancakes",
              @"Sweet Potato Vanilla Pancakes",
              @"Sweet & Sour Cabbage",
              @"Sweet, Spicy & Sour Salad or Garnish",
              @"Tangy Tomato Vinaigrette",
              @"Thai Me Up Chicken",
              @"Toasted Green Bean Fries",
              @"Tofu-lly Terrific Cesear Dressing",
              @"Turkey Meatballs and Veggies",
              @"Turkey Roll Up",
              @"Vampire Repellant Shrimp",
              @"Vanilla Cappuccino Dessert",
              @"Vegetable Frittata",
              @"Vegetarian Crispy “Fried Chicken”",
              @"Wonderful Waffles",
              @"Wrappin Up Dinner!",
              @"Zelicious Zucchini Bread",
              @"Zucchini Chips",
              @"Zucchini Fettucini",
              @"Zucchini-Lime Hummus",nil];
    
       
//    allImages = [NSArray arrayWithObjects:
//                 [UIImage imageNamed:@"1.jpg"],
//                 [UIImage imageNamed:@"2.jpg"],
//                 [UIImage imageNamed:@"3.p"],
//                 [UIImage imageNamed:@"4.jpg"],
//                 nil] ;
    
    allImages = [NSArray arrayWithObjects:
                [UIImage imageNamed:@"A-spare-me-some-garlic_100px.jpg"],
                [UIImage imageNamed:@"almost-deep-fat-fried-cauliflower_100px.jpg"],
                [UIImage imageNamed:@"American-Pancakes_100px.jpg"],
                [UIImage imageNamed:@"apple-cinnamon-steel-cut-oats-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Apple-Jacks-Cereal_100px.jpg"],
                 [UIImage imageNamed:@"asian-ground-turkey-wrap-_100px.jpg"],
                 [UIImage imageNamed:@"Baby-Bok-Choy-with-Shiitake-Mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"bacon-bruschetta-stuffed-chicken_100px.jpg"],
                 [UIImage imageNamed:@"baked-parmesan-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"baked-rhubarb-dessert_100px.jpg"],
                 [UIImage imageNamed:@"baked-tomato-turkey_100px.jpg"],
                 [UIImage imageNamed:@"banana-oat-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"banana-split-brkfast_100px.jpg"],
                 [UIImage imageNamed:@"bang-bang-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"barely-there-meringues_100px.jpg"],
                 [UIImage imageNamed:@"bbq-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"berry-crumble_100px.jpg"],
                 [UIImage imageNamed:@"berry-muffins_100px.jpg"],
                 [UIImage imageNamed:@"black-thai-affair-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"boost-me-up-granola_100px.jpg"],
                 [UIImage imageNamed:@"braised-zucchini-and-sun-gold-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"brocolli-pesto_100px.jpg"],
                 [UIImage imageNamed:@"Broccoli-Slaw-Meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Brussels-Sprouts-and-Tomato-Salad_100px.jpg"],
                 [UIImage imageNamed:@"buffalo-chicken-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Cabbage-Chicken-Salad_100px.jpg"],
                 [UIImage imageNamed:@"cabbage-roll-casserole_100px.jpg"],
                 [UIImage imageNamed:@"casserole-for-dummies_100px.jpg"],
                 [UIImage imageNamed:@"cauli-rice_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-mashed-potatoes_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-pizza-crust_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-poppers_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-tater-tots_100px.jpg"],
                 [UIImage imageNamed:@"ceviche_100px.jpg"],
                 [UIImage imageNamed:@"champion-chicken_100px.jpg"],
                 [UIImage imageNamed:@"chargin-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Chicken-Adobo_100px.jpg"],
                 [UIImage imageNamed:@"chicken-pork-shrimp-pancit_100px.jpg"],
                 [UIImage imageNamed:@"chili-lime-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-berry-drink_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-covered-banana-milkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-fudgsicles_100px.jpg"],
                 [UIImage imageNamed:@"ChocolatePeanutButtermilkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-raspberry-dessert_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-souffle_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                // [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-lime-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Cinnamon-bun-Pancakes_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-faux-apples_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-maple-oatmeal-muffins_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-mochachino_100px.jpg"],
                 [UIImage imageNamed:@"cod-with-spinach-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"cookies-and-cream-delight_100px.jpg"],
                 [UIImage imageNamed:@"creamy-cauliflower-soup_100px.jpg"],
                 [UIImage imageNamed:@"cucumber-lime-salad_100px.jpg"],
                 [UIImage imageNamed:@"cucumber,-onion-and-tomato-salad_100px.jpg"],
                 [UIImage imageNamed:@"curried-okra_100px.jpg"],
                 [UIImage imageNamed:@"dreamsicle-delight-drink_100px.jpg"],
                 [UIImage imageNamed:@"easy-teriyaki-salmon_100px.jpg"],
                 [UIImage imageNamed:@"Easy-tomato-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"egg-a-licious-salad_100px.jpg"],
                 [UIImage imageNamed:@"Eggplant-and-Chard-Salad_100px.jpg"],
                  [UIImage imageNamed:@"eggplant-brushetta_100px.jpg"],
                 [UIImage imageNamed:@"eggs-for-dinner_100px.jpg"],
                 [UIImage imageNamed:@"energy-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"Exotic-Teahouse-Chai-Pudding_100px.jpg"],
                 [UIImage imageNamed:@"faux-choco-eggs_100px.jpg"],
                 [UIImage imageNamed:@"faux-potato-salad_100px.jpg"],
                 [UIImage imageNamed:@"fit-in-your-caprese-salad_100px.jpg"],
                 [UIImage imageNamed:@"fresh-herb-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fresh-vinaigrette-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fried-rice_100px.jpg"],
                 [UIImage imageNamed:@"fruit-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"garlic-spinach_100px.jpg"],
                 [UIImage imageNamed:@"gar-licking-good-brussel-sprouts_100px.jpg"],
                 [UIImage imageNamed:@"giligans-island-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Greek-Goddess-dressing_100px.jpg"],
                 [UIImage imageNamed:@"grilled-eggplant-and-zucchini-salad_100px.jpg"],
                 [UIImage imageNamed:@"guiltless-rataouille_100px.jpg"],
                 [UIImage imageNamed:@"halibut-with-picante-sauce_100px.jpg"],
                 [UIImage imageNamed:@"herb-rubbed-turkey-breast_100px.jpg"],
                 [UIImage imageNamed:@"herb-your-enthusiasm-veggies_100px.jpg"],
                 [UIImage imageNamed:@"holiday-green-beans_100px.jpg"],
                 [UIImage imageNamed:@"hole-in-one_100px.jpg"],
                 [UIImage imageNamed:@"home-skillet-turnip-fries_100px.jpg"],
                 [UIImage imageNamed:@"homemade-pizza-sauce_100px.jpg"],
                 [UIImage imageNamed:@"I'm-having-Pie-for-breakfast_100px.jpg"],
                 [UIImage imageNamed:@"I'm-not-Cajun-Around-Steak_100px.jpg"],
                 [UIImage imageNamed:@"I'm-so-stuffed-peppers_100px.jpg"],
                 [UIImage imageNamed:@"incredible-hulk-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"italian-chicken-in-the-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"its-a-date-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"Its-Lemon-Thyme-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"It's-Shredding-Zucchini-Thyme_100px.jpg"],
                 [UIImage imageNamed:@"japanese-ginger-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"just-like-carrot-cake_100px.jpg"],
                 [UIImage imageNamed:@"kale-and-avocado-salad_100px.jpg"],
                 [UIImage imageNamed:@"kale-berry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"key-west-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"kickin-collard-greens_100px.jpg"],
                 [UIImage imageNamed:@"Legal-Hash-Browns_100px.jpg"],
                 [UIImage imageNamed:@"legal-lemon-noodles-php_100px.jpg"],
                 [UIImage imageNamed:@"Lem-Me-Some-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"lemon-cabbage-wedge_100px.jpg"],
                 [UIImage imageNamed:@"lemon-pepper-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"lemon-rosemary-broiled-salmon_100px.jpg"],
                 [UIImage imageNamed:@"lemon-zest-tofu_100px.jpg"],
                 [UIImage imageNamed:@"light-and-fresh-marinade_100px.jpg"],
                 [UIImage imageNamed:@"Lime-Coleslaw_100px.jpg"],
                 [UIImage imageNamed:@"limelight-dressing_100px.jpg"],
                 [UIImage imageNamed:@"magic-sauce__100px.jpg"],
                 [UIImage imageNamed:@"MaMaws-Chicken-'n'-Dumplings_100px.jpg"],
                 [UIImage imageNamed:@"maple-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Mazing-Marinade_100px.jpg"],
                 [UIImage imageNamed:@"mi-so-cute-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"mongolian-beef-goulash_100px.jpg"],
                 [UIImage imageNamed:@"must-try-roasted-fennel-root_100px.jpg"],
                 [UIImage imageNamed:@"no-fail-kale-chips_100px.jpg"],
                 [UIImage imageNamed:@"no-fluke-zuke_100px.jpg"],
                 [UIImage imageNamed:@"no-time-to-cook,-chicken-crockpot_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-cookies_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-zucchini-muffins_100px.jpg"],
                 [UIImage imageNamed:@"Old-school-oatmeal_100px.jpg"],
                 [UIImage imageNamed:@"once-upon-a-thyme-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"paprika-chicken,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"paradise-stir-fry_100px.jpg"],
                 [UIImage imageNamed:@"peach-and-mango-salsa_100px.jpg"],
                 [UIImage imageNamed:@"pepperoni-pizza-casserole_100px.jpg"],
                 [UIImage imageNamed:@"perfect-potato-rolls_100px.jpg"],
                 [UIImage imageNamed:@"pizza-stuffed-zucchini-boats_100px.jpg"],
                 [UIImage imageNamed:@"pumpkin-pie_100px.jpg"],
                 [UIImage imageNamed:@"Put-a-Lime-with-your-coconut-Trout_100px.jpg"],
                 [UIImage imageNamed:@"poppyseed-dressing_100px.jpg"],
                 [UIImage imageNamed:@"portobello-steaks_100px.jpg"],
                 [UIImage imageNamed:@"put-a-pork-in-it-dinner_100px.jpg"],
                 [UIImage imageNamed:@"quick-chicken-teriyaki_100px.jpg"],
                 [UIImage imageNamed:@"quick-quiche-cups_100px.jpg"],
                 [UIImage imageNamed:@"Quinoa-and-black-beans_100px.jpg"],
                 [UIImage imageNamed:@"quinoa-berry-crunch_100px.jpg"],
                
                 [UIImage imageNamed:@"raspberry-cream_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-lemon-cheesecake_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-lime-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"refreshing-cucumber-dill-salad_100px.jpg"],
                 [UIImage imageNamed:@"rice-crispy-treat_100px.jpg"],
                 [UIImage imageNamed:@"roasted-veggies,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"roasted-watermellon-radishes_100px.jpg"],
                 [UIImage imageNamed:@"rockin-zucchini-lasagna_100px.jpg"],
                 [UIImage imageNamed:@"rollin-in-cabbage-1_100px.jpg"],
                 [UIImage imageNamed:@"rosie's-one-dish-dinner_100px.jpg"],
                 [UIImage imageNamed:@"rotini-pasta-and-vegetables_100px.jpg"],
                 [UIImage imageNamed:@"Salmon-and-brocoli-eggs_100px.jpg"],
                 [UIImage imageNamed:@"sauteed-snow-peas-with-lemon-and-parsley_100px.jpg"],
                 [UIImage imageNamed:@"savory-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"scrambling-for-energy-meal_100px.jpg"],
                 [UIImage imageNamed:@"sesame-soy-crusted-pork_100px.jpg"],
                 [UIImage imageNamed:@"Sesame-Soy-Dressing_100px.jpg"],
                 [UIImage imageNamed:@"shrimp-skimpy_100px.jpg"],
                 [UIImage imageNamed:@"Shroom-Burgers_100px.jpg"],
                 [UIImage imageNamed:@"simple-pork-loin-chops_100px.jpg"],
                 [UIImage imageNamed:@"simple-skinny-dressing_100px.jpg"],
                 [UIImage imageNamed:@"simply-italian-dressing_100px.jpg"],
                 [UIImage imageNamed:@"sinless-scallops-and-spinach_100px.jpg"],
                 [UIImage imageNamed:@"skinny-cookie-doughjpg_100px.jpg"],
                 [UIImage imageNamed:@"So-orzo-side-dish_100px.jpg"],
                 [UIImage imageNamed:@"southwestern-spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"southwest-roasted-veggies_100px.jpg"],
                 [UIImage imageNamed:@"latin-soup_100px.jpg"],
                 [UIImage imageNamed:@"spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"spicy-sausage,-peppers-and-mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"stewed-okra-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"stir-fry-bokchoy_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-oat-bars_100px.jpg"],
                 [UIImage imageNamed:@"sugar-sheriff-onion-dressing_100px.jpg"],
                 [UIImage imageNamed:@"summer-lime-celery-salad_100px.jpg"],
                 [UIImage imageNamed:@"sunflower-parm-crackers_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-colada-drink_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-creamcicles_100px.jpg"],
                 [UIImage imageNamed:@"super-low-carb-pancakes_100px.jpg"],
                 [UIImage imageNamed:@"sweet-potato-vanilla-pancake_100px.jpg"],
                 [UIImage imageNamed:@"sweet-sour-red-cabbage_100px.jpg"],
                 [UIImage imageNamed:@"Sweet,-Spicy-&-Sour-Salad-or-Garnish_100px.jpg"],
                 [UIImage imageNamed:@"tangy-tomato-vinaigrette_100px.jpg"],
                 [UIImage imageNamed:@"thai-me-up-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Toasted-Green-Bean-Fries_100px.jpg"],
                 [UIImage imageNamed:@"tofu-lly-Terrific-ceasar-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Turkey-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"turkey-roll-up_100px.jpg"],
                 [UIImage imageNamed:@"vampire-repellant-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"vanilla-cappuccino_100px.jpg"],
                 [UIImage imageNamed:@"vegetable-fritata_100px.jpg"],
                 [UIImage imageNamed:@"vegetarian-crispy-fried-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Wonderful-Waffles_100px.jpg"],
                 [UIImage imageNamed:@"wrappin-up-dinner_100px.jpg"],
                 [UIImage imageNamed:@"Zelicious-Zucchini-Bread_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-chips_100px.jpg"],
                 [UIImage imageNamed:@"zucchini_fettuccine_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-lime-hummus_100px.jpg"],nil] ;
   
    
    
    
    
    
    
    phase1Names=[[NSArray alloc]initWithObjects:
                 @"A-Spare Me some Garlic",
                 @"Almost Deep Fat Fried Cauliflower",
              @"American Pancakes",
             
              @"Apple Jacks Cereal",
              @"Asian Ground Turkey Wraps",
              
              @"Baby Bok Choy & Mushrooms",
              @"Bacon Bruschetta Stuffed Chicken Breast, slow cooker",
           
              @"Baked Rhubarb Dessert",
              @"Baked Tomato Turkey",
          
           
              @"Bang Bang Shrimp",
              @"Barely There Meringues",
              @"BBQ Chicken, slow cooker",
              @"Berry Crumble, slow cooker",
              @"Berry Muffins",
              @"Black-Thai Affair Salad Dressing",
             
              @"Braised Zucchini and Sun Gold Cherry Tomatoes",
                  @"Broccoli Slaw Meatballs",
              @"Brussels Sprouts Tomato Salad",
              @"Buffalo Chicken Meatballs",
              @"Cabbage Chicken Salad",
              @"Cabbage Roll Casserole",
              @"Cauliflower Mashed Potatoes",
              @"Cauliflower Poppers",
              @"Cauliflower Pizza Crust",
              @"Cauli-Rice",
            
              @"Casserole for Dummies",
              @"Ceviche",
           
              @"Chargin’ Chicken, Slow Cooker",
              @"Chicken Adobo , Slow Cooker",
              @"Chicken, Pork and Shrimp Pancit",
              @"Chili-Lime Pork Chops",
              @"Chocolate Berry Drink",
              @"Chocolate Covered Banana Milkshake",
              @"Chocolate Fudgesicles",
              @"Chocolate Peanut Butter Milkshake",
              @"Chocolate Raspberry Dessert",
              @"Chocolate Soufflé",
              @"Cilantro-Garlic Sauce",
              @"Cilantro-Lime Chicken, Slow Cooker",
              @"Cinnamon Bun Pancakes",
              @"Cinnamon Faux Apples",
              @"Cinnamon Maple Oatmeal Muffins",
              @"Cinnamon Mochachino",
              @"Cod with Spinach and Tomatoes",
              @"Cookies & Cream Delight",
              @"Creamy Cauliflower Soup",
              @"Cucumber-Lime Salad",
              @"Cucumber, Onion & Tomato Salad",
              @"Curried Okra",
              @"Dreamsicle Delight Drink",
              @"Easy Teriyaki Salmon",
              @"Easy Tomato-Cucumber Salad",
              @"Egg-A-Licious Salad",
              @"Eggplant and Chard Salad",
              @"Eggplant Bruschetta",
              @"Eggs for Dinner",
           
              @"Exotic Teahouse Chai Pudding",
              @"Faux Choco Eggs",
              @"Faux Potato Salad",
              @"Fit in Your Caprese Salad",
              @"Fresh Herb Dressing",
              @"Fresh Vinaigrette Dressing",
              @"Fried Rice",
              @"Fruit Smoothie",
              @"Garlic Spinach",
              @"Gar-licking Good Brussels Sprouts",
              @"Gilligan’s Island Chicken",
              @"Greek Goddess Dressing",
              @"Grilled Eggplant and Zucchini Salad",
              @"Guiltless Ratatouille",
              @"Halibut with Picante Sauce",
              @"Herb Rubbed Turkey Breast, slow cooker",
              @"Herb Your Enthusiasm Veggies",
              @"Holiday Green Beans",
              @"Hole in One",
              @"Home Skillet Turnip Fries",
              @"Homemade Natural Pizza Sauce",
             
              @"“I’m Not Cajun Around” Steak, Slow Cooker",
              @"“I’m So Stuffed!” Peppers",
             
              @"Italian Chicken in the Slow Cooker",
             
              @"It’s Lemon-Thyme Chicken, Slow Cooker",
              @"It’s Shredding Zucchini Thyme",
              @"Japanese Ginger Salad Dressing",
              @"Just like Carrot Cake",
            
           
              @"Key West Shrimp",
              @"Kickin’ Collard Greens",
              @"Legal Hash Brownies",
              @"Legal Lemon Noodles",
              @"Lem Me Some Chicken, Slow Cooker",
              @"Lemon Cabbage Wedge",
              @"Lemon Pepper Zucchini",
              @"Lemon Rosemary Broiled Salmon",
              @"Lemon Zest Tofu",
              @"Light and Fresh Marinade",
              @"Lime Coleslaw",
              @"LimeLIGHT Dressing",
              @"Magic Sauce",
              @"MaMaws Chicken ‘n’ Dumplings",
              @"Maple Dressing",
              @"“Mazing Marinade”",
              @"Mi-So Cute Cucumber Salad",
              @"Mongolian Beef Goulash, Slow Coo",
              @"Must Try Roasted Fennel Root",
              @"No-Fail Kale Chips",
              @"No Fluke Zuke, Slow Cooker",
              @"No time to cook, Chicken Crockpot dinner",
              @"Oatmeal Cookies",
              @"Oatmeal Zucchini Muffins",
             
              @"Once upon a Thyme Zucchini",
              @"Paprika Chicken, Slow Cooker",
              @"Paradise Stir Fry",
              @"Peach and Mango Salsa",
              @"Pepperoni Pizza Casserole",
              @"Perfect Potato Rolls",
              @"Pizza-Stuffed Zucchini Boats",
              @"Pumpkin Pie",
              @"Put a Lime with your Coconut-Trout",
              @"Poppy Seed Dressing",
              @"Portobello Steaks",
              @"Put a Pork in it Dinner, Slow Cooker",
              @"Quick Chicken Teriyaki",
              @"Quick Quiche Cups",
            
             
              @"Raspberry Cream",
           
              
              @"Raspberry Smoothie",
              @"Refreshing Cucumber-Dill Salad",
              @"Rice Crispy Cereal Cakes",
              @"Roasted Veggies, Slow Cooker",
              @"Roasted Watermelon Radishes",
             
              @"Rollin’ in Cabbage",
              @"Rosie’s One Dish Dinner",
              @"Rotini Pasta and Vegetables",
              @"Salmon & Broccoli Scramble",
              @"Sautéed Snow Peas with Lemon & Parsley",
              @"Savory Pork Chops",
              @"Scrambling for Energy Meal",
              @"Sesame-Soy Crusted Pork Tenderloin",
              @"Sesame Soy Dressing",
              @"Shrimp Skimpy",
              @"Shroom Burgers",
              @"Simple Pork Loin Chops",
              @"Simple Skinny Dressing",
              @"Simply Italian Dressing",
             @"Sinless Scallops and Spinach",
             
              @"Southwestern Spicy Pork, Slow Cooker",
              @"Southwest Roasted Veggies",
              @"Spice Up Your Life Latin Soup",
              @"Spicy Pork, Slow Cooker",
              @"Spicy Sausage, Peppers and Onions",
              @"Stewed Okra & Tomatoes",
              @"Stir-Fry Bok Choy",
             
              @"Sugar Sheriff Onion Dressing",
              @"Summer Lime Celery Salad",
         
              @"Strawberry Colada Drink",
              @"Strawberry Creamsicles",
              @"Super Low Carb Pancakes",
              
              @"Sweet & Sour Cabbage",
              @"Sweet, Spicy & Sour Salad or Garnish",
              @"Tangy Tomato Vinaigrette",
              @"Thai Me Up Chicken",
              @"Toasted Green Bean Fries",
              @"Tofu-lly Terrific Cesear Dressing",
              @"Turkey Meatballs and Veggies",
              @"Turkey Roll Up",
              @"Vampire Repellant Shrimp",
              @"Vanilla Cappuccino Dessert",
              @"Vegetable Frittata",
              @"Vegetarian Crispy “Fried Chicken”",
                 @"Wonderful Waffles",
              @"Wrappin Up Dinner!",
         
              @"Zucchini Chips",
              @"Zucchini Fettucini",
              @"Zucchini-Lime Hummus",nil];
    
    
    
    phase1Images = [NSArray arrayWithObjects:
                 [UIImage imageNamed:@"A-spare-me-some-garlic_100px.jpg"],
                 [UIImage imageNamed:@"almost-deep-fat-fried-cauliflower_100px.jpg"],
                 [UIImage imageNamed:@"American-Pancakes_100px.jpg"],
                // [UIImage imageNamed:@"apple-cinnamon-steel-cut-oats-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Apple-Jacks-Cereal_100px.jpg"],
                 [UIImage imageNamed:@"asian-ground-turkey-wrap-_100px.jpg"],
                 [UIImage imageNamed:@"Baby-Bok-Choy-with-Shiitake-Mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"bacon-bruschetta-stuffed-chicken_100px.jpg"],
                 //[UIImage imageNamed:@"baked-parmesan-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"baked-rhubarb-dessert_100px.jpg"],
                 [UIImage imageNamed:@"baked-tomato-turkey_100px.jpg"],
                 //[UIImage imageNamed:@"banana-oat-breakfast-cookie_100px.jpg"],
                // [UIImage imageNamed:@"banana-split-brkfast_100px.jpg"],
                 [UIImage imageNamed:@"bang-bang-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"barely-there-meringues_100px.jpg"],
                 [UIImage imageNamed:@"bbq-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"berry-crumble_100px.jpg"],
                 [UIImage imageNamed:@"berry-muffins_100px.jpg"],
                 [UIImage imageNamed:@"black-thai-affair-salad-dressing_100px.jpg"],
                 //[UIImage imageNamed:@"boost-me-up-granola_100px.jpg"],
                 [UIImage imageNamed:@"braised-zucchini-and-sun-gold-tomatoes_100px.jpg"],
                // [UIImage imageNamed:@"brocolli-pesto_100px.jpg"],
                 [UIImage imageNamed:@"Broccoli-Slaw-Meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Brussels-Sprouts-and-Tomato-Salad_100px.jpg"],
                 [UIImage imageNamed:@"buffalo-chicken-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Cabbage-Chicken-Salad_100px.jpg"],
                 [UIImage imageNamed:@"cabbage-roll-casserole_100px.jpg"],
                      [UIImage imageNamed:@"cauliflower-mashed-potatoes_100px.jpg"],
                    
                    [UIImage imageNamed:@"cauliflower-poppers_100px.jpg"],
                     [UIImage imageNamed:@"cauliflower-pizza-crust_100px.jpg"],
                    [UIImage imageNamed:@"cauli-rice_100px.jpg"],
                 [UIImage imageNamed:@"casserole-for-dummies_100px.jpg"],
                 
              
                
                 
                 //[UIImage imageNamed:@"cauliflower-tater-tots_100px.jpg"],
                 [UIImage imageNamed:@"ceviche_100px.jpg"],
                 //[UIImage imageNamed:@"champion-chicken_100px.jpg"],
                 [UIImage imageNamed:@"chargin-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Chicken-Adobo_100px.jpg"],
                 [UIImage imageNamed:@"chicken-pork-shrimp-pancit_100px.jpg"],
                 [UIImage imageNamed:@"chili-lime-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-berry-drink_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-covered-banana-milkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-fudgsicles_100px.jpg"],
                 [UIImage imageNamed:@"ChocolatePeanutButtermilkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-raspberry-dessert_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-souffle_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 // [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-lime-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Cinnamon-bun-Pancakes_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-faux-apples_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-maple-oatmeal-muffins_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-mochachino_100px.jpg"],
                 [UIImage imageNamed:@"cod-with-spinach-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"cookies-and-cream-delight_100px.jpg"],
                 [UIImage imageNamed:@"creamy-cauliflower-soup_100px.jpg"],
                 [UIImage imageNamed:@"cucumber-lime-salad_100px.jpg"],
                 [UIImage imageNamed:@"cucumber,-onion-and-tomato-salad_100px.jpg"],
                 [UIImage imageNamed:@"curried-okra_100px.jpg"],
                 [UIImage imageNamed:@"dreamsicle-delight-drink_100px.jpg"],
                 [UIImage imageNamed:@"easy-teriyaki-salmon_100px.jpg"],
                 [UIImage imageNamed:@"Easy-tomato-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"egg-a-licious-salad_100px.jpg"],
                 [UIImage imageNamed:@"Eggplant-and-Chard-Salad_100px.jpg"],
                 [UIImage imageNamed:@"eggplant-brushetta_100px.jpg"],
                 [UIImage imageNamed:@"eggs-for-dinner_100px.jpg"],
                 //[UIImage imageNamed:@"energy-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"Exotic-Teahouse-Chai-Pudding_100px.jpg"],
                 [UIImage imageNamed:@"faux-choco-eggs_100px.jpg"],
                 [UIImage imageNamed:@"faux-potato-salad_100px.jpg"],
                 [UIImage imageNamed:@"fit-in-your-caprese-salad_100px.jpg"],
                 [UIImage imageNamed:@"fresh-herb-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fresh-vinaigrette-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fried-rice_100px.jpg"],
                 [UIImage imageNamed:@"fruit-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"garlic-spinach_100px.jpg"],
                 [UIImage imageNamed:@"gar-licking-good-brussel-sprouts_100px.jpg"],
                 [UIImage imageNamed:@"giligans-island-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Greek-Goddess-dressing_100px.jpg"],
                 [UIImage imageNamed:@"grilled-eggplant-and-zucchini-salad_100px.jpg"],
                 [UIImage imageNamed:@"guiltless-rataouille_100px.jpg"],
                 [UIImage imageNamed:@"halibut-with-picante-sauce_100px.jpg"],
                 [UIImage imageNamed:@"herb-rubbed-turkey-breast_100px.jpg"],
                 [UIImage imageNamed:@"herb-your-enthusiasm-veggies_100px.jpg"],
                 [UIImage imageNamed:@"holiday-green-beans_100px.jpg"],
                 [UIImage imageNamed:@"hole-in-one_100px.jpg"],
                 [UIImage imageNamed:@"home-skillet-turnip-fries_100px.jpg"],
                 [UIImage imageNamed:@"homemade-pizza-sauce_100px.jpg"],
                // [UIImage imageNamed:@"I'm-having-Pie-for-breakfast_100px.jpg"],
                 [UIImage imageNamed:@"I'm-not-Cajun-Around-Steak_100px.jpg"],
                 [UIImage imageNamed:@"I'm-so-stuffed-peppers_100px.jpg"],
                 //[UIImage imageNamed:@"incredible-hulk-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"italian-chicken-in-the-slow-cooker_100px.jpg"],
                 //[UIImage imageNamed:@"its-a-date-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"Its-Lemon-Thyme-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"It's-Shredding-Zucchini-Thyme_100px.jpg"],
                 [UIImage imageNamed:@"japanese-ginger-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"just-like-carrot-cake_100px.jpg"],
                 //[UIImage imageNamed:@"kale-and-avocado-salad_100px.jpg"],
                // [UIImage imageNamed:@"kale-berry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"key-west-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"kickin-collard-greens_100px.jpg"],
                 [UIImage imageNamed:@"Legal-Hash-Browns_100px.jpg"],
                 [UIImage imageNamed:@"legal-lemon-noodles-php_100px.jpg"],
                 [UIImage imageNamed:@"Lem-Me-Some-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"lemon-cabbage-wedge_100px.jpg"],
                 [UIImage imageNamed:@"lemon-pepper-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"lemon-rosemary-broiled-salmon_100px.jpg"],
                 [UIImage imageNamed:@"lemon-zest-tofu_100px.jpg"],
                 [UIImage imageNamed:@"light-and-fresh-marinade_100px.jpg"],
                 [UIImage imageNamed:@"Lime-Coleslaw_100px.jpg"],
                 [UIImage imageNamed:@"limelight-dressing_100px.jpg"],
                 [UIImage imageNamed:@"magic-sauce__100px.jpg"],
                 [UIImage imageNamed:@"MaMaws-Chicken-'n'-Dumplings_100px.jpg"],
                 [UIImage imageNamed:@"maple-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Mazing-Marinade_100px.jpg"],
                 [UIImage imageNamed:@"mi-so-cute-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"mongolian-beef-goulash_100px.jpg"],
                 [UIImage imageNamed:@"must-try-roasted-fennel-root_100px.jpg"],
                 [UIImage imageNamed:@"no-fail-kale-chips_100px.jpg"],
                 [UIImage imageNamed:@"no-fluke-zuke_100px.jpg"],
                 [UIImage imageNamed:@"no-time-to-cook,-chicken-crockpot_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-cookies_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-zucchini-muffins_100px.jpg"],
                 //[UIImage imageNamed:@"Old-school-oatmeal_100px.jpg"],
                 [UIImage imageNamed:@"once-upon-a-thyme-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"paprika-chicken,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"paradise-stir-fry_100px.jpg"],
                 [UIImage imageNamed:@"peach-and-mango-salsa_100px.jpg"],
                 [UIImage imageNamed:@"pepperoni-pizza-casserole_100px.jpg"],
                 [UIImage imageNamed:@"perfect-potato-rolls_100px.jpg"],
                 [UIImage imageNamed:@"pizza-stuffed-zucchini-boats_100px.jpg"],
                 [UIImage imageNamed:@"pumpkin-pie_100px.jpg"],
                 [UIImage imageNamed:@"Put-a-Lime-with-your-coconut-Trout_100px.jpg"],
                 [UIImage imageNamed:@"poppyseed-dressing_100px.jpg"],
                 [UIImage imageNamed:@"portobello-steaks_100px.jpg"],
                 [UIImage imageNamed:@"put-a-pork-in-it-dinner_100px.jpg"],
                 [UIImage imageNamed:@"quick-chicken-teriyaki_100px.jpg"],
                 [UIImage imageNamed:@"quick-quiche-cups_100px.jpg"],
                // [UIImage imageNamed:@"Quinoa-and-black-beans_100px.jpg"],
                 //[UIImage imageNamed:@"spicy-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-cream_100px.jpg"],
                // [UIImage imageNamed:@"raspberry-lemon-cheesecake_100px.jpg"],
                // [UIImage imageNamed:@"raspberry-lime-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"refreshing-cucumber-dill-salad_100px.jpg"],
                   
                    [UIImage imageNamed:@"rice-crispy-treat_100px.jpg"],
                 [UIImage imageNamed:@"roasted-veggies,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"roasted-watermellon-radishes_100px.jpg"],
                 //[UIImage imageNamed:@"rockin-zucchini-lasagna_100px.jpg"],
                 [UIImage imageNamed:@"rollin-in-cabbage-1_100px.jpg"],
                 [UIImage imageNamed:@"rosie's-one-dish-dinner_100px.jpg"],
                 [UIImage imageNamed:@"rotini-pasta-and-vegetables_100px.jpg"],
                 [UIImage imageNamed:@"Salmon-and-brocoli-eggs_100px.jpg"],
                 [UIImage imageNamed:@"sauteed-snow-peas-with-lemon-and-parsley_100px.jpg"],
                 [UIImage imageNamed:@"savory-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"scrambling-for-energy-meal_100px.jpg"],
                 [UIImage imageNamed:@"sesame-soy-crusted-pork_100px.jpg"],
                 [UIImage imageNamed:@"Sesame-Soy-Dressing_100px.jpg"],
                 [UIImage imageNamed:@"shrimp-skimpy_100px.jpg"],
                 [UIImage imageNamed:@"Shroom-Burgers_100px.jpg"],
                 [UIImage imageNamed:@"simple-pork-loin-chops_100px.jpg"],
                 [UIImage imageNamed:@"simple-skinny-dressing_100px.jpg"],
                 [UIImage imageNamed:@"simply-italian-dressing_100px.jpg"],
                 [UIImage imageNamed:@"sinless-scallops-and-spinach_100px.jpg"],
                // [UIImage imageNamed:@"skinny-cookie-doughjpg_100px.jpg"],
                // [UIImage imageNamed:@"So-orzo-side-dish_100px.jpg"],
                 [UIImage imageNamed:@"southwestern-spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"southwest-roasted-veggies_100px.jpg"],
                 [UIImage imageNamed:@"latin-soup_100px.jpg"],
                 [UIImage imageNamed:@"spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"spicy-sausage,-peppers-and-mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"stewed-okra-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"stir-fry-bokchoy_100px.jpg"],
                 //[UIImage imageNamed:@"strawberry-oat-bars_100px.jpg"],
                 [UIImage imageNamed:@"sugar-sheriff-onion-dressing_100px.jpg"],
                 [UIImage imageNamed:@"summer-lime-celery-salad_100px.jpg"],
                // [UIImage imageNamed:@"sunflower-parm-crackers_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-colada-drink_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-creamcicles_100px.jpg"],
                 [UIImage imageNamed:@"super-low-carb-pancakes_100px.jpg"],
                // [UIImage imageNamed:@"sweet-potato-vanilla-pancake_100px.jpg"],
                 [UIImage imageNamed:@"sweet-sour-red-cabbage_100px.jpg"],
                 [UIImage imageNamed:@"Sweet,-Spicy-&-Sour-Salad-or-Garnish_100px.jpg"],
                 [UIImage imageNamed:@"tangy-tomato-vinaigrette_100px.jpg"],
                 [UIImage imageNamed:@"thai-me-up-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Toasted-Green-Bean-Fries_100px.jpg"],
                 [UIImage imageNamed:@"tofu-lly-Terrific-ceasar-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Turkey-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"turkey-roll-up_100px.jpg"],
                 [UIImage imageNamed:@"vampire-repellant-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"vanilla-cappuccino_100px.jpg"],
                 [UIImage imageNamed:@"vegetable-fritata_100px.jpg"],
                 [UIImage imageNamed:@"vegetarian-crispy-fried-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Wonderful-Waffles_100px.jpg"],
                 [UIImage imageNamed:@"wrappin-up-dinner_100px.jpg"],
                 //[UIImage imageNamed:@"Zelicious-Zucchini-Bread_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-chips_100px.jpg"],
                 [UIImage imageNamed:@"zucchini_fettuccine_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-lime-hummus_100px.jpg"],nil] ;
    
    
    
    
   
    
    phase3Names=[[NSArray alloc]initWithObjects:
                  @"A-Spare Me some Garlic",
                 @"Almost Deep Fat Fried Cauliflower",
              @"American Pancakes",
              @"Apple Cinnamon Steel Cut Oats, slow cooker",
              @"Apple Jacks Cereal",
              @"Asian Ground Turkey Wraps",
             
              @"Baby Bok Choy & Mushrooms",
              @"Bacon Bruschetta Stuffed Chicken Breast, slow cooker",
              @"Baked Parmesan Tomatoes",
              @"Baked Rhubarb Dessert",
              @"Baked Tomato Turkey",
            
              @"Banana Split Breakfast",
              @"Bang Bang Shrimp",
              @"Barely There Meringues",
              @"BBQ Chicken, slow cooker",
              @"Berry Crumble, slow cooker",
              @"Berry Muffins",
              @"Black-Thai Affair Salad Dressing",
              @"Boost Me Up Granola",
              @"Braised Zucchini and Sun Gold Cherry Tomatoes",
                 
              @"Broccoli Slaw Meatballs",
              @"Brussels Sprouts Tomato Salad",
              @"Buffalo Chicken Meatballs",
              @"Cabbage Chicken Salad",
              @"Cabbage Roll Casserole",
                @"Casserole for Dummies",   
              @"Cauliflower Mashed Potatoes",
            
              @"Cauliflower Pizza Crust",
            @"Cauliflower Poppers",
             
            
              @"Ceviche",
              
              @"Chargin’ Chicken, Slow Cooker",
              @"Chicken Adobo , Slow Cooker",
              @"Chicken, Pork and Shrimp Pancit",
              @"Chili-Lime Pork Chops",
              @"Chocolate Berry Drink",
              @"Chocolate Covered Banana Milkshake",
              @"Chocolate Fudgesicles",
              @"Chocolate Peanut Butter Milkshake",
              @"Chocolate Raspberry Dessert",
              @"Chocolate Soufflé",
              @"Cilantro-Garlic Sauce",
              @"Cilantro-Lime Chicken, Slow Cooker",
              @"Cinnamon Bun Pancakes",
              @"Cinnamon Faux Apples",
              @"Cinnamon Maple Oatmeal Muffins",
              @"Cinnamon Mochachino",
              @"Cod with Spinach and Tomatoes",
              @"Cookies & Cream Delight",
              @"Creamy Cauliflower Soup",
              @"Cucumber-Lime Salad",
              @"Cucumber, Onion & Tomato Salad",
              @"Curried Okra",
              @"Dreamsicle Delight Drink",
              @"Easy Teriyaki Salmon",
              @"Easy Tomato-Cucumber Salad",
              @"Egg-A-Licious Salad",
              @"Eggplant and Chard Salad",
              @"Eggplant Bruschetta",
              @"Eggs for Dinner",
          
              @"Exotic Teahouse Chai Pudding",
              @"Faux Choco Eggs",
              @"Faux Potato Salad",
              @"Fit in Your Caprese Salad",
              @"Fresh Herb Dressing",
              @"Fresh Vinaigrette Dressing",
              @"Fried Rice",
              @"Fruit Smoothie",
              @"Garlic Spinach",
              @"Gar-licking Good Brussels Sprouts",
              @"Gilligan’s Island Chicken",
              @"Greek Goddess Dressing",
              @"Grilled Eggplant and Zucchini Salad",
              @"Guiltless Ratatouille",
              @"Halibut with Picante Sauce",
              @"Herb Rubbed Turkey Breast, slow cooker",
              @"Herb Your Enthusiasm Veggies",
              @"Holiday Green Beans",
              @"Hole in One",
              @"Home Skillet Turnip Fries",
              @"Homemade Natural Pizza Sauce",
              @"I’m Having PIE for breakfast",
              @"“I’m Not Cajun Around” Steak, Slow Cooker",
              @"“I’m So Stuffed!” Peppers",
              @"Incredible Hulk Smoothie",
              @"Italian Chicken in the Slow Cooker",
              @"It’s a Date!  Creamy Smoothie",
              @"It’s Lemon-Thyme Chicken, Slow Cooker",
              @"It’s Shredding Zucchini Thyme",
              @"Japanese Ginger Salad Dressing",
              @"Just like Carrot Cake",
            
              @"Kale Berry Smoothie",
              @"Key West Shrimp",
              @"Kickin’ Collard Greens",
              @"Legal Hash Brownies",
              @"Legal Lemon Noodles",
              @"Lem Me Some Chicken, Slow Cooker",
              @"Lemon Cabbage Wedge",
              @"Lemon Pepper Zucchini",
              @"Lemon Rosemary Broiled Salmon",
              @"Lemon Zest Tofu",
              @"Light and Fresh Marinade",
              @"Lime Coleslaw",
              @"LimeLIGHT Dressing",
              @"Magic Sauce",
              @"MaMaws Chicken ‘n’ Dumplings",
              @"Maple Dressing",
              @"“Mazing Marinade”",
              @"Mi-So Cute Cucumber Salad",
              @"Mongolian Beef Goulash, Slow Coo",
              @"Must Try Roasted Fennel Root",
              @"No-Fail Kale Chips",
              @"No Fluke Zuke, Slow Cooker",
              @"No time to cook, Chicken Crockpot dinner",
              @"Oatmeal Cookies",
              @"Oatmeal Zucchini Muffins",
            
              @"Once upon a Thyme Zucchini",
              @"Paprika Chicken, Slow Cooker",
              @"Paradise Stir Fry",
              @"Peach and Mango Salsa",
              @"Pepperoni Pizza Casserole",
              @"Perfect Potato Rolls",
              @"Pizza-Stuffed Zucchini Boats",
              @"Pumpkin Pie",
              @"Put a Lime with your Coconut-Trout",
              @"Poppy Seed Dressing",
              @"Portobello Steaks",
              @"Put a Pork in it Dinner, Slow Cooker",
              @"Quick Chicken Teriyaki",
              @"Quick Quiche Cups",
             
              @"Quinoa Berry Crunch",
              @"Raspberry Cream",
              @"Raspberry-Lemon Breakfast Cheesecake",
              @"Raspberry-Lime Smoothie",
              @"Raspberry Smoothie",
              @"Refreshing Cucumber-Dill Salad",
              @"Rice Crispy Cereal Cakes",
              @"Roasted Veggies, Slow Cooker",
              @"Roasted Watermelon Radishes",
           
              @"Rollin’ in Cabbage",
              @"Rosie’s One Dish Dinner",
              @"Rotini Pasta and Vegetables",
              @"Salmon & Broccoli Scramble",
              @"Sautéed Snow Peas with Lemon & Parsley",
              @"Savory Pork Chops",
              @"Scrambling for Energy Meal",
              @"Sesame-Soy Crusted Pork Tenderloin",
              @"Sesame Soy Dressing",
              @"Shrimp Skimpy",
              @"Shroom Burgers",
              @"Simple Pork Loin Chops",
              @"Simple Skinny Dressing",
              @"Simply Italian Dressing",
                  @"Sinless Scallops and Spinach",
             
              @"Southwestern Spicy Pork, Slow Cooker",
              @"Southwest Roasted Veggies",
              @"Spice Up Your Life Latin Soup",
              @"Spicy Pork, Slow Cooker",
              @"Spicy Sausage, Peppers and Onions",
              @"Stewed Okra & Tomatoes",
              @"Stir-Fry Bok Choy",
          
              @"Sugar Sheriff Onion Dressing",
              @"Summer Lime Celery Salad",
             
              @"Strawberry Colada Drink",
              @"Strawberry Creamsicles",
              @"Super Low Carb Pancakes",
              @"Sweet Potato Vanilla Pancakes",
              @"Sweet & Sour Cabbage",
              @"Sweet, Spicy & Sour Salad or Garnish",
              @"Tangy Tomato Vinaigrette",
              @"Thai Me Up Chicken",
              @"Toasted Green Bean Fries",
              @"Tofu-lly Terrific Cesear Dressing",
              @"Turkey Meatballs and Veggies",
              @"Turkey Roll Up",
              @"Vampire Repellant Shrimp",
              @"Vanilla Cappuccino Dessert",
              @"Vegetable Frittata",
              @"Vegetarian Crispy “Fried Chicken”",
                 @"Wonderful Waffles",
              @"Wrappin Up Dinner!",
              @"Zelicious Zucchini Bread",
              @"Zucchini Chips",
           
              @"Zucchini-Lime Hummus",nil];
   

    
    phase3Images = [NSArray arrayWithObjects:
                 [UIImage imageNamed:@"A-spare-me-some-garlic_100px.jpg"],
                 [UIImage imageNamed:@"almost-deep-fat-fried-cauliflower_100px.jpg"],
                 [UIImage imageNamed:@"American-Pancakes_100px.jpg"],
                 [UIImage imageNamed:@"apple-cinnamon-steel-cut-oats-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Apple-Jacks-Cereal_100px.jpg"],
                 [UIImage imageNamed:@"asian-ground-turkey-wrap-_100px.jpg"],
                 [UIImage imageNamed:@"Baby-Bok-Choy-with-Shiitake-Mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"bacon-bruschetta-stuffed-chicken_100px.jpg"],
                 [UIImage imageNamed:@"baked-parmesan-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"baked-rhubarb-dessert_100px.jpg"],
                 [UIImage imageNamed:@"baked-tomato-turkey_100px.jpg"],
                // [UIImage imageNamed:@"banana-oat-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"banana-split-brkfast_100px.jpg"],
                 [UIImage imageNamed:@"bang-bang-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"barely-there-meringues_100px.jpg"],
                 [UIImage imageNamed:@"bbq-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"berry-crumble_100px.jpg"],
                 [UIImage imageNamed:@"berry-muffins_100px.jpg"],
                 [UIImage imageNamed:@"black-thai-affair-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"boost-me-up-granola_100px.jpg"],
                 [UIImage imageNamed:@"braised-zucchini-and-sun-gold-tomatoes_100px.jpg"],
                // [UIImage imageNamed:@"brocolli-pesto_100px.jpg"],
                 [UIImage imageNamed:@"Broccoli-Slaw-Meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Brussels-Sprouts-and-Tomato-Salad_100px.jpg"],
                 [UIImage imageNamed:@"buffalo-chicken-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Cabbage-Chicken-Salad_100px.jpg"],
                 [UIImage imageNamed:@"cabbage-roll-casserole_100px.jpg"],
                 [UIImage imageNamed:@"casserole-for-dummies_100px.jpg"],
                 //[UIImage imageNamed:@"cauli-rice_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-mashed-potatoes_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-pizza-crust_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-poppers_100px.jpg"],
                 //[UIImage imageNamed:@"cauliflower-tater-tots_100px.jpg"],
                 [UIImage imageNamed:@"ceviche_100px.jpg"],
                 //[UIImage imageNamed:@"champion-chicken_100px.jpg"],
                 [UIImage imageNamed:@"chargin-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Chicken-Adobo_100px.jpg"],
                 [UIImage imageNamed:@"chicken-pork-shrimp-pancit_100px.jpg"],
                 [UIImage imageNamed:@"chili-lime-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-berry-drink_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-covered-banana-milkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-fudgsicles_100px.jpg"],
                 [UIImage imageNamed:@"ChocolatePeanutButtermilkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-raspberry-dessert_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-souffle_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 // [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-lime-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Cinnamon-bun-Pancakes_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-faux-apples_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-maple-oatmeal-muffins_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-mochachino_100px.jpg"],
                 [UIImage imageNamed:@"cod-with-spinach-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"cookies-and-cream-delight_100px.jpg"],
                 [UIImage imageNamed:@"creamy-cauliflower-soup_100px.jpg"],
                 [UIImage imageNamed:@"cucumber-lime-salad_100px.jpg"],
                 [UIImage imageNamed:@"cucumber,-onion-and-tomato-salad_100px.jpg"],
                 [UIImage imageNamed:@"curried-okra_100px.jpg"],
                 [UIImage imageNamed:@"dreamsicle-delight-drink_100px.jpg"],
                 [UIImage imageNamed:@"easy-teriyaki-salmon_100px.jpg"],
                 [UIImage imageNamed:@"Easy-tomato-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"egg-a-licious-salad_100px.jpg"],
                 [UIImage imageNamed:@"Eggplant-and-Chard-Salad_100px.jpg"],
                 [UIImage imageNamed:@"eggplant-brushetta_100px.jpg"],
                 [UIImage imageNamed:@"eggs-for-dinner_100px.jpg"],
                 //[UIImage imageNamed:@"energy-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"Exotic-Teahouse-Chai-Pudding_100px.jpg"],
                 [UIImage imageNamed:@"faux-choco-eggs_100px.jpg"],
                 [UIImage imageNamed:@"faux-potato-salad_100px.jpg"],
                 [UIImage imageNamed:@"fit-in-your-caprese-salad_100px.jpg"],
                 [UIImage imageNamed:@"fresh-herb-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fresh-vinaigrette-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fried-rice_100px.jpg"],
                 [UIImage imageNamed:@"fruit-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"garlic-spinach_100px.jpg"],
                 [UIImage imageNamed:@"gar-licking-good-brussel-sprouts_100px.jpg"],
                 [UIImage imageNamed:@"giligans-island-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Greek-Goddess-dressing_100px.jpg"],
                 [UIImage imageNamed:@"grilled-eggplant-and-zucchini-salad_100px.jpg"],
                 [UIImage imageNamed:@"guiltless-rataouille_100px.jpg"],
                 [UIImage imageNamed:@"halibut-with-picante-sauce_100px.jpg"],
                 [UIImage imageNamed:@"herb-rubbed-turkey-breast_100px.jpg"],
                 [UIImage imageNamed:@"herb-your-enthusiasm-veggies_100px.jpg"],
                 [UIImage imageNamed:@"holiday-green-beans_100px.jpg"],
                 [UIImage imageNamed:@"hole-in-one_100px.jpg"],
                 [UIImage imageNamed:@"home-skillet-turnip-fries_100px.jpg"],
                 [UIImage imageNamed:@"homemade-pizza-sauce_100px.jpg"],
                 [UIImage imageNamed:@"I'm-having-Pie-for-breakfast_100px.jpg"],
                 [UIImage imageNamed:@"I'm-not-Cajun-Around-Steak_100px.jpg"],
                 [UIImage imageNamed:@"I'm-so-stuffed-peppers_100px.jpg"],
                 [UIImage imageNamed:@"incredible-hulk-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"italian-chicken-in-the-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"its-a-date-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"Its-Lemon-Thyme-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"It's-Shredding-Zucchini-Thyme_100px.jpg"],
                 [UIImage imageNamed:@"japanese-ginger-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"just-like-carrot-cake_100px.jpg"],
                // [UIImage imageNamed:@"kale-and-avocado-salad_100px.jpg"],
                 [UIImage imageNamed:@"kale-berry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"key-west-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"kickin-collard-greens_100px.jpg"],
                 [UIImage imageNamed:@"Legal-Hash-Browns_100px.jpg"],
                 [UIImage imageNamed:@"legal-lemon-noodles-php_100px.jpg"],
                 [UIImage imageNamed:@"Lem-Me-Some-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"lemon-cabbage-wedge_100px.jpg"],
                 [UIImage imageNamed:@"lemon-pepper-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"lemon-rosemary-broiled-salmon_100px.jpg"],
                 [UIImage imageNamed:@"lemon-zest-tofu_100px.jpg"],
                 [UIImage imageNamed:@"light-and-fresh-marinade_100px.jpg"],
                 [UIImage imageNamed:@"Lime-Coleslaw_100px.jpg"],
                 [UIImage imageNamed:@"limelight-dressing_100px.jpg"],
                 [UIImage imageNamed:@"magic-sauce__100px.jpg"],
                 [UIImage imageNamed:@"MaMaws-Chicken-'n'-Dumplings_100px.jpg"],
                 [UIImage imageNamed:@"maple-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Mazing-Marinade_100px.jpg"],
                 [UIImage imageNamed:@"mi-so-cute-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"mongolian-beef-goulash_100px.jpg"],
                 [UIImage imageNamed:@"must-try-roasted-fennel-root_100px.jpg"],
                 [UIImage imageNamed:@"no-fail-kale-chips_100px.jpg"],
                 [UIImage imageNamed:@"no-fluke-zuke_100px.jpg"],
                 [UIImage imageNamed:@"no-time-to-cook,-chicken-crockpot_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-cookies_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-zucchini-muffins_100px.jpg"],
                 //[UIImage imageNamed:@"Old-school-oatmeal_100px.jpg"],
                 [UIImage imageNamed:@"once-upon-a-thyme-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"paprika-chicken,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"paradise-stir-fry_100px.jpg"],
                 [UIImage imageNamed:@"peach-and-mango-salsa_100px.jpg"],
                 [UIImage imageNamed:@"pepperoni-pizza-casserole_100px.jpg"],
                 [UIImage imageNamed:@"perfect-potato-rolls_100px.jpg"],
                 [UIImage imageNamed:@"pizza-stuffed-zucchini-boats_100px.jpg"],
                 [UIImage imageNamed:@"pumpkin-pie_100px.jpg"],
                 [UIImage imageNamed:@"Put-a-Lime-with-your-coconut-Trout_100px.jpg"],
                 [UIImage imageNamed:@"poppyseed-dressing_100px.jpg"],
                 [UIImage imageNamed:@"portobello-steaks_100px.jpg"],
                 [UIImage imageNamed:@"put-a-pork-in-it-dinner_100px.jpg"],
                 [UIImage imageNamed:@"quick-chicken-teriyaki_100px.jpg"],
                 [UIImage imageNamed:@"quick-quiche-cups_100px.jpg"],
                 //[UIImage imageNamed:@"Quinoa-and-black-beans_100px.jpg"],
                 [UIImage imageNamed:@"quinoa-berry-crunch_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-cream_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-lemon-cheesecake_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-lime-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"refreshing-cucumber-dill-salad_100px.jpg"],
                    
                    [UIImage imageNamed:@"rice-crispy-treat_100px.jpg"],
                 [UIImage imageNamed:@"roasted-veggies,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"roasted-watermellon-radishes_100px.jpg"],
                 //[UIImage imageNamed:@"rockin-zucchini-lasagna_100px.jpg"],
                 [UIImage imageNamed:@"rollin-in-cabbage-1_100px.jpg"],
                 [UIImage imageNamed:@"rosie's-one-dish-dinner_100px.jpg"],
                 [UIImage imageNamed:@"rotini-pasta-and-vegetables_100px.jpg"],
                 [UIImage imageNamed:@"Salmon-and-brocoli-eggs_100px.jpg"],
                 [UIImage imageNamed:@"sauteed-snow-peas-with-lemon-and-parsley_100px.jpg"],
                 [UIImage imageNamed:@"savory-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"scrambling-for-energy-meal_100px.jpg"],
                 [UIImage imageNamed:@"sesame-soy-crusted-pork_100px.jpg"],
                 [UIImage imageNamed:@"Sesame-Soy-Dressing_100px.jpg"],
                 [UIImage imageNamed:@"shrimp-skimpy_100px.jpg"],
                 [UIImage imageNamed:@"Shroom-Burgers_100px.jpg"],
                 [UIImage imageNamed:@"simple-pork-loin-chops_100px.jpg"],
                 [UIImage imageNamed:@"simple-skinny-dressing_100px.jpg"],
                 [UIImage imageNamed:@"simply-italian-dressing_100px.jpg"],
                 [UIImage imageNamed:@"sinless-scallops-and-spinach_100px.jpg"],
                 //[UIImage imageNamed:@"skinny-cookie-doughjpg_100px.jpg"],
                 //[UIImage imageNamed:@"So-orzo-side-dish_100px.jpg"],
                 [UIImage imageNamed:@"southwestern-spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"southwest-roasted-veggies_100px.jpg"],
                 [UIImage imageNamed:@"latin-soup_100px.jpg"],
                 [UIImage imageNamed:@"spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"spicy-sausage,-peppers-and-mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"stewed-okra-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"stir-fry-bokchoy_100px.jpg"],
                 //[UIImage imageNamed:@"strawberry-oat-bars_100px.jpg"],
                 [UIImage imageNamed:@"sugar-sheriff-onion-dressing_100px.jpg"],
                 [UIImage imageNamed:@"summer-lime-celery-salad_100px.jpg"],
                 //[UIImage imageNamed:@"sunflower-parm-crackers_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-colada-drink_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-creamcicles_100px.jpg"],
                 [UIImage imageNamed:@"super-low-carb-pancakes_100px.jpg"],
                 [UIImage imageNamed:@"sweet-potato-vanilla-pancake_100px.jpg"],
                 [UIImage imageNamed:@"sweet-sour-red-cabbage_100px.jpg"],
                 [UIImage imageNamed:@"Sweet,-Spicy-&-Sour-Salad-or-Garnish_100px.jpg"],
                 [UIImage imageNamed:@"tangy-tomato-vinaigrette_100px.jpg"],
                 [UIImage imageNamed:@"thai-me-up-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Toasted-Green-Bean-Fries_100px.jpg"],
                 [UIImage imageNamed:@"tofu-lly-Terrific-ceasar-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Turkey-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"turkey-roll-up_100px.jpg"],
                 [UIImage imageNamed:@"vampire-repellant-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"vanilla-cappuccino_100px.jpg"],
                 [UIImage imageNamed:@"vegetable-fritata_100px.jpg"],
                 [UIImage imageNamed:@"vegetarian-crispy-fried-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Wonderful-Waffles_100px.jpg"],
                 [UIImage imageNamed:@"wrappin-up-dinner_100px.jpg"],
                 [UIImage imageNamed:@"Zelicious-Zucchini-Bread_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-chips_100px.jpg"],
                // [UIImage imageNamed:@"zucchini_fettuccine_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-lime-hummus_100px.jpg"],nil] ;
    
    
    
    
    healthNames=[[NSArray alloc]initWithObjects:
                  @"A-Spare Me some Garlic",
                 @"Almost Deep Fat Fried Cauliflower",
              @"American Pancakes",
              @"Apple Cinnamon Steel Cut Oats, slow cooker",
              @"Apple Jacks Cereal",
              @"Asian Ground Turkey Wraps",
             
              @"Baby Bok Choy & Mushrooms",
              @"Bacon Bruschetta Stuffed Chicken Breast, slow cooker",
              @"Baked Parmesan Tomatoes",
              @"Baked Rhubarb Dessert",
              @"Baked Tomato Turkey",
              @"Banana Oat Breakfast Cookie",
              @"Banana Split Breakfast",
              @"Bang Bang Shrimp",
              @"Barely There Meringues",
              @"BBQ Chicken, slow cooker",
              @"Berry Crumble, slow cooker",
              @"Berry Muffins",
              @"Black-Thai Affair Salad Dressing",
              @"Boost Me Up Granola",
              @"Braised Zucchini and Sun Gold Cherry Tomatoes",
                  @"Broccoli Pesto Veggie Dip",
                  @"Broccoli Slaw Meatballs",
             
              @"Brussels Sprouts Tomato Salad",
              @"Buffalo Chicken Meatballs",
              @"Cabbage Chicken Salad",
              @"Cabbage Roll Casserole",
              @"Casserole for Dummies",
              @"Cauliflower Poppers",
                  @"Cauliflower Mashed Potatoes",
              @"Cauliflower Pizza Crust",
             
             
            
                  @"Cauliflower Tater Tots",
              @"Ceviche",
              @"Champion Chicken",
              @"Chargin’ Chicken, Slow Cooker",
              @"Chicken Adobo , Slow Cooker",
              @"Chicken, Pork and Shrimp Pancit",
              @"Chili-Lime Pork Chops",
              @"Chocolate Berry Drink",
              @"Chocolate Covered Banana Milkshake",
              @"Chocolate Fudgesicles",
              @"Chocolate Peanut Butter Milkshake",
              @"Chocolate Raspberry Dessert",
              @"Chocolate Soufflé",
              @"Cilantro-Garlic Sauce",
              @"Cilantro-Lime Chicken, Slow Cooker",
              @"Cinnamon Bun Pancakes",
              @"Cinnamon Faux Apples",
              @"Cinnamon Maple Oatmeal Muffins",
              @"Cinnamon Mochachino",
              @"Cod with Spinach and Tomatoes",
              @"Cookies & Cream Delight",
              @"Creamy Cauliflower Soup",
              @"Cucumber-Lime Salad",
              @"Cucumber, Onion & Tomato Salad",
              @"Curried Okra",
              @"Dreamsicle Delight Drink",
              @"Easy Teriyaki Salmon",
              @"Easy Tomato-Cucumber Salad",
              @"Egg-A-Licious Salad",
              @"Eggplant and Chard Salad",
              @"Eggplant Bruschetta",
              @"Eggs for Dinner",
              @"Energy Breakfast Cookie",
              @"Exotic Teahouse Chai Pudding",
             
              @"Faux Potato Salad",
              @"Fit in Your Caprese Salad",
              @"Fresh Herb Dressing",
              @"Fresh Vinaigrette Dressing",
              @"Fried Rice",
              @"Fruit Smoothie",
              @"Garlic Spinach",
              @"Gar-licking Good Brussels Sprouts",
              @"Gilligan’s Island Chicken",
              @"Greek Goddess Dressing",
              @"Grilled Eggplant and Zucchini Salad",
              @"Guiltless Ratatouille",
              @"Halibut with Picante Sauce",
              @"Herb Rubbed Turkey Breast, slow cooker",
              @"Herb Your Enthusiasm Veggies",
              @"Holiday Green Beans",
              @"Hole in One",
              @"Home Skillet Turnip Fries",
              @"Homemade Natural Pizza Sauce",
              @"I’m Having PIE for breakfast",
              @"“I’m Not Cajun Around” Steak, Slow Cooker",
              @"“I’m So Stuffed!” Peppers",
              @"Incredible Hulk Smoothie",
              @"Italian Chicken in the Slow Cooker",
              @"It’s a Date!  Creamy Smoothie",
              @"It’s Lemon-Thyme Chicken, Slow Cooker",
              @"It’s Shredding Zucchini Thyme",
              @"Japanese Ginger Salad Dressing",
              @"Just like Carrot Cake",
              @"Kale and Avocado Salad",
              @"Kale Berry Smoothie",
              @"Key West Shrimp",
              @"Kickin’ Collard Greens",
              @"Legal Hash Brownies",
              @"Legal Lemon Noodles",
              @"Lem Me Some Chicken, Slow Cooker",
              @"Lemon Cabbage Wedge",
              @"Lemon Pepper Zucchini",
              @"Lemon Rosemary Broiled Salmon",
              @"Lemon Zest Tofu",
              @"Light and Fresh Marinade",
              @"Lime Coleslaw",
              @"LimeLIGHT Dressing",
              @"Magic Sauce",
              @"MaMaws Chicken ‘n’ Dumplings",
              @"Maple Dressing",
              @"“Mazing Marinade”",
              @"Mi-So Cute Cucumber Salad",
              @"Mongolian Beef Goulash, Slow Coo",
              @"Must Try Roasted Fennel Root",
              @"No-Fail Kale Chips",
              @"No Fluke Zuke, Slow Cooker",
              @"No time to cook, Chicken Crockpot dinner",
              @"Oatmeal Cookies",
              @"Oatmeal Zucchini Muffins",
              @"Old School Oatmeal",
              @"Once upon a Thyme Zucchini",
              @"Paprika Chicken, Slow Cooker",
              @"Paradise Stir Fry",
              @"Peach and Mango Salsa",
              @"Pepperoni Pizza Casserole",
              @"Perfect Potato Rolls",
              @"Pizza-Stuffed Zucchini Boats",
              @"Pumpkin Pie",
              @"Put a Lime with your Coconut-Trout",
              @"Poppy Seed Dressing",
              @"Portobello Steaks",
              @"Put a Pork in it Dinner, Slow Cooker",
              @"Quick Chicken Teriyaki",
              @"Quick Quiche Cups",
              @"Quinoa and Black Beans",
              @"Quinoa Berry Crunch",
              @"Raspberry Cream",
              @"Raspberry-Lemon Breakfast Cheesecake",
              @"Raspberry-Lime Smoothie",
              @"Raspberry Smoothie",
              @"Refreshing Cucumber-Dill Salad",
              @"Rice Crispy Cereal Cakes",
              @"Roasted Veggies, Slow Cooker",
              @"Roasted Watermelon Radishes",
              @"Rockin’ Zucchini Lasagna",
              @"Rollin’ in Cabbage",
              @"Rosie’s One Dish Dinner",
              @"Rotini Pasta and Vegetables",
              @"Salmon & Broccoli Scramble",
              @"Sautéed Snow Peas with Lemon & Parsley",
              @"Savory Pork Chops",
              @"Scrambling for Energy Meal",
              @"Sesame-Soy Crusted Pork Tenderloin",
              @"Sesame Soy Dressing",
              @"Shrimp Skimpy",
              @"Shroom Burgers",
              @"Simple Pork Loin Chops",
              @"Simple Skinny Dressing",
              @"Simply Italian Dressing",
                  @"Sinless Scallops and Spinach",
              @"Skinny Cookie Dough",
              @"So Orzo Side Dish",
              @"Southwestern Spicy Pork, Slow Cooker",
              @"Southwest Roasted Veggies",
              @"Spice Up Your Life Latin Soup",
              @"Spicy Pork, Slow Cooker",
              @"Spicy Sausage, Peppers and Onions",
              @"Stewed Okra & Tomatoes",
              @"Stir-Fry Bok Choy",
              @"Strawberry Oat Bars",
              @"Sugar Sheriff Onion Dressing",
              @"Summer Lime Celery Salad",
              @"Sunflower-Parm Crackers",
              @"Strawberry Colada Drink",
              @"Strawberry Creamsicles",
              @"Super Low Carb Pancakes",
              @"Sweet Potato Vanilla Pancakes",
              @"Sweet & Sour Cabbage",
              @"Sweet, Spicy & Sour Salad or Garnish",
              @"Tangy Tomato Vinaigrette",
              @"Thai Me Up Chicken",
              @"Toasted Green Bean Fries",
              @"Tofu-lly Terrific Cesear Dressing",
              @"Turkey Meatballs and Veggies",
              @"Turkey Roll Up",
              @"Vampire Repellant Shrimp",
              @"Vanilla Cappuccino Dessert",
              @"Vegetable Frittata",
              @"Vegetarian Crispy “Fried Chicken”",
                 @"Wonderful Waffles",
              @"Wrappin Up Dinner!",
              @"Zelicious Zucchini Bread",
              @"Zucchini Chips",
             
              @"Zucchini-Lime Hummus",nil];
    
    
    
    
    healthImages = [NSArray arrayWithObjects:
                 [UIImage imageNamed:@"A-spare-me-some-garlic_100px.jpg"],
                 [UIImage imageNamed:@"almost-deep-fat-fried-cauliflower_100px.jpg"],
                 [UIImage imageNamed:@"American-Pancakes_100px.jpg"],
                 [UIImage imageNamed:@"apple-cinnamon-steel-cut-oats-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Apple-Jacks-Cereal_100px.jpg"],
                 [UIImage imageNamed:@"asian-ground-turkey-wrap-_100px.jpg"],
                 [UIImage imageNamed:@"Baby-Bok-Choy-with-Shiitake-Mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"bacon-bruschetta-stuffed-chicken_100px.jpg"],
                 [UIImage imageNamed:@"baked-parmesan-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"baked-rhubarb-dessert_100px.jpg"],
                 [UIImage imageNamed:@"baked-tomato-turkey_100px.jpg"],
                 [UIImage imageNamed:@"banana-oat-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"banana-split-brkfast_100px.jpg"],
                 [UIImage imageNamed:@"bang-bang-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"barely-there-meringues_100px.jpg"],
                 [UIImage imageNamed:@"bbq-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"berry-crumble_100px.jpg"],
                 [UIImage imageNamed:@"berry-muffins_100px.jpg"],
                 [UIImage imageNamed:@"black-thai-affair-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"boost-me-up-granola_100px.jpg"],
                 [UIImage imageNamed:@"braised-zucchini-and-sun-gold-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"brocolli-pesto_100px.jpg"],
                 [UIImage imageNamed:@"Broccoli-Slaw-Meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Brussels-Sprouts-and-Tomato-Salad_100px.jpg"],
                 [UIImage imageNamed:@"buffalo-chicken-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"Cabbage-Chicken-Salad_100px.jpg"],
                 [UIImage imageNamed:@"cabbage-roll-casserole_100px.jpg"],
                 [UIImage imageNamed:@"casserole-for-dummies_100px.jpg"],
                 //[UIImage imageNamed:@"cauli-rice_100px.jpg"],
                    [UIImage imageNamed:@"cauliflower-poppers_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-mashed-potatoes_100px.jpg"],
                 [UIImage imageNamed:@"cauliflower-pizza-crust_100px.jpg"],
                 //
                 [UIImage imageNamed:@"cauliflower-tater-tots_100px.jpg"],
                 [UIImage imageNamed:@"ceviche_100px.jpg"],
                 [UIImage imageNamed:@"champion-chicken_100px.jpg"],
                 [UIImage imageNamed:@"chargin-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Chicken-Adobo_100px.jpg"],
                 [UIImage imageNamed:@"chicken-pork-shrimp-pancit_100px.jpg"],
                 [UIImage imageNamed:@"chili-lime-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-berry-drink_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-covered-banana-milkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-fudgsicles_100px.jpg"],
                 [UIImage imageNamed:@"ChocolatePeanutButtermilkshake_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-raspberry-dessert_100px.jpg"],
                 [UIImage imageNamed:@"chocolate-souffle_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 // [UIImage imageNamed:@"cilantro-garlic-sauce_100px.jpg"],
                 [UIImage imageNamed:@"cilantro-lime-chicken-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"Cinnamon-bun-Pancakes_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-faux-apples_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-maple-oatmeal-muffins_100px.jpg"],
                 [UIImage imageNamed:@"cinnamon-mochachino_100px.jpg"],
                 [UIImage imageNamed:@"cod-with-spinach-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"cookies-and-cream-delight_100px.jpg"],
                 [UIImage imageNamed:@"creamy-cauliflower-soup_100px.jpg"],
                 [UIImage imageNamed:@"cucumber-lime-salad_100px.jpg"],
                 [UIImage imageNamed:@"cucumber,-onion-and-tomato-salad_100px.jpg"],
                 [UIImage imageNamed:@"curried-okra_100px.jpg"],
                 [UIImage imageNamed:@"dreamsicle-delight-drink_100px.jpg"],
                 [UIImage imageNamed:@"easy-teriyaki-salmon_100px.jpg"],
                 [UIImage imageNamed:@"Easy-tomato-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"egg-a-licious-salad_100px.jpg"],
                 [UIImage imageNamed:@"Eggplant-and-Chard-Salad_100px.jpg"],
                 [UIImage imageNamed:@"eggplant-brushetta_100px.jpg"],
                 [UIImage imageNamed:@"eggs-for-dinner_100px.jpg"],
                 [UIImage imageNamed:@"energy-breakfast-cookie_100px.jpg"],
                 [UIImage imageNamed:@"Exotic-Teahouse-Chai-Pudding_100px.jpg"],
                // [UIImage imageNamed:@"faux-choco-eggs_100px.jpg"],
                 [UIImage imageNamed:@"faux-potato-salad_100px.jpg"],
                 [UIImage imageNamed:@"fit-in-your-caprese-salad_100px.jpg"],
                 [UIImage imageNamed:@"fresh-herb-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fresh-vinaigrette-dressing_100px.jpg"],
                 [UIImage imageNamed:@"fried-rice_100px.jpg"],
                 [UIImage imageNamed:@"fruit-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"garlic-spinach_100px.jpg"],
                 [UIImage imageNamed:@"gar-licking-good-brussel-sprouts_100px.jpg"],
                 [UIImage imageNamed:@"giligans-island-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Greek-Goddess-dressing_100px.jpg"],
                 [UIImage imageNamed:@"grilled-eggplant-and-zucchini-salad_100px.jpg"],
                 [UIImage imageNamed:@"guiltless-rataouille_100px.jpg"],
                 [UIImage imageNamed:@"halibut-with-picante-sauce_100px.jpg"],
                 [UIImage imageNamed:@"herb-rubbed-turkey-breast_100px.jpg"],
                 [UIImage imageNamed:@"herb-your-enthusiasm-veggies_100px.jpg"],
                 [UIImage imageNamed:@"holiday-green-beans_100px.jpg"],
                 [UIImage imageNamed:@"hole-in-one_100px.jpg"],
                 [UIImage imageNamed:@"home-skillet-turnip-fries_100px.jpg"],
                 [UIImage imageNamed:@"homemade-pizza-sauce_100px.jpg"],
                 [UIImage imageNamed:@"I'm-having-Pie-for-breakfast_100px.jpg"],
                 [UIImage imageNamed:@"I'm-not-Cajun-Around-Steak_100px.jpg"],
                 [UIImage imageNamed:@"I'm-so-stuffed-peppers_100px.jpg"],
                 [UIImage imageNamed:@"incredible-hulk-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"italian-chicken-in-the-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"its-a-date-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"Its-Lemon-Thyme-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"It's-Shredding-Zucchini-Thyme_100px.jpg"],
                 [UIImage imageNamed:@"japanese-ginger-salad-dressing_100px.jpg"],
                 [UIImage imageNamed:@"just-like-carrot-cake_100px.jpg"],
                 [UIImage imageNamed:@"kale-and-avocado-salad_100px.jpg"],
                 [UIImage imageNamed:@"kale-berry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"key-west-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"kickin-collard-greens_100px.jpg"],
                 [UIImage imageNamed:@"Legal-Hash-Browns_100px.jpg"],
                 [UIImage imageNamed:@"legal-lemon-noodles-php_100px.jpg"],
                 [UIImage imageNamed:@"Lem-Me-Some-Chicken-Slow-Cooker_100px.jpg"],
                 [UIImage imageNamed:@"lemon-cabbage-wedge_100px.jpg"],
                 [UIImage imageNamed:@"lemon-pepper-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"lemon-rosemary-broiled-salmon_100px.jpg"],
                 [UIImage imageNamed:@"lemon-zest-tofu_100px.jpg"],
                 [UIImage imageNamed:@"light-and-fresh-marinade_100px.jpg"],
                 [UIImage imageNamed:@"Lime-Coleslaw_100px.jpg"],
                 [UIImage imageNamed:@"limelight-dressing_100px.jpg"],
                 [UIImage imageNamed:@"magic-sauce__100px.jpg"],
                 [UIImage imageNamed:@"MaMaws-Chicken-'n'-Dumplings_100px.jpg"],
                 [UIImage imageNamed:@"maple-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Mazing-Marinade_100px.jpg"],
                 [UIImage imageNamed:@"mi-so-cute-cucumber-salad_100px.jpg"],
                 [UIImage imageNamed:@"mongolian-beef-goulash_100px.jpg"],
                 [UIImage imageNamed:@"must-try-roasted-fennel-root_100px.jpg"],
                 [UIImage imageNamed:@"no-fail-kale-chips_100px.jpg"],
                 [UIImage imageNamed:@"no-fluke-zuke_100px.jpg"],
                 [UIImage imageNamed:@"no-time-to-cook,-chicken-crockpot_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-cookies_100px.jpg"],
                 [UIImage imageNamed:@"oatmeal-zucchini-muffins_100px.jpg"],
                 [UIImage imageNamed:@"Old-school-oatmeal_100px.jpg"],
                 [UIImage imageNamed:@"once-upon-a-thyme-zucchini_100px.jpg"],
                 [UIImage imageNamed:@"paprika-chicken,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"paradise-stir-fry_100px.jpg"],
                 [UIImage imageNamed:@"peach-and-mango-salsa_100px.jpg"],
                 [UIImage imageNamed:@"pepperoni-pizza-casserole_100px.jpg"],
                 [UIImage imageNamed:@"perfect-potato-rolls_100px.jpg"],
                 [UIImage imageNamed:@"pizza-stuffed-zucchini-boats_100px.jpg"],
                 [UIImage imageNamed:@"pumpkin-pie_100px.jpg"],
                 [UIImage imageNamed:@"Put-a-Lime-with-your-coconut-Trout_100px.jpg"],
                 [UIImage imageNamed:@"poppyseed-dressing_100px.jpg"],
                 [UIImage imageNamed:@"portobello-steaks_100px.jpg"],
                 [UIImage imageNamed:@"put-a-pork-in-it-dinner_100px.jpg"],
                 [UIImage imageNamed:@"quick-chicken-teriyaki_100px.jpg"],
                 [UIImage imageNamed:@"quick-quiche-cups_100px.jpg"],
                 [UIImage imageNamed:@"Quinoa-and-black-beans_100px.jpg"],
                 [UIImage imageNamed:@"quinoa-berry-crunch_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-cream_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-lemon-cheesecake_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-lime-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"raspberry-smoothie_100px.jpg"],
                 [UIImage imageNamed:@"refreshing-cucumber-dill-salad_100px.jpg"],
                 [UIImage imageNamed:@"rice-crispy-treat_100px.jpg"],
                 [UIImage imageNamed:@"roasted-veggies,-slow-cooker_100px.jpg"],
                 [UIImage imageNamed:@"roasted-watermellon-radishes_100px.jpg"],
                 [UIImage imageNamed:@"rockin-zucchini-lasagna_100px.jpg"],
                 [UIImage imageNamed:@"rollin-in-cabbage-1_100px.jpg"],
                 [UIImage imageNamed:@"rosie's-one-dish-dinner_100px.jpg"],
                 [UIImage imageNamed:@"rotini-pasta-and-vegetables_100px.jpg"],
                 [UIImage imageNamed:@"Salmon-and-brocoli-eggs_100px.jpg"],
                 [UIImage imageNamed:@"sauteed-snow-peas-with-lemon-and-parsley_100px.jpg"],
                 [UIImage imageNamed:@"savory-pork-chops_100px.jpg"],
                 [UIImage imageNamed:@"scrambling-for-energy-meal_100px.jpg"],
                 [UIImage imageNamed:@"sesame-soy-crusted-pork_100px.jpg"],
                 [UIImage imageNamed:@"Sesame-Soy-Dressing_100px.jpg"],
                 [UIImage imageNamed:@"shrimp-skimpy_100px.jpg"],
                 [UIImage imageNamed:@"Shroom-Burgers_100px.jpg"],
                 [UIImage imageNamed:@"simple-pork-loin-chops_100px.jpg"],
                 [UIImage imageNamed:@"simple-skinny-dressing_100px.jpg"],
                 [UIImage imageNamed:@"simply-italian-dressing_100px.jpg"],
                 [UIImage imageNamed:@"sinless-scallops-and-spinach_100px.jpg"],
                 [UIImage imageNamed:@"skinny-cookie-doughjpg_100px.jpg"],
                 [UIImage imageNamed:@"So-orzo-side-dish_100px.jpg"],
                 [UIImage imageNamed:@"southwestern-spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"southwest-roasted-veggies_100px.jpg"],
                 [UIImage imageNamed:@"latin-soup_100px.jpg"],
                 [UIImage imageNamed:@"spicy-pork_100px.jpg"],
                 [UIImage imageNamed:@"spicy-sausage,-peppers-and-mushrooms_100px.jpg"],
                 [UIImage imageNamed:@"stewed-okra-and-tomatoes_100px.jpg"],
                 [UIImage imageNamed:@"stir-fry-bokchoy_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-oat-bars_100px.jpg"],
                 [UIImage imageNamed:@"sugar-sheriff-onion-dressing_100px.jpg"],
                 [UIImage imageNamed:@"summer-lime-celery-salad_100px.jpg"],
                 [UIImage imageNamed:@"sunflower-parm-crackers_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-colada-drink_100px.jpg"],
                 [UIImage imageNamed:@"strawberry-creamcicles_100px.jpg"],
                 [UIImage imageNamed:@"super-low-carb-pancakes_100px.jpg"],
                 [UIImage imageNamed:@"sweet-potato-vanilla-pancake_100px.jpg"],
                 [UIImage imageNamed:@"sweet-sour-red-cabbage_100px.jpg"],
                 [UIImage imageNamed:@"Sweet,-Spicy-&-Sour-Salad-or-Garnish_100px.jpg"],
                 [UIImage imageNamed:@"tangy-tomato-vinaigrette_100px.jpg"],
                 [UIImage imageNamed:@"thai-me-up-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Toasted-Green-Bean-Fries_100px.jpg"],
                 [UIImage imageNamed:@"tofu-lly-Terrific-ceasar-dressing_100px.jpg"],
                 [UIImage imageNamed:@"Turkey-meatballs_100px.jpg"],
                 [UIImage imageNamed:@"turkey-roll-up_100px.jpg"],
                 [UIImage imageNamed:@"vampire-repellant-shrimp_100px.jpg"],
                 [UIImage imageNamed:@"vanilla-cappuccino_100px.jpg"],
                 [UIImage imageNamed:@"vegetable-fritata_100px.jpg"],
                 [UIImage imageNamed:@"vegetarian-crispy-fried-chicken_100px.jpg"],
                 [UIImage imageNamed:@"Wonderful-Waffles_100px.jpg"],
                 [UIImage imageNamed:@"wrappin-up-dinner_100px.jpg"],
                 [UIImage imageNamed:@"Zelicious-Zucchini-Bread_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-chips_100px.jpg"],
                 //[UIImage imageNamed:@"zucchini_fettuccine_100px.jpg"],
                 [UIImage imageNamed:@"zucchini-lime-hummus_100px.jpg"],nil] ;
   



    
    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(68  , 10, 180, 30)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    nameLabel.textAlignment=UITextAlignmentCenter;
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.adjustsFontSizeToFitWidth=YES;
   // nameLabel.font = [UIFont systemFontOfSize:21];
    [nameLabel setFont:[UIFont fontWithName:@"Helvetica Neue LT Pro" size:21]];
    nameLabel.minimumFontSize=12;
    nameLabel.text=name;
    [self.view addSubview:nameLabel];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        
         recipeTable =[[UITableView alloc]initWithFrame:CGRectMake(8, 53, 310, 450)];
    }
    else
    {
    
    recipeTable =[[UITableView alloc]initWithFrame:CGRectMake(8, 53, 310, 368)];
    }
    [recipeTable setBackgroundColor:[UIColor clearColor]];
    recipeTable.delegate=self;
    recipeTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    recipeTable.dataSource=self;
    //[listTable setShowsVerticalScrollIndicator:NO ];
    [self.view addSubview:recipeTable];
     [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    recipeTable.indicatorStyle=UIScrollViewIndicatorStyleDefault;
   // recipeTable.tableHeaderView=searchBar;
    
    if ([name isEqualToString:@"ALL"]) {
        
        [[NSUserDefaults standardUserDefaults]setObject:allNames forKey:@"allnames"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

    }
    else if ([name isEqualToString:@"PHASE 1 and 2"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:phase1Names forKey:@"allnames"];
         [[NSUserDefaults standardUserDefaults]synchronize];

    }
    
    
    else if ([name isEqualToString:@"PHASE 3"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:phase3Names forKey:@"allnames"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else if ([name isEqualToString:@"HEALTHY MAINTENANCE"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:healthNames forKey:@"allnames"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    

    [self hideActivityIndicater];
    [super viewDidLoad];
  
}
-(void) onTimer:(NSTimer *)timer1{
    [recipeTable flashScrollIndicators];
    if (!recipeTable.isDragging && !recipeTable.isDecelerating)
    {
        searchButton.enabled=YES;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchButton:(id)sender {
    copyRecipies=[[NSMutableArray alloc]init];
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320,44)];
    searchBar.delegate = self;
    searchBar.barStyle=UIBarStyleBlackTranslucent;
    searchBar.showsCancelButton=YES;
    searchBar.placeholder=@"Search";
    searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
   
   
    searchBar.hidden=NO;
     [self.view addSubview:searchBar];
    [searchBar becomeFirstResponder];
    

}


#pragma table
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    if (searching)
       return [copyRecipies count];
  else {

    
    return cellNo;
  }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        UIImageView *te = (UIImageView *)[cell.contentView viewWithTag:999];
        [te removeFromSuperview];
        te = nil;
        UILabel *te1 = (UILabel *)[cell.contentView viewWithTag:9999];
        [te1 removeFromSuperview];
        te1 = nil;
        UIImageView *te2 = (UIImageView *)[cell.contentView viewWithTag:99999];
        [te2 removeFromSuperview];
        te2 = nil;

    }
    
    
    
    
    
    UIImageView *  divider2=[[UIImageView alloc]initWithFrame:CGRectMake(0  , 0, 299, 62)];
    [divider2 setImage:[UIImage imageNamed:@"IM_recipe-list_single-item-box.png"]];
    [divider2 setTag:999];
    [cell.contentView addSubview:divider2];
    
    
    productName=[[UILabel alloc]initWithFrame:CGRectMake(67, 3 ,185,55 )];
    [productName setTag:9999];
   
   productName.backgroundColor=[UIColor clearColor];
   productName.numberOfLines=3;
   productName.adjustsFontSizeToFitWidth=YES;
    productName.font=[UIFont systemFontOfSize:15];
   productName.minimumFontSize=10.0;
   productName.textColor = [UIColor blackColor];
  
  [cell.contentView addSubview:productName];
    
  UIImageView * productImage=[[UIImageView alloc]initWithFrame:CGRectMake(5    , 5, 50  , 50)];
    //[productImage setBackgroundColor:[UIColor grayColor]];
    [productImage setTag:99999];
    [cell.contentView addSubview:productImage];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkButton.frame=CGRectMake(265, 18.5, 25   , 25);
    //checkButton.frame=CGRectMake(260, 18.5, 35   , 25);
    
    [checkButton setImage:[UIImage imageNamed:@"IM_recipe-details_button.png"] forState:UIControlStateNormal];
    //[checkButton setImage:[UIImage imageNamed:@"IM_recipe-details_button-press.png"] forState:UIControlStateHighlighted];
    
    [checkButton setTag:indexPath.row];
    [checkButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSString *tag=[[NSString alloc]initWithFormat:@"%d",indexPath.row +1] ;
    [checkButton setTitle:tag  forState:UIControlStateNormal];
    // (indexPath.row & 0xFFFF)];
    [cell.contentView addSubview:checkButton];
    
    forwardButton=[[UIButton alloc]initWithFrame:CGRectMake(3, 3 ,290,55)];
   
    [forwardButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [forwardButton setBackgroundColor:[UIColor clearColor]];
    
    [cell.contentView addSubview:forwardButton];
    
   
    if (tableView.isDragging && tableView.isDecelerating)
    {
        searchButton.enabled=NO;
    }
    if (searching) {
        
        
        
         [productName setText:[copyRecipies objectAtIndex:indexPath.row]];
        [productImage setImage:[copyImages objectAtIndex:indexPath.row]];
       //  NSLog(@"%d",indexPath.row);
        //NSLog(@"%@",count);
        
        
        NSString *myString=[[NSString alloc]initWithFormat:@"%@",[count objectAtIndex:indexPath.row]];
        int p=[myString intValue];
       // NSLog(@"%d",p);
        [forwardButton setTag:p];
    }
    else
    {
        
     [forwardButton setTag:indexPath.row];
    
    if ([name isEqualToString:@"ALL"]) {
        
        [productName setText:[allNames objectAtIndex:indexPath.row]];
        [productImage setImage:[allImages objectAtIndex:indexPath.row]];
    }
    else if ([name isEqualToString:@"PHASE 1 and 2"])
    {
        [productName setText:[phase1Names objectAtIndex:indexPath.row]];
        [productImage setImage:[phase1Images objectAtIndex:indexPath.row]];
    }
    
    
    else if ([name isEqualToString:@"PHASE 3"])
    {
        [productName setText:[phase3Names objectAtIndex:indexPath.row]];
        [productImage setImage:[phase3Images objectAtIndex:indexPath.row]];
    }
    else if ([name isEqualToString:@"HEALTHY MAINTENANCE"])
    {
        [productName setText:[healthNames objectAtIndex:indexPath.row]];
        [productImage setImage:[healthImages objectAtIndex:indexPath.row]];
    }

    }
    
    
    
    
         
      
    
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}


-(void)buttonTapped:(id)sender
{
  
    buttonTag=[sender tag]+1;
     // NSLog(@"button tag is %d",buttonTag);
   [[NSUserDefaults standardUserDefaults]setInteger:buttonTag forKey:@"tag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [Flurry logEvent:@"Recipie Selected Button Pressed"];
    [self performSegueWithIdentifier:@"description" sender:self];

}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	
	//This method is called again when the user clicks back from teh detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
    /*if ([copyItems count] > 0)
     {
     letUserSelectRow = YES;
     recipeTable.scrollEnabled = YES;
     }
     else {
     letUserSelectRow = NO;
     recipeTable.scrollEnabled = NO;
     }
     searching = YES;*/
    
    if(searching)
		return;
	
	//Add the overlay view.
	if(dvController == nil)
		dvController = [[DetailViewcontroller alloc] init];
		CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
	CGFloat width = self.view.frame.size.width;
	CGFloat height = self.view.frame.size.height;
	//Parameters x = origion on x-axis, y = origon on y-axis.
	CGRect frame = CGRectMake(0, yaxis, width, height);
	dvController.view.frame=frame;
    dvController.view.backgroundColor = [UIColor grayColor];
	dvController.view.alpha = 0.8;
	
	dvController.rvController = self;
	searchBar.showsCancelButton=YES;
    [self.view addSubview:dvController.view];
	//[self.view insertSubview:dvController.view aboveSubview:self.parentViewController.view];
    //[recipeTable insertSubview:dvController.view aboveSubview:self.parentViewController.view];
    
    searching = YES;
	letUserSelectRow = NO;
	recipeTable.scrollEnabled = NO;
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
	
	[self searchTableView];
    [searchBar resignFirstResponder];
    [Flurry logEvent:@"Search(recipies)  Button Pressed"];
}

- (void) searchTableView

{
    
    [copyRecipies removeAllObjects];
    [copyImages removeAllObjects];
    
    
    NSMutableArray* searchResult = [[NSMutableArray alloc] init];
    
    if ([name isEqualToString:@"ALL"])
    {
         [searchResult addObjectsFromArray:allNames];
        o=1;
        
    }
    
    else if ([name isEqualToString:@"PHASE 1 and 2"])
    {
            
             [searchResult addObjectsFromArray:phase1Names];
        o=2;
            
    }
    
    else if ([name isEqualToString:@"PHASE 3"])
    
    {
     [searchResult addObjectsFromArray:phase3Names];
        o=3;
        
    }
    
    else if ([name isEqualToString:@"HEALTHY MAINTENANCE"])
    
    {
                    
         [searchResult addObjectsFromArray:healthNames];
        o=4;
        
    }
    
//	ff
    
    count=[[NSMutableArray alloc]init];
    //NSLog(@"hkjefhk...%@",searchResult);
    NSString *valueStr=searchBar.text;
    //NSUInteger t=valueStr.length;
    
    for (NSString *name1 in searchResult)
    {
        
             
        NSComparisonResult result = [name1 compare:valueStr options:(NSCaseInsensitiveSearch) range:NSMakeRange(0, [valueStr length])];
        if (result == NSOrderedSame)
        {
            [copyRecipies addObject:name1];
            
            int p=[searchResult indexOfObject:name1];
            //p=p+1;
            NSString *check=[[NSString alloc]initWithFormat:@"%d",p];
            if (o==1) {
                
                [copyImages addObject:[allImages objectAtIndex:p]];
            }
            else if (o==2)
            {
                 [copyImages addObject:[phase1Images objectAtIndex:p]];
            }
            else if (o==3)
            {
                 [copyImages addObject:[phase3Images objectAtIndex:p]];
            }
            else if (o==4)
            {
                 [copyImages addObject:[healthImages objectAtIndex:p]];
            }
            
            [count addObject:check];
            
        }
    
        
    
    }
    //NSLog(@"%@",count);

}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
	[copyRecipies removeAllObjects];
    
    if(searchText && [searchText length] > 0) {
        
        [dvController.view removeFromSuperview];
        
        searching = YES;
        letUserSelectRow = NO;
        recipeTable.scrollEnabled = YES;
        [self searchTableView];
        
    }
    else {
        
        [self.view addSubview:dvController.view];
       // [recipeTable insertSubview:dvController.view aboveSubview:self.parentViewController.view];
        
        searching =NO ;
        letUserSelectRow =NO;
        recipeTable.scrollEnabled = NO;
        
    }
    
	[recipeTable reloadData];
    
}
- (void) searchBarCancelButtonClicked:(UISearchBar *)Bar
{
	
	searchBar.text = @"";
	[searchBar resignFirstResponder];
	letUserSelectRow = YES;
	searching = NO;
    searchBar.showsCancelButton=NO;
	recipeTable.scrollEnabled = YES;
    
    [dvController.view removeFromSuperview];
	
    dvController = nil;
	[recipeTable reloadData];
    searchBar.hidden=YES;
    searchBar=nil;
    [searchBar removeFromSuperview];
}

-(void)viewWillDisappear:(BOOL)animated
{
    // [searchBar removeFromSuperview];
    [self searchBarCancelButtonClicked:searchBar ];
}

-(void)viewDidUnload
{
    [self setSearchButton:nil];
    NSMutableArray *allNamesArray=[NSMutableArray arrayWithArray:allNames];
    [allNamesArray removeAllObjects];
    NSMutableArray *allImagesArray=[NSMutableArray arrayWithArray:allImages];
    [allImagesArray removeAllObjects];
    
    
    
    NSMutableArray *phase1NamesArray=[NSMutableArray arrayWithArray:phase1Names];
    [phase1NamesArray removeAllObjects];
    NSMutableArray *phase1ImagesArray=[NSMutableArray arrayWithArray:phase1Images];
    [phase1ImagesArray removeAllObjects];
    
    NSMutableArray *phase3NamesArray=[NSMutableArray arrayWithArray:phase3Names];
    [phase3NamesArray removeAllObjects];
    NSMutableArray *phase3ImagesArray=[NSMutableArray arrayWithArray:phase3Images];
    [phase3ImagesArray removeAllObjects];
    
    NSMutableArray *healthNamesArray=[NSMutableArray arrayWithArray:healthNames];
    [healthNamesArray removeAllObjects];
    NSMutableArray *healthImagesArray=[NSMutableArray arrayWithArray:healthImages];
    [healthImagesArray removeAllObjects];
    
    [searchBar removeFromSuperview];
}



@end
