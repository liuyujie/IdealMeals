//
//  IMrecipieDescription.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 08/02/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMrecipieDescription.h"
#import "IMrecipies.h"

@interface IMrecipieDescription ()

@end

@implementation IMrecipieDescription

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
-(void)createTable:(NSString *)tableName

        withField1:(NSString *)no
        withField2:(NSString *)recipieType
        withField3:(NSString *)recipe
        withField4:(NSString *)quanty{
    
    
    char *err;
    NSString *sql=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@'INTEGER PRIMARY KEY AUTOINCREMENT,'%@' TEXT,'%@' TEXT ,'%@' TEXT); ",tableName,no,recipieType,recipe,quanty];
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"could not create table");
        
    }else{
      //  NSLog(@"table created");
        
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
         NSLog(@"table created ");
        
    }
    
}

//-(void)transfer
//{
//    NSString *insertSQL=[NSString stringWithFormat:@"INSERT INTO selection SELECT * FROM info"];
//    sqlite3_stmt  *statement1;
//    
//    
//    
//    const char *insert_stmt = [insertSQL UTF8String];
//    sqlite3_prepare_v2(db, insert_stmt,
//                       -1, &statement1, NULL);
//    if (sqlite3_step(statement1) == SQLITE_DONE)
//    {
//        //NSLog(@"%@",@"contact added");
//        
//    }
//    
//    else
//        
//    {
//        
//        NSLog(@"%@",@"failed");
//        
//    }


//}
- (void)viewDidLoad
{    //self.tabBarController.delegate=self ;
    [self openDB];
    today=[[NSDate alloc]initWithTimeIntervalSinceNow:1];
    [self createTable:@"info" withField1:@"No" withField2:@"Type" withField3:@"Name" withField4:@"Quantity"];
    [self createTable2:@"calendar" withField1:@"Date" withField2:@"Breakfast" withField3:@"Lunch" withField4:@"Dinner" withField5:@"Other"];
     meals=[[NSArray alloc]initWithObjects:@"Breakfast",@"Lunch",@"Dinner",@"Other", nil];
   
    //[self transfer];
    ingrdArray =[[NSMutableArray alloc]init];
    quantity=[[NSMutableArray alloc]init];
    quantityName=[[NSMutableArray alloc]init];
    name=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    //NSLog(@"name is %@",name );
    buttonTag=[[NSUserDefaults standardUserDefaults]integerForKey:@"tag"];
    
    
    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(70  , 10, 210, 35)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    nameLabel.textAlignment=UITextAlignmentCenter;
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.adjustsFontSizeToFitWidth=YES;
   [nameLabel setFont:[UIFont fontWithName:@"Helvetica Neue LT Pro" size:21]];
    nameLabel.minimumFontSize=12;
    nameLabel.text=name;
    [self.view addSubview:nameLabel];

    
    recipieName=[[UILabel alloc]initWithFrame:CGRectMake(10  , 42, 300, 35)];
    [recipieName setBackgroundColor:[UIColor clearColor]];
    recipieName.textAlignment=UITextAlignmentCenter;
    recipieName.textColor=[UIColor whiteColor];
    recipieName.adjustsFontSizeToFitWidth=YES;
    recipieName.font = [UIFont systemFontOfSize:21];
    recipieName.minimumFontSize=12;
   // recipieName.text=name;
    
    [self method];
    [self.view addSubview:recipieName];
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bckButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ingridients
{
    for (int y=0; y<[groceryArray count]; y++) {
        
        NSString *xyz=[groceryArray objectAtIndex:y];
        
        NSString *match = @"+=";
        
        NSString *preTelTest;
        NSString *postTel;
        
        NSScanner *scanner = [NSScanner scannerWithString:xyz];
        
        [scanner scanUpToString:match intoString:&preTelTest];
        
        [scanner scanString:match intoString:nil];
        postTel = [xyz substringFromIndex:scanner.scanLocation];
        
        NSString *match2=@"@#";
        NSString *preTel;
        NSString *post;
        NSString *newstring;
        NSScanner *scanner2 = [NSScanner scannerWithString:preTelTest];
        
        [scanner2 scanUpToString:match2 intoString:&preTel];
        
        [scanner2 scanString:match2 intoString:nil];
        post = [preTelTest substringFromIndex:scanner2.scanLocation];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"space"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if ([preTel isEqualToString:@"nil"]) {
            preTel=@"";
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"space"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        if ([preTel isEqualToString:@"nil1"]) {
            preTel=@"";
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"toTaste"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"space"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"space" ] ==YES)
        {
            newstring =[[preTel stringByAppendingString:@""]stringByAppendingString:post];
        }
        else
        {
            newstring =[[preTel stringByAppendingString:@" "]stringByAppendingString:post];
            
            
        }
        [ingrdArray addObject:newstring];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"toTaste"]==YES) {
            
            preTel=@"to taste";
            post=[post stringByReplacingOccurrencesOfString:@", to taste" withString:@""];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"toTaste"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        [quantity addObject:preTel];
        [quantityName addObject:post];
        
        
    }

}


-(void)buttontag1
{
   
       
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"A-spare-me-some-garlic_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#fresh asparagus+=prd",
                  @"2 tsp@#olive oil+=bak",
                  
                  @"2@#cloves garlic, minced+=prd",
                  nil];
    
    
        
    
    
    [self ingridients];
    
    
    
        
  
    
    
    
    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Break the ends off the asparagus where they naturally snap.",
                @"Cut asparagus naturally into 1- inch lengths.",
                @"Heat the oil in a skillet over medium-high heat.",
                @"Add asparagus and sauté, stirring occasionally, until it is tender-crisp (about 6-8 minutes).",
                @"Stir in the garlic, sauté 1 minute more and serve.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

}

-(void)buttontag2
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"almost-deep-fat-fried-cauliflower_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 head@#cauliflower+=prd",
                  @"1-2 tsp@#olive oil+=bak",
                  @"1-2 tsp@#garlic powder+=ssn",
                  @"1-2 tsp@#chili powder+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",nil];
    
      
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Wash and break apart cauliflower.",
                @"In a ziploc bag or container you can put a lid on, put cauliflower in, drizzle with olive oil, sprinkle with garlic powder, chili powder, salt and pepper.",
                @"Seal and shake until cauliflower is  coated.",
                @"Put in metal 9x13 pan, cover with foil and bake at 350 degrees for 20 minutes.",
                @"Take out and remove foil. Put back in over for another 10-15 minutes.",
                @"Should be almost crunchy when it comes out",
                nil];
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

}
-(void)buttontag3
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"American-Pancakes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved crispy cereal+=iwm",
                  @"2@#egg whites+=dry",
                  @"1/4 tsp@#baking powder+=bak",
                  @"1/4 tsp@#vanilla extract+=ssn",
                  
                  @"nil1@#cinnamon and nutmeg, to taste+=ssn",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Beat together in a small bowl the egg whites and vanilla extract.", @"In another bowl, mix the cereal package with the baking powder, cinnamon and nutmeg.", @"Pour dry mix in to egg white mixture and combine.", @"Cook in a pan as you would pancakes using either non-stick cooking spray or coconut oil.", @"You can use the Walden Farms Pancake Syrup, just be sure to watch serving size.",nil];
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
}
-(void)buttontag4
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"apple-cinnamon-steel-cut-oats-slow-cooker_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3@#apples,cored and cut into pieces+=prd",
                  @"1 1/2 cups@#unsweetened vanilla almond milk+=dry",
                  @"1 1/2 cups@#water+=wtr",
                  @"1 cup@#uncooked steel-cut oats+=grn",
                  
                  @"2 tbsp@#sweetener of choice (agave syrup, maple syrup or turbinado sugar)+=bak",
                  @"1 scoop@#vanilla protein powder+=prt",
                  @"1 1/2 tbsp@#coconut oil+=bak",
                  @"1/2 tsp@#cinnamon+=ssn",
                  @"1 tbsp@#ground flax seed+=ssn",
                  @"1/4 tsp@#sea salt+=ssn",
                  @"nil@#optional toppings: nuts, raisins, fruit+=tpn",
                  nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Be sure to grease your crockpot with coconut oil first. If you miss this step, you’ll be cleaning your crock pot for days.",
                @"Put all ingredients together in the crockpot and stir.",
                @"Cook on low for about 6-7 hours.",
                @"Enjoy it warm.",
                nil];
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"3/4 cup"];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

}
-(void)buttontag5
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Apple-Jacks-Cereal_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved crispy cereal+=iwm",
                  @"1/4 package@#approved apple cinnamon soy puffs +=iwm",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:   @"Follow the instructions to make the cereal.",
                @"You can add a dash of vanilla ready made if you like it more creamy.",
                @"Take 6-7 apple cinnamon soy puffs and top them off on your cereal.",
                @"Store the package in a zip lock bag and you can use them for 4 servings.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag6
{
    
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"asian-ground-turkey-wrap-_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 lb@#ground turkey or lean ground beef+=meat",
                  @"1 tsp@#fresh ginger+=prd",
                  @"1 tsp@#garlic, minced+=prd",
                  @"1@#chopped green pepper+=prd",
                  @"1 cup@#mushroom, diced+=prd",
                  @"nil@#fresh cilantro+=prd",
                  @"2 tbsp@#soy sauce or Braggs+=ssn",
                  @"1 tsp@#red pepper flakes+=ssn",
                  @"4-6 large@#lettuce leaves, romaine works well+=prd",
                  @"1 tsp@#Asian spice or seasoning+=ssn",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place cilantro aside.",
                @"Brown the ground turkey with the vegetables and seasonings.",
                @"Serve in a lettuce wrap and sprinkle with cilantro.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

}

-(void)buttontag7
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Baby-Bok-Choy-with-Shiitake-Mushrooms-500_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tbsp@#olive oil+=bak",
                  
                  @"4 ounces@#shiitake mushrooms (stemmed and sliced)+=prd",
                  @"2 cloves@#garlic (chopped)+=prd",
                  @"2 tsp@#ginger+=prd",
                  
                  
                  @"1/4 cup@#vegetable broth (or chicken    stock)+=ssn",
                  @"1 tbsp@#light soy sauce+=ssn",
                  @"1 tsp@#chili sauce (optional, to    taste)+=ssn",
                  @"3 large@#baby bok choy (the thick end of the stem removed, rinsed & steamed)+=prd",
                  @"2@#green onions (sliced)+=prd",
                  
                  @"1 tsp@#sesame oil+=eth",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat the oil in a pan over med heat.",
                @"Add the mushrooms and sauté for about 7 minutes.",
                @"Add the garlic and ginger and sauté until fragrant, about a minute.",
                @"Add the broth and deglaze the pan.",
                @"Add the soy sauce and chili sauce and simmer to reduce the sauce to the thickness that you desire.",
                @"Add the sesame oil and remove from heat.",
                @"Pour the mushroom sauce over the bok choy and garnish with the green onions.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag8
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"bacon-bruschetta-stuffed-chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4-6 pieces@#cooked turkey bacon with no nitrates (Applegate farms or Trader Joe’s brand is perfect)+=meat",
                  @"2 pounds@#boneless skinless chicken breast+=meat",
                  @"1 cup@#cherry tomatoes, halved+=prd",
                  @"1 cup@#fresh basil+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:
                @"In a large skillet, cook the bacon until it’s thoroughly done.",
                @"Crumble the bacon and set aside.",
                @"Butterfly each chicken breast by cutting them in half lengthwise and keeping one side in tact.",
                @"Evenly stuff the chicken breasts with the tomatoes, basil and bacon.",
                @"Fasten the open side of the stuffed chicken breasts with toothpicks to hold them closed, Place the stuffed chicken breasts into your slow cooker, cover and cook on low for 6 -8 hours.",
                @"Season the dish with sea salt and pepper, to taste.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag9
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"baked-parmesan-tomatoes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4@#tomatoes, halved horizontally+=prd",
                  @"1/4 cup@#fresh grated parmesan cheese+=dry",
                  @"1 tsp@#chopped fresh oregano+=ssn",
                  @"1/4 tsp@#sea salt+=ssn",
                  
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"4 tsp@#olive oil+=bak",nil];
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450℉.",
                @"Place tomatoes cut-side up on a baking sheet.",
                @"Top with parmesan, oregano, salt and pepper.",
                @"Drizzle with oil and bake the tomatoes are tender, about 15 minutes.",
                @"You can have this with your phase 3 breakfast or a healthy maintenance snack.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag10
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"baked-rhubarb-dessert.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#rhubarb, leaves discarded and stalks cut diagonally into 1-inch pieces (you can use frozen)+=prd",
                  @"1 package@#approved apple cinnamon puffs+=iwm",
                  @"1/4 cup@#Splenda or stevia+=bak",
                  @"1/2@#vanilla bean, halved lengthwise+=ssn",
                  
                  @"1 tsp@#coconut oil+=bak",
                  @"1 packet@#approved vanilla pudding+=iwm",nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place rhubarb and 1/4 cup Splenda in a large bowl.",
                @"Scrape vanilla seeds into bowl and add pod.",
                @"Toss to combine; let stand 20 minutes.",
                @"Preheat oven to 375℉.",
                @"Use the coconut oil and grease an 8-inch square baking dish.",
                @"Transfer rhubarb mixture to baking dish and bake, gently stirring halfway through, for about 30 minutes or until tender.",
                @"While it’s cooking, make the approved vanilla pudding and use a little less water to give it the look of heavy whipped cream.",
                @"Make sure it’s in the freezer or fridge until thickened.",
                @"Add the crushed apple cinnamon puffs to the rhubarb or the last 5 - 10 minutes.",
                @"Discard vanilla pod.",
                @"Let the rhubarb cool slightly in dish on a wire rack.",
                @"Serve warm next to the vanilla pudding.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag11
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"baked-tomato-turkey_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 lbs@#turkey breast+=meat",
                  @"10@#cherry tomatoes+=prd",
                  @"4 tbsp@#apple cider vinegar+=bak",
                  @"4 tbsp@#olive oil+=bak",
                  
                  @"1 tsp@#dried basil, crumbled+=ssn",
                  @"1 tsp@#thyme+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 400°F.",
                @"In a baking dish, add tomatoes, olive oil, vinegar, herbs and mix well.",
                @"Place turkey in the baking dish and coat with mixture.",
                @"Place in the oven and cook for 30 minutes, or until done.",
                @"Remove from the oven and serve with spinach or two cups vegetables over a green salad.",
                @"*You can also use chicken breast for the same recipe.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag12
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"banana-oat-breakfast-cookie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 whole@#ripe bananas, mash until           creamy+=prd",
                  @"1/3@#peanut butter, creamy or chunky+=nts",
                  @"2/3@#unsweetened applesauce+=prd",
                  @"1/4 cup@#approved vanilla protein powder+=iwm",
                  
                  @"1 tsp@#vanilla extract+=ssn",
                  @"1 tsp@#butter extract, uncooked+=ssn",
                  @"1 1/2 cup@#rolled oats+=grn",
                  @"1/4 cup@#chopped walnuts+=nts",
                  @"1/4 cup@#carob chips or chocolate chips, optional+=bak",nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat heat oven to 350ºF.",
                @"In a large bowl, mix mashed banana and peanut butter until completely combined.",
                @"Then add in the applesauce, vanilla protein powder and vanilla and butter extracts.",
                @"Mix again until completely combined.",
                @"Add in the oatmeal and nuts to the banana mixture and combine.(Add the optional carob/chocolate chips at this time if you want them mixed throughout.)",
                @"Let dough rest for 10 minutes.",
                @"Drop cookie dough, by spoonfuls, onto a parchment paper lined cookie sheet and flatten cookies into circles, about a 1/3″ thick.",
                @"If you want the optional carob/chocolate chips on the top of the cookies, push them into the cookies now.",
                @"Bake cookies approximately 30 minutes, or until golden brown and done.",
                @"Remove from oven and let rest on cookie sheet for 5 minutes, then move to cooling rack.",
                @"If you want the traditional fork tine marks on the cookies, use a pizza cutter or sharp knife to score the tops of the cookies while they’re still warm.",
                @"When cookies are completely cool, store in a covered container. Enjoy!",
                nil];
    
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 Cookies"];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag13
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"banana-split-brkfast_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1@#banana, cut in half lengthwise+=prd",
                  @"2/3 cup@#cottage cheese (or plain greek yogurt)+=dry",
                  @"1 tbsp@#all-fruit preserves+=sac",
                  @"1 tsp@#ground flax seed+=ssn",
                  
                  @"1 tbsp@#chopped walnuts (or almonds)+=nts",
                  @"nil@#cinnamon, shredded unsweetened coconut or raisins (optional)+=ssn",nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place two banana halves in serving dish.",
                @"Add scoops of cottage cheese on top of banana.",
                @"Drizzle with fruit preserves (if you want it to look pretty and have more of a drizzle consistency, add a small amount of hot water but this is just for aesthetics) and garnish with flax and chopped nuts.",
                @"You can add the optional garnishes on top.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag14
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"bang-bang-shrimp_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#shrimp, peeled and deveined+=sf",
                  @"3/4 cup@#walden farms mayo+=iwm",
                  @"3-4 tbsp@#hot sauce+=cnd",
                  @"1/2 tsp@#red pepper flakes+=ssn",
                  
                  @"2 tbsp@#coconut oil+=bak",
                  @"nil1@#garlic powder, to taste+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Lay the shrimp out on a cutting board and season with garlic powder, salt, and pepper (I used garlic salt).",
                @"Heat the coconut oil in a skillet over medium heat.",
                @"While you’re waiting for the oil to heat up, combine the mayo, hot sauce, and red pepper flakes in a medium sized bowl.",
                @"Once the oil is hot, add the shrimp, stirring frequently.",
                @"When the shrimp are done (about 3-5 minutes) add them to the sauce bowl and stir until coated.",
                @"Serve over some butter lettuce and enjoy!",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

     
}
-(void)buttontag15
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"barely-there-meringues_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3@#egg whites+=dry",
                  @"1/4 tsp@#cream of tarter+=ssn",
                  @"1 tbsp@#walden farms syrup+=iwm",
                  @"8 drops@#Vanilla Cream liquid stevia    drops+=iwm",
                  
                  nil];
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 300°F.",
                @"Line 2 cookie sheets with parchment paper.",
                @"Using an electric beater, whip at high speed all ingredients until they are stiff.",
                @"There should be a peak when you pull the beaters out of the bowl.",
                @"Spoon it out onto baking sheets and cook for 90 minutes to 2 hours, until honey brown and dry through.",
                @"Store in air tight container.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"36"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cookie" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag16
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"bbq-chicken-slow-cooker_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#boneless skinless chicken breast+=meat",
                  @"1 bottle@#Walden Farms BBQ sauce+=iwm",
                  
                  nil];
    
    
  [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Place the chicken and about half the bottle of BBQ sauce in the slow cooker and cook on low 6- 8 hours.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag17
{   int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"berry-crumble_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4 cups@#fresh or frozen mixed berries+=frz",
                  @"1 tbsp@#butter (optional)+=dry",
                  @"2 tbsp@#melted coconut oil (topping)+=bak",
                  @"1 cup@#almond flour (topping)+=nts",
                  
                  @"1 tbsp@#agave nectar or honey+=bak",nil];
    
    
   [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Place the berries in your slow cooker, dot with butter if you choose.",
                @"For the topping, melt 2 tbsp coconut oil and add the agave or honey in a small bowl.",
                @"Stir in the almond flour into the melted coconut oil.",
                @"Mix together until starts to crumble.",
                @"Sprinkle the topping mixture evenly over the berries in the slow cooker.",
                @"Cook on low for two hours.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag18
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"berry-muffins_640_bad.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved strawberry pudding+=iwm",
                  @"1 oz@#egg white+=dry",
                  @"1 oz@#water+=wtr",
                  @"1/4 tsp@#cinnamon+=ssn",
                  
                  @"nil@#dash of vanilla extract+=ssn",nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350°F, Mix pudding packet, water, egg white and vanilla.",
                @"Mix well to try and get out most of the lumps.",
                @"Fill 2 non-stick muffin tins approximately 2/3 full (or make mini- muffins).",
                @"Sprinkle with cinnamon. Bake for 10 -15 minutes. Serve warm.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

     
}
-(void)buttontag19
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"black-thai-affair-salad-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 clove@#garlic, finely chopped+=prd",
                  @"1/2 tsp@#fresh ginger, finely sliced+=prd",
                  @"3 tbsp@#rice vinegar+=ssn",
                  @"1 tsp@#Splenda or Stevia+=bak",
                  
                  @"1 tsp@#soy sauce+=ssn",
                  @"1/4 cup@#olive oil+=bak",
                  @"1 tsp@#sesame seeds+=ssn",
                  @"1/4 tsp@#crushed red pepper+=ssn",
                  nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Mix all ingredients together in a bowl.",
                @"Store in a glass container.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"6"];            //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 tsp"];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
   
}
-(void)buttontag20
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"boost-me-up-granola_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 cups@#rolled oats+=grn",
                  @"1 cup@#raw almonds+=nts",
                  @"1/2 cup@#walnuts+=nts",
                  @"1/2 cup@#shelled, unsalted sunflower      seeds+=nts",
                  
                  @"1/2 cup@#raw shelled pumpkin seeds+=nts",
                  @"1/2 cup@#agave nectar+=bak",
                  @"2/3 cup@#coconut oil+=bak",
                  @"1/2 cup@#ground flax seed+=hlt",
                  @"2 tbsp@# cinnamon+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"1 cup@#raisins or dates (optional)+=prd",
                  nil];
   [self ingridients];    
    
    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Preheat oven to 350°F.",
                @"In a 9 x 13 baking dish, spread out the rolled oats and nuts.",
                @"Sprinkle the cinnamon, sea salt and flax seed.",
                @"Drizzle the agave over the mix.",
                @"Just scoop the coconut oil and drop it on top (it will melt quickly and then you can stir it in).",
                @"Cook the granola at 350°F, stirring every 15 minutes for about 30 - 45 minutes.",
                @"It may not look quite done when you take it off, but it will cook more while it cools.",
                @"When cool, store in an air-tight container in the fridge.",
                @"Add blueberries or any fresh fruit and mix with either low-fat milk, almond milk, or a Vanilla Ready Made! If you want to add dried fruit, just avoid any with added sugars.",
                @"Raisins, dates and dried cranberries make a nice addition.",
                @"Use this with your phase 3 breakfast.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    //int cup=1/2 serving;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag21
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"braised-zucchini-and-sun-gold-tomatoes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4@#zucchini,washed and sliced lengthwise+=prd",
                  @"1/2 cup@#sun gold cherry tomatoes, sliced in half+=prd",
                  @"3 cloves@#garlic, minced+=prd",
                  @"1 tbsp@#olive oil+=bak",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 small@#bunch fresh basil, torn or cut into large pieces+=prd",
                  nil];
   [self ingridients];    
    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat olive oil in large skillet with high sides or braising pan.",
                @"When it shimmers, add zucchini and cook quickly until browned.",
                @"Remove to a bowl and set aside.",
                @"Add a little more olive oil to pan and add garlic.",
                @"Sauté briefly, 30 seconds-1 minute, then add cherry tomatoes.",
                @"When tomatoes begin to soften and release juices, add zucchini back to pan, season with salt and pepper, and toss to combine. Add basil, toss again, and serve hot or at room temperature.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d cup",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
   
}
-(void)buttontag22
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"brocolli-pesto_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 cups@#broccoli florets+=prd",
                  @"1/4 cup@#pine nuts+=nts",
                  @"1/3 cup@#parmesan cheese+=dry",
                  @"2 tbsp@#lemon juice+=prd",
                  
                  @"1/2 tsp@#sea salt+=ssn",
                  @"5-6@#garlic cloves+=prd",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Lightly steam the broccoli with garlic.",
                @"Transfer the broccoli, garlic and all other ingredients to the food processor.",
                @"Blend to a smooth puree and enjoy.",
                @"You can also use this to stuff in mushrooms and bake them.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"8"];            //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/4 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag23
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Broccoli-Slaw-Meatballs_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 bag@#broccoli slaw+=prd",
                  @"1 lb@#ground turkey or lean ground beef+=meat",
                  @"nil@#garlic salt or fresh garlic+=ssn",
                  @"nil@#Mrs. Dash Garlic & Herb salt-free seasoning+=ssn",
                  
                  @"nil@#Parsley, finely chopped+=prd",
                  @"2@#eggs+=dry",nil];
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350° F.",
                @"Pierce the bag of broccoli slaw with a knife and microwave for 4 - 7 minutes until tender.",
                @"Let the slaw cool before adding it to the other ingredients.",
                @"In a large bowl, add all the above ingredients and mix until well combined.",
                @"Spray baking sheet with cooking spray.",
                @"Use an ice cream scoop to make 16 meatballs and place on baking sheet.",
                @"Bake in 350-degree oven for 30 minutes.",
                @"You can serve these plain, with an approved marinara sauce or in a soup.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag24
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Brussels-Sprouts-and-Tomato-Salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/4 cup@#white wine vinegar+=ssn",
                  @"1 tbsp@#dijon mustard+=cnd",
                  @"1 tsp@#sea salt+=ssn",
                  @"1/2 tsp@#black pepper+=ssn",
                  
                  @"5 tbsp@#olive oil, divided+=bak",
                  @"1 1/4 pounds@#Brussels sprouts+=prd",
                  @"1 cup@#grape or cherry tomatoes, halved+=prd",
                  @"2 tbsp@#chopped fresh chives+=prd",nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450° F  Whisk together vinegar, Dijon, 1/2 teaspoon salt and pepper in a small bowl.",
                @"Slowly add 3 tablespoons olive oil.",
                @"Set aside.",
                @"Rinse Brussels sprouts; remove any discolored leaves.",
                @"Trim stem ends.",
                @"Place sprouts on a lightly greased large baking sheet and drizzle with remaining olive oil and remaining salt.",
                @"Bake sprouts for 25 minutes or until tender, stirring occasionally.",
                @" Let cool slightly.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    //int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag25
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"buffalo-chicken-meatballs_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#ground chicken breast or        turkey+=meat",
                  @"1/2 cup@#finely grated zucchini+=prd",
                  @"1/2 cup@#grated celery+=prd",
                  @"1 tsp@#garlic powder+=ssn",
                  
                  @"1 1/4 tsp@#sea salt+=ssn",
                  @"3@#egg whites, beaten+=dry",
                  @"nil@#olive oil cooking spray+=bak",
                  @"1 cup@#wing sauce with NO Sugar!+=sac",
                  @"nil@#Walden Farms Blue Cheese dressing for dipping (optional)+=iwm",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350℉.",
                @"In a large bowl, combine chicken, vegetables, spices beaten egg whites and 2 tsp wing sauce.",
                @"Gently mix by hand the ingredients.",
                @"Do not squeeze or over mix.",
                @"Spray a baking sheet with olive oil cooking spray.",
                @"Scoop meat mixture into 2 tbsp sized portions.",
                @"Roll portion gently between palms to form a smooth ball.",
                @"Place on baking sheet.",
                @"Bake meatballs on center rack for 15 minutes.",
                @"Remove meatballs from oven.",
                @"Pour wing sauce in a bowl and transfer meatballs to the bowl and toss to coat.",
                @"Let the meatballs sit in the sauce while you raise the oven temperature to 450℉.",
                @"Drain the moisture and wipe the grease from the baking sheet.",
                @"Apply a fresh coat of olive oil spray.",
                @"When oven has reached 450℉, give meatballs another toss in the bowl, then transfer, sauce and all to the baking sheet.",
                @"Bake, on the top rack of the oven for 12-15 minutes.",
                @"Serve with Walden Farms blue cheese dressing for dipping.",nil];
    
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag26
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Cabbage-Chicken-Salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 head@#green cabbage, chopped+=prd",
                  @"1 bunch@#cilantro, finely chopped+=prd",
                  @"6@#green onions, finely chopped+=prd",
                  @"1 pound@#skinless boneless chicken     breast+=meat",
                  
                  @"1 tbsp@#olive oil+=bak",
                  @"1/4 cup@#sesame seeds (optional, omit for phase 1)+=nts",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1/4 cup@#olive oil (dressing)+=bak",
                  @"3 tbsp@#rice vinegar (dressing)+=ssn",
                  @"1 tsp@#sea salt (dressing)+=ssn",
                  @"1/2 tsp@#black pepper (dressing)+=ssn",nil];
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"If using sesame seeds (not on phase 1), brown them in a skillet in a little olive oil.",
                @"In a small pot of boiling water, add 1/2 teaspoon of salt and boil chicken until fully cooked.",
                @"Drain water, allow the chicken to cool and shred.",
                @"Mix cabbage, cilantro,green onions and chicken in a large bowl.",
                @"Combine the dressing ingredients in a small bowl and stir well.",
                @"Just before serving, add the browned sesame seeds.",
                @"Pour the dressing.",
                @"Gently toss well.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag27
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cabbage-roll-casserole_640_worse.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#lean ground beef+=meat",
                  @"1 cup@#mushroom, diced+=prd",
                  @"1 tsp@#onion powder+=ssn",
                  @"1 tsp@#garlic powder+=ssn",
                  
                  @"1/2 tsp@#black pepper+=ssn",
                  @"1 tsp@#redmond’s sea salt+=ssn",
                  @"2 cups@#grated cauliflower+=prd",
                  @"2 cups@#chopped cabbage+=prd",
                  @"8 oz@#diced tomatoes+=prd",
                  @"1 tsp@#olive oil+=ssn",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350° F.",
                @"In large skillet, heat olive oil over med heat and brown the ground beef with the mushrooms, onion powder, garlic powder, salt and pepper.",
                @"Add the grated cauliflower (you can use a food processor to grate it or a cheese grater) to the skillet.",
                @"Boil water in a pot and steam the cabbage until almost cooked.",
                @"Layer the ground beef mixture with the cabbage in a casserole dish.",
                @"Spread the diced tomatoes over top and bake for 45 minutes at 350 degrees.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag28
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"casserole-for-dummies_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#broccoli florets+=prd",
                  @"1 cup@#cauliflower florets+=prd",
                  @"2 cups@#diced, cooked chicken+=meat",
                  @"1/2 cup@#sliced mushrooms+=prd",
                  
                  @"2 tbsp@#olive oil+=bak",
                  @"1/4 cup@#brown mustard+=cnd",
                  @"1/8 tsp@#garlic powder+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",
                  @"1/2 cup@#celery, chopped+=prd",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Preheat oven to 350°F.",
                @"Place the vegetables and the chicken in a greased 9-inch square baking dish.",
                @"In a medium skillet, sauté the mushrooms and celery in the oil until very soft and a little browned (about 8 minutes).",
                @"Stir in the mustard and seasonings into the vegetables until well coated.",
                @"Mix in all of the remaining ingredients along with the sautéed vegetables.",
                @"Cover the baking dish with foil and bake at 350°F for 40 minutes.",
                @"Uncover and bake 5-10 minutes longer until the casserole is browned and bubbly.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag29
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cauli-rice_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 head@#cauliflower+=prd",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"To make a very rice-like side using cauliflower, simply put the cauliflower through your food processor using the shredding blade.",
                @"You can also use a cheese grater.",
                @"You can then steam or sauté it, just be careful not to overcook.",
                
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag30
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cauliflower-mashed-potatoes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 head@#cauliflower+=prd",
                  @"2@#garlic cloves, chopped+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Cut the cauliflower into florets.",
                @"Steam them until very tender.",
                @"Transfer them to a blender or a large glass bowl (if you have an emersion stick).",
                @"Add the garlic, sea salt and pepper.",
                @"Blend until smooth and serve warm.",
                @"Option: you can use bags of steamers as well.",nil];
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag31
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cauliflower-pizza-crust_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @" 1 bag@#frozen cauliflower steamers+=frz",
                  @"1/4 cup@#egg whites+=dry",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450°F.",
                @"Steam cauliflower according to directions on bag and then poor it on a clean dishcloth that has been heavily lined with paper towels.",
                @"Cover with another layer of paper towels, fold the dish towel over itself and press hard to squeeze as much moisture as you can out of the cauliflower.",
                @"Feed the cauliflower through the shredding disk of your food processor.",
                @"Repeat the squeezing step with fresh paper towels.",
                @"Get as much moisture out until you have something resembling dough.",
                @"Combine the shreds with the egg whites.",
                @"Line a baking sheet with parchment paper (not foil as it will stick).",
                @" Mound the cauliflower mixture in the center of the pan.",
                @"Using slightly damp hands, press from the center outward to create a thin crust.",
                @"Gently blot excess moisture off the top with a paper towel.",
                @"Make it very thin; if it’s too thick it will be soggy.",
                @"Bake at 450°F. for 20 - 25 minutes.",
                @"The crust should be browned, perhaps slightly burned in some spots.",
                @"DO NOT under-bake.",
                @"Because the top will tend to be more crusty, flip it to add the sauce and toppings.",
                @"You can warm your sauce, veggies and meat while it cooks and then add them on at the end.",
                @"Use spinach, mushrooms, peppers or any other veggies that you prefer.",nil];
    
    
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=1;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d Slice",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag32
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cauliflower-poppers_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 heads@#cauliflower+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"1 1/2 tsp@#sea salt+=ssn",
                  @"1 tsp@#ground pepper+=ssn",
                  
                  nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 400℉.",
                @"Wash and clean the cauliflower.",
                @"Cut off and discard the stem.",
                @"Cut the cauliflower up into small pieces.",
                @"In a large bowl, combine the olive oil, salt and pepper.",
                @"Add the cauliflower pieces and thoroughly coat each piece.",
                @"Place cauliflower pieces onto a baking sheet lined with parchment paper.",
                @"Bake for one hour and turn 3 times during cooking until each piece has a nice brown coloring.",
                @"The browner they are the better.",
                
                nil];
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag33
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cauliflower-tater-tots_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 head@#cauliflower+=prd",
                  @"2 tbsp@#heavy cream+=dry",
                  @"2 tbsp@#butter+=dry",
                  @"1/3 cup@#shredded sharp cheddar+=dry",
                  
                  @"4 egg@#whites+=dry",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 tbsp@#olive oil+=bak",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350℉.",
                @"Steam the cauliflower until soft.",
                @"In a big bowl, add the steamed cauliflower with the butter and cream.",
                @"Add the cheese to the mixture and then use an emersion stick or transfer to a blender to purée until mostly smooth, but still some chunks.",
                @"Season with salt and pepper.",
                @"Chill for at least half an hour.",
                @"Whip the egg whites to a stiff peak.",
                @"Fold 1/3 of the egg whites into the cauliflower mixture to lighten it up.",
                @"Fold the cauliflower mixture into the rest of the egg whites and gently mix until combined.",
                @"For best results, chill for another half hour or they won’t hold their shape as well.",
                @"Spoon out the mixture onto a greased cookie sheet.",
                @"Bake for 10-12 minutes (or longer if you’re skipping the frying) until puffed and slightly browned.",
                @"Remove from the oven and serve – or heat 1/4 inch of oil in a sauté pan and when it’s very hot add the tots.",
                @"It doesn’t need long, a minute per side to turn them golden brown and crispy.",
                @"Serve immediately.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

     
}
-(void)buttontag34
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"ceviche_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 lb@#medium shrimp, peeled and       deveined+=sf",
                  @"5@#limes, juiced+=prd",
                  @"5@#lemons, juiced+=prd",
                  @"1 cup@#red onion, finely chopped+=prd",
                  
                  @"1@#serrano chili pepper, minced+=prd",
                  @"1 cup@#fresh cilantro, chopped+=prd",
                  @"1@#cucumber, peeled and diced+=prd",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a large pot, bring to a boil 4 quarts water, salted.",
                @"Add the shrimp and cook for 1 minute to 2 minutes, max, depending on the size of shrimp. (overcooking shrimp will turn them rubbery).",
                @"Remove shrimp and place into a bowl of ice water to stop the cooking.",
                @"Drain the shrimp.",
                @"Cut each piece of shrimp in half, or into inch-long pieces.",
                @"Place shrimp in a glass or ceramic bowl.",
                @"Mix in the lime and lemon juice.",
                @"Cover and refrigerate for a half hour.",
                @"Mix in the chopped red onion and serrano chile.",
                @"Refrigerate an additional half hour.",
                @"Right before serving, add the cilantro and cucumber.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
   
}
-(void)buttontag35
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"champion-chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#skinless boneless chicken breast+=meat",
                  @"1 cup@#plain greek yogurt+=dry",
                  @"6 tbsp@#grated parmesan cheese+=dry",
                  @"2 tsp@#garlic, chopped+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 tsp@#dried parsley+=ssn",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 375℉.",
                @"Spray a large baking pan with cooking spray.",
                @"In a small bowl, mix together the yogurt, cheese, garlic and parsley.",
                @"Place chicken breasts in baking pan and brush yogurt mixture evenly over chicken breasts, covering the tops and the sides evenly.",
                @"Sprinkle with sea salt and pepper to your desired taste.",
                @"Bake chicken 30 - 35 minutes, until cooked with no pink in the middle.",
                @"Enjoy the chicken warm.",
                
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag36
{   int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chargin-chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 lbs@#boneless, skinless chicken breast+=meat",
                  @"2 cups@#mushrooms, sliced+=prd",
                  @"2 cloves@#garlic, finely chopped+=prd",
                  @"3 tbsp@#olive oil+=bak",
                  
                  @"6 tbsp@#white wine vinegar+=ssn",
                  @"4 tbsp@#soy sauce or Braggs+=ssn",
                  @"4 tbsp@#dijon mustard+=ssn",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Add all ingredients to the crockpot and cook on low all day.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag37
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Chicken-Adobo_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4@#garlic cloves, minced+=prd",
                  @"2/3 cup@#apple cider vinegar+=ssn",
                  @"1/3 cup@#low-sodium soy sauce+=ssn",
                  @"1/2 tsp@#Splenda or Stevia (optional)+=bak",
                  @"1@#bay leaf+=ssn",
                  @"nil1@#black pepper, to taste+=ssn",
                  @"8@#skinless, bone-in chicken thighs+=meat",
                  
                  @"2 tsp@#paprika+=ssn",
                  @"1 large@#head bok choy, cut into 1-inch strips+=prd",
                  @"2@#scallions (thinly sliced)+=prd",nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a slow-cooker, combine all ingredients except bok choy and scallions.",
                @"Let it cook on low for 7-8 hrs or high for 4-5 hrs.",
                @"Ten minutes before serving, if it’s on the low setting, turn it to high.",
                @"Gently fold the bok choy into the chicken and cook uncovered for 3-5 minutes.",
                @" Serve and sprinkle with scallions ",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

     
}
-(void)buttontag38
{   int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chicken-pork-shrimp-pancit_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1.5 pounds@#chicken breasts, cut into small bite size pieces+=meat",
                  @"1 pound@#pork loin, cut into small bite size pieces+=meat",
                  @"1/2 pound@#shrimp, tails removed and de-veined+=sf",
                  @"2 tbsp@#coconut oil+=bak",
                  
                  @"8@#green onions, diced+=prd",
                  @"6-8 cups@#shredded green cabbage+=prd",
                  @"1/4 cup@#Tamari, soy sauce or Braggs+=ssn",
                  @"1/4 cup@#chicken broth+=ssn",
                  @"2 tbsp@#fish sauce+=eth",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"nil@#lemon wedges+=prd",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a large wok or skillet heat the coconut oil over medium to medium high heat.",
                @"When the wok or pan is nice and hot, add the chicken, pork, green onions and garlic and sauté for about 6-7 minutes or until the meat is done all the way through but still tender.",
                @"Remove the meat from the pan and set aside.",
                @"Add the cabbage to the wok or pan and cook until the cabbage is tender, about 4 minutes.",
                @"Add the shrimp to the cabbage and sauté together until the shrimps turn pink.",
                @"Add the chicken and pork back to the veggies and pour in soy sauce, chicken broth, and fish sauce.",
                @"Season with lots of black pepper.",
                @"Stir well and cook for another minute or two. Serve in bowls with a lemon wedge.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag39
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chili-lime-pork-chops_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tsp@#chili powder+=ssn",
                  @"1/2 tsp@#garlic powder or salt+=ssn",
                  @"1/8 tsp@#ground red pepper (cayenne)+=ssn",
                  @"1 tbsp@#lime juice+=prd",
                  
                  @"1 tsp@#olive oil+=bak",
                  @"4@#boneless pork loin chops 1/2 to 3/4 inch thick (1 pound)+=meat",
                  @"nil@#chopped fresh cilantro (optional)+=prd",
                  @"nil@#lime wedges (cilantro)+=prd",nil];
   [self ingridients];    
    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Pre-heat grill.",
                @"Meanwhile, in small bowl, mix all seasoning ingredients.",
                @"Brush mixture evenly on both sides of each chop.",
                @"When grill is heated, place pork on grill surface.",
                @"Close grill, cook 5-7 min or until pork is no longer pink in center.",
                @"Sprinkle pork with cilantro and serve with lime wedges.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag40
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chocolate-berry-drink_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved wildberry yogurt+=iwm",
                  @"nil@#approved chocolate drink mix+=iwm",
                  @"20 oz@#water+=wtr",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a small blender, combine the two packets and water.",
                @"Blend and then separate into two servings.",
                @"You can add ice if you like it a little icy.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=10;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag41
{   int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chocolate-covered-banana-milkshake_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved banana pudding+=iwm",
                  @"2 tbsp@#Walden Farms Chocolate Dip+=iwm",
                  @"10 oz@#cold water+=wtr",
                  @"1/2 cup@#ice+=wtr",
                  
                  nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Blend all ingredients in a small blender until ice is crushed.",
                @" Enjoy this milkshake as a great after- dinner treat!",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag42
{   int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chocolate-fudgsicles_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved ready made chocolate drink or chocolate drink mix+=iwm",
                  nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"If using the packet, follow directions to make the chocolate drink.",
                @"Place drink in ice cube trays or popsicle makers.",
                @"Freeze.",
                @"Once chocolate is frozen, pop out and enjoy!",
                nil];
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag43
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"ChocolatePeanutButtermilkshake_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved vanilla pudding+=iwm",
                  @"1 scoop@#Walden Farms Peanut Spread+=iwm",
                  @"1 tsp@#Walden Farms Chocolate Syrup+=iwm",
                  @"1 tsp@#vanilla extract+=ssn",
                  @"8 oz@#water+=wtr",
                  
                  @"1/2 cup@#ice+=wtr",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Blend all ingredients and enjoy a little Reese’s Peanut Butter Delight!",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag44
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chocolate-raspberry-dessert_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved chocolate pancake+=iwm",
                  @"nil@#approved raspberry jello+=iwm",
                  nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Pour 1-2 ounces of cold water into shaker.",
                @"Add pancake mix and shake vigorously until smooth.",
                @"Bake in a muffin pan for 10 minutes or microwave in a microwave-safe cup for 30 seconds.",
                @"Remove and let cool.  Poke holes in cake with a fork.",
                @"Make the jello following the directions on the packet.",
                @"Poor the jello into the holes.",
                @"Place in the refrigerator until set.",
                @"Note that this makes 2 servings (each one including half of a restricted food).",
                @"Save the other serving for another day.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag45
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"chocolate-souffle_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved chocolate pudding+=iwm",
                  @"2@#egg whites+=dry",
                  @"nil@#dash of vanilla extract+=ssn",
                  @"1@#packet Splenda or Truvia (optional)+=bak",
                  
                  @"nil@#Walden Farms chocolate syrup+=iwm",
                  @"nil@#Walden Farms Raspberry Jam+=iwm",nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 325℉.",
                @"In a mixing bowl, beat two egg whites until stiff.",
                @"In another bowl, mix the pudding as directed but with a bit less water so that the pudding is thick.",
                @"Beat 3/4 of the egg whites and the pudding together.",
                @"With the remaining egg whites, add a few drops of vanilla extract.",
                @"In small, greased cooking pot, spread the chocolate mixture.",
                @"Next, put thin layer of WF Raspberry Jam.",
                @"Finally, add the vanilla egg whites on top.",
                @"Sprinkle with Splenda or Truvia.",
                @"Cover pot with tinfoil and bake for 30 - 40 minutes, depending on how deep the pot is.",
                @"Take off the tinfoil until the top begins to turn golden.",
                @"Let cool and drizzle with WF Chocolate syrup.",
                @"Note: You may need to vary the cooking time/degrees depending on your pot, but it’s better to cook a over than under for this treat.",
                @"VARIATIONS: try using any of the puddings as an added layer on the inside.",nil];
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag46
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cilantro-garlic-sauce1.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#fresh cilantro leaves+=prd",
                  @"2@#garlic cloves+=prd",
                  @"1/4 cup@#olive oil+=bak",
                  @"2 tbsp@#soy sauce or Braggs+=ssn",
                  
                  @"1@#lemon, juiced+=prd",
                  @"nil@#fresh ginger, 1 inch piece+=prd",
                  @"pinch@#cayenne (optional)+=ssn",nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Put all ingredients into blender and blend until smooth.",
                @"Pour over your favorite dish – fish, veggies, tempeh, tofu, meat, eggs, whatever you want!! Either way, just make it soon so I have other people to share my enthusiasm with.",
                nil];
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/4 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag47
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cilantro-lime-chicken-slow-cooker_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"6-8@#boneless, skinless chicken breast+=meat",
                  @"24 oz@#mild salsa (no sugar added to ingredients)+=prd",
                  @"1/4 cup@#fresh cilantro, chopped+=prd",
                  @"1@#lime, juiced+=prd",
                  
                  @"2@#Jalapeno peppers, finely chopped+=prd",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place all ingredients in the crockpot and cook on low 6-8 hours.",
                @"Serve over a salad or with your sides of veggies.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag48
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cinnamon-pancakes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved plain crepe or pancake+=iwm",
                  @"nil1@#cinnamon, to taste+=ssn",
                  @"nil1@#Splenda or Stevia, to taste+=bak",
                  @"nil@#approved vanilla pudding+=iwm",
                  
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Follow the instructions for the crepe, using enough water to make it slightly runny.",
                @"Spoon into a non-stick skillet.",
                @"Sprinkle the top with a mixture of cinnamon and Splenda to your taste.",
                @"Follow the instructions to make the pudding with extra water so that it’s runny enough to poor, but not too thin.",
                @"Drizzle it over the Crepe.",nil];
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag49
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cinnamon-faux-apples_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2-3 large@#zucchinis+=prd",
                  @"1/2@#lemon, juiced+=prd",
                  @"1 tbsp@#all spice+=ssn",
                  @"1 tbsp@#coconut oil+=bak",
                  
                  @"2 tbsp@#Walden Farms Apple Butter+=bak",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350° F.",
                @"Peel and cut a zucchini lengthwise.",
                @"Seed it and then cut it crosswise into “apple slices”.",
                @"Spread in a baking dish and drizzle with a lemon and all spice.",
                @"Add the coconut oil and Walden Farms Apple Butter in the middle of the dish.",
                @"When it is placed in the oven, the coconut oil and apple butter will melt and spread out.",
                @"Bake them for 15 - 20 minutes, stirring about half way through.",
                @"Enjoy them warm.",
                nil];
    NSString *size=[[NSString alloc]initWithFormat:@"6"];            //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag50
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cinnamon-maple-oatmeal-muffins_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved plain crepe or pancake+=iwm",
                  @"nil@#approved maple oatmeal+=iwm",
                  @"1/4 tsp@#baking powder+=bak",
                  @"1/4 tsp@#baking soda+=bak",
                  
                  @"1/4 tsp@#cinnamon+=ssn",
                  @"1@#egg white+=dry",
                  @"1/2 tsp@#vanilla extract+=ssn",
                  @"3-4 oz@#water+=wtr",
                  @"1 tsp@#Splenda or Stevia+=bak",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350℉.",
                @"Mix dry ingredients together.",
                @"Combine wet ingredients and add to dry ingredients.",
                @"Mix until batter is smooth.",
                @"Fill 4 non-stick muffin tins approximately 2/3 full.",
                @"There should be enough batter for 4 muffins (2 servings).",
                @"Bake for 15-20 minutes.",
                @"Serve warm.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];            //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 Muffins" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

     
}
-(void)buttontag51
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cinnamon-mochachino_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved cappuccino mix+=iwm",
                  @"1/2 tsp@#instant coffee+=tc",
                  @"1/8 tsp@#unsweetened cocoa powder+=bak",
                  @"nil@#dash of cinnamon+=ssn",
                  
                  @"8 oz@#water+=wtr",
                  @"nil@#Walden Farms Chocolate syrup (optional)+=iwm",nil];
    
 [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Pour cold water in a shaker and add all the other ingredients.",
                @"Shake well until completely dissolved and enjoy a scrumptious shake.",
                @"*If you have a magic bullet or blender, throw it in with a few ice cubes to make it extra cold and creamy.",
                @"You can also get an iced coffee and mix it with that too!",
                nil];
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag52
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cod-with-spinach-and-tomatoes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 cups@#fresh spinach+=prd",
                  @"4 tsp@#olive oil+=bak",
                  @"1 pound@#cod fillet+=sf",
                  @"1@#lemon+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"4 pinches@#cayenne+=ssn",
                  @"2 small@#tomatoes, thinly sliced+=prd",nil];
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350°F.",
                @"Grease baking dish that will fit your fillet.",
                @"Spread the spinach in the dish.",
                @"Coat the fish with the olive oil (but not to use more than 4 tsp).",
                @"Place the fillets over the spinach in the baking dish.",
                @" Squeeze the lemon over all the fillets and sprinkle with salt and pepper, to taste.",
                @"Sprinkle a little cayenne, to taste.",
                @"Cover each fillet with the tomato slices and then cook for 15 minutes.",nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag53
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cookies-and-cream-delight_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved cookies and cream protein bar+=iwm",
                  @"nil@#approved wildberry yogurt or vanilla pudding+=iwm",
                  @"nil@#approved raspberry jello+=iwm",
                  nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Prepare yogurt and jelly as directed on package and divided into 2 servings each.",
                @"Layer yogurt and jelly in alternate layers in pudding cup.",
                @"Crumble half the cookies and cream bar on top of each serving.",
                @" Chill and serve.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2.5"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

     
}
-(void)buttontag54
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"creamy-cauliflower-soup_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#olive oil+=bak",
                  @"2 medium@#onions, halved and thinly      sliced+=prd",
                  @"1/2 tsp@#sea salt+=ssn",
                  @"3@#garlic cloves, minced+=prd",
                  
                  @"1/2 cup@#dry white wine+=ssn",
                  @"1 large@#head cauliflower, chopped+=prd",
                  @"4 cups@#chicken or vegetable broth+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"2 tbsp@#minced chives (for garnish)+=prd",
                  @"1 tbsp@#finely chopped flat-leaf parsley (for garnish)+=prd",nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat 1 tbsp in a large pot over medium-high heat.",
                @"Add onions (yes, I know you’re cooking them...) and salt, cover, reduce heat to medium, and cook, stirring occasionally, until onions are very soft, 5 to 8 minutes.",
                @"Add garlic and wine.",
                @"Cook, stirring, until liquid is almost completely evaporated, 3 to 5 minutes.",
                @"Stir in cauliflower and broth and bring to a boil.",
                @"Reduce heat to a simmer, cover, and cook until cauliflower is very soft, 20 to 25 minutes.",
                @"If you have an emersion stick, use it here to blend, if not then blend in blender In 3 batches.",
                @"Whirl soup in a blender until very smooth, at least 3 minutes per batch (or, if you'd like a few florets in your soup, blend 2 batches and leave the last chunky).",
                @"Stir together and season to taste with white pepper and salt.",
                @"In a small bowl, combine the other 1 tbsp olive oil, chives, and parsley.",
                @"Ladle soup into bowls and decoratively drizzle herb oil on top.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"6"];           // int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

  
    
}
-(void)buttontag55
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cucumber-lime-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#cucumbers, peeled+=prd",
                  @"1@#lime+=prd",
                  @"1/2 cup@#fresh cilantro, chopped+=prd",
                  @"1/2 cup@#chopped red onion (optional)+=prd",
                  
                  @"6-8@#cherry tomatoes, quartered+=prd",nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Slice cucumber and then cut slices in half.",
                @"Squeeze in the juice from the lime.",
                @"Add cilantro, onion and tomatoes.",
                @"Toss and ENJOY.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag56
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"cucumber,-onion-and-tomato-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#cucumbers, peeled and sliced+=prd",
                  @"1 pint@#cherry tomatoes, halved+=prd",
                  @"1/2@#Vidalia onion, very thinly sliced+=prd",
                  @"2 tbsp@#chopped fresh parsley leaves+=prd",
                  
                  @"1 tbsp@#apple cider vinegar+=ssn",
                  @"1 tbsp@#olive oil+=bak",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a large serving bowl, toss together all ingredients.",
                @"Let the salad stand for 10 minutes before serving.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

     
}
-(void)buttontag57
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"curried-okra_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#okra, washed, trimmed, cut into 1/2” thick sliced+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"1 large@#onion, sliced+=prd",
                  @"nil@#dash cayenne pepper+=ssn",
                  
                  @"1/4 tsp@#ground tumeric+=ssn",
                  @"1/4 tsp@#mild curry powder, or to taste+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat the oil in a large heavy non-stick or well seasoned iron skillet; add okra and sauté for 10 minutes, turning frequently to keep from sticking. When the okra is lightly browned, add remaining ingredients.",
                @"Continue cooking for an 3 minutes longer, or until onions are tender.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    //int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup" ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag58
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"dreamsicle-delight-drink_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved orange drink+=iwm",
                  @"nil@#approved vanilla drink+=iwm",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a blender, combing both drinks with 1/2 cup ice and 12 - 16 oz of water.",
                @"Blend until smooth.",
                @"Counts as two servings, so divide it in half and save some for later or split with a friend.",
                nil];
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    int cup=8;
    //float serve=0.5;
    NSString *serveString=[[NSString alloc]initWithFormat:@"%d OZ",cup ];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag59
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"easy-teriyaki-salmon_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tbsp@#sesame oil+=eth",
                  @"1/4 cup@#lemon juice+=prd",
                  @"1/4 cup@#soy sauce or Braggs+=ssn",
                  @"1 tsp@#ground mustard+=ssn",
                  
                  @"1 tsp@#ground ginger+=ssn",
                  @"1/4 tsp@#garlic powder+=ssn",
                  @"4-7 oz@#salmon steaks+=sf",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a large re-sealable plastic bag combine the first six ingredients; mix well.",
                @"Set aside 1/2 cup of marinade and refrigerate.",
                @"Add salmon to remaining marinade, cover and refrigerate for 1-1/2 hours, turning once.",
                @"Drain and discard marinade.",
                @"Place the salmon on a broiler pan.",
                @"Broil 3-4 in. from the heat for 5 minutes.",
                @"Brush with reserved marinade; turn and broil for 5 minutes or until fish flakes easily with a fork.",
                @"Brush with remaining marinade.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ fish"];
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag60
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Easy-tomato-cucumber-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 medium@#Roma tomatoes, cubed+=prd",
                  @"1@#cucumber, cubed+=prd",
                  @"1/2 medium@#red onion, cubed or 4 scallions, finely sliced+=prd",
                  @"3 tbsp@#finely minced flat-leaf parsley+=prd",
                  
                  @"1/2@#lemon, juiced+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"1 1/2 tsp@#sumac powder+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Mix all ingredients together and you can eat this alone or as a nice garnish to any meal.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag61
{   int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"egg-a-licious-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"5@#eggs+=dry",
                  @"nil@#spicy mustard+=cnd",
                  @"nil@#celery+=prd",
                  @"nil@#green peppers+=prd",
                  
                  @"nil@#sea salt+=ssn",
                  @"nil@#lemon or lime juice+=prd",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Boil the eggs.",
                @"Peel them and cut in half, throwing out the yolk.",
                @"Mix in a bowl with the mustard (to taste), celery, green peppers, lemon or lime juice and a dash of sea salt.",
                @"You can eat it alone or on a bed of baby spinach.",
                @"As an option, you can add tuna, chicken or shrimp as a protein source.",
                nil];
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

     
}
-(void)buttontag62
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Eggplant-and-Chard-Salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"one bunch@#rainbow chard+=prd",
                  @"1 cup@#diced eggplant, sliced rounds+=prd",
                  @"1@#garlic clove, minced+=prd",
                  @"1 tbsp@#olive oil+=bak",
                  
                  @"1/4 cup@#vegetable stock+=ssn",
                  @"1/2@#lemon, juiced+=prd",
                  @"1 tsp@#Walden Farms Pancake Syrup (optional)+=iwm",
                  @"nil1@#sea salt, to taste+=ssn",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Remove the stems from the chard (you can use these in a salad so don’t toss them).",
                @"Wash the leaves and tear them into 1” pieces.",
                @"Heat oil in a skillet over med-low heat.",
                @"Add the eggplant and sauté until golden brown.",
                @"Add your garlic and vegetable stock until it simmers.",
                @"Add the swiss chard and continue stirring.",
                @"Once the chard leaves become softened, remove from heat and add the lemon juice, salt and syrup.",
                @"Enjoy this dish warm.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag63
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"eggplant-brushetta_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 large@#eggplant+=prd",
                  @"1 jar@#no sugar added bruschetta +=sac",
                  @"nil@#fresh basil+=prd",
                  @"1-2 tsp@#olive oil+=bak",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Preheat oven to 350° F.",
                @"Wash eggplant and remove stem.",
                @"Slice into 1/4 length-wise inch slices.",
                @"In a skillet, heat the olive oil over med-high heat.",
                @"Add the eggplant and lightly brown each side.",
                @"Transfer the eggplant to a baking dish.",
                @"Top with jar of bruschetta and fresh basil.",
                @"Cook until tender, about 30 minutes.",nil];
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag64
{    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"eggs-for-dinner_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 large@#zucchini+=prd",
                  @"1 large@#yellow squash+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"2 tsp@#olive oil (these are divided portions of olive oil)+=bak",
                  
                  @"2@#shallots, sliced+=prd",
                  @"1/4 tsp@#smoked paprika, plus a little more for sprinkling+=ssn",
                  @"1 large@#tomato, chopped+=prd",
                  @"1/4 cup@#fresh basil+=prd",
                  @"4 large@#eggs+=dry",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 tbsp@#sea salt+=ssn",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Trim the ends off the squash and grate using a box grater or a food processor with the grating attachment.",
                @"Combine with 1 tablespoon salt in a colander and let drain in the sink for 30 minutes.",
                @"Preheat oven to 375°F.",
                @"In an oven-proof skillet, heat 2 tablespoons olive oil over medium heat.",
                @"Add shallots, garlic, and paprika and cook, stirring, until just tender and fragrant.",
                @"Squeeze as much liquid as possible from the squash and add the squash to the skillet along with the tomatoes.",
                @"Cook, stirring occasionally, until the mixture is tender and no longer releasing liquid, about 10 minutes.",
                @"Remove skillet from heat and stir in basil.",
                @"Smooth the mixture evenly in the skillet and make four wells using the back of a spoon.",
                @"Pour 1/2 teaspoon olive oil in each well. One at a time, crack an egg into a small bowl and pour into one of the wells.",
                @"Sprinkle salt, pepper, and paprika over each egg.",
                @"Bake until egg whites are set and yolks are still soft, about 10 minutes.",
                @"Garnish with basil.",nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 eggs"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag65
{  
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"energy-breakfast-cookie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 1/2 cups@#old fashioned rolled oats+=grn",
                  @"2@#ripe bananas+=prd",
                  @"1 cup@#unsweetened applesauce+=prd",
                  @"1/3 cup@#raisins (or to taste)+=prd",
                  
                  @"1/4 cup@#chopped walnuts, toasted (optional)+=nts",
                  @"1 tsp@#vanilla extract+=ssn",
                  @"1 tsp@#cinnamon+=ssn",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat heat oven to 350℉.",
                @"Mix vanilla extract & cinnamon into the applesauce.",
                @"Blend applesauce mixture with all other ingredients & let sit for 10 minutes.",
                @"Drop cookie dough, by spoonfuls, onto a parchment paper lined cookie sheet & flatten cookies into rounds.",
                @"Bake approx. 20 - 30 minutes, or until golden & done.",
                @"Remove from oven & let rest on cookie sheet for 5 minutes, then move to cooling rack.",
                @"Store in a covered container when completely cool.",
                nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 cookies"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
}
-(void)buttontag66
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Exotic-Teahouse-Chai-Pudding_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved vanilla pudding+=iwm",
                  @"1 strong cup (5oz)@#Chai tea, chilled+=tc",
                  nil ];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"After the tea has chilled, open the vanilla pudding pack and mix it with the tea (instead of water).",
                @"Shake vigorously in a shaker.",
                @"Don’t be afraid to explore your options of your other favorite teas:  green tea, jasmine, rose tea, lemon, etc.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 oz"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

}
-(void)buttontag67
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"faux-choco-eggs_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4@#hard boiled eggs, shell removed+=dry",
                  @"5 tbsp@#Tamari soy sauce or Braggs+=ssn",
                  nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Pour the soy sauce into a pan that is approximately 10 inches in diameter.",
                @"Heat the soy sauce of medium-high heat.",
                @"When the soy sauce starts foaming up, reduce the heat to medium heat and carefully add the eggs.",
                @"Roll the eggs around in the soy sauce to coat them, and continue rolling them around the pan until the eggs are a dark mahogany color and the soy sauce has been reduced to a thick sludge.",
                @"Remove the eggs, letting any extra soy sauce drain off, and place on a plate to cool.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 egg"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag68
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"faux-potato-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"6-8@#turnips, peeled and cubed+=prd",
                  @"6-8@#hard boiled eggs, peeled and      chopped+=dry",
                  @"1/2@#green pepper, chopped+=prd",
                  @"1@#stalk celery, chopped+=prd",
                  
                  @"nil@#dijon mustard+=cnd",
                  @"1@#dill pickle, chopped+=dry",
                  @"nil1@#salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Boil the cubed turnips in salted water as you would potatoes, until tender but not real soft.",
                @"Drain and cool.",
                @"Let the turnips dry out a little.",
                @"Chop up the eggs, green pepper and celery or any other vegetable you like in your ""potato"" salad and set aside.",
                @"When the turnips are a little dry, put in large bowl.",
                @"Add the chopped veggies and eggs, and mustard.",
                @"Add the chopped pickle.",
                @"Mix it all up very well.",
                @"Salt and pepper to taste.",
                @"Chill for a few hours and serve.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag69
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"faux-potato-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#vine-ripe tomatoes+=prd",
                  @"1@#cucumber, sliced+=prd",
                  @"6@#red onion rounds+=prd",
                  @"nil@#fresh basil, chopped+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"2 tbsp@#olive oil+=bak",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Slice the tomatoes into thick round slices and spread them out on a large plate.",
                @"Layer the tomato slices with a cucumber round and onion round.",
                @"Drizzle the olive oil over each stack.",
                @"Sprinkle with chopped basil, sea salt and fresh ground pepper.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 tomato stacks"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag70
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"fresh-herb-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/4 c.@#rice vinegar+=bak",
                  @"2 tbsp@#fresh basil leaves+=prd",
                  @"1 tbsp@#fresh oregano leaves+=prd",
                  @"1/2 tsp@#fresh rosemary leaves+=prd",
                  
                  @"1 small@#clove garlic+=prd",
                  @"1/2 tsp@#Splenda or Stevia+=bak",
                  @"1/4 tsp@#sea salt+=ssn",
                  @"1/8 tsp@# ground black pepper+=ssn",
                  @"1/2 c.@#olive oil+=bak",nil];
    
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a blender add rice vinegar, basil, oregano, rosemary, garlic, Splenda or stevia, salt, and pepper.",
                @"Blend 10-15 sec. until all the herbs and garlic are finely minced.",
                @"Gradually add the olive oil and continue blending for 10-15 seconds or until everything is mixed well.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 -2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag71
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"fresh-vinaigrette-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3/4 cup@#olive oil+=bak",
                  @"1/3 cup@#white wine vinegar+=ssn",
                  @"1/2 tsp@# dijon mustard+=cnd",
                  @"nil1@#sea salt, to taste+=ssn",
                  
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Put all the ingredients in a container with a tight-fitting lid, and shake well.",
                @"Shake again before pouring over salad and tossing.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"12"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 -2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag72
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"fried-rice_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 head@#cauliflower+=prd",
                  @"2@#cloves garlic, minced+=prd",
                  @"2 tsp@#olive oil+=bak",
                  @"1 tsp@#sesame oil+=eth",
                  
                  @"1@#egg, beaten+=dry",
                  @"3@#green onions, chopped+=prd",
                  @"nil@#dash of ground pepper+=ssn",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"To grate your cauliflower, you can either use a food processor or a cheese grater.",
                @"You only need half of the head, but I suggest grating all of it and then storing half in a freezer bag for next time.",
                @"Heat the oil in a wok or large non-stick skillet on medium to medium-high heat.",
                @"Add the cauliflower and garlic and stir fry until the cauliflower is tender, not mushy.",
                @"Stir in the soy sauce and sesame oil.",
                @"Push the cauliflower to one side of the pan; pour in the beaten egg. Lightly scramble the egg briefly and then mix into the cauliflower.",
                @"Add the green onion and pepper and toss.",
                @"NOTE: Add some shrimp or chicken for a great full faux chinese meal!",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag73
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"fruit-smoothie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved peach and mango drink+=iwm",
                  @"nil@#approved wildberry yogurt or vanilla pudding+=iwm",
                  nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Combine the peach mango and wildberry yogurt drink in a blender with desired amount of ice and water.",
                @"Puree until well blended.",
                @"Counts as two servings, so divide it in half and save some for later or split with a friend.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag74
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"garlic-spinach_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 bunch@#spinach+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"2 cloves@#garlic, minced+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Wash the spinach leaves and pat them dry or dry them in a salad spinner.",
                @"Place the olive oil in a large skillet over medium heat.",
                @"Add the minced garlic to the skillet.",
                @"Add the spinach to the skillet and sauté over medium-low heat until the spinach leaves turn dark green.",
                @"Don’t over cook!  Sprinkle with sea salt and ground pepper to taste.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
   
}
-(void)buttontag75
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"gar-licking-good-brussel-sprouts_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 lb@#brussels sprouts, ends trimmed+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"12 cloves@#garlic, peeled and quartered lengthwise+=prd",
                  @"1/2 tsp@#sea salt+=ssn",
                  
                  @"1/8 tsp@# ground black pepper+=ssn",
                  @"1 tbsp@#apple cider vinegar+=bak",
                  nil];
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Place brussels sprouts in food processor.",
                @"Pulse 12 to 15 times, or until shredded.",
                @"Heat oil in large nonstick skillet over medium-low heat.",
                @"Add garlic, and cook 5 to 7 minutes, or until light brown.",
                @"Increase heat to medium-high, and add shredded Brussels sprouts, salt and pepper.",
                @"Cook 5 minutes, or until browned, stirring often.",
                @"Add 1 1/2 cups water, and cook 5 minutes more, or until most of liquid is evaporated.",
                @"Stir in vinegar, and season to taste with sea salt and pepper.",
                @"Serve immediately.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag76
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"giligans-island-chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#skinless boneless chicken breast+=meat",
                  @"6 tbsp@#soy sauce+=ssn",
                  @"2 tbsp@#ginger, fresh+=prd",
                  @"8 oz@#chicken broth+=ssn",
                  
                  @"2 tbsp@#lemon juice+=prd",
                  @"2 tsp@#Walden Farms pancake syrup+=wf",
                  @"4 cups@#broccoli+=prd",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 375°F.",
                @"Marinate chicken thighs for 5-10 minutes in 4 tbs. of soy sauce, 1 tbs. of ginger, and the lemon juice.",
                @"While marinating prepare a baking sheet with broccoli, spray with olive oil, then sprinkle with salt, pepper, garlic powder, and a few squirts of lemon juice.",
                @"Put in oven at 375℉ for 10 minutes (my broccoli was frozen).",
                @"In a sauce pan, whisk together, 2 tbs. soy sauce, 1/2-3/4 can of chicken broth,  and 1 tbs. ginger.",
                @"Bring to a boil, whisk in syrup and simmer until thickened.",
                @"Increase oven temp to 400℉ and continue to roast broccoli until just browned at tips of florets.",
                @"Heat a skillet on med-medhigh heat and spray with olive oil or nonstick spray.",
                @"Brown chicken thighs, approximately 3-4 minutes per side or until fully cooked.",
                @"Top chicken and broccoli with the ginger sauce.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag77
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Greek-Goddess-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3/4 cup@#olive oil+=bak",
                  @"1/4 cup@#lemon juice+=prd",
                  @"2 tbsp@#dried oregano, crushed+=ssn",
                  @"1 clove@#garlic, crushed+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Put all the ingredients in a container with a tight-fitting lid, and shake well.",
                @"Don’t double this one, the lemon juice doesn’t last as long as the recipes that use vinegar.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"12"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag78
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"grilled-eggplant-and-zucchini-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1@#eggplant, sliced into rounds+=prd",
                  @"1@#yellow squash, sliced into rounds+=prd",
                  @"1@#zucchini, sliced into rounds+=prd",
                  @"3 tbsp@#olive oil+=bak",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",
                  @"2 cloves@#garlic, finely chopped+=prd",
                  @"2 tbsp@#fresh basil, chopped+=prd",
                  @"1 tbsp@#apple cider vinegar+=bak",
                  @"2 tbsp@#olive oil+=bak",
                  @"nil@#sea salt+=ssn",
                  @"nil@#pepper+=ssn",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat grill to medium-high intensity.",
                @"Place eggplant rounds, squash and zucchini with the olive oil, salt, pepper and mix well.",
                @"Cook on the grill directly over the heat to keep rounds light and crispy.",
                @"Prepare dressing by mixing garlic, basil, vinegar, olive oil, salt and pepper.",
                @"Add dressing to the warm eggplant rounds and grilled zucchini and stir delicately so as not to break the rounds.",
                @"Serve lukewarm or at room temperature.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag79
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"guiltless-rataouille_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1@#eggplant, cut into disks+=prd",
                  @"1/3 cup@#olive oil+=bak",
                  @"4@#garlic cloves, minced+=prd",
                  @"1 tsp@#sea salt+=ssn",
                  
                  @"1/2 tsp@#dried rosemary+=ssn",
                  @"1/2 tsp@#dried thyme+=ssn",
                  @"1/4 tsp@#ground pepper+=ssn",
                  @"1 medium@#zucchini, cut into chunks+=prd",
                  @"1@#yellow squash, sliced into chunks+=prd",
                  @"1@#red bell pepper, cut into small chunks+=prd",
                  @"1@#small tomato, cut into small chunks+=prd",
                  @"1 small@#onion, thinly sliced+=prd",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Sprinkle eggplant with salt; place in a colander and let bitter juices drain 20 minutes.",
                @"Rinse eggplant and pat dry.",
                @"Heat oven to 425℉.",
                @"In a 10x15 baking dish, mix oil, garlic, salt, rosemary, thyme, and pepper.",
                @"Add vegetables, toss to coat evenly with oil mixture.",
                @"Cover dish with foil and bake 15 minutes.",
                @"Uncover and cook 30 minutes more, mixing occasionally, until vegetables are tender and browned.",
                nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag80
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"halibut-with-picante-sauce_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#cucumbers, seeded and finely        chopped+=prd",
                  @"2@#radishes, finely chopped+=prd",
                  @"4@#tomatoes, seeded and finely chopped+=prd",
                  @"1@#grilled yellow pepper, finely chopped+=prd",
                  
                  @"1/8@#red onion finely chopped+=prd",
                  @"1/2 tsp@#lemon juice+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"4@#halibut fillets (your favorite white fish)+=sf",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Mix cucumbers, radishes, tomatoes, yellow pepper, onion, lemon juice, salt and pepper in a small bowl.",
                @"Roast fish on oiled baking sheet (about 5 minutes on each side at 375 degrees) or on a grill, over medium heat (about 5 minutes on each side).",
                @"Serve with picante sauce.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag81
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"herb-rubbed-turkey-breast_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 tsp@#sage, fresh+=prd",
                  @"1 tsp@#thyme, fresh+=prd",
                  @"1/4 tsp@#celery salt+=ssn",
                  @"1@#sprig rosemary, fresh+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"3 pounds@#turkey breast, bone in or boneless+=meat",nil];
   [self ingridients];
    
    instrArray=[[NSArray alloc]initWithObjects:@"Combine the herbs in a small bowl and mix well.",
                @"Rub the herb mixture generously over the outside of the turkey breasts and under the skin, taking care not to tear the skin.",
                @"Place the turkey breasts in your slow cooker, cover and cook on low for eight hours.",
                @"You can also cook this in the oven and bake at 350℉ for 20 minutes per pound.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag82
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"herb-your-enthusiasm-veggies_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 cups@#raw broccoli florets+=prd",
                  @"2 cups@#eggplant, cut into small chunks+=prd",
                  @"nil@#spray olive oil+=bak",
                  @"1 tbsp@# sea salt+=ssn",
                  
                  @"1 tbsp@#black pepper+=ssn",
                  @"1 tbsp@#paprika+=ssn",
                  @"1 clove@#garlic, finely chopped+=prd",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 400°F.",
                @"Spray a foil-lined baking sheet with Olive Oil.",
                @"Add the veggies, spray with more olive oil.",
                @"Add the salt, pepper, paprika, garlic, rosemary and thyme.",
                @"Toss to distribute.",
                @"Bake for 10 - 15 minutes.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag83
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"holiday-green-beans_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4-5@#garlic cloves, minced+=prd",
                  @"1 tbsp@#minced ginger root+=prd",
                  @"1@#red bell pepper, cut into thin strips+=prd",
                  @"1 pound@#green beans with ends trimmed and cut in half+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450℉.",
                @"Mince the garlic cloves, enough to make a heaping tablespoon.",
                @"Peel ginger root and finely mince enough to make a heaping tablespoon.",
                @"Put olive oil, minced garlic and minced ginger in a glass bowl or measuring cup and let it marinate while you prep vegetables.",
                @"Cut red bell pepper into fourths lengthwise, then remove seeds and trim any white pithy parts.",
                @"Cut off rounded top and bottom parts to make it easier to cut even strips, then cut each piece of pepper into thin crosswise strips.",
                @"Trim ends of green beans and cut them in half.",
                @"Put the green beans and red pepper strips into a medium-sized bowl and then toss with the olive oil, minced garlic, and minced ginger.",
                @"Season to taste with salt and fresh ground black pepper.",
                @"Spread the vegetables out on a large baking sheet, arranging it so vegetables aren't crowded (as much as you can).",
                @"Roast 15 minutes, or until a few beans are starting to look browned and the veggies are tender-crisp.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag84
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"hole-in-one_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1@#red bell pepper+=prd",
                  @"1@#green bell pepper+=prd",
                  @"1@#orange bell pepper+=prd",
                  @"8@#eggs+=dry",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
    
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Cut off the tops of the peppers and core out the seeds on the inside.",
                @"Slice pepper into rings.",
                @"Spray your skillet with olive oil and heat over low heat.",
                @"Add the pepper rings and you may need to hold them down while you crack the eggs into the pepper ring.",
                @"Heat over low heat until desired firmness of yolk.",
                @"Serve with turnip hash browns for a great “breakfast for dinner” meal.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 eggs"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
   
}
-(void)buttontag85
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"home-skillet-turnip-fries_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#turnips+=prd",
                  @"2 tsp@#olive oil+=bak",
                  @"nil@#Rosemary & Garlic seasoning (or fresh)+=ssn",
                  @"nil@#sea salt+=ssn",
                  
                  @"nil@#pepper+=ssn",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Peel the turnips.",
                @"Cut into small cubes.",
                @"Heat olive oil over medium heat in skillet.",
                @"Cook turnips until they start to brown.",
                @"This takes a lot longer than typical potatoes, but they are better the longer they cook.",
                @"Top with seasonings.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag86
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"homemade-pizza-sauce_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"12@#plum tomatoes+=prd",
                  @"1@#white onion, chopped fine+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"2 tbsp@#garlic, minced+=prd",
                  
                  @"1 tbsp@#sea salt+=ssn",
                  @"1/2 tbsp@#crushed red pepper+=ssn",
                  nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Peel the tomatoes and purée them in a food processor until smooth.",
                @"Heat the oil in an 8 quart pan.",
                @"Add onions and sauté them until they are transparent, about 6 minutes (this is the only time you have cooked onions on phase 1).",
                @"Then, add the garlic.",
                @"Add the tomato purée along with the salt and red pepper.",
                @"Bring the mixture to a boil.",
                @"Then reduce heat and simmer, stirring occasionally, as the sauce thickens.",
                @"The sauce should be pretty smooth when finished.",
                @"Voila! You’ve made all-natural, excellent pizza sauce from all whole ingredients.",
                @"This pizza sauce recipe can be canned or frozen, so if you have leftovers after you prepare your pizza, go ahead and save some for next time.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/4 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
     
}
-(void)buttontag87
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"I'm-having-Pie-for-breakfast_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 cups@#unsalted macadamia nuts+=nts",
                  @"1/2 cup@#pitted dates (non sugar coated)+=prd",
                  @"1/4 cup@#dried coconut+=bak",
                  @"1 32-oz@#vanilla greek yogurt+=dry",
                  
                  @"1/2 cup@#fresh blueberries+=prd",
                  @"1/2 cup@#fresh strawberries+=prd",
                  @"1/2 cup@#fresh blackberries+=prd",
                  @"1/2 cup@#fresh raspberries+=prd",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Line mesh sieve with 3 paper towels over bowl.",
                @"Pour yogurt into sieve.",
                @"Refrigerate and drain 8 hours or overnight.",
                @"To make the crust, process the 2 cups of the macadamia nuts and 1/2 cup of the dates in the food processor until they get to the crust consistency.",
                @"Sprinkle dried coconut onto the bottom of a round pie pan.",
                @"Yogurt should be as dry as possible.",
                @"Discard liquid in bowl.",
                @"Pour yogurt into pie shell and chill for 2 hours or more.",
                @"Top with berries before serving.",
                @"You can have this with your phase 3 breakfast",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 slice"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

    
}
-(void)buttontag88
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"I'm-not-cajun-around_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 lb@#round steak cut in 8 pieces+=meat",
                  @"1/4 tsp@#sea salt+=ssn",
                  @"2 tbsp@#olive oil+=bak",
                  @"1/4 cup@#tomato paste, no sugar added+=cg",
                  
                  @"2 cups@#light beef broth, no MSG+=bak",
                  @"2 slices@#turkey bacon, no nitrates+=meat",
                  @"2 small@#leeks cut in half rounds (whites only)+=prd",
                  @"2 cloves@#garlic, minced+=prd",
                  @"2@#elery stalks, chopped+=prd",
                  @"2 tsp@#cajun seasoning+=ssn",
                  @"1 tsp@#dried thyme+=ssn",
                  @"1@#green pepper, diced+=prd",
                  @"2@#green onions, chopped+=prd",
                  @"2 tbsp@#fresh parsley, chopped+=prd",nil];
    
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In skillet, heat olive oil over medium-high heat and brown meat in different batches if needed.",
                @"Transfer meat to slow cooker.",
                @"In a bowl, whisk tomato paste into beef broth; pour into skillet and bring to boil, scraping up brown bits.",
                @"Pour into slow cooker.",
                @"Add remaining ingredients, except green pepper, green pepper, green onions and parsley.",
                @"Cover and cook until meat is tender (low for 8 hrs or high for 4-6 hrs).",
                @"Add green pepper; cook on high 15 mins.",
                @"Serve sprinkled with green onions and parsley.",nil];
    
    
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag89
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"I'm-so-stuffed-peppers_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"6 large@#green peppers+=prd",
                  @"2 pounds@#lean ground beef+=meat",
                  @"1/2 cup@#soy sauce or Braggs+=ssn",
                  @"nil@#Salsa with no added sugar+=prd",
                  
                  @"nil1@#cilantro, to taste+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"1 tsp@#olive oil+=bak",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350° F.",
                @"Cut the tops of the peppers and clean out the seeds.",
                @"Cook the peppers in boiling water for 5 minutes.",
                @"Drain and sprinkle salt inside each pepper.",
                @"In a large skillet, sauté beef in 1 tsp olive oil and 1/2 cup soy sauce.",
                @"Stuff each pepper with the beef and a spoon-full of salsa. bake covered for 25 -35 minutes.",
                
                
                nil];
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 pepper"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    

     
}
-(void)buttontag90
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"incredible-hulk-smoothie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @" 6 oz.@#plain greek yogurt+=dry",
                  @"3/4 cup@#chopped kale+=prd",
                  @"1 small@#stalk celery, chopped+=prd",
                  @"1/2@#banana+=prd",
                  
                  @"1/2@#apple (with the peel)+=prd",
                  @"1/2 cup@#ice+=wtr",
                  @"1 tbsp@#fresh lemon or lime juice+=prd",
                  @"1/2 cup@#milk (or milk substitute)+=dry",
                  @"1 scoop@#vanilla protein powder+=othr",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place milk and kale in blender and blend until very smooth.",
                @"Then add the other ingredients and blend until smooth.",
                @"Note:  be sure to use a high biological and clean protein powder.",
                @"You can also use a Ready Made Vanilla as your milk product AND protein!  Makes a great phase 3 breakfast.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag91
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"italian-chicken-in-the-slow-cooker_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3 pounds@#boneless chicken breast+=meat",
                  @"1 can@#chopped tomatoes+=cg",
                  @"2 1/2 cups@#water+=wtr",
                  @"2 tsp@#sea salt+=ssn",
                  
                  @"2 tsp@#ground pepper+=ssn",
                  @"2 tsp@#garlic powder+=ssn",
                  @"4 tsp@#oregano+=ssn",
                  @"1 pkg@#frozen collard greens+=frz",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place collard greens in crock pot and pour in water.",
                @"Sprinkle all of the dry ingredients onto the chicken breasts and then place the chicken on top of the greens.",
                @"Pour tomatoes over chicken.",
                @"Cook on high or 6 to 8 hours.",
                @"Add a small salad to this and it’s perfect.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag92
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"its-a-date-smoothie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"6 oz.@#plain greek yogurt+=dry",
                  @"1/2 cup@#milk (or milk substitute)+=dry",
                  @" 1/3 cup@#halved pitted dates+=prd",
                  @"1/2@#banana+=prd",
                  
                  @"1/2 cup@#ice+=wtr",
                  @"1 scoop@#vanilla protein powder+=othr",
                  nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Place the dates and milk in a blender and refrigerate until the dates have softened (about 15 mins).",
                @"Add the other smoothie ingredients and blend until smooth.",
                @"Note: be sure to use a high biological and clean protein powder.",
                @"You can also use a Ready Made Vanilla as your milk product AND protein!  Makes a great phase 3 breakfast.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

     
}
-(void)buttontag93
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"It's-Lemon-Thyme-Chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 lbs@#boneless skinless chicken breasts+=meat",
                  @"1 lb@#fresh green beans+=prd",
                  @"1/2 can@#stewed tomatoes+=cg",
                  @"1/2 tsp@#fennel seeds+=ssn",
                  
                  @"1/2 tsp@#paprika+=ssn",
                  @"1/2 cup@#water+=wtr",
                  @"nil@#zest of a lemon+=prd",
                  @"1/2 tbsp@#fresh chopped thyme+=ssn",
                  @"3 cloves@#garlic, minced+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",
                  @"1/4 cup@#olive oil+=bak",nil];
    
    [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"In a slow cooker, combine all ingredients.",
                @"Let it cook on low for 7-8 hours or high for 4-5 hours.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];

   
}
-(void)buttontag94
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"It's-Shredding-Zucchini-Thyme_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3-4@#zucchini+=prd",
                  @"1 1/2 tsp@#sea salt+=ssn",
                  @"1 tbsp@#apple cider vinegar+=bak",
                  @"1/2 tbsp@#olive oil+=bak",
                  
                  @"1 tsp@#fresh thyme+=ssn",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Remove the stem ends from the zucchini, then grate.",
                @"Transfer to a colander, stir in the salt.",
                @"Let rest for about 15 minutes in a sink or over a dish.",
                @"Grab a handful of zucchini and squeeze out the liquid, repeating until no more can be easily extracted.",
                @"Heat a skillet over MEDIUM HIGH.",
                @"Add vinegar, olive oil and zucchini.",
                @"Toss gently.",
                @"Cook until zucchini is hot and cooked through, turning occasionally.",
                @"Stir in thyme.",
                @"Serve immediately.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag95
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"japanese-ginger-salad-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/4 cup@#soy sauce+=eth",
                  @"1@#lemon, juiced+=prd",
                  @"3@#cloves garlic, minced+=prd",
                  @"3 tbsp@#minced fresh ginger root+=prd",
                  
                  @"1 tsp@#dijon mustard+=cnd",
                  @"2 tsp@#Splenda or Stevia+=bak",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
    
    
    [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Put all ingredients into a blender and purée until smooth.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag96
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"just-like-carrot-cake_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved white chocolate cinnamon bar+=iwm",
                  nil];
    
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Just heat in the microwave for 15 -20 seconds and close your eyes and enjoy your carrot cake!",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag97
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"kale-and-avocado-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 bunch@#kale+=prd",
                  @"1/2@#avocado, diced+=prd",
                  @"1@#carrot+=prd",
                  @"1@#cucumber, sliced+=prd",
                  
                  @"1/2@#red onion, thinly sliced+=prd",
                  @"1/2@#lime, juiced+=prd",
                  @"1/2 tbsp@#rice vinegar+=ssn",
                  @"1 tbsp@#walnut (or olive) oil+=bak",
                  @"1 tsp@#sea salt+=ssn",
                  @"1 tsp@#ground pepper+=ssn",
                  @"2 tbsp @#parmesan cheese (optional)+=dry",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Fold the kale leaves and remove the stem with your hands.",
                @"You can also use your knife to cut the stem out as well.",
                @"Then thinly slice or tear the kale into bite-sized pieces.",
                @"Add the avocado pieces and massage into the kale with your hands.",
                @"This will help break the kale down, making it easier to chew.",
                @"The avocado should no longer be in pieces, but resemble more of a chunky paste.",
                @"You can chop the carrot and cucumber or cut into matchsticks.",
                @"Add the carrot and cucumber to the kale along with the red onion.",
                @"Mix the lime juice, vinegar and oil together in a small dish with the sea salt and pepper.",
                @"Pour over the salad and again massage in with your hands.",
                @"Add parmesan if you'd like.",
                @"Enjoy immediately or pack for lunch the next day.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
}
-(void)buttontag98
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"kale-berry-smoothie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 cup@#frozen blueberries+=frz",
                  @"1/2 cup@#frozen strawberries+=frz",
                  @"1 tbsp@#ground flax seed+=bak",
                  @"2 cups@#raw kale, torn into pieces+=prd",
                  
                  @"1 cup@#water+=wtr",
                  nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"First blend kale and water until all the chunks are one.",
                @"Then add the berries and flax seed and blend until smooth.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag99
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"key-west-shrimp_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tsp@#olive oil+=bak",
                  @"2 pounds@#shrimp, shelled and deveined+=sf",
                  @"6@#cloves garlic, crushed+=prd",
                  @"1/3 cup@#chopped fresh cilantro+=prd",
                  
                  @"1@#lime+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat a large frying pan on medium-high heat.",
                @"Add oil to the pan, when hot add shrimp.",
                @"Season with salt and pepper.",
                @"When the shrimp is cooked on one side, about 2 minutes, turn over and add garlic.",
                @"Sauté another minute or two until shrimp is cooked, careful not to overcook.",
                @"Remove from heat.",
                @"Squeeze lime all over shrimp and toss with cilantro.",
                @"Serve hot.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag100
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"kickin-collard-greens_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tbsp@#olive oil+=bak",
                  @"3 slices@#turkey bacon (with no nitrates!  Applegate Farms or Trader Joe’s Brands are great)+=meat",
                  @"2@#cloves garlic, minced+=prd",
                  @"1 tsp@#sea salt+=ssn",
                  
                  @"1 tsp@#ground pepper+=ssn",
                  @"3 cups@#chicken broth+=ssn",
                  @"1 pinch@#red pepper flakes+=ssn",
                  @"1 pound@#fresh collard greens, cut into 2-inch pieces+=prd",nil];
    
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat oil in a large pot over medium-high heat.",
                @"Add bacon, and cook until crisp.",
                @"Remove bacon from pan, crumble and return to the pan.",
                @"Add garlic, and cook until just fragrant.",
                @"Add collard greens, and fry until they start to wilt.",
                @"Pour in chicken broth, and season with salt, pepper, and red pepper flakes.",
                @"Reduce heat to low, cover, and simmer for 45 minutes, or until greens are tender.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag101
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Legal-Hash-Browns_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#bean sprouts+=prd",
                  @"2@#beaten egg whites+=dry",
                  @"1 tsp@#dried basil, crumbled+=ssn",
                  @"1 tsp@#dried oregano+=ssn",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"nil@#hot sauce (optional)+=sac",nil];
 [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Beat 2 egg whites until they hold a firm shape.",
                @"Add in herbs, sprouts and spices.",
                @"Mix. Scoop onto a med-hot pan sprayed wit non-stick spray or a little olive oil.",
                @"Spread the batter out to make a patty in the shape you want.",
                @"When fully cooked on one side, flip.",
                @"If not cooked thoroughly, it may fall apart but is still tasty.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag102
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"legal-lemon-noodles-php_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 whole@#cucumber+=prd",
                  @"1 whole@#lemon, zested and juiced+=prd",
                  @"1 tbsp@#sea salt+=ssn",
                  @"1 tsp@#cumin+=ssn",
                  
                  nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"To make the cucumber into noodles, you’ll need a Spiral Slicer or a Julienne Peeler or just make this recipe with diced cucumber",
                @"Once your cucumber is prepared how you like it, place it in a bowl and toss with the lemon juice, sea salt, and cumin",
                @"Transfer to a bowl and garnish with lemon zest",
                nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag103
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Lem-Me-Some-Chicken-Slow-Cooker_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#chicken breasts+=meat",
                  @"2 tsp@#olive oil+=bak",
                  @"1 tsp@#dried oregano+=ssn",
                  @"1/4 cupchicken broth+=bak",
                  
                  @"3 tbsp@#lemon juice+=prd",
                  @"2@#cloves garlic, finely chopped+=prd",
                  @"2 tbsp@#fresh parsley, chopped+=prd",
                  @"1 tsp@#chicken bouillon concentrate+=bak",
                  @"nil1@#sea salt, to taste+=ssn",nil];

    [self ingridients];
    instrArray=[[NSArray alloc]initWithObjects:@"In a big heavy skillet, brown the chicken in the olive oil over medium-high heat.",
                @"In a bow, mix together the oregano, salt and pepper.",
                @"When the chicken is golden, sprinkle the spice mixture over it.",
                @"Transfer the chicken to your slow cooker.",
                @"Pour the broth and lemon juice in the skillet, stirring around to deglaze the pan.",
                @"Add the garlic, parsley and bouillon.",
                @"Stir until the bouillon dissolves, Poor into the slow cooker.",
                @"Cover the slow cooker, set it to low and let it cook for 4 - 5 hours.",
                @"When the chicken is tender, remove it from the slow cooker.",
                @"Poor the sauce from the slow cooker over the chicken.",
                @"This dish goes well with Cauli-Rice.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag104
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"lemon-cabbage-wedge_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 medium@#head of green cabbage+=prd",
                  @"1 tbsp@#olive oil+=bak",
                  @"2 -3 tbsp@#fresh squeezed lemon juice+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450 °F.",
                @"Spray a roasting pan with olive oil spray.",
                @"Cut the head of the cabbage into 8 same-size wedges, cutting through the core and stem end.",
                @" Then carefully trim the core strip and stem from each wedge and arrange wedges in a single layer on the roasting pan (leave some space around them as much as you can).",
                @"Whisk together the olive oil and lemon juice.",
                @"Then use a pastry brush to brush the top sides of each cabbage wedge with the mixture and season generously with salt and fresh ground pepper.",
                @"Turn cabbage wedges carefully, then brush the second side with the olive oil/lemon juice mixture and season with salt and pepper.",
                @"Roast cabbage for about 15 minutes or until the side touching the pan is nicely browned.",
                @"Then turn each wedge carefully and roast 10-15 minutes more, until the cabbage is slightly crispy.",
                @"Serve warm with a lemon wedge on the side.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag105
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"lemon-pepper-zucchini_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 large@#zucchini, shredded+=prd",
                  @"2 tbsp@#fresh lemon juice+=prd",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"2 tbsp@#olive oil+=bak",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"2 tbsp@#sesame seeds+=ssn",
                  @"nil@#fresh herbs (basil, oregano, cilantro to taste)+=prd",
                  @"1 tsp@#fresh ginger+=prd",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Add 2 tbsp olive oil to pan on med-high heat.",
                @"Pour in sesame seeds and cook until just starting to brown and stir so that they don’t burn.",
                @"Drop in shredded zucchini. Squeeze lemon juice.",
                @"Add herbs, ginger, salt and pepper.",
                @"Remove from heat and eat hot.",
                @"*FOR LEFTOVERS: refrigerate the leftovers.",
                @"When ready, beat 2 egg whites and add remaining zucchini.",
                @"Drop into hot pan to make veggie pancakes.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag106
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"lemon-rosemary-broiled-salmon_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#coconut oil+=bak",
                  @"1 pound@#wild salmon+=sf",
                  @"1@#lemon+=prd",
                  @"1 tsp@#rosemary blend (or you can make your own)+=ssn",
                  
                  nil];
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat the oven to a low broil setting.",
                @"Place coconut oil in a baking dish where you will place the salmon.",
                @"Place the salmon in the dish and sprinkle with the rosemary salt.",
                @"Place a little more coconut oil on top of the salmon, then top with slices of lemon.",
                @"Broil on low for approximately 10-15 minutes or until the salmon is cooked to your liking.",
                @"A  thicker piece of fish may take closer to 15 minutes while a thin piece will take just around 10.",
                @"For the Rosemary Salt Blend:  Ingredients: 1/2 c ground, dried rosemary (preferably made from drying fresh rosemary)1/4 c coarse sea salt ",
                @"Preparation:1. Combine all spices in a food processor. Store in a jar or resealable bag for use in recipes.",nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag107
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"lemon-zest-tofu_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 blocks@#firm or extra firm tofu, well-pressed+=veg",
                  @"2 tbsp@#olive oil+=bak",
                  @"2 tbsp@#soy sauce or Braggs+=ssn",
                  @"2 tbsp@#lemon juice+=prd",
                  
                  @"2 tbsp@#dijon mustard+=cnd",
                  @"1 tsp@#basil+=ssn",
                  @"1 tsp@#thyme+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",nil];
    
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"To press your tofu, you'll need a cutting board, several paper towels, a large bowl or another cutting board, and something to use as a weight (a can of beans is fine).",
                @"Fold a paper towel or dish cloth in half or fourths to increase absorbency.",
                @"Place the towels on the cutting board and place the tofu on the towels.",
                @"If the towels become too wet after absorbing the initial moisture, you may want to place the tofu on a second fresh layer of towels.",
                @"Place another layer of folded paper towels on top of the tofu.",
                @"Then, place the bowl or another cutting board on top of the towels.",
                @"Next, place the weight on top.",
                @"Your weight should be heavy enough to press down evenly across the top of the tofu, but not so heavy that the tofu crumbles.",
                @"A large can of beans or soup is perfect.",
                @"Let the tofu sit for at least 15 minutes.",
                @"Preheat oven to 375°F.",
                @"Slice your pressed tofu into 1/2 inch thick strips.",
                @"Whisk together all ingredients except for tofu.",
                @"Transfer to a shallow pan or zip-lock bag and add tofu, coating well.",
                @"Allow tofu to marinate for at least 1 hour (the longer the better!), turning to coat well with marinade.",
                @"Heat oven to 375°F.",
                @"Transfer tofu and marinade to baking dish and bake for 20-25 minutes, turning halfway through and pouring extra marinade over the tofu as needed.",
                nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag108
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"light-and-fresh-marinade_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#grainy mustard+=cnd",
                  @"1 tbsp@#fresh rosemary or 1 1/2 tsp dried+=prd",
                  @"2@#shallots, peeled and chopped+=prd",
                  @"1/2 c@#white wine vinegar+=bak",
                  
                  @"3@#cloves garlic, minced+=prd",
                  @"1/4 tsp@#black pepper+=ssn",nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Mix all ingredients together well and allow your veggies, poultry, fish or other protein to soak for at least 15 - 20 minutes.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 -2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag109
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Lime-Coleslaw_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2@#head cabbage, sliced+=prd",
                  @"nil@#juice and zest of 1 lime+=prd",
                  @"1 tbsp@#lemon juice+=prd",
                  @"1 1/2 tsp@#sea salt+=ssn",
                  
                  @"1 packet@#Splenda or Truvia (optional)+=bak",
                  @"1 1/2 tbsp@#olive oil+=bak",
                  @"3 tbsp@#apple cider vinegar+=ssn",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Add all ingredients in a bowl and cover with plastic wrap.",
                @"Let it sit at least 8 hours.",
                @"Enjoy cool.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag110
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"limelight-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1@#clove garlic, finely chopped+=prd",
                  @"1 1/2 tsp@#mustard+=cnd",
                  @"2@#limes, finely grated rind and juice+=prd",
                  @"1 tbsp@#rice vinegar+=ssn",
                  
                  @"1/4 cup@#olive oil+=bak",
                  @"1 tsp@#capers+=ssn",
                  @"3 tbsp@#fresh cilantro, chopped+=prd",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place the garlic, mustard, lime juice, rind, and vinegar in a bowl and mix together.",
                @"Slowly poor in the oil, whisking constantly, until well emulsified.",
                @"Stir in the capers and cilantro.",
                @"Season with fresh ground pepper.",
                @"Store in a glass container.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 Tsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag111
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"magic-sauce_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4@#green tomatoes or 6 tomatillos+=prd",
                  @"1@#red pepper+=prd",
                  @"1@#poblano pepper+=prd",
                  @"1 tbsp@#chopped garlic+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"1/4 cup@#chopped fresh cilantro+=prd",
                  @"1 -2 tbsp@#olive oil+=bak",nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat your oven to broil and line a cookie sheet with foil.",
                @"Core the tomatoes and the peppers.",
                @"Peel the tomatillos to get the papery outside off, wash them to get the stickiness off and then core them.",
                @"Cut all the vegetables into about 1 inch chunks.",
                @"Coat and toss them all lightly in olive oil.",
                @"Spread them out on the cookie sheet in a thin layer.",
                @"Place under broiler - top shelf of oven.",
                @"Watch them closely as they start to brown.",
                @"Take them out once they have started to brown and let cool.",
                @"Put 1/2 of the vegetables in the blender.",
                @"Add garlic, salt, pepper and cilantro.",
                @"Blend until mixture is to the texture of your preference.",
                @"Add the rest of the veggies and blend again.",
                @"Serve warm over a piece of grilled chicken or fish.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag112
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"MaMaws-Chicken-'n'-Dumplings_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved plain crepe or pancake+=iwm",
                  @"2 cups@#chicken broth+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  
                  @"8 oz@#uncooked chicken+=meat",
                  nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Cook chicken in crock pot with broth for about 6 hours.",
                @"Note: you can use pre-cooked chicken if time doesn’t allow.",
                @"Remove chicken and cut into pieces.",
                @"Pour broth into pot over high heat and bring to a boil.",
                @"Mix crepe mix into a thick dough.",
                @"Add salt and pepper to taste.",
                @"Roll into a few small dough balls and drop into the boiling broth.",
                @"If the broth isn’t boiling, they will fall apart.",
                @"Stir in cooked chicken and enjoy.",
                @"Add any veggies you want too! Delicious!",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
}
-(void)buttontag113
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"maple-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 cup@#soy sauce or Braggs+=ssn",
                  @"1/2 cup@#apple cider vinegar+=ssn",
                  @"1/2 cup@#Walden Farms syrup+=wf",
                  @"2 tbsp@#Splenda or stevia+=bak",
                  
                  @"2 tbsp@#dijon mustard+=cnd",
                  @"1 small@#garlic clove+=prd",
                  @"1/ tsp@#ginger, finely chopped+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1/2 cup@#olive oil+=bak",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Put all the ingredients in a container with a tight-fitting lid, and shake well.",
                @"Shake again before pouring over salad and tossing.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag114
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Mazing-Marinade_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4 tbsp@#olive oil+=bak",
                  @"4 tbsp@#soy sauce or Braggs+=ssn",
                  @"1 tbsp@#fresh ginger+=prd",
                  @"1 tbsp@#garlic, minced+=prd",
                  
                  @"1 tsp@#paprika+=ssn",
                  @"nil@#squeeze of lemon juice+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a ziploc bag, combine all ingredients and allow your protein of choice to soak for at least 30 minutes.",
                @"Then just bake or grill your food and enjoy!",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/4 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag115
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"mi-so-cute-cucumber-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 1/2 tbsp@#white miso (soybean paste) or lower sodium soy sauce+=eth",
                  @"1 tbsp@#rice vinegar+=bak",
                  @"1 tbsp@#hot water+=wtr",
                  @"2 tsp@#dark sesame oil+=eth",
                  
                  @"4 cups@#thinly sliced, seeded cucumber+=prd",
                  @"1 tbsp@#sliced green onions+=prd",
                  nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Combine miso, water, vinegar, 1 tablespoon sliced green onions, 1/4 teaspoon black pepper, and 1/8 teaspoon salt.",
                @"Heat 1 tablespoon sesame oil in a large skillet over medium heat.",
                @"Add cucumber to pan; sauté 4 minutes.",
                @"Toss cucumber with juice mixture.",
                nil];
    
   
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag116
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"mongolian-beef-goulash_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#beef stew meat or lean steak cut up+=meat",
                  @"2 tbsp@#hot paprika+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 large@#onion, chopped+=prd",
                  
                  @"1@#red bell pepper, chopped+=prd",
                  @"1 cup@#tomatoes, diced+=prd",
                  @"1 cup@#mushroom, sliced+=prd",
                  @"1 1/2 cups@#reduced sodium beef broth+=ssn",
                  @"1 tsp@#worcestershire sauce+=ssn",
                  @"3@#cloves garlic, minced+=prd",
                  @"2@#bay leaves+=ssn",
                  @"1 tbsp@#cornstarch mixed with 2 tbsp      water+=bak",nil];
    
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Spray crockpot with non-stick spray.",
                @"Place beef in crockpot.",
                @"Sprinkle the beef with paprika and pepper.",
                @"Add diced tomatoes, mushrooms, broth, worcestershire sauce, chopped onion, chopped bell pepper and garlic.",
                @"Place bay leaves on top. Cover on low for 6 -8 hours until beef is tender.",
                @"Remove the bay leaves and add the cornstarch mixture to the stew and cook on high, until thickened - about 10 -1 5 minutes.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag117
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"must-try-roasted-fennel-roots_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1-2@#Fennel bulbs+=prd",
                  @"2 tsp@#olive oil+=bak",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",
                  
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350°F.",
                @"Cut green tops off the fennel bulb.",
                @"Cut the bulb into quarters and place in a baking dish.",
                @"Bake in oven for about 45 minutes.",
                @"Fennel should be soft but still have some firmness.",
                @"Enjoy as a side dish or cool and slice on salads.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag118
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"no-fail-kale-chips_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 large@#bunch of kale+=prd",
                  @"1-2 tsp@#olive oil+=bak",
                  @"nil@#sea salt+=ssn",
                  @"nil@#pepper+=ssn",
                  
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 300° F.",
                @"Wash kale, remove the inner rib or stem, and tear into chip-size pieces.",
                @"Make the pieces a little larger than you want the chips because they will shrink.",
                @"The kale must be thoroughly dried.",
                @"I ran it through a salad spinner, laid it out on paper towels for 5 minutes, and then ran it through the spinner once more.",
                @"Put the kale pieces in a gallon plastic baggie and add the olive oil.",
                @"“Massage” the kale to ensure that each piece has a coating of oil.",
                @"Arrange the kale in a single layer on a large baking sheet lined with parchment paper (or you can place them right on the sheet).",
                @"You may need a to use more than one sheet or bake in batches.",
                @"Sprinkle with sea salt.",
                @"Use a bit less than you think you need because the kale shrinks and the salt intensifies.",
                @"Bake for about 20 minutes, until the kale is crisp and slightly browned.",
                @"These can be stored in an air-tight container for 2 days.",
                nil];
    
    
    
    
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag119
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"no-fluke-zuke_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#olive oil+=bak",
                  @"1 medium@#cucumber, cut in half and seeds removed+=prd",
                  @"2 medium@#zucchini, sliced+=prd",
                  @"1@#green bell pepper+=prd",
                  
                  @"1@#red bell pepper+=prd",
                  @"1/2 cup@#apple cider vinegar+=bak",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Cut cucumber in half lengthwise and remove seeds.",
                @"Seed both peppers and cut into strips.",
                @"Add vegetables and cook for 5 minutes without browning.",
                @"Stir in cider and season well.",
                @"Turn into slow cooker; cover and cook on LOW for 4 to 6 hours.",
                @"Check and adjust seasoning before serving with roast lamb or pork.",
                nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag120
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"no-time-to-cook,-chicken-crockpot_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#chicken breasts+=meat",
                  @"1@#onion+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"2 tsp@#sea salt+=ssn",
                  
                  @"1 tsp@#garlic powder+=ssn",
                  @"1 tsp@#onion powder+=ssn",
                  @"1 tsp@#dried oregano+=ssn",
                  @"1/4 tsp@#chili powder+=ssn",
                  @"1/2 tsp@#white pepper+=ssn",
                  @"1/2 tsp@#paprika+=ssn",nil];
    
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Put all ingredients into a slow cooker and cook on low for 6-8 hours or high 4-5 hours.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag121
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"oatmeal-cookies_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved oatmeal+=iwm",
                  @"nil@#approved butterscotch pudding+=iwm",
                  @"1/8 cup@#rolled oats+=grn",
                  @"1 tsp@#Splenda or Stevia+=bak",
                  
                  @"1/4 tsp@#sea salt+=ssn",
                  @"1@#egg white+=dry",
                  @"1 tsp@#vanilla extract+=ssn",
                  @"nil@#dash of cinnamon+=ssn",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 325℉.",
                @"Combine dry ingredients, then add the last 3 liquid ingredients and enough water to reach a cookie dough texture.",
                @"Spray a cookie sheet with Pam Olive Oil and bake 10 minutes at 325℉.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag122
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"oatmeal zucchini muffins_S-A-M-E.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved maple oatmeal+=iwm",
                  @"1@#egg, beaten+=dry",
                  @"1/2 tsp@#baking powder+=bak",
                  @"1 tsp@#Splenda or Stevia+=bak",
                  
                  @"1 1/2 tsp@#cinnamon+=ssn",
                  @"1/2 to 3/4@#a grated zucchini, finely grated+=prd",
                  @"2- 3oz@#water+=wtr",
                  @"nil1@#sea salt, to taste+=ssn",nil];
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Squeeze the juice out of the zucchini as much as possible.",
                @"Beat the egg in a bowl.",
                @"Add the Maple Oatmeal, baking powder, salt, sweetener, cinnamon and zucchini.",
                @"Mix and gradually add water until you have a good batter.",
                @"Bake at 385 degrees for 20 minutes.",
                @"Makes 3 regular muffins or 12 bite-size.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag123
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Old-school-oatmeal_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tsp@#flax seeds+=othr",
                  @"1 tbsp@#pure maple syrup+=bak",
                  @"1 cup@#milk or almond milk+=dry",
                  @"1/2 cup@#old fashioned oats+=bf",
                  
                  @"1/4 cup@#fresh blueberries+=prd",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Place a small pan over medium heat with milk and oats.",
                @"Cook for about 5 minutes, stirring constantly.",
                @"Reduce the heat to low and cook for another 2 minutes.",
                @"Poor into a serving bowl and drizzle with flax seeds and maple syrup.",
                @"Serve with fresh blueberries on the side.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/4 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag124
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"once-upon-a-thyme-zucchini_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/4 cup@#water+=wtr",
                  @"4 medium@#zucchini, sliced into rounds+=prd",
                  @"10-12 small@#sprigs of fresh thyme+=prd",
                  @"1@#lemon, zest and juice+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat water in a covered pan.",
                @"Add zucchini, thyme and lemon zest.",
                @"Cover and cook until zucchini is just tender.",
                @"Stir in lemon juice and pepper.",
                @"Cook uncovered until most of the water evaporates.",
                @"When ready to serve, remove thyme stems - you can strip leaves from stems and put leaves back into zucchini.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag125
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Paprika-Chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#skinless boneless chicken breast+=meat",
                  @"4 medium@#zucchini, sliced+=prd",
                  @"1/2 cup@#water+=wtr",
                  @"1/2 cup@#chicken, veggie or beef broth+=ssn",
                  
                  @"3 tbsp@#olive oil+=bak",
                  @"2 tbsp@#paprika+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"2@#clove garlic, minced+=prd",
                  @"nil1@#red pepper flakes, to taste+=ssn",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Make sure to season the chicken breast with some salt, pepper, garlic and some red pepper flakes (for some added heat, if you would like).",
                @"Then place the chicken at the bottom of the crock pot.",
                @"Sprinkle on a tablespoon of paprika over the chicken and then cover it with a layer of zucchini.",
                @"Add the 3 tbsp of the extra virgin olive oil and then pour the rest of the paprika over the vegetables.",
                @"Pour the mixture of water and chicken stock into the crockpot and make sure to try to miss the paprika so it can soak into the vegetables and chicken.",
                @"Turn on low 6-8 hours or high 4 - 6 hours.",
                @"You can add the extra seasonings to your taste.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag126
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"paradise-stir-fry_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#coconut oil+=bak",
                  @"3 tbsp@#curry powder+=ssn",
                  @"1/2@#lemon, juiced+=prd",
                  @"2 cups@#frozen broccoli florets+=frz",
                  
                  @"1 cup@#frozen green peppers+=frz",
                  @"1 cup@#frozen snow peas+=frz",
                  @"1 cup@#frozen mushrooms+=frz",
                  @"2 pounds@#frozen peeled shrimp+=frz",
                  @"1 tsp@#ground cinnamon+=ssn",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a skillet, warm the coconut oil over medium heat.",
                @"Add the frozen veggies and sauté until warm (don’t let them get too tender).",
                @"Add in the shrimp and cook until they are pink.",
                @"Squeeze the lemon over the skillet.",
                @"Sprinkle with curry, cinnamon , sea salt and pepper.",
                @"Serve warm with cauli-rice for a great Caribbean meal.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag127
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"peach-and-mango-salsa_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved peach and mango drink+=iwm",
                  @"1@#Vidalia onion, chopped+=prd",
                  @"4-5@#celery heart stalks chopped+=prd",
                  @"1-2” piece@#fresh grated ginger+=prd",
                  
                  @"nil@#apple cider vinegar+=ssn",
                  @"1/2 cup@#chopped red pepper+=prd",
                  @"1/2 cup@#chopped yellow pepper+=prd",
                  @"1 cup@#chopped roma tomatoes+=prd",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a bowl, combine onion, celery, peppers, tomatoes and ginger.",
                @"Add peach and mango packet and stir thoroughly.",
                @"It will become a little pasty in places.",
                @"Add enough vinegar to remove pastiness, but not overpower the Peach-Mango.",
                @"Mix well, cover and refrigerate overnight (or about 4 hours).",
                @"Makes a great topping for fish or chicken or on a salad.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag128
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"pepperoni-pizza-casserole_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3 medium@#zucchini+=prd",
                  @"1/2 cup@#tomato sauce (no sugar added)+=sac",
                  @"1 tsp@#italian seasoning+=ssn",
                  @"1 tsp@#garlic powder+=ssn",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1/8 cup@#grated parmesan cheese (or cauli-rice if on phase 1)+=dry",
                  @"12@#pepperoni (no nitrates, like Applegate farms brand)+=meat",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 425℉.",
                @"Spray a 9 x 13” casserole dish with olive oil spray.",
                @"Wash zucchini, and cut lengthwise, then into 1” chunks.",
                @"Spray a large non-stick skillet over high heat.",
                @"Add 1/4 cup water and zucchini, and cover for about 2 minutes.",
                @"Remove cover off of pan and stir until the water is evaporated, and zucchini is slightly softened, but not translucent or mushy.",
                @"Drain any water off of zucchini, and spread out evenly over baking dish.",
                @"Spoon the sauce over the zucchini and spread evenly with a spatula.",
                @"Top with seasonings and parmesan cheese or cauli-rice if on phase 1 or want a non-dairy dish.",
                @"Finish with pepperonis.",
                @"Place baking dish in the oven and bake for 20 minutes, or until parmesan cheese is slightly browned.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag129
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"perfect-potato-rolls_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved potato purée+=iwm",
                  @"2@#egg whites+=dry",
                  @"1/2 tsp@#baking powder+=bak",
                  @"1/8 tsp@#baking soda+=bak",
                  
                  @"nil@#olive oil cooking spray+=bak",
                  @"nil@#any fresh herbs like rosemary, thyme or oregano+=ssn",
                  nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 400℉.",
                @"Beat egg whites until foamy, but not stiff.",
                @"Add the baking soda. Mix well.",
                @"Batter should be medium thick  Spray cupcake pan with olive oil.",
                @"Spoon batter into cupcake pan about 2/3 full.",
                @"Should make 4 to 5 rolls.",
                @"Spray top of each roll with olive oil.",
                @"Bake 7 to 12 min. Rolls should rise and brown a bit.",
                @"Don't overcook or they may become too ""papery"".",
                @"Enjoy hot out of the oven!",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag130
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"pizza-stuffed-zuchhini-boats_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#Olive oil+=bak",
                  @"1@#clove garlic, finely chopped+=prd",
                  @"2@#whole large zucchini+=prd",
                  @"1 tsp@#sea salt+=ssn",
                  
                  @"1/2 tsp@#black pepper+=ssn",
                  @"2/3 cups@#pizza sauce, no added sugar+=sac",
                  @"1/2 cup@#turkey pepperoni+=meat",
                  @"4@#sliced deli ham, julienned+=dl",
                  @"1/4 cup@#yellow onion+=prd",
                  @"1/2 tsp@#oregano+=ssn",
                  @"1 cup@#cherry tomatoes, halved+=prd",
                  @"10@#fresh basil leaves+=prd",nil];
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat skillet over medium heat with olive oil and garlic.",
                @"Cut the zucchinis in half lengthwise.",
                @"Scoop all the seeds out so you are left with a skinny boat shaped zucchini, about 1/3 - 1/2 inch thick.",
                @"prinkle each zucchini with salt and pepper.",
                @"S  Place zucchini cut side down in the skillet and cover.",
                @"Cook 5 minutes and turn over.",
                @"Edges should be brown.",
                @"Cover and cook another 5 minutes.",
                @"Transfer cooked zucchini to a sheet pan.",
                @"Fill with pizza sauce and desired toppings.",
                @"Sprinkle with oregano.",
                @"Bake under the broiler for 3 - 5 minutes.",
                @"In small bowl, combine tomatoes with basil, salt and pepper.",
                @"Top cooked pizza stuffed zucchinis with tomato mixture.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 zucchini"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag131
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"pumpkin-pie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved plain crepe or pancake (crust)+=iwm",
                  @"1 tsp@#pumpkin pie spice (crust)+=ssn",
                  @"2 oz@#water (crust)+=wtr",
                  @"nil@#approved vanilla pudding (filling)+=iwm",
                  
                  @"1@#egg (filling)+=dry",
                  @"2 tsp@#olive oil (filling)+=bak",
                  @"1 tsp@#vanilla extract (filling)+=ssn",
                  @"1 tsp@#pumpkin pie spice (filling)+=ssn",
                  @"1/2 tsp@#nutmeg (filling)+=ssn",
                  @"1/2 tsp@#cinnamon (filling)+=ssn",
                  @"2 tbsp@#Splenda or stevia (filling)+=bak",
                  @"1@#egg white (meringue)+=dry",
                  @"3 tbsp@#Splenda or Stevia (meringue)+=bak",
                  @"1/8 tsp@#cream of tarter (meringue)+=ssn",
                  @"1 tsp@#vanilla extract (meringue)+=ssn",nil];
    
[self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 425℉.",
                @"In your shaker mix Crust ingredients.",
                @"With Olive oil spray, coat 8-9” diameter skillet and pour mixture in.",
                @"Cook on medium heat until the crepe has reached a soft pliable texture.",
                @"You do not want the crepe to be crispy.",
                @"In 4-5 inch glass pie pan, place the crepe in and shape it like a pie crust.",
                @"Next mix filling ingredients in your shaker and pour into crust.",
                @"Bake at 425℉ for 9 minutes.",
                @"While your filling is baking, place meringue ingredients in a bowl and mix until it forms peaks.",
                @"By varying the amount of sweetener you control how hard or soft the final meringue will be.",
                @"Remove filling and crust from oven and spread meringue on while hot.",
                @"Reduce oven temperature to 325℉ and bake for 9 minutes.",
                @"Meringue should be stiff and have golden brown coloring on peaks.",
                @"Let cool and chill before serving.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag132
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Put-a-Lime-with-your-coconut-Trout_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"14 oz@#trout+=sf",
                  @"2 tbsp@#coconut oil+=bak",
                  @"1@#lime+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  
                  nil];
[self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350 °F.",
                @"Put the trout in the bottom of a 9 x 13 pan, skin down.",
                @"Scoop 1 tbsp coconut oil on each filet.",
                @"This oil replaces your olive oil requirement for the day.",
                @"No need to spread it out as it will melt quickly.",
                @"Squeeze the lime over top.",
                @"Add sea salt, to taste.",
                @"Bake for about 15 minutes until cooked thoroughly.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag133
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"poppyseed-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/3 cup@#olive oil+=bak",
                  @"2 tbsp@#apple cider vinegar+=ssn",
                  @"1@#shallot or small onion, minced+=prd",
                  @"1 tbsp@#poppy seeds+=ssn",
                  
                  @"1 tsp@#Splenda or Stevia+=bak",
                  @"1/4 tsp@#sea salt+=ssn",
                  @"1/4 tsp@#ground pepper+=ssn",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In bowl or jar, whisk or shake together oil, vinegar, shallot, poppy seeds, Splenda, salt and pepper.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag134
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"portobello-steaks_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#olive oil+=bak",
                  @"3 tsp@#oregano+=ssn",
                  @"2 tbsp@#Walden Farms Balsamic Vinegar Dressing+=drs",
                  @"4@#portobello mushrooms+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350℉.",
                @"Cut off mushroom stems and wash both tops and stems.",
                @"Mix oil, oregano and Walden Farms balsamic vinegar in a small bowl.",
                @"Place mushroom tops and stems in baking dish with an edge.",
                @"Pour oil mixture over mushrooms and bake for 30 minutes.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag135
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"put-a-pork-in-it-dinner_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4 pounds@#boneless pork shoulder roast, trimmed of fat+=meat",
                  @"2 tbsp@#olive oil+=bak",
                  @"2@#cloves garlic, finely chopped+=prd",
                  @"2@#celery stalks, chopped+=prd",
                  
                  @"1 cup@#chopped mushrooms+=prd",
                  @"4 cups@#cabbage, coarsely chopped+=prd",
                  @"1 1/2 cups@#chicken broth+=bak",nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a big, heavy skillet, start browning the pork in the oil.",
                @"Place the mushrooms, garlic and celery in your slow cooker.",
                @"Add the broth. When the pork is brown all over, put it on top of the vegetables in the slow cooker.",
                @"Cover the slow cooker, set it to low, and let it cook for 7 hours.",
                @"When the time’s up, stir in the cabbage, pushing it down into the liquid.",
                @"Re-cover the slow cooker and let it cook for another 45 minutes to 1 hour.",
                @"Remove the pork and put it on a platter.",
                @"Use a slotted spoon to pile the vegetables around the pork.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag136
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"quick-chicken-teriyaki_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#skinless boneless chicken breast+=meat",
                  @"5 1/2 cups@#soybean sprouts+=prd",
                  @"2 cups@#green peppers+=prd",
                  @"4 tbsp@#green onions, sliced+=prd",
                  
                  @"2 tsp@#fresh ginger, minced+=prd",
                  @"2@#cloves garlic, minced+=prd",
                  @"1/4 cup@#soy sauce or Braggs+=ssn",
                  @"1 tbsp@#sesame oil+=eth",nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place chicken pieces in a nonstick 9” square baking dish.",
                @"Mix garlic, half of the ginger and soy sauce.",
                @"Pour over chicken. Cover and refrigerate for an hour.",
                @"Preheat oven to 350°F.",
                @"Remove chicken from marinade and bake uncovered for 15 minutes.",
                @"Turn and bake for an additional 10 to 15 minutes until cooked.",
                @"Boil the marinade for 1 minute and set aside.",
                @"Sauté green pepper in sesame oil.",
                @"Add the the other half of ginger.",
                @"Add sprouts and sauté for 4 minutes.",
                @"The sprouts should be very hot and start to become tender.",
                @"Do not overcook.",
                @"Add the boiling marinade and reduce for 2 minutes.",
                @"Slice the chicken breasts and serve on a bed of sprouts.",
                @"Sprinkle with green onions.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag137
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"quick-quiche-cups_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#chopped spinach+=prd",
                  @"12@#eggs (whites only) or 15oz container of egg whites or egg beaters+=dry",
                  @"1/4 cup@#chopped peppers+=prd",
                  @"1/4 cup@#chopped mushrooms+=prd",
                  
                  @"nil@#hot sauce (optional)+=cnd",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350℉.",
                @"Line a 12 cup muffin tray with foil baking cups and spray with cooking spray.",
                @"Combine the egg whites and vegetables in a bowl.",
                @"Add hot sauce to taste.",
                @"Divide evenly among the cups.",
                @"Bake at 350℉ for 20 minutes or until knife inserted comes out clean.",
                @"May then be frozen if desired.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"12"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag138
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Quinoa-and-black-beans_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tsp@#vegetable oil+=bak",
                  @"1@#onion, chopped+=prd",
                  @"3@#cloves garlic, minced+=prd",
                  @"3/4 cup@#uncooked quinoa+=grn",
                  
                  @"1 1/2 cups@#vegetable broth+=bak",
                  @"1 tsp@#ground cumin+=ssn",
                  @"1/4 tsp@#cayenne pepper+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 cup@#frozen corn kernels+=frz",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat the oil in a medium saucepan over medium heat.",
                @"Stir in the onion and garlic, and sauté until lightly browned.",
                @"Mix quinoa into the saucepan and cover with vegetable broth.",
                @"Season with cumin, cayenne pepper, salt, and pepper.",
                @"Bring the mixture to a boil.",
                @"Cover, reduce heat, and simmer 20 minutes.",
                @"Stir frozen corn into the saucepan, and continue to simmer about 5 minutes until heated through.",
                @"Mix in the black beans and cilantro.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"10"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag139
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"quinoa-berry-crunch_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#quinoa+=grn",
                  @"1/2 cup@#ground flax seed+=hlt",
                  @"1 tbsp@#agave nectar+=bak",
                  @"1 tbsp@#olive oil+=bak",
                  
                  @"2 cups@#greek yogurt (plain or vanilla)+=dry",
                  @"2 cups@#mixed berries+=prd",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 375°F.",
                @"Rinse quinoa in a fine mesh strainer until the water runs clear (about 3 - 4minutes).",
                @"Dry quinoa with paper towels and transfer to mixing bowl.",
                @"Combine with flax seed, agave nectar and olive oil.",
                @"Spread in a thin layer on a baking sheet (make sure it is rimmed).",
                @"Bake 10-15 minutes or until it is lightly browned, stirring every 5 minutes.",
                @"Remove from pan and allow to cool.",
                @"Store in a sealed container up to a week.",
                @"Place the yogurt in a serving bowl and top with berries and quinoa crunch.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag140
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"raspberry-cream_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved raspberry jello+=iwm",
                  @"nil@#approved wildberry yogurt or vanilla pudding+=iwm",
                  @"10 oz@#warm water+=wtr",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Add the raspberry jello to 5 oz of warm water (don’t shake this in a shaker because it will explode, but mix it in a medium bowl).",
                @"In a shaker, combine the wildberry yogurt with 5 oz of cold water and shake.",
                @"Then add the Wildberry Yogurt to the jello and mix well. Divide into two snacks and refrigerate for 30 - 45 minutes.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag141
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"raspberry-lemon-cheesecake_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 cups@#unsalted macadamia nuts+=nts",
                  @"1 cup@#pitted dates (non sugar-coated)+=prd",
                  @"1/4 cup@#dried coconut+=bak",
                  @"3 cups@#raw cashews+=nts",
                  
                  @"2 cups@#frozen raspberries+=frz",
                  @"2/3 cup@#agave nectar+=bak",
                  @"2/3 cup@#lemon or lime juice+=prd",
                  @"1/2 cup@#water+=wtr",
                  @"1 tsp@#vanilla extract+=bak",
                  @"1/2 tsp@#sea salt+=ssn",nil];
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Soak the cashews for at least an hour.",
                @"To make the crust, process the 2 cups of the macadamia nuts and 1/2 cup of the dates in the food processor until they get to the crust consistency.",
                @"Sprinkle dried coconut onto the bottom of an 8 or 9 in spring-form pan.",
                @"This will prevent it from sticking.",
                @"Press crust into coconut.",
                @"To make the filling, blend the cashews, 1 cup of the frozen raspberries, coconut oil, agave, lemon or lime juice, water, vanilla extract and salt.",
                @"Blend until completely smooth smooth with no gritty texture.",
                @"The smoother the better, so let it blend for a while.",
                @"Pour the mixture in the crust and place in freezer until firm.",
                @"You can make the raspberry sauce topping while it starts to freeze.",
                @"Place the other 1 cup of frozen raspberries with the other 1/2 cup of pitted dates in a food processor and let it get to liquid consistency.",
                @"Spread over the top (it’s a little easier when it’s firmed up a little).",
                @"Store in the freezer, but you can defrost it a little in the fridge before serving.",
                @"This is a great breakfast that even the kids will love.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 slice"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag142
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"raspberry-lime-smoothie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"6 oz.@#plain greek yogurt+=dry",
                  @"3/4@#milk (or milk substitute)+=dry",
                  @"1/2 cup@#raspberries (frozen or fresh)+=frzn",
                  @"1 cup@#ice+=wtr",
                  
                  @"1 tsp@#agave nectar (or sweetener of choice)+=bak",
                  @"2 tbsp@#unrefined coconut oil+=bak",
                  @" 1 scoop@#vanilla protein powder+=othr",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place all ingredients in the blender and blend until smooth.",
                @"Note:  be sure to use a high biological and clean protein powder.",
                @"You can also use a Ready Made Vanilla as your milk product AND protein!  Makes a great phase 3 breakfast.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag143
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"raspberry-smoothie_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved raspberry jello+=iwm",
                  @"nil@#approved vanilla pudding+=iwm",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Prepare Raspberry Jello as directed.",
                @"Pour in a small rectangular or square pan and put in refrigerator.",
                @"Once the jello has solidified, cut into cubes.",
                @"Then prepare the vanilla pudding as directed.",
                @"Mix pudding and jello and serve in two dessert cups.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag144
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"refreshing-cucumber-dill-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3@#cucumbers+=prd",
                  @"1/2@#red onion, chopped+=prd",
                  @"5-6@#cherry tomatoes, halved+=prd",
                  @"1-2 tsp@#olive oil+=bak",
                  
                  @"1 tsp@#white wine vinegar+=bak",
                  @"1/2@#lemon, juiced+=prd",
                  @"nil@#sea salt+=ssn",
                  @"nil@#pepper+=ssn",
                  @"nil@#fresh dill, chopped+=prd",
                  nil];
  [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Cut the cucumbers lengthwise and then crosswise to make cucumber pieces.",
                @"Add in onion and tomatoes.",
                @"In a separate bowl, mix olive oil, vinegar, lemon juice, salt and pepper.",
                @"Drizzle the dressing over the cucumber mix.",
                @"Stir in the chopped dill and add salt and pepper to taste.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag145
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"rice-crispy-treat_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved crispy cereal+=iwm",
                  @"1 tsp@#water+=wtr",
                  @"2 tbsp@#Walden Farms Chocolate Dip+=iwm",
                  @"1@#egg white+=dry",
                  
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350℉.",
                @"Mix all ingredients in a medium bowl.",
                @"Pour this mixture in a muffin pan.",
                @"Bake at 350℉ for 30 min.",
                @"You can replace the chocolate dip with Walden Farms Strawberry spread or Pancake Syrup.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag146
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"roasted-veggies,slow-cooker_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#bell peppers, cut into large slices+=prd",
                  @"3 small@#zucchini, cut in thick slices+=prd",
                  @"1@#red bell pepper, cut into large slices+=prd",
                  @"1/2 cup@#peeled garlic cloves+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1 tsp@#italian seasoning+=ssn",
                  @"2 tbsp@#olive oil+=bak",nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Grease your crock pot, then add all the veggies.",
                @"Season with the sea salt, pepper, italian seasoning and oil, then stir to evenly coat.",
                @"Cook 3 hours on high (or longer on low), stirring just once every hour or so.",
                @"At this point, you can open the lid and drain the liquid for another use.",
                @"No need to toss the liquid...it makes a great base for a soup.",
                @"The veggies will be a softer texture than oven-roasted veggies, but they are actually even more flavorful and sweet.",
                @"You can add any veggies in this dish you would like, or any other seasonings too.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag147
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"roasted-watermellon-radishes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#watermelon radishes, trimmed+=prd",
                  @"3 tbsp@#olive oil, divided+=bak",
                  @"nil1@#sea salt, to taste+=ssn",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 375°F.",
                @"Cut radishes into wedges.",
                @"Mix with 2 tbsp. oil and put in a 2-qt. baking dish.",
                @"Roast radishes, stirring occasionally, until fork tender, about 1 hour.",
                @"Drizzle with remaining 1 tbsp. oil and sprinkle with sea salt.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag148
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"rockin-zucchini-lasag_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"6@#zucchini, cut lengthwise into 1/8” strips+=prd",
                  @"2 pounds@#ground turkey+=meat",
                  @"1@#onion, chopped+=prd",
                  @"2 cups@#broccoli+=prd",
                  
                  @"2 cups@#cauliflower+=prd",
                  @"2 cups@#chopped spinach+=prd",
                  @"25 oz@#jar spaghetti sauce with no sugar added+=sac",
                  @"1 clove@#garlic, finely chopped+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"16 oz@#cottage cheese+=dry",
                  @"1/2 cup@#grated parmesan cheese+=dry",
                  @"3/4  cup@#mozzarella cheese+=dry",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Start with the “zucchini noodles”: Preheat oven to 425℉.",
                @"Spray a baking sheet with non-stick cooking spray, arrange zucchini slices and season with salt and pepper.",
                @"Bake zucchini slices for 5 minutes on each side, then remove from oven.",
                @"Set zucchini slices aside and lower oven temperature to 375℉.",
                @"For the meat sauce layer: In a large non-stick skillet, cook meat until it’s browned.",
                @"To the skillet, add the veggies, seasonings, and the jar of spaghetti sauce.",
                @"Simmer for about 10 minutes, stirring occasionally.",
                @"For the cheesy layer: Mix the cottage cheese and parmesan cheese together.",
                @"Put it all together: Spray a 9×13 baking dish with non-stick cooking spray.",
                @"Begin by spreading 1/3 of the meat sauce in the bottom of the pan.",
                @"Follow meat sauce with a layer of zucchini slices, followed by a layer of cottage cheese.",
                @"Repeat the layers until casserole dish is full.",
                @"Finish it off: Sprinkle the mozzarella evenly over the top.",
                @"Cover with foil and bake at 375℉ for 1 hour.",
                @"Remove foil and bake or broil another 5-10 minutes until cheese is browned.",
                @"Remove from oven and let rest for about 10 minutes before slicing, and serve warm!",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"6 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag149
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"rollin-in-cabbage-1_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 medium@#head cabbage+=prd",
                  @"2 pound@#ground beef+=meat",
                  @"1/2 cup@#chopped onion+=prd",
                  @"2 tbsp@#fresh parsley+=prd",
                  
                  @"2 tsp@#sea salt+=ssn",
                  @"1/2 tsp@#black pepper+=ssn",
                  @"1@#egg+=dry",
                  @"1 1/2 cup@#tomato sauce with no added sugar+=sac",
                  @"1 cup@#fresh spinach+=prd",
                  @"1 cup@#mushroom, diced+=prd",nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat the oven to 350℉.",
                @"Put the head of cabbage in a pot.",
                @"Cover with water.",
                @"Remove the cabbage and bring the water to a boil.",
                @"Turn off the heat.",
                @"Submerge the whole head of cabbage in the boiling water and cover.",
                @"Let sit for 15-20 minutes.",
                @"Meanwhile, brown the beef and onion.",
                @"Add the mushrooms and spinach.",
                @"Turn off the heat.",
                @"Add the parsley, salt, pepper, and egg.",
                @"When the cabbage is done cooking, remove it from the water onto a cookie sheet with sides (to catch any remaining water).",
                @"Very carefully, remove 12 leaves.",
                @"Cut the thickest part of center rib out of each leaf, about 1 or 2 inches.",
                @"There will be a little V in the middle of each leaf.",
                @"Divide the meat filling between the leaves and roll up jelly roll fashion, but tucking in the ends so the filling stays put.",
                @"Place the rolls in a deep casserole dish.",
                @"Pour the tomato sauce over the rolls.",
                @"Cover and bake at 350℉ for about an hour and a half.",
                @"Let set a few minutes before serving.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag150
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"rosie's-one-dish-dinner_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#lean ground beef+=meat",
                  @"1 10 oz@#package frozen, chopped      spinach+=frz",
                  @"1 medium@#green pepper, chopped+=prd",
                  @"1-2@#cloves garlic, crushed+=prd",
                  
                  @"3 whole@#eggs+=dry",
                  @"2@#egg whites+=dry",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Brown the beef in a skillet over medium heat.",
                @"While the beef is cooking, cook the spinach according to the directions on package.",
                @"When the ground beef is half done, add the peppers and garlic and cook until the beef is completely done.",
                @"Pour off the extra fat.",
                @"Drain the spinach well (and you may consider keeping the juice to drink later...no, I’m not kidding).",
                @"Stir the spinach in with the ground beef.",
                @"Mix up the eggs and egg whites well with a fork and stir them in with the beef and spinach.",
                @"Continue cooking and stirring over low heat for a few more minutes, until the eggs are set.",
                @"Salt and pepper to taste and serve.",nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag151
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"rotini-pasta-and-vegetables_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved rotini+=iwm",
                  @"1 cup@#mushroom, diced+=prd",
                  @"1 cup@#zucchini, cubed+=prd",
                  @"1/2 cup@#spinach+=prd",
                  
                  @"1 tbsp@#olive oil+=bak",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Follow the directions to prepare the rotini.",
                @"While it’s cooking, sauté the veggies in olive oil.",
                @"When the rotini is finished, drain it and mix it with the veggies.",
                @"Sprinkle with sea salt and pepper, to taste and serve warm.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag152
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"salmon-and-broccoli-eggs_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tsp@#olive oil+=bak",
                  @"1 cup@#fresh broccoli, cut into small     pieces+=prd",
                  @"5@#egg whites+=dry",
                  @"7 oz@#grilled or smoked salmon, separated into small pieces+=sf",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat olive oil in a skillet over low-medium heat.",
                @"Add the broccoli, egg whites and salmon and continue to stir while cooking until the whites are firm.",
                @"Add the salt and pepper and enjoy warm.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag153
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sauteed-snow-peas-with-lemon-and-parsley_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tbsp@#olive oil+=bak",
                  @"1 small@#shallot minced+=prd",
                  @"1 tsp@#finely grated lemon zest+=prd",
                  @"1 tsp@#lemon juice+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"4 cups@#snow peas, tips pulled off and strings removed+=prd",
                  @"1 tbsp@#fresh parsley leaves, minced (chives or tarragon can be used instead parsley)+=prd",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Combine 1 tsp. oil, shallots, and lemon zest in small bowl.",
                @"Heat remaining 2 tsp. oil in 12 inch nonstick skillet over high heat until just smoking.",
                @"Add snow peas, sprinkle with salt mixture, and cook, without stirring, 30 seconds.",
                @"Stir and continue to cook, without stirring, 30 seconds longer.",
                @"Continue to cook, stirring constantly, until peas are crisp- tender, 1 to 2 minutes longer.",
                @"Push peas to side of skillet; add shallot mixture to clearing and cook, mash with spatula, until fragrant, about 30 seconds.",
                @"Toss to combine shallot mixture with vegetables.",
                @"Transfer peas to bowl and stir in lemon juice and parsley.",
                @"Season with salt and pepper, and serve",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag154
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"savory-pork-chops_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 tsp@#olive oil+=bak",
                  @"2 pounds@#pork loin chops (with bone), 1 inch thick, trim all visible fat+=meat",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1/4 cup@#chopped shallots+=prd",
                  
                  @"1 cup@#chicken stock+=ssn",
                  @"10 oz@#sliced baby bella mushrooms+=prd",
                  @"1 tbsp@#dijon mustard+=cnd",
                  @"2 tbsp@#fresh parsley, chopped+=prd",nil];
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a large frying pan heat the olive oil over moderately low heat.",
                @"Season pork with salt and pepper.",
                @"Raise heat to medium and add the chops to the pan and sauté for 7 minutes.",
                @"Turn and cook until chops are browned and done to medium, about 7-8 minutes longer.",
                @"Remove the chops and put in a warm spot.",
                @"Add shallots to the pan and cook, stirring, until soft, about 3 minutes.",
                @"Add the stock to deglaze the pan, stir in the mustard, 1 tbsp parsley, then add mushrooms, season with fresh pepper and cook about 3 minutes, or until mushrooms are done.",
                @"Put the chops on a platter and pour the mushroom sauce over the meat, top with remaining parsley.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag155
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"scrambling-for-energy-meal_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4@#egg whites+=dry",
                  @"8 oz@#sliced chicken strips+=meat",
                  @"1 cup@#mushroom, diced+=prd",
                  @"1 cup@#fresh spinach+=prd",
                  
                  @"1/4 cup@#tomatoes, chopped+=prd",
                  @"2 tbsp@#fresh cilantro+=prd",
                  @"1 tsp@#olive oil+=bak",nil];
    
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"On a skillet, warm the olive oil over medium-low heat.",
                @"Sauté the chicken breast and veggies for 2 minutes.",
                @"Add the egg whites and continue stirring until the chicken is thoroughly cooked.",
                @"Transfer to a bowl and sprinkle with cilantro, salt and pepper.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag156
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sesame-soy-crusted-pork_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"5@#garlic cloves, minced+=prd",
                  @"2 tbsp@#soy sauce or Braggs+=ssn",
                  @"2 tbsp@#white wine vinegar+=prd",
                  @"2 1/2 tsp@#sea salt+=ssn",
                  
                  @"1/2 tsp@#black pepper+=ssn",
                  @"1/2 tsp@#sesame seeds+=ssn",
                  @"2 tbsp@#olive oil+=bak",
                  @"2@#pork tenderloins (about 1 1/4 pounds each)+=meat",
                  @"2 tbsp@#canola oil (if preparing in the     oven)+=bak",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Stir together garlic, soy sauce, salt, pepper, sesame seeds, and olive oil in a small bowl.",
                @"Rub the paste all over pork.",
                @"If you like or have the time, marinate overnight.",
                @"If not, no worries, it will still be great!",
                @"Grill preparation: ",
                @"Sear the tenderloins on all sides, then grill for about 20-30 minutes, rotating every 10 minutes, until the internal temperature is 160℉.",
                @"Try to let it rest before slicing.",
                @"Oven preparation:",
                @"Preheat oven to 400℉.",
                @"Heat canola oil in a large, heavy sauté pan over medium-high heat.",
                @"Working in batches if necessary, add pork, and brown all over, about 4 minutes.",
                @"Transfer pan to oven.",
                @"Roast pork, turning occasionally, until the internal temperature is 160℉, about 20 minutes.",
                @"Transfer pork to a cutting board, and try to let it rest 10 minutes before slicing.",nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"3"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag157
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Sesame-Soy-Dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#soy sauce or Braggs+=ssn",
                  @"2 tbsp@#rice vinegar+=bak",
                  @"1/2 tsp@#Splenda or Stevia+=bak",
                  @"1/4 cup@#olive oil+=bak",
                  
                  @" 2@#garlic cloves, chopped+=prd",
                  @"1 tbsp@#sesame seeds+=ssn",
                  nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a bowl, whisk together sweetener, soy sauce, vinegar and salt to taste.",
                @"Whisk olive oil in small stream into the vinegar mixture.",
                @"Stir in the sesame seeds.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag158
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"shrimp-skimpy_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#cloves garlic, minced+=prd",
                  @"1/4 cup@#olive oil+=bak",
                  @"14 oz@#uncooked shrimp, shelled and deveined+=sf",
                  @"1 tbsp@#fresh parsley+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"1/2 tsp@#basil, dried+=ssn",
                  @"1/2 tsp@#oregano, dried+=ssn",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Warm olive oil in medium-large skillet.",
                @"Add garlic when oil is hot.",
                @"Add shrimp and cook about 2 -3 minutes on each side until pink and no longer translucent.",
                @"Add parsley and seasonings.",
                @"With mesh strainer over pan, drain off all the oil possible.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag159
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Shroom-Burgers_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#lean ground beef+=meat",
                  @"1 tsp@#soy sauce or Braggs+=ssn",
                  @"4 large@#portobello mushroom caps+=prd",
                  @"nil@#garnishes for burger, lettuce, onion, tomato+=prd",
                  
                  @"nil@#brown spicy mustard+=cnd",
                  nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Get the grill started (or you can cook these in a skillet on the stove top).",
                @"Mix ground beef and soy sauce in a large bowl.",
                @"Make patties to be 1/4” thin.",
                @"Should make about 10 patties.",
                @"Grill the burgers.",
                @"While they are grilling, score the inside of the mushrooms so that they easily clean out.",
                @"Place them face down (so they look like a hat).",
                @"Grill them for about 5 minutes but don’t filp them.",
                @"Make burgers with the burgers, condiments, garnishes all inside the mushroom cap “buns”.",
                @"Serve with rutabaga fries.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag160
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"simple-pork-loin-chops_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 tsp@#sea salt+=ssn",
                  @"1/4 tsp@#ground pepper+=ssn",
                  @"1/4 tsp@#paprika+=ssn",
                  @"1/4 tsp@#dried sage+=ssn",
                  
                  @"1/4 tsp@#dried thyme+=ssn",
                  @"2 pounds@#boneless pork loin chops+=meat",
                  @"2 tbsp@#coconut oil+=bak",
                  @"1@#onion, thinly sliced+=prd",nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 425° F.",
                @"In a small bowl, mix the salt, pepper, paprika, sage, and thyme together.",
                @"Sprinkle both sides of each pork chop with the seasoning mixture.",
                @"Add coconut oil to a skillet over high heat.",
                @"When good and hot, brown both sides of each chop.",
                @"Place the browned chops on a large piece of heavy foil and layer with sliced onions.",
                @"Close the foil into a tight pouch and place on baking sheet.",
                @"Bake for 30 minutes, or until pork reaches desired temperature.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag161
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"simple-skinny-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2/3 cup@#apple cider vinegar+=ssn",
                  @"1/3 cup@#olive oil+=bak",
                  @"nil1@#sea salt , to taste+=ssn",
                  @"nil1@#pepper , to taste+=ssn",
                  
                  @"nil@#lemon or lime juice+=prd",
                  @"nil@#dijon mustard+=cnd",
                  nil];
 [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Mix all ingredients together in a bowl.",
                @"Store in a glass container.",
                @"If you like a lighter dressing, you can add some water until it is to your preferred consistency.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"12"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag162
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"simply-italian-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/3 cup@#olive oil+=bak",
                  @"2 tbsp@#white wine vinegar+=ssn",
                  @"2 tbsp@#fresh parsley+=prd",
                  @"1 tbsp@#lemon juice+=prd",
                  
                  @"2@#garlic cloves, chopped+=prd",
                  @"1 tsp@#dried basil, crumbled+=prd",
                  @"1/4 tsp@#crushed red pepper+=ssn",
                  @"1 pinch@#oregano+=ssn",nil];
 [self ingridients];    instrArray=[[NSArray alloc]initWithObjects:@"Mix all ingredients together in a bowl.",
                @"Store in a glass container.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag163
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"skinny-cookie-doughjpg_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2/3 cup@#raw cashews+=nts",
                  @"1/3 cup@#rolled oats+=grn",
                  @"2 tbsp@#Agave+=bak",
                  @"1 tbsp@#Maple Syrup+=bak",
                  
                  @"1 tsp@#vanilla extract+=ssn",
                  @"1/4 cup@#chocolate chips+=bak",
                  nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Blend the oats and cashews in a food processor.",
                @"Add the agave, maple syrup and vanilla extract and blend again.",
                @"Keep blending until it’s at cookie dough consistency.",
                @"Stir in the chocolate chips.",
                @"Store in airtight container in the fridge.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"3 balls"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag164
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sinless-scallops-and-spinach_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"28 oz@#bay or sea scallops+=sf",
                  @"2 tbsp@#olive oil+=ssn",
                  @"1 tbsp@#lemon pepper seasoning+=ssn",
                  @"2@#clove garlic+=prd",
                  
                  @"4 cups@#fresh spinach+=prd",nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450° F.",
                @"Place scallops in baking pan and drizzle with olive oil.",
                @"Add the lemon pepper seasoning to taste.",
                @"Bake scallops at 450°F for 10 -14 minutes.",
                @"While the scallops bake, put 1 tbsp olive oil in large skillet.",
                @"Add garlic and heat over low heat.",
                @"Add fresh spinach and turn with tongs to coat until the spinach is wilted.",
                @"Add baked scallops to the spinach and serve warm with a lemon wedge.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag165
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"So-orzo-side-dish_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"12 oz@#package whole wheat orzo+=pst",
                  @"1 large@#handful fresh basil, slice small+=prd",
                  @"8 oz@#jar of roasted sweet red pepper strips, drained and chopped+=prd",
                  @"2 cups@#cubed zucchini+=prd",
                  
                  @"1@#clove garlic, finely chopped+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"2 tbsp@#lemon juice+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",nil];
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Boil water and cook Orzo half way.",
                @"Add cubed zucchini to pot and complete cooking of pasta.",
                @"Drain all, rinse with cool water.",
                @"Put in bowl, gently toss with olive oil, garlic, lemon juice, red bell pepper strips and sliced basil.",
                @"Can be served warm or cool.",
                @"You can also add cooked shrimp, bay scallops or sliced chicken sausage to make it a one-dish meal.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag166
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"southwestern-spicy-pork_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#pork shoulder roast+=meat",
                  @"1 16 oz@#jar green salsa+=eth",
                  @"1/2 cup@#fresh cilantro+=prd",
                  @"2@#chile peppers+=prd",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Spray slow cooker with non-stick spray.",
                @"Season the pork shoulder with salt and pepper and place in the crockpot.",
                @"Pour the green salsa over the pork and sprinkle the cilantro over top.",
                @"Drop the chile peppers into the crockpot.",
                @"Cook on low for about 8 hours.",
                @"Gently remove the pork to a cutting board.",
                @"Shred the pork shoulder with a pair of forks.",
                @"Pour liquid from the slow cooker over shredded pork to serve.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag167
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"southwest-roasted-veggies_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 tbsp@#olive oil+=bak",
                  @"2@#cloves garlic, minced+=prd",
                  @"1@#turnip, unpeeled+=prd",
                  @"1@#zucchini+=prd",
                  
                  @"1@#yellow squash+=prd",
                  @"3 large@#Roma tomatoes+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"nil1@#dried thyme, to taste+=ssn",
                  @"1 bag@#approved Southwest cheese curls (optional)+=iwm",nil];
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 375°F.",
                @"Coat the baking dish with spray olive oil.",
                @"Slice the turnips, zucchini, squash and tomatoes in 1/4 inch thick slices.",
                @"Layer them alternately in the dish, fitting them tightly into a spiral, making only one layer.",
                @"Season with sea salt, black pepper and dried thyme, to taste.",
                @"Drizzle the olive oil over the top.",
                @"Cover the dish with tin foil and bake for 35 minutes or until turnips are tender.",
                @"Uncover and sprinkle with SW Cheese Curls (optional) and bake for another 25 - 30 minutes or until browned.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag168
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"latin-soup_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"8 oz@#slaw mix+=prd",
                  @"16 oz@#diced tomatoes+=cg",
                  @"1 cup@#broccoli florets+=frzn",
                  @"1 cup@#sliced zucchini+=prd",
                  
                  @"1 cup@#green beans+=prd",
                  @"3@#cloves garlic, minced+=prd",
                  @"2 tbsp@#sofrito seasoning+=frzn",
                  @"2 tbsp@#recaito seasoning+=frzn",
                  @"1 packet@#sazon+=ssn",
                  @"4 cups@#chicken broth+=brt",
                  @"1 tbsp@#olive oil+=ssn",nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Put olive oil in a pot and heat until it shimmers.",
                @"Add slaw mix and garlic and sazon, stirring occasionally until it reduces by half.",
                @"Add the rest of the vegetables and ingredients.",
                @"Bring to a boil and reduce heat to simmer for 10 - 15 minutes.",
                @"You can freeze this soup and have it handy for a delicious serving of veggies.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag169
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@""];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#lean pork chops+=meat",
                  @"1/2 cup@#chicken, veggie or beef broth+=ssn",
                  @"nil@#chili sauce+=eth",
                  @"1/2 cup@#soy sauce or Braggs+=ssn",
                  
                  @"2-4@#garlic cloves, chopped+=prd",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Place all ingredients in the crockpot and cook on low 6-8 hours or high 5 - 6 hours.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag170
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"spicy-sausage,-peppers-and-mushrooms_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 pounds@#Italian Turkey sausage (ground or links, sliced diagonally)+=meat",
                  @"2 tsp@#coconut oil+=bak",
                  @"1@#red onion, chopped+=prd",
                  @"2@#cloves garlic, diced+=prd",
                  
                  @"1-2 tsp@#fennel seeds, whole+=ssn",
                  @"2 bell@#peppers, cut into large slices+=prd",
                  @"2 cups@#mushrooms, halved+=prd",
                  @"1/2 cup@#fresh parsley, chopped+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Heat coconut oil in a large skillet over Medium High heat.",
                @"Add onions and garlic, and sauté until onions are slightly soft and translucent.",
                @"If on phase one, don’t cook these as much.",
                @"Add the turkey sausage and fennel, and sauté until meat is browned but not cooked through.",
                @"Add remaining ingredients, and sauté until meat is cooked through and bell peppers are slightly crisp.",
                @"Empty contents into a colander to drain excess fat, if desired.",
                @"Serve hot.",
                @"*This recipe can be used with ground beef, turkey, chicken, etc.",nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag171
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"stewed-okra-and-tomatoes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4 ounces@#breakfast sausage, Applegate Farms brand is best+=meat",
                  @"1 medium@#onion, chopped+=prd",
                  @"1 pound@#okra, sliced+=prd",
                  @"3 cups@#chopped tomatoes+=prd",
                  
                  @"2/3 cup@#water+=wtr",
                  @"1/4 tsp@#real sea salt+=ssn",
                  @"1/2 tsp@#crushed pepper+=ssn",
                  @"OR 1/2@#minced jalapeno+=prd",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:
                @"Cook sausage in a large saucepan over medium heat, breaking it up as it cooks, about 2 to 3 minutes.",
                @"Add onion and cook, stirring frequently, until soft and translucent, about 5 minutes.",
                @"Increase heat to high; add okra, tomatoes, or water, salt and crushed red pepper (or jalapeno) and cook, stirring often, until bubbling.",
                @"Reduce heat to a gentle simmer and cook, stirring occasionally, until the mixture is thick and the vegetables are very tender, 35 to 45 minutes.",
                nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag172
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"stir-fry-bokchoy_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 bunches@#bok choy, washed+=prd",
                  @"2 slices@#fresh ginger+=prd",
                  @"2 tbsp@#soy sauce or Braggs+=ssn",
                  @"1/4 cup@#water+=wtr",
                  @"1 tsp@#sesame oil+=eth",
                  @"2 tsp@#olive oil+=bak",
                  nil];
    
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Separate the stalks and leaves.",
                @"Cut the stalks diagonally and cut the leaves across.",
                @"Be sure to measure out the oil and drop both the sesame oil and olive oil n a skillet.",
                @"Add the ginger and soy sauce sauté for about 5 minutes.",
                @"Serve warm.",
                @"Note: Bok Choy is on your UNLIMITED list, but the oils are not.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag173
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"strawberry-oat-bars_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 1/2 cups@#pitted dates+=prd",
                  @"1/4 cup@#raw macadamia nuts+=nts",
                  @"2 tbsp@#old fashioned rolled oats+=grn",
                  @"1 pinch@#sea salt+=ssn",
                  
                  @"1 cup@#strawberries, thinly sliced+=prd",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Pulse dates, nuts, oats, and salt in a food processor until combined.",
                @"Press the date mixture into the bottom of a 9-by-5-inch loaf pan.",
                @"Mash half the strawberries and spread on top of date mixture.",
                @"Top with remaining strawberries.",
                @"Slice into rectangles.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"6"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 Slice"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag174
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sugar-sheriff-salad-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 cup@#purple onion, finely chopped+=prd",
                  @"1/4 cup@#olive oil+=bak",
                  @"1 cup@#apple cider vinegar+=bak",
                  @"1/4 cup@#Splenda or stevia+=bak",
                  
                  @"1 tbsp@#dried mustard+=ssn",
                  @"1 tsp@#sea salt+=ssn",
                  nil];
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Mix all ingredients together.",
                @"This dressing is exceptional on a spinach salad with cucumbers and mushrooms.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"12"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag175
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"summer-lime-celery-salad_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"4 whole@#celery stalks+=prd",
                  @"1 whole@#lemon or lime+=prd",
                  @"handful@#chopped fresh mint+=prd",
                  @"2 tsp@#olive oil+=bak",
                  
                  @"nil1@#sea salt, to taste+=bak",
                  @"nil1@#pepper, to taste+=ssn",
                  @"nil@#chopped red onion (optional)+=prd",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Wash and cut/thinly slice celery stalks in large bowl.",
                @"Squeeze in the juice from whole lemon or lime.",
                @"Add mint, olive oil and season to preference with salt and pepper.",
                @"The red onion will give it a little sweet taste too.",
                @"Toss and ENJOY!",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag176
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sunflower-parm-crackers_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#raw, shelled sunflower seeds+=nts",
                  @"1/2 cup@#parmesan cheese, grated+=dry",
                  @"1/4 cup@#water+=wtr",
                  nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350°F.",
                @"Grind the seeds in a food processor and then grind the parmesan cheese.",
                @"Combine them in the food processor and add the water until it gets to the consistency of bread dough.",
                @"Put the mix between 2 sheets of parchment paper the size of a cookie sheet and roll it out until its thickness is that of a cracker.",
                @"Thinner is better.",
                @"Remove top piece of paper.",
                @"Using a pizza cutter or sharp knife, score it into squares to be the size of crackers.",
                @"Sprinkle with sea salt and then bake until they are brown and crispy (about 20 - 30 minutes).",
                @"Let them cool and then break along the score marks.",
                @"Store in a sealed bag or container to keep fresh.",
                @"These are awesome and great for kids too!",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"10 crackers"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag177
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"strawberry-colada-drink_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved strawberry pudding+=iwm",
                  @"nil@#approved Pina Colada+=iwm",
                  @"20 oz@#water+=wtr",
                  nil];
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"In a small blender, combine the two packets and water.",
                @"Blend and then separate into two servings.",
                @"You can add ice if you like it a little icy.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"10 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag178
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"strawberry-creamcicles_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved strawberry pudding+=iwm",
                  @"nil@#approved ready made vanilla+=iwm",
                  @"8 oz@#water+=wtr",
                  nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a small blender, combine all ingredients.",
                @"Pour into popsicle molds (you can use dixie cups with popsicle sticks) and freeze.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"10 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag179
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"super-low-carb-pancakes_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved pudding (any flavor will work)+=iwm",
                  @"1/2 tsp@#vanilla extract+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"1 oz@#water+=wtr",
                  
                  @"1 oz@#egg white+=dry",
                  nil];
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Blend all ingredients, adding a little more egg white if you prefer your pancakes a little thiner.",
                @"Spray a skillet with non-stick spray or use 1 tsp Coconut Oil and heat to low heat.",
                @"Cook the pancakes and enjoy with Walden Farms Pancake Syrup!",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag180
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sweet-potato-vanilla-pancake_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 large@#sweet potato, peeled, cooked and mashed+=prd",
                  @"1/2 cup@#quinoa flour+=bak",
                  @"1/2 cup@#coconut flour+=bak",
                  @"1 tsp@#cinnamon+=ssn",
                  
                  @"1 tbsp@#coconut oil, melted+=bak",
                  @"1@#egg+=dry",@"or 1@#flax egg (1 tbsp ground flax and 3 tbsp of water)+=dry",
                  @"1 pinch@#salt+=ssn",
                  @"nil@#real maple syrup, honey or agave (on      top)+=cnd",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"*NOTE:  the next time you cook sweet potatoes at dinner, just save yourself some to puree and throw them in a freezer bag to use for pancakes.",
                @"Combine all ingredients in a large bowl. Let chill in the fridge or freezer until malleable.",
                @"Form into flat “cakes.” Make sure they are relatively thin, about 1/4 inch thick.",
                @"Fry in coconut oil until golden brown.",
                @"Drizzle with syrup and then dust with coconut flour.",
                nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2-3 pancakes"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag181
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"sweet-sour-red-cabbage_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3 slices@#turkey bacon (with no nitrates!  Applegate Farms or Trader Joe’s Brands are great)+=meat",
                  @"4 cups@#shredded cabbage+=prd",
                  @"2 tbsp@#cider vinegar+=ssn",
                  @"2 tsp@#Splenda or Stevia+=bak",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Cook the Turkey Bacon in a skillet until crispy.",
                @"Remove and drain.",
                @"Add the cabbage to the skillet and sauté it until tender-crisp.",
                @"Stir in the vinegar and Splenda or Stevia, crumble the turkey bacon and serve.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag182
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Sweet,-Spicy-&-Sour-Salad-or-Garnish_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2@#yellow bell pepper, chopped+=prd",
                  @"2 - 3@#radishes, chopped+=prd",
                  @"2 tsp@#horseradish+=sac",
                  @"1 tsp@#white vinegar+=ssn",
                  
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"1/4 packet@#Splenda or stevia+=bak",nil];
    
    [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Mix altogether and add a little parsley for a fancy look.",
                @"Serve along with the eggplant recipe “Vegetarian Crispy Fried Chicken”",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
    
}
-(void)buttontag183
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"tangy-tomato-vinaigrette_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1/2 cup@#tomatoes, chopped+=prd",
                  @" 2 tbsp@#white vinegar+=bak",
                  @"1/2 tsp@#dried basil+=ssn",
                  @"1/2 tsp@#dried thyme+=ssn",
                  
                  @"1/2 tsp@#dijon mustard+=cnd",
                  nil];
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"In a blender, blend tomatoes, vinegar, basil, thyme, and mustard until well combined.",
                @"To store, transfer to a jar with a tight-fitting lid and refrigerate for up to 2 days.",
                @"Shake well before serving tomato vinaigrette.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag184
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"thai-me-up-chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 cup@#walden farms peanut spread+=cnd",
                  @"1/4 cup@#coconut oil+=bak",
                  @"3 tbsp@#lime juice+=prd",
                  @"3 tbsp@#soy sauce+=eth",
                  
                  @"1 tbsp@#hot sauce+=cnd",
                  @"1 tbsp@#fresh ginger+=prd",
                  @"3@#cloves garlic, minced+=prd",
                  @"1/4 cup@#fresh cilantro+=prd",
                  @"8@#thin chicken breasts+=meat",nil];
    
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350°F.",
                @"Place chicken breast in baking dish.",
                @"In a glass bowl, whisk together all other ingredients.",
                @"Smother the chicken with the sauce.",
                @"Bake for 20 - 30 minutes until cooked thoroughly.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag185
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Toasted-Green-Bean-Fries_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 lb@#fresh green beans+=prd",
                  @"2 tbsp@#olive oil+=bak",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#pepper, to taste+=ssn",
                  
                  nil];
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to Broil.",
                @"Toss green beans with olive oil and salt and pepper.",
                @"Spread the green beans out on a baking sheet and broil for 5 minutes.",
                @"Turn them and broil for another 5 - 7 minutes.",
                @"They will be slightly burnt and crispy.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag186
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"tofu-lly-Terrific-ceasar-dressing_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2/3 cup (about 5 oz)@#firm silken tofu+=prd",
                  @"1/4 cup@#water+=wtr",
                  @"1/4 cup@#lemon juice+=prd",
                  @"2 tbsp@#light soy sauce+=eth",
                  
                  @"1 tbsp@#white wine vinegar+=bak",
                  @"1 tbsp@#dijon mustard+=cnd",
                  @"2@#clove garlic+=prd",
                  @"nil1@#ground pepper, to taste+=ssn",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Put all ingredients into a blender and purée until smooth.",
                @"Yields about 1 cup, but a serving size is still 2 tbsp.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1-2 tbsp"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
    
}
-(void)buttontag187
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Turkey-meatballs_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#ground turkey+=meat",
                  @"2@#egg whites+=dry",
                  @"1/4 cup@#fresh parsley+=prd",
                  @"1/2 tsp@#black pepper+=ssn",
                  
                  @"1/2 tsp@#sea salt+=ssn",
                  @"1/2 tsp@#onion powder+=ssn",
                  @"1 1/2 tsp@#garlic, minced+=prd",
                  @"1 large@#zucchini, cut into chunks+=prd",
                  @"1/2 head@#cauliflower+=prd",
                  @"1/2 cup@#mushrooms (or spinach)       chopped+=prd",nil];
    
 [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 425°F.",
                @"Grate the zucchini to make 3/4 cup.",
                @"Shred the cauliflower either in a food processor or with a cheese grater to make 3/4 cup.",
                @"You can store the left over shredded cauliflower in the freezer or make cauli-rice out of it.",
                @"Mix together all ingredients thoroughly.",
                @"Form meatballs and bake for 18 - 20 minutes on a non-stick cookie sheet.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag188
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"turkey-roll-up_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved plain crepe or pancake+=iwm",
                  @"2 slices@#turkey breast+=meat",
                  @"1/2 cup@#fresh spinach+=prd",
                  @"1/2 cup@#roasted red peppers+=prd",
                  nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Follow the instructions for the crepe then place your turkey and veggies in the middle of the crepe and roll it up.",
                @"You can add some spicy mustard too.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 roll up"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag189
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"vampire-repellant-shrimp_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#raw shrimp, deveined and     peeled+=sf",
                  @"4@#cloves garlic, minced+=prd",
                  @"2 tbsp@#lime juice+=prd",
                  @"nil1@#sea salt, to taste+=ssn",
                  
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"2 tbsp@#olive oil+=bak",
                  @"1/2 cup@#crushed approved southwest cheese curls+=iwm",
                  @"2 tbsp@#fresh cilantro, chopped+=prd",nil];
    
[self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 425 F.",
                @"In a bowl, combine shrimp, garlic and lime juice.",
                @"Stir to combine, then pour into a baking dish.",
                @"Spread out evenly, and then season with salt and pepper.",
                @"In another bowl, use a fork to mix olive oil, SW Cheese Curls, and cilantro until well combined.",
                @"With your fingers, sprinkle the mixture evenly in the baking dish over the shrimp.",
                @"Transfer dish to oven and bake until the shrimp are pink and opaque, about 15-18 minutes.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"7 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag190
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"vanilla-cappuccino_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved vanilla pudding+=iwm",
                  @"nil@#approved cappuccino mix (only need        1/2)+=iwm",
                  @"1@#yours favorite bars+=iwm",
                  nil];
    
    
  [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Prepare 1 package of vanilla pudding and set aside.",
                @"Crumble the bar into the pudding and mix.",
                @"Stir in 1/2 package of unprepared Cappuccino drink powder.",
                @"Place in 2 dessert bowls and sprinkle with cinnamon.",
                @"Note that this makes 2 servings (each one including half of a restricted food).",
                @"This is fine to do once a week.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag191
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"vegetable-fritata-_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"12@#eggs+=dry",@"or 15 oz@#container of egg whites+=dry",@"or@#egg beaters+=dry",
                  @"1 small@#zucchini, diced+=prd",
                  @"1 cup@#raw spinach+=prd",
                  @"2@#cloves garlic, finely chopped+=prd",
                  
                  @"4 oz@#low sodium natural ham+=meat",
                  @"1/2 cup@#sliced mushrooms+=prd",
                  @"1 tbsp@#olive oil+=bak",
                  @"nil@#sea salt+=ssn",
                  @"nil@#pepper+=ssn",
                  @"1/2 cup@#yellow banana peppers       (optional)+=prd",nil];
    
 [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 350°F.",
                @"In a large oven proof skillet (see note at bottom if you don’t have this top of skillet), heat oil and sauté garlic, zucchini and mushrooms.",
                @"Once slightly browned, add spinach.",
                @"Sauté until spinach shrinks by half and wilts.",
                @"In a large glass bowl, use 1 whole egg and the whites from the other 11.",
                @"Whip eggs until frothy & yellow.",
                @"Add salt and pepper to taste.",
                @"Pour egg mixture over veggies and sprinkle ham on top.",
                @"Once the frittata starts to set around the edges, bake for about 10 - 15 minutes or until the center is set.",
                @"Optional:  top with sautéd hot banana peppers.",
                @"*Note:  if you don’t have an oven proof skillet, just use a 9 x 13 inch baking pan.",
                @"Put the egg mixture in it and add the vegetables on top then bake about 20 minutes.",nil];
    
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 slice"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag192
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"vegetarian-crispy-fried-chicken_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1@#egg white (beaten with a dash of sea salt)+=dry",
                  @"1@#approved salt & vinegar ridges, crushed fine+=iwm",
                  @"1@#eggplant, cut into disks+=prd",
                  @"1 tsp@#dried basil, crumbled+=ssn",
                  
                  @"1 tsp@#dried oregano+=ssn",
                  @"nil1@#sea salt, to taste+=ssn",
                  @"nil1@#ground pepper, to taste+=ssn",
                  @"nil@#hot sauce (optional)+=cnd",
                  @"nil@#tomato sauce (no sugar added)+=sac",
                  @"2 tsp@#olive oil+=bak",nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 400℉.",
                @"Beat egg whites until stiff.",
                @"Crush the Salt and Vinegar Ridges (use a rolling pin over the bag before you open).",
                @"Place crushed mix in bowl.",
                @"Cut eggplant into slices.",
                @"If using hot sauce, shake a drop or two on one side of each slice.",
                @"Dip eggplant in egg white and shake off excess.",
                @"Sprinkle eggplant with herbs.",
                @"Dip eggplant in Salt and Vinegar mix (coat both sides).",
                @"Place on baking sheet covered with parchment paper.",
                @"Repeat until crushed mix is gone.",
                @"Coat remaining eggplant slices in olive oil and sprinkle with salt, pepper and herbs.",
                @"Bake about 20 minutes, checking at 10 and 15 minutes to ensure it doesn’t burn.",
                @"Do not turn the eggplant.",
                @"Take out of oven and enjoy.",
                @"*NOTE: Eggplant is best when cooked thoroughly.",
                @"You can take out the crispy eggplant when browning and then let the rest of it continue to cook.",
                @"Serve with Yellow Bell Pepper and Radish Salad.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag193
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Wonderful-Waffles_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"nil@#approved pudding (any flavor will work)+=iwm",
                  @"2@#beaten egg whites+=dry",
                  @"2 oz@#water+=wtr",
                  @"1 tsp@#vanilla extract+=bak",
                  
                  @"1/8 tsp@#baking powder+=bak",
                  @"1/8 tsp@#nutmeg+=ssn",
                  @"1/8 tsp@#sea salt+=ssn",
                  @"1 packet@#Splenda or Truvia (optional)+=bak",nil];
    
    
    
  [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Spray waffle iron with non-stick spray and pre-heat.",
                @"Beat egg whites with salt.",
                @"Mix all dry ingredients together, add them to the egg whites and vanilla extract.",
                @"Slowly add the water until desired consistency.",
                @"Pour mixture in waffle iron until cooked.",
                @"Enjoy with Walden Farms Syrup.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"1"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"2 waffles"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag194
{ int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"wrappin-up-dinner_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 pound@#lean ground beef+=meat",
                  @"1 cup@#mushroom, diced+=prd",
                  @"1 cup@#green peppers, diced+=prd",
                  @"1 cup@#fresh spinach+=prd",
                  
                  @"1/2 cup@#tomatoes, chopped+=prd",
                  @"8 large@#collard leaves+=prd",
                  nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Brown the beef in a skillet over medium heat.",
                @"Add the mushrooms, peppers, tomatoes and spinach.",
                @"Clean the collard leaves, trim off the bottom and then de-vein the thick end of the leaf.",
                @"Lay one leaf down with the bright green side facing down, inside up.",
                @"Lay another leaf the same way so that it overlaps the first leaf.",
                @"Put your beef mixture in the middle, not using too much.",
                @"This should make 4 wraps.",
                @"Then fold the ends in first (this is folding the de-veined sides in).",
                @"Then wrap tight like a burrito.",
                @"You can wrap it in a paper towel to better hold it together while you enjoy it.",
                @"You can also do this with egg whites and make an awesome breakfast burrito!",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"2"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"8 OZ"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag195
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"Zelicious-Zucchini-Bread_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2@#eggs, beaten+=dry",
                  @"2/3 plus 1/4 cup@#agave nectar+=bak",
                  @"2 tsp@#vanilla extract (with no corn syrup)+=ssn",
                  @"3 cups@#grated zucchini+=prd",
                  
                  @"2/3 cup@#melted butter+=dry",
                  @"2 tsp@#ground cinnamon+=ssn",
                  @"3 cups@#whole wheat flour+=bak",
                  @"2 tsp@#baking soda+=bak",
                  @"2 tsp@#cinnamon+=ssn",
                  @"1 tsp@#nutmeg+=ssn",
                  @"1 cup@#chopped pecans (optional)+=bak",
                  @"1 cup@#dried cranberries+=prd",nil];
    
    [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat the oven to 325°F.",
                @"In a large bowl, mix together the agave nectar, eggs, and vanilla.",
                @"Next mix in the zucchini and melted butter.",
                @"Add baking soda, cinnamon, and nutmeg.",
                @"Mix well.",
                @"Add the flour, a cup at a time.",
                @"Fold in the nuts and dried cranberries.",
                @"Divide the batter equally between 2 non-stick sprayed loaf pans.",
                @"Bake for 1 hour or until a wooden pick inserted in to the center comes out clean.",
                @"Cool in pans for 10 minutes.",
                @"Turn out onto wire racks to cool thoroughly.",
                @"Can have with phase 3 breakfast.",nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"8"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 Slice"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
}
-(void)buttontag196
{int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"zucchini-chips_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"2 large@#zucchini, sliced into 1/4” disks+=prd",
                  @"1@#approved Broccoli Cheese Soup         Packet+=iwm",
                  @"2@#egg whites+=dry",
                  @"1/4 tsp@#real sea salt+=ssn",
                  
                  @"1/4 tsp@#garlic powder+=ssn",
                  @"1/4 tsp@#ground pepper+=ssn",
                  nil];
    
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"Preheat oven to 450℉.",
                @"Line a baking sheet with parchment paper and spray with olive oil spray.",
                @"Wash zucchini and slice into 1/4 inch slices.",
                @"Mix the broccoli cheese soup packet and seasoning in one bowl.",
                @"Place the egg whites in another bowl.",
                @"Dip zucchini slices in the egg whites, then dip into the soup mixture, coating evenly.",
                @"Spread zucchini in a single layer on the baking sheet.",
                @"Roast 7 minutes, then turn zucchini over.",
                @"Roast another 7 - 8 minutes or until coating is crispy and golden brown.",
                @"Serve immediately.",nil];
    
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
    
    
}
-(void)buttontag197
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"zucchini_fettuccine_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"3 large@#zucchini+=prd",
                  nil];
   [self ingridients];    
    
    instrArray=[[NSArray alloc]initWithObjects:@"This is a great alternate to pasta and a dish that the entire family will love.",
                @"Just use a vegetable peeler (or even a knife) and make long strips (like fettuccine) until you get to the seeds.",
                @"Boil some water with salt and then add the zucchini for about 1 minute.",
                @"Take zucchini out and immediately blanch in cold water or just strain under running cold water.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
}
-(void)buttontag198
{
    int i=buttonTag-1;
    UIImage *newImage= [UIImage imageNamed:@"zucchini-lime-hummus_640.jpg"];
    recipieName.text=[nameArray objectAtIndex:i];
    groceryArray=[[NSArray alloc]initWithObjects:
                  @"1 large@#zucchini, cut into chunks+=prd",
                  @"2 tsp@#tahini+=eth",
                  @"1 clove@#garlic, minced+=prd",
                  @"2 tbsp@#lime juice+=prd",
                  
                  @"1 tsp@#sea salt+=ssn",
                  @"1 tsp@#cumin+=ssn",
                  @"1 tsp@#cayenne pepper+=ssn",nil];
    
   [self ingridients];    
    instrArray=[[NSArray alloc]initWithObjects:@"Combine all ingredients in a food processor or a blender.",
                @"Use as a veggie dip or even as a salad dressing.",
                nil];
    
    //int size=1;
    //int cup=8;
    //float serve=0.5;
    NSString *size=[[NSString alloc]initWithFormat:@"4"];
    NSString *serveString=[[NSString alloc]initWithFormat:@"1/2 cup"];;
    [self addScrollview:ingrdArray withServing:size withInstructions:instrArray andServingSize:serveString havingImage:newImage];
}


-(void)method
{
   
    nameArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"allnames"];
        if ([name isEqualToString:@"ALL"])
    {
         if  (buttonTag==1) {
            
            
            [self buttontag1];
            
            
        }

        else if (buttonTag==2) {
             [self buttontag2];
            
        }
        
        else if  (buttonTag==3) {
             [self buttontag3];
           
            
        }
        else if  (buttonTag==4) {
             [self buttontag4];
            
            
                    }
        else if  (buttonTag==5) {
            
            
             [self buttontag5];
        
        }

        else if  (buttonTag==6) {
           
            
             [self buttontag6];
            
        }

        
        else if  (buttonTag==7) {
            [self buttontag7];
            
        }

        else if  (buttonTag==8) {
            
             [self buttontag8];
        }

        else if  (buttonTag==9) {
             
            [self buttontag9];
            
        }
        
        else if  (buttonTag==10) {
          
             [self buttontag10];
            
            
        }
        
        else if  (buttonTag==11) {
            
            [self buttontag11];
            
            
        }

        else if  (buttonTag==12) {
            
            
            [self buttontag12];
            
        }

        else if  (buttonTag==13) {
             [self buttontag13];
            
        }

        else if  (buttonTag==14) {
             [self buttontag14];
            
        }
        
        else if  (buttonTag==15) {
             [self buttontag15];
            
        }
//
        else if  (buttonTag==16) {
             [self buttontag16];
            
        }

        else if  (buttonTag==17) {
             [self buttontag17];
            
        }

        else if  (buttonTag==18) {
             [self buttontag18];
            
            
            
        }

        else if  (buttonTag==19) {
             [self buttontag19];
            
        }
        
        else if  (buttonTag==20) {
           
             [self buttontag20];
        }

        else if  (buttonTag==21) {
             [self buttontag21];
            
        }
        
        else if  (buttonTag==22) {
            [self buttontag22];
            
        }

        else if  (buttonTag==23) {
            
             [self buttontag23];
            
        }
        
        else if  (buttonTag==24) {
            
              [self buttontag24];
           
            
        }
        
        else if  (buttonTag==25) {
             [self buttontag25];
        }

        else if  (buttonTag==26) {
             [self buttontag26];
        }
        
        else if  (buttonTag==27) {
            [self buttontag27];
            
        }
        
        else if  (buttonTag==28) {
             [self buttontag28];
        }
        
        else if  (buttonTag==29) {
            
             [self buttontag29];
           
            
        }

        else if  (buttonTag==30) {
             [self buttontag30];
        }

        else if  (buttonTag==31) {
             [self buttontag31];
        }
        
        else if  (buttonTag==32) {
             [self buttontag32];
        }

        else if  (buttonTag==33) {
             [self buttontag33];
           
                   }
        else if  (buttonTag==34) {
            [self buttontag34];
            
        }
        
        else if  (buttonTag==35) {
             [self buttontag35];
        }
        
        else if  (buttonTag==36) {
             [self buttontag36];
            
        }

        else if  (buttonTag==37) {
              [self buttontag37];
                   }

        else if  (buttonTag==38) {
             [self buttontag38];
        }
        
        else if  (buttonTag==39) {
             [self buttontag39];
        }

        else if  (buttonTag==40) {
           
             [self buttontag40];
        }
        
        else if  (buttonTag==41) {
            
             [self buttontag41];
        }

        else if  (buttonTag==42) {
            
             [self buttontag42];
        }
        
        else if  (buttonTag==43) {
             [self buttontag43];
                       
        }
        
        else if  (buttonTag==44) {
             [self buttontag44];
        }
        
        else if  (buttonTag==45) {
             [self buttontag45];
        }
        
        else if  (buttonTag==46) {
             [self buttontag46];
            
        }
        
        else if  (buttonTag==47) {
             [self buttontag47];
        }
        
        else if  (buttonTag==48) {
             [self buttontag48];

            
        }
    
        else if  (buttonTag==49) {
            
             [self buttontag49];
        }
    
        else if  (buttonTag==50) {
             [self buttontag50];
        }
    
        else if  (buttonTag==51) {
             [self buttontag51];
            
        }
    
        else if  (buttonTag==52) {
             [self buttontag52];
        }
    
        else if  (buttonTag==53) {
             [self buttontag53];
        }
    
        else if  (buttonTag==54) {
            [self buttontag54];
        } 
    
        else if  (buttonTag==55) {
            [self buttontag55];
            
        }
    
        else if  (buttonTag==56) {
             [self buttontag56];
                    }
    
        else if  (buttonTag==57) {
            [self buttontag57];
        }
    
        else if  (buttonTag==58) {
           [self buttontag58];
            
        }
    
        else if  (buttonTag==59) {
            [self buttontag59];
        }
    

        
               else if  (buttonTag==60) {
            
            [self buttontag60];
        }

        else if  (buttonTag==61) {
            [self buttontag61];
        }
        else if  (buttonTag==62) {
            [self buttontag62];
            
        }
        else if  (buttonTag==63) {
            [self buttontag63];
            
        }
        else if  (buttonTag==64) {
           [self buttontag64];
            
        }
        else if  (buttonTag==65) {
            [self buttontag65];
            
        }
        else if  (buttonTag==66) {
            [self buttontag66];
        }
        else if  (buttonTag==67) {
            [self buttontag67];
            
        }
        else if  (buttonTag==68) {
            [self buttontag68];
        }
        else if  (buttonTag==69) {
            [self buttontag69];
            
        }
        else if  (buttonTag==70) {
            [self buttontag70];
        }
        else if  (buttonTag==71) {
             [self buttontag71];
            
            
        }
        else if  (buttonTag==72) {
            [self buttontag72];
        }
        else if  (buttonTag==73) {
            [self buttontag73];
        }
        else if  (buttonTag==74) {
            [self buttontag74];
            
        }
        else if  (buttonTag==75) {
            [self buttontag75];
            
        }
        else if  (buttonTag==76) {
            [self buttontag76];
        }
        else if  (buttonTag==77) {
           [self buttontag77];
            
        }
        else if  (buttonTag==78) {
           [self buttontag78];
            
        }
        else if  (buttonTag==79) {
            [self buttontag79];
        }
        else if  (buttonTag==80) {
            [self buttontag80];
        }
        else if  (buttonTag==81) {
            [self buttontag81];
            
        }
        else if  (buttonTag==82) {
           [self buttontag82];
            
        }
        else if  (buttonTag==83) {
           [self buttontag83]; 
        }
        else if  (buttonTag==84) {
            [self buttontag84];
            
        }
        else if  (buttonTag==85) {
            [self buttontag85];
            
        }
        else if  (buttonTag==86) {
            [self buttontag86];
            
        }
        else if  (buttonTag==87) {
            [self buttontag87];
        }
        else if  (buttonTag==88) {
            [self buttontag88];
        }
        else if  (buttonTag==89) {
            
            [self buttontag89];
            
            
                    }
        else if  (buttonTag==90) {
            [self buttontag90];
            
        }
        else if  (buttonTag==91) {
            [self buttontag91];
        }
        else if  (buttonTag==92) {
            [self buttontag92];
        }
        else if  (buttonTag==93) {
            [self buttontag93];
        }
        else if  (buttonTag==94) {
            
            [self buttontag94];
            
                    }
        else if  (buttonTag==95) {
           
            [self buttontag95];
        }
        else if  (buttonTag==96) {
           
            [self buttontag96];
        }
        else if  (buttonTag==97) {
            [self buttontag97];
            
        }
        else if  (buttonTag==98) {
            [self buttontag98];
            
        }
        else if  (buttonTag==99) {
            [self buttontag99];
            
        }
        else if  (buttonTag==100) {
           [self buttontag100];
            
        }
        else if  (buttonTag==101) {
            [self buttontag101];
        }
        else if  (buttonTag==102) {
            [self buttontag102];
        }
        else if  (buttonTag==103) {
            [self buttontag103];
            
        }
        else if  (buttonTag==104) {
            [self buttontag104];
        }
        else if  (buttonTag==105) {
            [self buttontag105];
        }
        else if  (buttonTag==106) {
            [self buttontag106];
        }
        else if  (buttonTag==107) {
            [self buttontag107];
        }
        else if  (buttonTag==108) {
            
            [self buttontag108];
        }
        else if  (buttonTag==109) {
            [self buttontag109];
            
        }
        else if  (buttonTag==110) {
            [self buttontag110];
        }
        else if  (buttonTag==111) {
            [self buttontag111];
            
        }
        else if  (buttonTag==112) {
           [self buttontag112];
            
        }
        else if  (buttonTag==113) {
            [self buttontag113];
            
        }
        else if  (buttonTag==114) {
            [self buttontag114];
            
        }
        else if  (buttonTag==115) {
            [self buttontag115];
        }
        else if  (buttonTag==116) {
            
            [self buttontag116];
                   }
        else if  (buttonTag==117) {
            [self buttontag117];
        }
        else if  (buttonTag==118) {
            [self buttontag118];
            
        }
        else if  (buttonTag==119) {
            [self buttontag119];
            
        }
        else if  (buttonTag==120) {
            [self buttontag120];
        }
        else if  (buttonTag==121) {
            [self buttontag121];
            
        }
        else if  (buttonTag==122) {
            [self buttontag122];
        }
        else if  (buttonTag==123) {
           [self buttontag123];
            
        }
        else if  (buttonTag==124) {
            [self buttontag124];
        }
        else if  (buttonTag==125) {
            
            [self buttontag125];
                    }
        else if  (buttonTag==126) {
            [self buttontag126];
            
        }
        else if  (buttonTag==127) {
            [self buttontag127];
        }
        else if  (buttonTag==128) {
            [self buttontag128];
        }
        else if  (buttonTag==129) {
            [self buttontag129];
        }
        else if  (buttonTag==130) {
            [self buttontag130];
            
        }
        else if  (buttonTag==131) {
        [self buttontag131];    
        
        }
        else if  (buttonTag==132) {
            [self buttontag132];
        }
        else if  (buttonTag==133) {
           [self buttontag133];
            
        }
        else if  (buttonTag==134) {
            [self buttontag134];
            
        }
        else if  (buttonTag==135) {
            [self buttontag135];
        }
        else if  (buttonTag==136) {
            [self buttontag136];
        }
        else if  (buttonTag==137) {
            [self buttontag137];
        }
        else if  (buttonTag==138) {
           [self buttontag138];
            
        }
        else if  (buttonTag==139) {
            [self buttontag139];
        }
        else if  (buttonTag==140) {
           [self buttontag140];
            
        }
        else if  (buttonTag==141) {
            [self buttontag141];
            
        }
        else if  (buttonTag==142) {
        [self buttontag142];    
        
        }
        else if  (buttonTag==143) {
            [self buttontag143];
            
        }
        else if  (buttonTag==144) {
            [self buttontag144];
        }
        else if  (buttonTag==145) {
            [self buttontag145];
            
        }
        else if  (buttonTag==146) {
            [self buttontag146];
            
        }
        else if  (buttonTag==147) {
            [self buttontag147];
        }
        else if  (buttonTag==148) {
            [self buttontag148];
        }
        else if  (buttonTag==149) {
           [self buttontag149];
            
        }
        else if  (buttonTag==150) {
        [self buttontag150];    
        
        }
        else if  (buttonTag==151) {
         [self buttontag151];   
        }
        else if  (buttonTag==152) {
          [self buttontag152];  
            
        }
        else if  (buttonTag==153) {
            
          [self buttontag153];  
        }
        else if  (buttonTag==154) {
          [self buttontag154];  
            
        }
        else if  (buttonTag==155) {
           [self buttontag155]; 
            
        }
        else if  (buttonTag==156) {
            [self buttontag156];
        }
        else if  (buttonTag==157) {
            
          [self buttontag157];  
        }
        else if  (buttonTag==158) {
        [self buttontag158];    
        }
        else if  (buttonTag==159) {
           [self buttontag159]; 
            
        }
        else if  (buttonTag==160) {
            [self buttontag160];
            
        }
        else if  (buttonTag==161) {
            [self buttontag161];
            
        }
        else if  (buttonTag==162) {
            [self buttontag162];
        }
        else if  (buttonTag==164) {
            [self buttontag163];
        }
        else if  (buttonTag==163) {
            [self buttontag164];
            
        }
        else if  (buttonTag==165) {
            [self buttontag165];
            
        }
        else if  (buttonTag==167) {
            [self buttontag167];
            
                    }
        else if  (buttonTag==166) {
            
            [self buttontag166];
        }
        else if  (buttonTag==168) {
            
            [self buttontag168];
                    }
        else if  (buttonTag==169) {
            [self buttontag169];
            
        }
        else if  (buttonTag==170) {
            
            [self buttontag170];
        }
        else if  (buttonTag==171) {
            [self buttontag171];
            
        }
        else if  (buttonTag==172) {
           [self buttontag172];
            
        }
        else if  (buttonTag==173) {
            
            [self buttontag173];
        }
        else if  (buttonTag==174) {
            [self buttontag174];
        }
        else if  (buttonTag==175) {
           [self buttontag175];
            
        }
        else if  (buttonTag==176) {
           [self buttontag176];
        }
        else if  (buttonTag==177) {
            [self buttontag177];
            
        }
        else if  (buttonTag==178) {
            
            [self buttontag178];
                    }
        else if  (buttonTag==179) {
            [self buttontag179];
            
        }
        else if  (buttonTag==180) {
            
            [self buttontag180];
                    }
        else if  (buttonTag==181) {
           
            [self buttontag181];
        }
        else if  (buttonTag==182) {
            [self buttontag182];
        }
        else if  (buttonTag==183) {
           [self buttontag183];
            
        }
        else if  (buttonTag==184) {
           [self buttontag184];
            
        }
        else if  (buttonTag==185) {
            [self buttontag185];
        }
        else if  (buttonTag==186) {
            [self buttontag186];
        }
        else if  (buttonTag==187) {
            [self buttontag187];
        }
        else if  (buttonTag==188) {
            [self buttontag188];
            
        }
        else if  (buttonTag==189) {
            [self buttontag189];
            
        }
        else if  (buttonTag==190) {
            [self buttontag190];
            
        }
        else if  (buttonTag==191) {
           [self buttontag191];
            
        }
        else if  (buttonTag==192) {
            [self buttontag192];
        }
        else if  (buttonTag==193) {
            [self buttontag193];
            
        }
        else if  (buttonTag==194) {
           [self buttontag194];
            
        }
        else if  (buttonTag==195) {
            [self buttontag195];
            
        }
        else if  (buttonTag==196) {
            [self buttontag196];
        }
        else if  (buttonTag==197) {
            [self buttontag197];
            
        }
        else if  (buttonTag==198) {
            [self buttontag198];
            
        }
       
    }
    else if ([name isEqualToString:@"PHASE 1 and 2"])
    {
        if  (buttonTag==1) {
            
            
            [self buttontag1];
            
            
        }
        
        else if (buttonTag==2) {
            [self buttontag2];
            
        }
        
        else if  (buttonTag==3) {
            [self buttontag3];
            
            
        }
        else if  (buttonTag==4) {
            [self buttontag5];
            
            
        }
        else if  (buttonTag==5) {
            
            
            [self buttontag6];
            
        }
        
        else if  (buttonTag==6) {
            
            
            [self buttontag7];
            
        }
        
        
        else if  (buttonTag==7) {
            [self buttontag8];
            
        }
        
        else if  (buttonTag==8) {
            
            [self buttontag10];
        }
        
        else if  (buttonTag==9) {
            
            [self buttontag11];
            
        }
        
        else if  (buttonTag==10) {
            
            [self buttontag14];
            
            
        }
        
        else if  (buttonTag==11) {
            
            [self buttontag15];
            
            
        }
        
        else if  (buttonTag==12) {
            
            
            [self buttontag16];
            
        }
        
        else if  (buttonTag==13) {
            [self buttontag17];
            
        }
        
        else if  (buttonTag==14) {
            [self buttontag18];
            
        }
        
        else if  (buttonTag==15) {
            [self buttontag19];
            
        }
        //
        else if  (buttonTag==16) {
            [self buttontag21];
            
        }
        
        else if  (buttonTag==17) {
            [self buttontag23];
            
        }
        
        else if  (buttonTag==18) {
            [self buttontag24];
            
            
            
        }
        
        else if  (buttonTag==19) {
            [self buttontag25];
            
        }
        
        else if  (buttonTag==20) {
            
            [self buttontag26];
        }
        
        else if  (buttonTag==21) {
            [self buttontag27];
            
        }
        
        else if  (buttonTag==22) {
            [self buttontag30];
            
        }
        
        else if  (buttonTag==23) {
             [self buttontag32];
          
            
        }
        
        else if  (buttonTag==24) {
            
            [self buttontag31];
            
            
        }
        
        else if  (buttonTag==25) {
           
              [self buttontag29];
        }
        
        else if  (buttonTag==26) {
            [self buttontag28];
        }
        
        else if  (buttonTag==27) {
            [self buttontag34];
            
        }
        
        else if  (buttonTag==28) {
            [self buttontag36];
        }
        
        else if  (buttonTag==29) {
            
            [self buttontag37];
            
            
        }
        
        else if  (buttonTag==30) {
            [self buttontag38];
        }
        
        else if  (buttonTag==31) {
            [self buttontag39];
        }
        
        else if  (buttonTag==32) {
            [self buttontag40];
        }
        
        else if  (buttonTag==33) {
            [self buttontag41];
            
        }
        else if  (buttonTag==34) {
            [self buttontag42];
            
        }
        
        else if  (buttonTag==35) {
            [self buttontag43];
        }
        
        else if  (buttonTag==36) {
            [self buttontag44];
            
        }
        
        else if  (buttonTag==37) {
            [self buttontag45];
        }
        
        else if  (buttonTag==38) {
            [self buttontag46];
        }
        
        else if  (buttonTag==39) {
            [self buttontag47];
        }
        
        else if  (buttonTag==40) {
            
            [self buttontag48];
        }
        
        else if  (buttonTag==41) {
            
            [self buttontag49];
        }
        
        else if  (buttonTag==42) {
            
            [self buttontag50];
        }
        
        else if  (buttonTag==43) {
            [self buttontag51];
            
        }
        
        else if  (buttonTag==44) {
            [self buttontag52];
        }
        
        else if  (buttonTag==45) {
            [self buttontag53];
        }
        
        else if  (buttonTag==46) {
            [self buttontag54];
            
        }
        
        else if  (buttonTag==47) {
            [self buttontag55];
        }
        
        else if  (buttonTag==48) {
            [self buttontag56];
            
            
        }
        
        else if  (buttonTag==49) {
            
            [self buttontag57];
        }
        
        else if  (buttonTag==50) {
            [self buttontag58];
        }
        
        else if  (buttonTag==51) {
            [self buttontag59];
            
        }
        
        else if  (buttonTag==52) {
            [self buttontag60];
        }
        
        else if  (buttonTag==53) {
            [self buttontag61];
        }
        
        else if  (buttonTag==54) {
            [self buttontag62];
        }
        
        else if  (buttonTag==55) {
            [self buttontag63];
            
        }
        
        else if  (buttonTag==56) {
            [self buttontag64];
        }
        
        else if  (buttonTag==57) {
            [self buttontag66];
        }
        
        else if  (buttonTag==58) {
            [self buttontag67];
            
        }
        
        else if  (buttonTag==59) {
            [self buttontag68];
        }
        
        
        
        else if  (buttonTag==60) {
            
            [self buttontag69];
        }
        
        else if  (buttonTag==61) {
            [self buttontag70];
        }
        else if  (buttonTag==62) {
            [self buttontag71];
            
        }
        else if  (buttonTag==63) {
            [self buttontag72];
            
        }
        else if  (buttonTag==64) {
            [self buttontag73];
            
        }
        else if  (buttonTag==65) {
            [self buttontag74];
            
        }
        else if  (buttonTag==66) {
            [self buttontag75];
        }
        else if  (buttonTag==67) {
            [self buttontag76];
            
        }
        else if  (buttonTag==68) {
            [self buttontag77];
        }
        else if  (buttonTag==69) {
            [self buttontag78];
            
        }
        else if  (buttonTag==70) {
            [self buttontag79];
        }
        else if  (buttonTag==71) {
            [self buttontag80];
            
            
        }
        else if  (buttonTag==72) {
            [self buttontag81];
        }
        else if  (buttonTag==73) {
            [self buttontag82];
        }
        else if  (buttonTag==74) {
            [self buttontag83];
            
        }
        else if  (buttonTag==75) {
            [self buttontag84];
            
        }
        else if  (buttonTag==76) {
            [self buttontag85];
        }
        else if  (buttonTag==77) {
            [self buttontag86];
            
        }
        else if  (buttonTag==78) {
            [self buttontag88];
            
        }
        else if  (buttonTag==79) {
            [self buttontag89];
        }
        else if  (buttonTag==80) {
            [self buttontag91];
        }
        else if  (buttonTag==81) {
            [self buttontag93];
            
        }
        else if  (buttonTag==82) {
            [self buttontag94];
            
        }
        else if  (buttonTag==83) {
            [self buttontag95];
        }
        else if  (buttonTag==84) {
            [self buttontag96];
            
        }
        else if  (buttonTag==85) {
            [self buttontag99];
            
        }
        else if  (buttonTag==86) {
            [self buttontag100];
            
        }
        else if  (buttonTag==87) {
            [self buttontag101];
        }
        else if  (buttonTag==88) {
            [self buttontag102];
        }
        else if  (buttonTag==89) {
            
            [self buttontag103];
            
            
        }
        else if  (buttonTag==90) {
            [self buttontag104];
            
        }
        else if  (buttonTag==91) {
            [self buttontag105];
        }
        else if  (buttonTag==92) {
            [self buttontag106];
        }
        else if  (buttonTag==93) {
            [self buttontag107];
        }
        else if  (buttonTag==94) {
            
            [self buttontag108];
            
        }
        else if  (buttonTag==95) {
            
            [self buttontag109];
        }
        else if  (buttonTag==96) {
            
            [self buttontag110];
        }
        else if  (buttonTag==97) {
            [self buttontag111];
            
        }
        else if  (buttonTag==98) {
            [self buttontag112];
            
        }
        else if  (buttonTag==99) {
            [self buttontag113];
            
        }
        else if  (buttonTag==100) {
            [self buttontag114];
            
        }
        else if  (buttonTag==101) {
            [self buttontag115];
        }
        else if  (buttonTag==102) {
            [self buttontag116];
        }
        else if  (buttonTag==103) {
            [self buttontag117];
            
        }
        else if  (buttonTag==104) {
            [self buttontag118];
        }
        else if  (buttonTag==105) {
            [self buttontag119];
        }
        else if  (buttonTag==106) {
            [self buttontag120];
        }
        else if  (buttonTag==107) {
            [self buttontag121];
        }
        else if  (buttonTag==108) {
            
            [self buttontag122];
        }
        else if  (buttonTag==109) {
            [self buttontag124];
            
        }
        else if  (buttonTag==110) {
            [self buttontag125];
        }
        else if  (buttonTag==111) {
            [self buttontag126];
            
        }
        else if  (buttonTag==112) {
            [self buttontag127];
            
        }
        else if  (buttonTag==113) {
            [self buttontag128];
            
        }
        else if  (buttonTag==114) {
            [self buttontag129];
            
        }
        else if  (buttonTag==115) {
            [self buttontag130];
        }
        else if  (buttonTag==116) {
            
            [self buttontag131];
        }
        else if  (buttonTag==117) {
            [self buttontag132];
        }
        else if  (buttonTag==118) {
            [self buttontag133];
            
        }
        else if  (buttonTag==119) {
            [self buttontag134];
            
        }
        else if  (buttonTag==120) {
            [self buttontag135];
        }
        else if  (buttonTag==121) {
            [self buttontag136];
            
        }
        else if  (buttonTag==122) {
            [self buttontag137];
        }
        else if  (buttonTag==123) {
            [self buttontag140];
            
        }
        else if  (buttonTag==124) {
            [self buttontag143];
        }
        else if  (buttonTag==125) {
            
            [self buttontag144];
        }
        else if  (buttonTag==126) {
            [self buttontag145];
            
        }
        else if  (buttonTag==127) {
            [self buttontag146];
        }
        else if  (buttonTag==128) {
            [self buttontag147];
        }
        else if  (buttonTag==129) {
            [self buttontag149];
        }
        else if  (buttonTag==130) {
            [self buttontag150];
            
        }
        else if  (buttonTag==131) {
            [self buttontag151];
            
        }
        else if  (buttonTag==132) {
            [self buttontag152];
        }
        else if  (buttonTag==133) {
            [self buttontag153];
            
        }
        else if  (buttonTag==134) {
            [self buttontag154];
            
        }
        else if  (buttonTag==135) {
            [self buttontag155];
        }
        else if  (buttonTag==136) {
            [self buttontag156];
        }
        else if  (buttonTag==137) {
            [self buttontag157];
        }
        else if  (buttonTag==138) {
            [self buttontag158];
            
        }
        else if  (buttonTag==139) {
            [self buttontag159];
        }
        else if  (buttonTag==140) {
            [self buttontag160];
            
        }
        else if  (buttonTag==141) {
            [self buttontag161];
            
        }
        else if  (buttonTag==142) {
            [self buttontag162];
            
        }
        else if  (buttonTag==143) {
            [self buttontag163];
            
        }
        else if  (buttonTag==144) {
            [self buttontag166];
        }
        else if  (buttonTag==145) {
            [self buttontag167];
            
        }
        else if  (buttonTag==146) {
            [self buttontag168];
            
        }
        else if  (buttonTag==147) {
            [self buttontag169];
        }
        else if  (buttonTag==148) {
            [self buttontag170];
        }
        else if  (buttonTag==149) {
            [self buttontag171];
            
        }
        else if  (buttonTag==150) {
            [self buttontag172];
            
        }
        else if  (buttonTag==151) {
            [self buttontag174];
        }
        else if  (buttonTag==152) {
            [self buttontag175];
            
        }
        else if  (buttonTag==153) {
            
            [self buttontag177];
        }
        else if  (buttonTag==154) {
            [self buttontag178];
            
        }
        else if  (buttonTag==155) {
            [self buttontag179];
            
        }
        else if  (buttonTag==156) {
            [self buttontag181];
        }
        else if  (buttonTag==157) {
            
            [self buttontag182];
        }
        else if  (buttonTag==158) {
            [self buttontag183];
        }
        else if  (buttonTag==159) {
            [self buttontag184];
            
        }
        else if  (buttonTag==160) {
            [self buttontag185];
            
        }
        else if  (buttonTag==161) {
            [self buttontag186];
            
        }
        else if  (buttonTag==162) {
            [self buttontag187];
        }
        else if  (buttonTag==164) {
            [self buttontag188];
        }
        else if  (buttonTag==163) {
            [self buttontag189];
            
        }
        else if  (buttonTag==165) {
            [self buttontag190];
            
        }
        else if  (buttonTag==167) {
            
            [self buttontag191];
        }
        else if  (buttonTag==166) {
            
            [self buttontag192];
        }
        else if  (buttonTag==168) {
            
            [self buttontag193];
        }
        else if  (buttonTag==169) {
            [self buttontag194];
            
        }
        else if  (buttonTag==170) {
            
            [self buttontag196];
        }
        else if  (buttonTag==171) {
            [self buttontag197];
            
        }
        else if  (buttonTag==172) {
            [self buttontag198];
            
        }

        


    
    
    
    }
    
    
    
    

else if ([name isEqualToString:@"PHASE 3"])
{
    
    if  (buttonTag==1) {
        
        
        [self buttontag1];
        
        
    }
    
    else if (buttonTag==2) {
        [self buttontag2];
        
    }
    
    else if  (buttonTag==3) {
        [self buttontag3];
        
        
    }
    else if  (buttonTag==4) {
        [self buttontag4];
        
        
    }
    else if  (buttonTag==5) {
        
        
        [self buttontag5];
        
    }
    
    else if  (buttonTag==6) {
        
        
        [self buttontag6];
        
    }
    
    
    else if  (buttonTag==7) {
        [self buttontag7];
        
    }
    
    else if  (buttonTag==8) {
        
        [self buttontag8];
    }
    
    else if  (buttonTag==9) {
        
        [self buttontag9];
        
    }
    
    else if  (buttonTag==10) {
        
        [self buttontag10];
        
        
    }
    
    else if  (buttonTag==11) {
        
        [self buttontag11];
        
        
    }
    
    else if  (buttonTag==12) {
        
        
        [self buttontag13];
        
    }
    
    else if  (buttonTag==13) {
        [self buttontag14];
        
    }
    
    else if  (buttonTag==14) {
        [self buttontag15];
        
    }
    
    else if  (buttonTag==15) {
        [self buttontag16];
        
    }
    //
    else if  (buttonTag==16) {
        [self buttontag17];
        
    }
    
    else if  (buttonTag==17) {
        [self buttontag18];
        
    }
    
    else if  (buttonTag==18) {
        [self buttontag19];
        
        
        
    }
    
    else if  (buttonTag==19) {
        [self buttontag20];
        
    }
    
    else if  (buttonTag==20) {
        
        [self buttontag21];
    }
    
    else if  (buttonTag==21) {
        [self buttontag23];
        
    }
    
    else if  (buttonTag==22) {
        [self buttontag24];
        
    }
    
    else if  (buttonTag==23) {
        
        [self buttontag25];
        
    }
    
    else if  (buttonTag==24) {
        
        [self buttontag26];
        
        
    }
    
    else if  (buttonTag==25) {
        [self buttontag27];
    }
    
    else if  (buttonTag==26) {
        [self buttontag28];
    }
    
    else if  (buttonTag==27) {
        [self buttontag30];
        
    }
    
    else if  (buttonTag==28) {
        [self buttontag31];
    }
    
    else if  (buttonTag==29) {
        
        [self buttontag32];
        
        
    }
    
    else if  (buttonTag==30) {
        [self buttontag34];
    }
    
    else if  (buttonTag==31) {
        [self buttontag36];
    }
    
    else if  (buttonTag==32) {
        [self buttontag37];
    }
    
    else if  (buttonTag==33) {
        [self buttontag38];
        
    }
    else if  (buttonTag==34) {
        [self buttontag39];
        
    }
    
    else if  (buttonTag==35) {
        [self buttontag40];
    }
    
    else if  (buttonTag==36) {
        [self buttontag41];
        
    }
    
    else if  (buttonTag==37) {
        [self buttontag42];
    }
    
    else if  (buttonTag==38) {
        [self buttontag43];
    }
    
    else if  (buttonTag==39) {
        [self buttontag44];
    }
    
    else if  (buttonTag==40) {
        
        [self buttontag45];
    }
    
    else if  (buttonTag==41) {
        
        [self buttontag46];
    }
    
    else if  (buttonTag==42) {
        
        [self buttontag47];
    }
    
    else if  (buttonTag==43) {
        [self buttontag48];
        
    }
    
    else if  (buttonTag==44) {
        [self buttontag49];
    }
    
    else if  (buttonTag==45) {
        [self buttontag50];
    }
    
    else if  (buttonTag==46) {
        [self buttontag51];
        
    }
    
    else if  (buttonTag==47) {
        [self buttontag52];
    }
    
    else if  (buttonTag==48) {
        [self buttontag53];
        
        
    }
    
    else if  (buttonTag==49) {
        
        [self buttontag54];
    }
    
    else if  (buttonTag==50) {
        [self buttontag55];
    }
    
    else if  (buttonTag==51) {
        [self buttontag56];
        
    }
    
    else if  (buttonTag==52) {
        [self buttontag57];
    }
    
    else if  (buttonTag==53) {
        [self buttontag58];
    }
    
    else if  (buttonTag==54) {
        [self buttontag59];
    }
    
    else if  (buttonTag==55) {
        [self buttontag60];
        
    }
    
    else if  (buttonTag==56) {
        [self buttontag61];
    }
    
    else if  (buttonTag==57) {
        [self buttontag62];
    }
    
    else if  (buttonTag==58) {
        [self buttontag63];
        
    }
    
    else if  (buttonTag==59) {
        [self buttontag64];
    }
    
    
    
    else if  (buttonTag==60) {
        
        [self buttontag66];
    }
    
    else if  (buttonTag==61) {
        [self buttontag67];
    }
    else if  (buttonTag==62) {
        [self buttontag68];
        
    }
    else if  (buttonTag==63) {
        [self buttontag69];
        
    }
    else if  (buttonTag==64) {
        [self buttontag70];
        
    }
    else if  (buttonTag==65) {
        [self buttontag71];
        
    }
    else if  (buttonTag==66) {
        [self buttontag72];
    }
    else if  (buttonTag==67) {
        [self buttontag73];
        
    }
    else if  (buttonTag==68) {
        [self buttontag74];
    }
    else if  (buttonTag==69) {
        [self buttontag75];
        
    }
    else if  (buttonTag==70) {
        [self buttontag76];
    }
    else if  (buttonTag==71) {
        [self buttontag77];
        
        
    }
    else if  (buttonTag==72) {
        [self buttontag78];
    }
    else if  (buttonTag==73) {
        [self buttontag79];
    }
    else if  (buttonTag==74) {
        [self buttontag80];
        
    }
    else if  (buttonTag==75) {
        [self buttontag81];
        
    }
    else if  (buttonTag==76) {
        [self buttontag82];
    }
    else if  (buttonTag==77) {
        [self buttontag83];
        
    }
    else if  (buttonTag==78) {
        [self buttontag84];
        
    }
    else if  (buttonTag==79) {
        [self buttontag85];
    }
    else if  (buttonTag==80) {
        [self buttontag86];
    }
    else if  (buttonTag==81) {
        [self buttontag87];
        
    }
    else if  (buttonTag==82) {
        [self buttontag88];
        
    }
    else if  (buttonTag==83) {
        [self buttontag89];
    }
    else if  (buttonTag==84) {
        [self buttontag90];
        
    }
    else if  (buttonTag==85) {
        [self buttontag91];
        
    }
    else if  (buttonTag==86) {
        [self buttontag92];
        
    }
    else if  (buttonTag==87) {
        [self buttontag93];
    }
    else if  (buttonTag==88) {
        [self buttontag94];
    }
    else if  (buttonTag==89) {
        
        [self buttontag95];
        
        
    }
    else if  (buttonTag==90) {
        [self buttontag96];
        
    }
    else if  (buttonTag==91) {
        [self buttontag98];
    }
    else if  (buttonTag==92) {
        [self buttontag99];
    }
    else if  (buttonTag==93) {
        [self buttontag100];
    }
    else if  (buttonTag==94) {
        
        [self buttontag101];
        
    }
    else if  (buttonTag==95) {
        
        [self buttontag102];
    }
    else if  (buttonTag==96) {
        
        [self buttontag103];
    }
    else if  (buttonTag==97) {
        [self buttontag104];
        
    }
    else if  (buttonTag==98) {
        [self buttontag105];
        
    }
    else if  (buttonTag==99) {
        [self buttontag106];
        
    }
    else if  (buttonTag==100) {
        [self buttontag107];
        
    }
    else if  (buttonTag==101) {
        [self buttontag108];
    }
    else if  (buttonTag==102) {
        [self buttontag109];
    }
    else if  (buttonTag==103) {
        [self buttontag110];
        
    }
    else if  (buttonTag==104) {
        [self buttontag111];
    }
    else if  (buttonTag==105) {
        [self buttontag112];
    }
    else if  (buttonTag==106) {
        [self buttontag113];
    }
    else if  (buttonTag==107) {
        [self buttontag114];
    }
    else if  (buttonTag==108) {
        
        [self buttontag115];
    }
    else if  (buttonTag==109) {
        [self buttontag116];
        
    }
    else if  (buttonTag==110) {
        [self buttontag117];
    }
    else if  (buttonTag==111) {
        [self buttontag118];
        
    }
    else if  (buttonTag==112) {
        [self buttontag119];
        
    }
    else if  (buttonTag==113) {
        [self buttontag120];
        
    }
    else if  (buttonTag==114) {
        [self buttontag121];
        
    }
    else if  (buttonTag==115) {
        [self buttontag122];
    }
    else if  (buttonTag==116) {
        
        [self buttontag124];
    }
    else if  (buttonTag==117) {
        [self buttontag125];
    }
    else if  (buttonTag==118) {
        [self buttontag126];
        
    }
    else if  (buttonTag==119) {
        [self buttontag127];
        
    }
    else if  (buttonTag==120) {
        [self buttontag128];
    }
    else if  (buttonTag==121) {
        [self buttontag129];
        
    }
    else if  (buttonTag==122) {
        [self buttontag130];
    }
    else if  (buttonTag==123) {
        [self buttontag131];
        
    }
    else if  (buttonTag==124) {
        [self buttontag132];
    }
    else if  (buttonTag==125) {
        
        [self buttontag133];
    }
    else if  (buttonTag==126) {
        [self buttontag134];
        
    }
    else if  (buttonTag==127) {
        [self buttontag135];
    }
    else if  (buttonTag==128) {
        [self buttontag136];
    }
    else if  (buttonTag==129) {
        [self buttontag137];
    }
    else if  (buttonTag==130) {
        [self buttontag139];
        
    }
    else if  (buttonTag==131) {
        [self buttontag140];
        
    }
    else if  (buttonTag==132) {
        [self buttontag141];
    }
    else if  (buttonTag==133) {
        [self buttontag142];
        
    }
    else if  (buttonTag==134) {
        [self buttontag143];
        
    }
    else if  (buttonTag==135) {
        [self buttontag144];
    }
    else if  (buttonTag==136) {
        [self buttontag145];
    }
    else if  (buttonTag==137) {
        [self buttontag146];
    }
    else if  (buttonTag==138) {
        [self buttontag147];
        
    }
    else if  (buttonTag==139) {
        [self buttontag149];
    }
    else if  (buttonTag==140) {
        [self buttontag150];
        
    }
    else if  (buttonTag==141) {
        [self buttontag151];
        
    }
    else if  (buttonTag==142) {
        [self buttontag152];
        
    }
    else if  (buttonTag==143) {
        [self buttontag153];
        
    }
    else if  (buttonTag==144) {
        [self buttontag154];
    }
    else if  (buttonTag==145) {
        [self buttontag155];
        
    }
    else if  (buttonTag==146) {
        [self buttontag156];
        
    }
    else if  (buttonTag==147) {
        [self buttontag157];
    }
    else if  (buttonTag==148) {
        [self buttontag158];
    }
    else if  (buttonTag==149) {
        [self buttontag159];
        
    }
    else if  (buttonTag==150) {
        [self buttontag160];
        
    }
    else if  (buttonTag==151) {
        [self buttontag161];
    }
    else if  (buttonTag==152) {
        [self buttontag162];
        
    }
    else if  (buttonTag==153) {
        
        [self buttontag165];
    }
    else if  (buttonTag==154) {
        [self buttontag166];
        
    }
    else if  (buttonTag==155) {
        [self buttontag167];
        
    }
    else if  (buttonTag==156) {
        [self buttontag168];
    }
    else if  (buttonTag==157) {
        
        [self buttontag169];
    }
    else if  (buttonTag==158) {
        [self buttontag170];
    }
    else if  (buttonTag==159) {
        [self buttontag171];
        
    }
    else if  (buttonTag==160) {
        [self buttontag172];
        
    }
    else if  (buttonTag==161) {
        [self buttontag174];
        
    }
    else if  (buttonTag==162) {
        [self buttontag175];
    }
    else if  (buttonTag==164) {
        [self buttontag177];
    }
    else if  (buttonTag==163) {
        [self buttontag178];
        
    }
    else if  (buttonTag==165) {
        [self buttontag179];
        
    }
    else if  (buttonTag==167) {
        
        [self buttontag180];
    }
    else if  (buttonTag==166) {
        
        [self buttontag181];
    }
    else if  (buttonTag==168) {
        
        [self buttontag182];
    }
    else if  (buttonTag==169) {
        [self buttontag183];
        
    }
    else if  (buttonTag==170) {
        
        [self buttontag184];
    }
    else if  (buttonTag==171) {
        [self buttontag185];
        
    }
    else if  (buttonTag==172) {
        [self buttontag186];
        
    }
    else if  (buttonTag==173) {
        
        [self buttontag187];
    }
    else if  (buttonTag==174) {
        [self buttontag188];
    }
    else if  (buttonTag==175) {
        [self buttontag189];
        
    }
    else if  (buttonTag==176) {
        [self buttontag190];
    }
    else if  (buttonTag==177) {
        [self buttontag191];
        
    }
    else if  (buttonTag==178) {
        
        [self buttontag192];
    }
    else if  (buttonTag==179) {
        [self buttontag193];
        
    }
    else if  (buttonTag==180) {
        
        [self buttontag194];
    }
    else if  (buttonTag==181) {
        
        [self buttontag195];
    }
    else if  (buttonTag==182) {
        [self buttontag196];
    }
    else if  (buttonTag==183) {
        [self buttontag198];
        
    }

    
    
    
    
}
else if ([name isEqualToString:@"HEALTHY MAINTENANCE"])
{
    if  (buttonTag==1) {
        
        
        [self buttontag1];
        
        
    }
    
    else if (buttonTag==2) {
        [self buttontag2];
        
    }
    
    else if  (buttonTag==3) {
        [self buttontag3];
        
        
    }
    else if  (buttonTag==4) {
        [self buttontag4];
        
        
    }
    else if  (buttonTag==5) {
        
        
        [self buttontag5];
        
    }
    
    else if  (buttonTag==6) {
        
        
        [self buttontag6];
        
    }
    
    
    else if  (buttonTag==7) {
        [self buttontag7];
        
    }
    
    else if  (buttonTag==8) {
        
        [self buttontag8];
    }
    
    else if  (buttonTag==9) {
        
        [self buttontag9];
        
    }
    
    else if  (buttonTag==10) {
        
        [self buttontag10];
        
        
    }
    
    else if  (buttonTag==11) {
        
        [self buttontag11];
        
        
    }
    
    else if  (buttonTag==12) {
        
        
        [self buttontag12];
        
    }
    
    else if  (buttonTag==13) {
        [self buttontag13];
        
    }
    
    else if  (buttonTag==14) {
        [self buttontag14];
        
    }
    
    else if  (buttonTag==15) {
        [self buttontag15];
        
    }
    //
    else if  (buttonTag==16) {
        [self buttontag16];
        
    }
    
    else if  (buttonTag==17) {
        [self buttontag17];
        
    }
    
    else if  (buttonTag==18) {
        [self buttontag18];
        
        
        
    }
    
    else if  (buttonTag==19) {
        [self buttontag19];
        
    }
    
    else if  (buttonTag==20) {
        
        [self buttontag20];
    }
    
    else if  (buttonTag==21) {
        [self buttontag21];
        
    }
    
    else if  (buttonTag==22) {
        [self buttontag22];
        
    }
    
    else if  (buttonTag==23) {
        
        [self buttontag23];
        
    }
    
    else if  (buttonTag==24) {
        
        [self buttontag24];
        
        
    }
    
    else if  (buttonTag==25) {
        [self buttontag25];
    }
    
    else if  (buttonTag==26) {
        [self buttontag26];
    }
    
    else if  (buttonTag==27) {
        [self buttontag27];
        
    }
    
    else if  (buttonTag==28) {
        [self buttontag28];
    }
    
    else if  (buttonTag==29) {
        
        [self buttontag32];
        
        
    }
    
    else if  (buttonTag==30) {
        [self buttontag30];
    }
    
    else if  (buttonTag==31) {
        [self buttontag31];
    }
    
    else if  (buttonTag==32) {
        [self buttontag33];
    }
    
    else if  (buttonTag==33) {
        [self buttontag34];
        
    }
    else if  (buttonTag==34) {
        [self buttontag35];
        
    }
    
    else if  (buttonTag==35) {
        [self buttontag36];
    }
    
    else if  (buttonTag==36) {
        [self buttontag37];
        
    }
    
    else if  (buttonTag==37) {
        [self buttontag38];
    }
    
    else if  (buttonTag==38) {
        [self buttontag39];
    }
    
    else if  (buttonTag==39) {
        [self buttontag40];
    }
    
    else if  (buttonTag==40) {
        
        [self buttontag41];
    }
    
    else if  (buttonTag==41) {
        
        [self buttontag42];
    }
    
    else if  (buttonTag==42) {
        
        [self buttontag43];
    }
    
    else if  (buttonTag==43) {
        [self buttontag44];
        
    }
    
    else if  (buttonTag==44) {
        [self buttontag45];
    }
    
    else if  (buttonTag==45) {
        [self buttontag46];
    }
    
    else if  (buttonTag==46) {
        [self buttontag47];
        
    }
    
    else if  (buttonTag==47) {
        [self buttontag48];
    }
    
    else if  (buttonTag==48) {
        [self buttontag49];
        
        
    }
    
    else if  (buttonTag==49) {
        
        [self buttontag50];
    }
    
    else if  (buttonTag==50) {
        [self buttontag51];
    }
    
    else if  (buttonTag==51) {
        [self buttontag52];
        
    }
    
    else if  (buttonTag==52) {
        [self buttontag53];
    }
    
    else if  (buttonTag==53) {
        [self buttontag54];
    }
    
    else if  (buttonTag==54) {
        [self buttontag55];
    }
    
    else if  (buttonTag==55) {
        [self buttontag56];
        
    }
    
    else if  (buttonTag==56) {
        [self buttontag57];
    }
    
    else if  (buttonTag==57) {
        [self buttontag58];
    }
    
    else if  (buttonTag==58) {
        [self buttontag59];
        
    }
    
    else if  (buttonTag==59) {
        [self buttontag60];
    }
    
    
    
    else if  (buttonTag==60) {
        
        [self buttontag61];
    }
    
    else if  (buttonTag==61) {
        [self buttontag62];
    }
    else if  (buttonTag==62) {
        [self buttontag63];
        
    }
    else if  (buttonTag==63) {
        [self buttontag64];
        
    }
    else if  (buttonTag==64) {
        [self buttontag65];
        
    }
    else if  (buttonTag==65) {
        [self buttontag66];
        
    }
    else if  (buttonTag==66) {
        [self buttontag68];
    }
    else if  (buttonTag==67) {
        [self buttontag69];
        
    }
    else if  (buttonTag==68) {
        [self buttontag70];
    }
    else if  (buttonTag==69) {
        [self buttontag71];
        
    }
    else if  (buttonTag==70) {
        [self buttontag72];
    }
    else if  (buttonTag==71) {
        [self buttontag73];
        
        
    }
    else if  (buttonTag==72) {
        [self buttontag74];
    }
    else if  (buttonTag==73) {
        [self buttontag75];
    }
    else if  (buttonTag==74) {
        [self buttontag76];
        
    }
    else if  (buttonTag==75) {
        [self buttontag77];
        
    }
    else if  (buttonTag==76) {
        [self buttontag78];
    }
    else if  (buttonTag==77) {
        [self buttontag79];
        
    }
    else if  (buttonTag==78) {
        [self buttontag80];
        
    }
    else if  (buttonTag==79) {
        [self buttontag81];
    }
    else if  (buttonTag==80) {
        [self buttontag82];
    }
    else if  (buttonTag==81) {
        [self buttontag83];
        
    }
    else if  (buttonTag==82) {
        [self buttontag84];
        
    }
    else if  (buttonTag==83) {
        [self buttontag85];
    }
    else if  (buttonTag==84) {
        [self buttontag86];
        
    }
    else if  (buttonTag==85) {
        [self buttontag87];
        
    }
    else if  (buttonTag==86) {
        [self buttontag88];
        
    }
    else if  (buttonTag==87) {
        [self buttontag89];
    }
    else if  (buttonTag==88) {
        [self buttontag90];
    }
    else if  (buttonTag==89) {
        
        [self buttontag91];
        
        
    }
    else if  (buttonTag==90) {
        [self buttontag92];
        
    }
    else if  (buttonTag==91) {
        [self buttontag93];
    }
    else if  (buttonTag==92) {
        [self buttontag94];
    }
    else if  (buttonTag==93) {
        [self buttontag95];
    }
    else if  (buttonTag==94) {
        
        [self buttontag96];
        
    }
    else if  (buttonTag==95) {
        
        [self buttontag97];
    }
    else if  (buttonTag==96) {
        
        [self buttontag98];
    }
    else if  (buttonTag==97) {
        [self buttontag99];
        
    }
    else if  (buttonTag==98) {
        [self buttontag100];
        
    }
    else if  (buttonTag==99) {
        [self buttontag101];
        
    }
    else if  (buttonTag==100) {
        [self buttontag102];
        
    }
    else if  (buttonTag==101) {
        [self buttontag103];
    }
    else if  (buttonTag==102) {
        [self buttontag104];
    }
    else if  (buttonTag==103) {
        [self buttontag105];
        
    }
    else if  (buttonTag==104) {
        [self buttontag106];
    }
    else if  (buttonTag==105) {
        [self buttontag107];
    }
    else if  (buttonTag==106) {
        [self buttontag108];
    }
    else if  (buttonTag==107) {
        [self buttontag109];
    }
    else if  (buttonTag==108) {
        
        [self buttontag110];
    }
    else if  (buttonTag==109) {
        [self buttontag111];
        
    }
    else if  (buttonTag==110) {
        [self buttontag112];
    }
    else if  (buttonTag==111) {
        [self buttontag113];
        
    }
    else if  (buttonTag==112) {
        [self buttontag114];
        
    }
    else if  (buttonTag==113) {
        [self buttontag115];
        
    }
    else if  (buttonTag==114) {
        [self buttontag116];
        
    }
    else if  (buttonTag==115) {
        [self buttontag117];
    }
    else if  (buttonTag==116) {
        
        [self buttontag118];
    }
    else if  (buttonTag==117) {
        [self buttontag119];
    }
    else if  (buttonTag==118) {
        [self buttontag120];
        
    }
    else if  (buttonTag==119) {
        [self buttontag121];
        
    }
    else if  (buttonTag==120) {
        [self buttontag122];
    }
    else if  (buttonTag==121) {
        [self buttontag123];
        
    }
    else if  (buttonTag==122) {
        [self buttontag124];
    }
    else if  (buttonTag==123) {
        [self buttontag125];
        
    }
    else if  (buttonTag==124) {
        [self buttontag126];
    }
    else if  (buttonTag==125) {
        
        [self buttontag127];
    }
    else if  (buttonTag==126) {
        [self buttontag128];
        
    }
    else if  (buttonTag==127) {
        [self buttontag129];
    }
    else if  (buttonTag==128) {
        [self buttontag130];
    }
    else if  (buttonTag==129) {
        [self buttontag131];
    }
    else if  (buttonTag==130) {
        [self buttontag132];
        
    }
    else if  (buttonTag==131) {
        [self buttontag133];
        
    }
    else if  (buttonTag==132) {
        [self buttontag134];
    }
    else if  (buttonTag==133) {
        [self buttontag135];
        
    }
    else if  (buttonTag==134) {
        [self buttontag136];
        
    }
    else if  (buttonTag==135) {
        [self buttontag137];
    }
    else if  (buttonTag==136) {
        [self buttontag138];
    }
    else if  (buttonTag==137) {
        [self buttontag139];
    }
    else if  (buttonTag==138) {
        [self buttontag140];
        
    }
    else if  (buttonTag==139) {
        [self buttontag141];
    }
    else if  (buttonTag==140) {
        [self buttontag142];
        
    }
    else if  (buttonTag==141) {
        [self buttontag143];
        
    }
    else if  (buttonTag==142) {
        [self buttontag144];
        
    }
    else if  (buttonTag==143) {
        [self buttontag145];
        
    }
    else if  (buttonTag==144) {
        [self buttontag146];
    }
    else if  (buttonTag==145) {
        [self buttontag147];
        
    }
    else if  (buttonTag==146) {
        [self buttontag148];
        
    }
    else if  (buttonTag==147) {
        [self buttontag149];
    }
    else if  (buttonTag==148) {
        [self buttontag150];
    }
    else if  (buttonTag==149) {
        [self buttontag151];
        
    }
    else if  (buttonTag==150) {
        [self buttontag152];
        
    }
    else if  (buttonTag==151) {
        [self buttontag153];
    }
    else if  (buttonTag==152) {
        [self buttontag154];
        
    }
    else if  (buttonTag==153) {
        
        [self buttontag155];
    }
    else if  (buttonTag==154) {
        [self buttontag156];
        
    }
    else if  (buttonTag==155) {
        [self buttontag157];
        
    }
    else if  (buttonTag==156) {
        [self buttontag158];
    }
    else if  (buttonTag==157) {
        
        [self buttontag159];
    }
    else if  (buttonTag==158) {
        [self buttontag160];
    }
    else if  (buttonTag==159) {
        [self buttontag161];
        
    }
    else if  (buttonTag==160) {
        [self buttontag162];
        
    }
    else if  (buttonTag==161) {
        [self buttontag163];
        
    }
    else if  (buttonTag==162) {
        [self buttontag164];
    }
    else if  (buttonTag==164) {
        [self buttontag166];
    }
    else if  (buttonTag==163) {
        [self buttontag165];
        
    }
    else if  (buttonTag==165) {
        [self buttontag167];
        
    }
    else if  (buttonTag==167) {
    
        [self buttontag169];
    }
    else if  (buttonTag==166) {
        
        [self buttontag168];
    }
    else if  (buttonTag==168) {
        
        [self buttontag170];
    }
    else if  (buttonTag==169) {
        [self buttontag171];
        
    }
    else if  (buttonTag==170) {
        
        [self buttontag172];
    }
    else if  (buttonTag==171) {
        [self buttontag173];
        
    }
    else if  (buttonTag==172) {
        [self buttontag174];
        
    }
    else if  (buttonTag==173) {
        
        [self buttontag175];
    }
    else if  (buttonTag==174) {
        [self buttontag176];
    }
    else if  (buttonTag==175) {
        [self buttontag177];
        
    }
    else if  (buttonTag==176) {
        [self buttontag178];
    }
    else if  (buttonTag==177) {
        [self buttontag179];
        
    }
    else if  (buttonTag==178) {
        
        [self buttontag180];
    }
    else if  (buttonTag==179) {
        [self buttontag181];
        
    }
    else if  (buttonTag==180) {
        
        [self buttontag182];
    }
    else if  (buttonTag==181) {
        
        [self buttontag183];
    }
    else if  (buttonTag==182) {
        [self buttontag184];
    }
    else if  (buttonTag==183) {
        [self buttontag185];
        
    }
    else if  (buttonTag==184) {
        [self buttontag186];
        
    }
    else if  (buttonTag==185) {
        [self buttontag187];
    }
    else if  (buttonTag==186) {
        [self buttontag188];
    }
    else if  (buttonTag==187) {
        [self buttontag189];
    }
    else if  (buttonTag==188) {
        [self buttontag190];
        
    }
    else if  (buttonTag==189) {
        [self buttontag191];
        
    }
    else if  (buttonTag==190) {
        [self buttontag192];
        
    }
    else if  (buttonTag==191) {
        [self buttontag193];
        
    }
    else if  (buttonTag==192) {
        [self buttontag194];
    }
    else if  (buttonTag==193) {
        [self buttontag195];
        
    }
    else if  (buttonTag==194) {
        [self buttontag196];
        
    }
    else if  (buttonTag==195) {
        [self buttontag198];
        
    }

    
    
    
    
    
    
}




}

-(void) addScrollview:(NSArray *)ingridients withServing:(NSString*)servingV withInstructions:(NSArray *)instructions andServingSize:(NSString *)servingSizeV havingImage:(UIImage *)product
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        
         descriptionScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,78,320,438)];
    }
    else
    {
    descriptionScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0,78,320,354)];
        
    }
        // this makes the scroll view - set the f }as the size you want to SHOW on the screen
    [descriptionScroll setBackgroundColor:[UIColor clearColor]];
    
  
        productImage=[[UIImageView alloc]initWithFrame:CGRectMake(0    , 0, 320, 200)];
        //[productImage setBackgroundColor:[UIColor blackColor]];
    [productImage setImage:product];
    [descriptionScroll addSubview:productImage];
    
    UIImageView *serving=[[UIImageView alloc]initWithFrame:CGRectMake(20, 213, 65, 13)];
    [serving setImage:[UIImage imageNamed:@"IM-servings.png"]];
    //[serving setBackgroundColor:[UIColor redColor]];
        [descriptionScroll addSubview:serving];
   
    
    
    UILabel *servingValue=[[UILabel alloc]initWithFrame:CGRectMake(87, 209, 27, 20)];
    servingValue.adjustsFontSizeToFitWidth=YES;
    
    [servingValue setFont:[UIFont systemFontOfSize:15]];
    servingValue.minimumFontSize=12;
    //NSString *ne=[[NSString alloc]initWithFormat:@"%d",servingV] ;
    servingValue.text=servingV;
    servingValue.textColor = [UIColor colorWithRed:0.1803f green:0.3137f blue:0.4078f alpha:1.0];
    
    [servingValue setBackgroundColor:[UIColor clearColor]];
    [descriptionScroll addSubview:servingValue];

    UIImageView *servingSize=[[UIImageView alloc]initWithFrame:CGRectMake(120, 213, 93, 13)];
   // [servingSize setBackgroundColor:[UIColor yellowColor]];
    [servingSize setImage:[UIImage imageNamed:@"IM-serving-size.png"]];
    [descriptionScroll addSubview:servingSize];
   
    
    
    
    UILabel *servingSizeValue=[[UILabel alloc]initWithFrame:CGRectMake(214, 204, 106, 30)];
    servingSizeValue.adjustsFontSizeToFitWidth=YES;
   
    [servingSizeValue setFont:[UIFont systemFontOfSize:15.5]];
     servingSizeValue.minimumFontSize=12;
    [servingSizeValue setBackgroundColor:[UIColor clearColor]];
     servingSizeValue.text=servingSizeV;
    servingSizeValue.textColor = [UIColor colorWithRed:0.1803f green:0.3137f blue:0.4078f alpha:1.0];
//    if ([name isEqualToString:@"ALL"])
//    {
//
//        if (buttonTag==69)
//        {
//            NSString *xyz=servingSizeV;
//            NSString *match = @"@-";
//
//            NSString *preTel;
//            NSString *postTel;
//
//            NSScanner *scanner = [NSScanner scannerWithString:xyz];
//            //  NSScanner *scanner = [NSScanner scannerWithString:xyz];
//            [scanner scanUpToString:match intoString:&preTel];
//
//            [scanner scanString:match intoString:nil];
//            postTel = [xyz substringFromIndex:scanner.scanLocation];
//
//
//            servingSizeValue.frame=CGRectMake(214, 208, 80, 12) ;
//            [servingSizeValue setFont:[UIFont systemFontOfSize:10]];
//            [servingSizeValue setBackgroundColor:[UIColor clearColor]];
//
//            UILabel *servingSizeValue2=[[UILabel alloc]initWithFrame:CGRectMake(214, 218, 80, 12)];
//            [servingSizeValue2 setFont:[UIFont systemFontOfSize:10]];
//            [servingSizeValue2 setBackgroundColor:[UIColor clearColor]];
//            servingSizeValue2.text=postTel;
//            [descriptionScroll addSubview:servingSizeValue2];
//
//
//        }
//    }
    //NSString *s=[[NSString alloc]initWithFormat:@"%f",servingSizeV] ;
    
    
    
    [descriptionScroll addSubview:servingSizeValue];

    
    
    UIImageView *ingridientsImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 238, 294, 26)];
    [ingridientsImage setImage:[UIImage imageNamed:@"IM_label_ingredients.png"]];
    //[ingridients setBackgroundColor:[UIColor greenColor]];
    [descriptionScroll addSubview:ingridientsImage];
    
    
    
    
    
    

        int y = 275;
        //[scrollview3 addSubview:label];
    for(int i = 0; i <[ingridients count] ; i ++)
        
    {
       
  
        UILabel *ingridientName=[[UILabel alloc]initWithFrame:CGRectMake(20, y, 260,25)];
       
        ingridientName.numberOfLines=6;
        
        ingridientName.text=[ingridients objectAtIndex:i];
        
        [ingridientName setBackgroundColor:[UIColor clearColor]];
        ingridientName.textColor = [UIColor colorWithRed:0.1803f green:0.3137f blue:0.4078f alpha:1.0];
        
        
         [ingridientName setFont:[UIFont systemFontOfSize:13.8f]];

        
        
        
        
        CGSize maximumLabelSize = CGSizeMake(250,9999);
         CGSize expectedLabelSize = [ingridientName.text sizeWithFont:ingridientName.font
                                           constrainedToSize:maximumLabelSize
                                               lineBreakMode:ingridientName.lineBreakMode];
       // [ingridientName setLineBreakMode:NSLineBreakByTruncatingTail];
        CGRect newFrame = ingridientName.frame;
        newFrame.size.height = expectedLabelSize.height;
        ingridientName.frame = newFrame;
         y=y+expectedLabelSize.height+8;
                     [descriptionScroll addSubview:ingridientName];
        
        
        
    }
    //NSLog(@"hint is %d",y);
    
    UIImageView *instructionsImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, y+5, 294, 26)];
    [instructionsImage setImage:[UIImage imageNamed:@"IM_label_instructions.png"]];
    //[instructions setBackgroundColor:[UIColor greenColor]];
    [descriptionScroll addSubview:instructionsImage];
    
    y=y+35;
   
    
    for(int i = 0; i < [instructions count] ; i ++)
        
        
        
    {
        NSString *new=[[NSString alloc]initWithFormat:@"%d.",i+1 ];
        UILabel *no=[[UILabel alloc]initWithFrame:CGRectMake(13, y+12, 20, 15)];
        [no setBackgroundColor:[UIColor clearColor]];
        no.text=new;
        no.textAlignment=UITextAlignmentRight;
        no.textColor = [UIColor colorWithRed:0.1803f green:0.3137f blue:0.4078f alpha:1.0];
        [no setFont:[UIFont boldSystemFontOfSize:14]];
         CGSize maximumLabelSize = CGSizeMake(250,9999);
        [descriptionScroll addSubview:no];
        
        
        UILabel *ingridientName=[[UILabel alloc]initWithFrame:CGRectMake(40, y+10, 250,30)];
        
        ingridientName.numberOfLines=6;
        
        ingridientName.text=[instructions objectAtIndex:i];
        
        [ingridientName setBackgroundColor:[UIColor clearColor]];
        ingridientName.textColor = [UIColor colorWithRed:0.1803f green:0.3137f blue:0.4078f alpha:1.0];
        [descriptionScroll addSubview:ingridientName];
        
        
        [ingridientName setFont:[UIFont systemFontOfSize:13.8f]];
        
        
        
        
       
        CGSize expectedLabelSize = [ingridientName.text sizeWithFont:ingridientName.font
                                                   constrainedToSize:maximumLabelSize
                                                       lineBreakMode:ingridientName.lineBreakMode ];
       // [ingridientName setLineBreakMode:NSLineBreakByTruncatingTail];
        CGRect newFrame = ingridientName.frame;
        newFrame.size.height = expectedLabelSize.height;
        ingridientName.frame = newFrame;
        y=y+expectedLabelSize.height+8;
        
    }
   // NSLog(@"hint 2 is %d",y);
    
    UIButton *addToMeal=[[UIButton alloc]initWithFrame:CGRectMake(110, y+13, 100, 34)];
    [addToMeal setImage:[UIImage imageNamed:@"IM-addtomeals.png"] forState:UIControlStateNormal];
    [addToMeal setImage:[UIImage imageNamed:@"IM-addtomeals-press.png"] forState:UIControlStateHighlighted];
    [addToMeal addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
     [addToMeal addTarget:self action:@selector(addToCalendar) forControlEvents:UIControlEventTouchUpInside];
   // [addToMeal setBackgroundColor:[UIColor purpleColor]];
    
    [descriptionScroll addSubview:addToMeal];
    
    y=y+34;
    
    
    
    descriptionScroll.contentSize = CGSizeMake(30,y+18);
    
    //[scrollview3 setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    
    [self.view addSubview:descriptionScroll];
    
    
    
    
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabbarItem==YES) {
        return NO;
    }
    
    //tabbarItem=NO;
    
    return YES;
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
    tabbarItem=YES;
    [[NSUserDefaults standardUserDefaults]setBool:tabbarItem forKey:@"tabItem"];
    [[NSUserDefaults standardUserDefaults ]synchronize];
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
    tabbarItem=NO;
    [[NSUserDefaults standardUserDefaults]setBool:tabbarItem forKey:@"tabItem"];
    [[NSUserDefaults standardUserDefaults ]synchronize];

    NSString * latestDate=[[NSString alloc]initWithFormat:@"%@",[datePickerLabel text] ];
    NSString * latestMeal=[[NSString alloc]initWithFormat:@"%@",[mealPicker text] ];
    [[NSUserDefaults standardUserDefaults]setObject:latestDate forKey:@"latest"];
    [[NSUserDefaults standardUserDefaults]setObject:latestMeal forKey:@"meal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [pickerBase removeFromSuperview];
    [datePicker removeFromSuperview];
    [inputAccView removeFromSuperview];
    [cityPicker removeFromSuperview];
}
-(void)initialiseMealPicker
{ tabbarItem=YES;
    [[NSUserDefaults standardUserDefaults]setBool:tabbarItem forKey:@"tabItem"];
    [[NSUserDefaults standardUserDefaults ]synchronize];
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



-(void)addToCalendar
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"dateSelector"]==NO) {
        
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
            
           [Flurry logEvent:@"Add to Meals(recipies) Button Pressed"];
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
            
            [Flurry logEvent:@"Add to Meals(recipies) Button Pressed"];
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
        
        [self addToDatabase];
    }
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"dateSelector"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
  [Flurry logEvent:@"Add to Meals(recipie) Button Pressed"];
    
}
    
    
 -(void)addToDatabase
{
    NSString *arrayString=[recipieName text];
    //NSLog(@"%@",arrayString);
    
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
    tabbarItem=NO;
    [[NSUserDefaults standardUserDefaults]setBool:tabbarItem forKey:@"tabItem"];
    [[NSUserDefaults standardUserDefaults ]synchronize];
    [selection removeFromSuperview];
      //[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.4]];
   // [self.navigationController popViewControllerAnimated:YES];
    
    
    
  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ADDED" message:@"Recipe added to calendar." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
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
-(void)back
{
    [selection removeFromSuperview];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}


-(void)buttonPressed


{   //quantity=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<[groceryArray count];i++)
    {
        
        NSString *xyz=[groceryArray objectAtIndex:i];
        NSString *match = @"+=";
        
        NSString *preTelTest;
        NSString *postTel;
        
        NSScanner *scanner = [NSScanner scannerWithString:xyz];
        //  NSScanner *scanner = [NSScanner scannerWithString:xyz];
        [scanner scanUpToString:match intoString:&preTelTest];
        
        [scanner scanString:match intoString:nil];
        postTel = [xyz substringFromIndex:scanner.scanLocation];
        //NSLog(@"posttel:%@ ",postTel);
        NSString *match2=@"@#";
        NSString *preTel;
        NSString *post;
        NSString *newstring;
        NSScanner *scanner2 = [NSScanner scannerWithString:preTelTest];
        
        [scanner2 scanUpToString:match2 intoString:&preTel];
        
        [scanner2 scanString:match2 intoString:nil];
        post = [preTelTest substringFromIndex:scanner2.scanLocation];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"space"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if ([preTel isEqualToString:@"nil"]) {
            preTel=@"";
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"space"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        if ([preTel isEqualToString:@"nil1"]) {
            preTel=@"";
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"toTaste"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"space"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"space" ] ==YES)
        {
            newstring =[[preTel stringByAppendingString:@""]stringByAppendingString:post];
        }
        else
        {
            newstring =[[preTel stringByAppendingString:@" "]stringByAppendingString:post];
            
            
        }
        [ingrdArray addObject:newstring];
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"toTaste"]==YES) {
            
            preTel=@"to taste";
            post=[post stringByReplacingOccurrencesOfString:@", to taste" withString:@""];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"toTaste"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
        //NSLog(@"pretel %@",preTel);
        quantity=[[NSMutableArray alloc]init];
        quantityName=[[NSMutableArray alloc]init];
//       [quantity addObject:preTel];
//        [quantityName addObject:post];
        
       // NSLog(@"hhhhh%@",postTel);
         if ([postTel isEqualToString:@"prd"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
            //            [produce addObject:post];
            //            [produceqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"produce"];
            
        }

       else if ([postTel isEqualToString:@"ssn"]) {
            
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [seasoning addObject:post];
//            [seasoningqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"seasoning"];
            
       }else if ([postTel isEqualToString:@"veg"]) {
           
           [quantity addObject:preTel];
           [quantityName addObject:post];
           //            [seasoning addObject:post];
           //            [seasoningqty addObject:preTel];
           type=[[NSString alloc]initWithFormat:@"vegetarian"];
           
       }
       else if ([postTel isEqualToString:@"dl"]) {
           
           [quantity addObject:preTel];
           [quantityName addObject:post];
           //            [seasoning addObject:post];
           //            [seasoningqty addObject:preTel];
           type=[[NSString alloc]initWithFormat:@"deli"];
           
       }


            else  if ([postTel isEqualToString:@"bak"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [baking addObject:post];
//            [bakingqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"baking"];
            
        }
        else if ([postTel isEqualToString:@"iwm"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [iwm addObject:post];
//            [iwmqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"iwm store"];
            
        }
       else if ([postTel isEqualToString:@"dry"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [dairy addObject:post];
//            [dairyqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"dairy"];
            
        }
       else if ([postTel isEqualToString:@"prt"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [protein addObject:post];
//            [proteinqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"protein"];
            
        }
       else if ([postTel isEqualToString:@"grn"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [grains addObject:post];
//            [grainsqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"grains"];
            
        }
       else if ([postTel isEqualToString:@"tpn"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [toppings addObject:post];
//            [toppingsqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"toppings"];
            
        }
       else if ([postTel isEqualToString:@"meat"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [meat addObject:post];
//            [meatqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"meat"];
            
        }
       else if ([postTel isEqualToString:@"eth"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [ethnic addObject:post];
//            [ethnicqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"ethnic"];
            
        }
       else if ([postTel isEqualToString:@"nts"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [nuts addObject:post];
//            [nutsqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"nuts"];
            
        }
       else if ([postTel isEqualToString:@"sac"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [sauces addObject:post];
//            [saucesqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"sauces"];
            
        }
       else if ([postTel isEqualToString:@"sf"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [seafood addObject:post];
//            [seafoodqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"sea food"];
            
        }
       else if ([postTel isEqualToString:@"cnd"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [condiments addObject:post];
//            [condimentsqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"condiments"];
            
        }
       else if ([postTel isEqualToString:@"frz"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [freezer addObject:post];
//            [freezerqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"freezer"];
            
        }
       else if ([postTel isEqualToString:@"hlt"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [health addObject:post];
//            [healthqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"health"];
            
        }
      else  if ([postTel isEqualToString:@"wtr"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
            //[water addObject:post];
           // [waterqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"water"];
            
        }
      else  if ([postTel isEqualToString:@"tc"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [tea addObject:post];
//            [teaqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"tea/coffee"];
            
        }
       else if ([postTel isEqualToString:@"wf"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [waldenfarms addObject:post];
//            [waldenfarmsqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"walden farms"];
            
        }
      else  if ([postTel isEqualToString:@"cg"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [canned addObject:post];
//            [cannedqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"canned goods"];
            
        }
      else  if ([postTel isEqualToString:@"othr"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [other addObject:post];
//            [otherqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"other"];
            
        }
       else if ([postTel isEqualToString:@"bf"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [breakfast addObject:post];
//            [breakfastqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"breakfast"];
            
        }
       else if ([postTel isEqualToString:@"drs"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [dressing addObject:post];
//            [dressingqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"dressing"];
            
        }
       else if ([postTel isEqualToString:@"frzn"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [frozen addObject:post];
//            [frozenqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"frozen"];
            
        }
       else if ([postTel isEqualToString:@"pst"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [pasta addObject:post];
//            [pastaqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"pasta"];
            
            
        }
       else if ([postTel isEqualToString:@"brt"]) {
            [quantity addObject:preTel];
            [quantityName addObject:post];
//            [broth addObject:post];
//            [brothqty addObject:preTel];
            type=[[NSString alloc]initWithFormat:@"broth"];
            
        }
        

    
    
   

   // NSDate *theDate=[NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
   // NSString* serverDate = [dateFormatter stringFromDate:theDate];
        NSString *recipie=[[NSString alloc]initWithFormat:@"%@",[quantityName objectAtIndex:0] ];
        
    NSString *recipieQty=[[NSString alloc]initWithFormat:@"%@",[quantity objectAtIndex:0] ];
       // NSLog(@"%@",recipieQty);
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO info('Type','Name','Quantity')VALUES ('%@','%@','%@')",type,recipie,recipieQty];
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        
        sqlite3_close(db);
        NSAssert(0, @"could not update table");
        
        }
    
       
    }

   }
-(void)viewDidUnload
{
    NSMutableArray *instr=[NSMutableArray arrayWithArray:instrArray];
    [instr removeAllObjects];
    NSMutableArray *grocery=[NSMutableArray arrayWithArray:groceryArray];
    [grocery removeAllObjects];
    NSMutableArray *names=[NSMutableArray arrayWithArray:nameArray];
    [names removeAllObjects];
    
}

@end
