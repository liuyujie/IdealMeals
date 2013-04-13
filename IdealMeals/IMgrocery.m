//
//  IMSecondViewController.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 17/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMgrocery.h"
#import "SVProgressHUD.h"
#define SectionHeaderHeight 21
@interface IMgrocery()

@end

@implementation IMgrocery
@synthesize Bool,nameOfIngridient,ingridientQuantity,saveButton,menuView,emailButtonGrocery,clearButtonGrocery,addButtonGrocery;

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    { if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"grocery-2.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"grocery.png"]];
    }else
    {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IM_i5_icons_0009_GROCERY.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"IM_i5_icons_0008_GROCERY-copy.png"]];    }}
    return self;
}






-(NSString *)filePath{
    
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    return[[paths objectAtIndex:0]stringByAppendingPathComponent:@"idealmeals.sql"];

}





-(void) openDB {
    
    if (sqlite3_open([[self filePath] UTF8String], &db)!= SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database Failed to Open");
        
    }
    else{
    
        //NSLog(@"Database Opened");
    }
}

- (void)viewDidLoad
{
     [self showActivityIndicater];
    
    emailArray=[[NSMutableArray alloc]init];
     [self openDB];
      [self createTable:@"info" withField1:@"No" withField2:@"Type" withField3:@"Name" withField4:@"Quantity"];
    
   
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)allocation
{
    [listTable removeFromSuperview];
    allArray=[[NSMutableArray alloc]init];
    
    done=[[NSMutableArray alloc]init];
    doneQty=[[NSMutableArray alloc]init];
     doneNo=[[NSMutableArray alloc]init];
    
    vegetarian=[[NSMutableArray alloc]init];
    vegetarianqty=[[NSMutableArray alloc]init];
    vegetarianNo=[[NSMutableArray alloc]init];
    
    deli=[[NSMutableArray alloc]init];
    deliqty=[[NSMutableArray alloc]init];
    deliNo=[[NSMutableArray alloc]init];
    
    seasoning=[[NSMutableArray alloc]init];
    seasoningqty=[[NSMutableArray alloc]init];
    seasoningNo=[[NSMutableArray alloc]init];
    
    produce=[[NSMutableArray alloc]init];
    produceqty=[[NSMutableArray alloc]init];
    produceNo=[[NSMutableArray alloc]init];
    
    baking=[[NSMutableArray alloc]init];
    bakingqty=[[NSMutableArray alloc]init];
     bakingNo=[[NSMutableArray alloc]init];
    
    iwm=[[NSMutableArray alloc]init];
    iwmqty=[[NSMutableArray alloc]init];
    iwmNo=[[NSMutableArray alloc]init];
    
    dairy=[[NSMutableArray alloc]init];
    dairyqty=[[NSMutableArray alloc]init];
    dairyNo=[[NSMutableArray alloc]init];
    
    protein=[[NSMutableArray alloc]init];
    proteinqty=[[NSMutableArray alloc]init];
    proteinNo=[[NSMutableArray alloc]init];
    
    grains=[[NSMutableArray alloc]init];
    grainsqty=[[NSMutableArray alloc]init];
    grainsNo=[[NSMutableArray alloc]init];
    
    toppings=[[NSMutableArray alloc]init];
    toppingsqty=[[NSMutableArray alloc]init];
    toppingsNo=[[NSMutableArray alloc]init];
    
    meat=[[NSMutableArray alloc]init];
    meatqty=[[NSMutableArray alloc]init];
    meatNo=[[NSMutableArray alloc]init];
    
    ethnic=[[NSMutableArray alloc]init];
    ethnicqty=[[NSMutableArray alloc]init];
    ethnicNo=[[NSMutableArray alloc]init];
    
    nuts=[[NSMutableArray alloc]init];
    nutsqty=[[NSMutableArray alloc]init];
     nutsNo=[[NSMutableArray alloc]init];
    
    sauces=[[NSMutableArray alloc]init];
    saucesqty=[[NSMutableArray alloc]init];
    saucesNo=[[NSMutableArray alloc]init];
    
    seafood=[[NSMutableArray alloc]init];
    seafoodqty=[[NSMutableArray alloc]init];
    seafoodNo=[[NSMutableArray alloc]init];
    
    condiments=[[NSMutableArray alloc]init];
    condimentsqty=[[NSMutableArray alloc]init];
    condimentsNo=[[NSMutableArray alloc]init];
    
    freezer=[[NSMutableArray alloc]init];
    freezerqty=[[NSMutableArray alloc]init];
    freezerNo=[[NSMutableArray alloc]init];
    
    health=[[NSMutableArray alloc]init];
    healthqty=[[NSMutableArray alloc]init];
    healthNo=[[NSMutableArray alloc]init];
    
    water=[[NSMutableArray alloc]init];
    waterqty=[[NSMutableArray alloc]init];
     waterNo=[[NSMutableArray alloc]init];
    
    tea=[[NSMutableArray alloc]init];
    teaqty=[[NSMutableArray alloc]init];
     teaNo=[[NSMutableArray alloc]init];
    
    waldenfarms=[[NSMutableArray alloc]init];
    waldenfarmsqty=[[NSMutableArray alloc]init];
    waldenfarmsNo=[[NSMutableArray alloc]init];
    
    canned=[[NSMutableArray alloc]init];
    cannedqty=[[NSMutableArray alloc]init];
     cannedNo=[[NSMutableArray alloc]init];
    
    other=[[NSMutableArray alloc]init];
    otherqty=[[NSMutableArray alloc]init];
     otherNo=[[NSMutableArray alloc]init];
    
    breakfast=[[NSMutableArray alloc]init];
    breakfastqty=[[NSMutableArray alloc]init];
    breakfastNo=[[NSMutableArray alloc]init];
    
    dressing=[[NSMutableArray alloc]init];
    dressingqty=[[NSMutableArray alloc]init];
    dressingNo=[[NSMutableArray alloc]init];
    
    frozen=[[NSMutableArray alloc]init];
    frozenqty=[[NSMutableArray alloc]init];
     frozenNo=[[NSMutableArray alloc]init];
    
    pasta=[[NSMutableArray alloc]init];
    pastaqty=[[NSMutableArray alloc]init];
    pastaNo=[[NSMutableArray alloc]init];
    
    broth=[[NSMutableArray alloc]init];
    brothqty=[[NSMutableArray alloc]init];
    brothNo=[[NSMutableArray alloc]init];
    
    
    products=[[NSMutableArray alloc]init];
    productsQty=[[NSMutableArray alloc]init];
    productsNo=[[NSMutableArray alloc]init];
    
     array3=[[NSMutableArray alloc]init];
    
    [self.view addSubview:listTable];

}


-(void)viewWillAppear:(BOOL)animated
{
    
    [addButtonGrocery setExclusiveTouch:YES];
    [clearButtonGrocery setExclusiveTouch:YES];
    [emailButtonGrocery setExclusiveTouch:YES];
    [self showActivityIndicater];
    [self.tabBarController setDelegate:self ];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
          listTable =[[UITableView alloc]initWithFrame:CGRectMake(15, 104, 290, 397)];
    }
    else
    {
    listTable =[[UITableView alloc]initWithFrame:CGRectMake(12, 100, 296, 320)];
    }
    [listTable setBackgroundColor:[UIColor lightGrayColor]];
    listTable.delegate=self;
    listTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    // [listTable setSeparatorColor:[UIColor lightGrayColor]];
    listTable.dataSource=self;
//    UIImageView *frame=[[UIImageView alloc ]initWithFrame:CGRectMake(10, 97, 300, 326)];
//    [frame setImage:[UIImage imageNamed:@"IM_grocerylist_listbox_frame-overlay.png" ]];
    
    //[listTable setShowsVerticalScrollIndicator:NO ];
    [self.view addSubview:listTable];
   // [self.view addSubview:frame];

   // CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        frame=[[UIImageView alloc ]initWithFrame:CGRectMake(12, 100, 296, 405)];
        [frame setImage:[UIImage imageNamed:@"IM_i5_grocery-list_overlay.png" ]];

    }
    else{
        frame=[[UIImageView alloc ]initWithFrame:CGRectMake(8, 95, 302, 326)];
        [frame setImage:[UIImage imageNamed:@"IM_grocerylist_listbox_frame-overlay.png" ]];

    }
       [self.view addSubview:frame];
    UIStoryboardSegue *segue;
    IMProductList *vc = [segue destinationViewController];
    
    [vc.products removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:vc.products forKey:@"productArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   // NSLog(@"%@hhhh",vc.products);
    [self newfunction];
    [self hideActivityIndicater];
    
    
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
-(void)newfunction
{
   
    
    
    [self openDB];
    [self allocation];
    [self allOnALL];
    [self firstFunction];
    [self produceDataLoading];
    [self bakingDataLoading];
    [self seasoningDataLoading];
    [self iwmDataLoading];
    [self dairyDataLoading];
    [self proteinDataLoading];
    [self grainsDataLoading];
    [self toppingsDataLoading];
    [self meatDataLoading];
    [self ethnicDataLoading];
    [self nutsDataLoading];
    [self saucesDataLoading];
    [self seafoodDataLoading];
    [self condimentsDataLoading];
    [self freezerDataLoading ];
    [self healthDataLoading];
    [self waterDataLoading];
    [self tcDataLoading  ];
    [self wfDataLoading  ];
    [self cgDataLoading  ];
    [self otherDataLoading  ];
    [self breakfastDataLoading  ];
    [self dressingDataLoading  ];
    [self frozenDataLoading  ];
    [self pastaDataLoading  ];
    [self brothDataLoading  ];
    [self vegDataLoading  ];
    [self dlDataLoading];
    [self doneDataLoading];
    [self check];
    //[self load];
    [self noItemsAdded];
    

    
    [listTable reloadData];

  //  [self hideActivityIndicater];
}
-(void)load
{
        // dic = [[NSMutableDictionary alloc]init];

    
    self.Bool = [[NSMutableArray alloc]init];
    for (int k=0; k<productArray.count; k++)
    {
        NSDictionary *dictionary = [productArray objectAtIndex:k];
        array = [dictionary objectForKey:@"PRODUCTS"];
        sectionArray = [[NSMutableArray alloc]init];
        for(int g=0;g< array.count;g++)
        {
            NSString *check = @"check";
            [sectionArray addObject:check];
        }
        [self.Bool addObject:sectionArray];
    }
    

   // NSLog(@"%@",self.Bool);
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
        
        
        //NSLog(@"table created");
        
    }
    
}

-(void)allOnALL
{
NSString *sql=[NSString stringWithFormat:@"SELECT   Name,Quantity,No  FROM info ORDER BY Name COLLATE NOCASE ASC"];
sqlite3_stmt  *statement;
    

if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
    while (sqlite3_step(statement)==SQLITE_ROW) {
        
        
        
        
        
        char *field3=(char *) sqlite3_column_text(statement, 0);
        NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
        
        char *field4=(char *) sqlite3_column_text(statement, 1);
        NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
        
        char *field1=(char *) sqlite3_column_text(statement, 2);
        NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
        
        
        
        //NSString *str= [[NSString alloc] initWithFormat:@"%@/%@-%@", field2Str,field3Str,field4Str];
        [allArray addObject:field3Str];
        [allQuantityArray addObject:field4Str];
         [allArrayNo addObject:field1Str];
        
        }

    }
//    for(int g=0;g<[allArray count];g++)
//    {
//int occurrences = 0;
//for(NSString *string in allArray){
//    
//    occurrences += ([string isEqualToString:[allArray objectAtIndex:g] ]?1:0);
//}
////NSLog(@"number of occurences %d", occurrences);
//    }

}

-(void)firstFunction
{
     
    NSMutableArray *locations;
    for(int q=0;q<[allArray count];q++)
    {
        locations=[[NSMutableArray alloc]init];
        NSString *sql=[NSString stringWithFormat:@"SELECT * FROM info WHERE NAME IS '%@'",[allArray objectAtIndex:q]];
        sqlite3_stmt  *statement;
        
        
        if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
        {
            while (sqlite3_step(statement)==SQLITE_ROW)
            {
                char *field1=(char *) sqlite3_column_text(statement, 0);
                NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
                
                
                [locations addObject:field1Str];
            }
        }
        int occurrences = 0;
        for(NSString *string in allArray){
            
            occurrences += ([string isEqualToString:[allArray objectAtIndex:q] ]?1:0);
        }
    q=q+occurrences-1;
    
        
    
    NSMutableArray *newQuantity=[[NSMutableArray alloc]init];
 
        
   // NSLog(@"locations are %@",locations );
        
        for(int t=0;t<[locations count];t++)
        {
            NSString *sql=[NSString stringWithFormat:@"SELECT Quantity FROM info WHERE No IS '%@'",[locations objectAtIndex:t]];
            sqlite3_stmt  *statement;
            
            
            if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
            {
                while (sqlite3_step(statement)==SQLITE_ROW)
                {
               
                    char *field1=(char *) sqlite3_column_text(statement, 0);
                    NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
                    
                    [newQuantity addObject:field1Str];
                }
            }
            
           

        }
    // NSLog(@"%@",newQuantity);
        
        
        
        NSMutableString *val2=[[NSMutableString alloc]init];
       
        for (int r=0;r<[newQuantity count];r++)
        {
            
           
            
            //for(int g=0;g<[newQuantity count];g++)
            //{
                int occurrences = 0;
            for(NSString *string in newQuantity)
            {
                //NSLog(@"%d",r);
                
                occurrences += ([string isEqualToString:[newQuantity objectAtIndex:r] ]?1:0);
            
            
            }
                r=r+occurrences-1;
                //NSLog(@"###%d",occurrences);
                
           
               

            
            //}
        }
        bool p=YES;
        NSString *val;
         for (int r=1; r<[locations count]; r++) {
       val =[[NSString alloc]initWithFormat:@"%@",[newQuantity objectAtIndex:r] ];
            
             NSString *newString=[[NSString alloc]initWithFormat:@"%@",[newQuantity objectAtIndex:0]];
             
             if (p==YES) {
                 [val2 appendString:newString];
             }
             p=NO;
             
             
             
             //NSLog(@"hhh: %@",val);
             if ([newQuantity count]>1)
             {
            [val2 appendString:@","];
        }
        
             
             
        [val2 appendString:val];
          //NSLog(@"%@",val2);
             
         }
        
        if ([locations count]>1)
        {
           // [val2 appendString:@","];
            //[val2 appendString:val];
            
            //NSLog(@"66%@",val2);
            
            if ([val2 isEqualToString:@","]) {
                [val2 setString:@""];
            
            }
            if ([val2 isEqualToString:@",,"]) {
                [val2 setString:@""];
                
            }

            if ([val2 isEqualToString:@",,,"]) {
                [val2 setString:@""];
                
            }
            if ([val2 isEqualToString:@",,,,"]) {
                [val2 setString:@""];
                
            }
            if ([val2 isEqualToString:@",,,,,"]) {
                [val2 setString:@""];
                
            }
            if ([val2 isEqualToString:@",,,,,,"]) {
                [val2 setString:@""];
                
            }
            if ([val2 isEqualToString:@",,,,,,,"]) {
                [val2 setString:@""];
                
            }
            if ([val2 isEqualToString:@",,,,,,,"]) {
                [val2 setString:@""];
                
            }
            if ([val2 isEqualToString:@",,,,,,,,,"]) {
                [val2 setString:@""];
                
            }

            NSString *insertSQL=[NSString stringWithFormat:@"UPDATE info SET Quantity=('%@') WHERE No IS '%@'",val2,[locations objectAtIndex:0]];
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
                    NSString *insertSQL=[NSString stringWithFormat:@"UPDATE info SET Quantity=('%@') WHERE No IS '%@'",[newQuantity objectAtIndex:0],[locations objectAtIndex:0]];
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
            
            //NSLog(@"%@",@"failed");
            
        }
        
        }
        
    
    
    
    
   // NSLog(@"new locations:%@",locations);
            
        for (int y=1; y<[locations count]; y++) {
            
        
        
//       NSString *rowSQL=[NSString stringWithFormat:@"DELETE FROM info WHERE No= %@",[locations objectAtIndex:y]];
//        sqlite3_stmt  *statement2;
//            if (sqlite3_prepare(db, [rowSQL UTF8String], -1, &statement2, nil)==SQLITE_OK) {            
//             NSLog(@"uuuuuu %@",[locations objectAtIndex:0]);
        
            
            //}
            NSString *insertSQL=[NSString stringWithFormat:@"DELETE FROM info WHERE No= %@",[locations objectAtIndex:y]];
            sqlite3_stmt  *statement1;
            
            
            
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(db, insert_stmt,
                               -1, &statement1, NULL);
            if (sqlite3_step(statement1) == SQLITE_DONE)
            {
                //NSLog(@"%@",@"contact added");
                
            }
            
            else
                
            {
                
               // NSLog(@"%@",@"failed");
               
            }

            
            
            
            
        }
        
        
    }
    }
        




-(void)produceDataLoading
{
   // NSString *sql=[NSString stringWithFormat:@"SELECT DISTINCT * FROM info "];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM info WHERE Type IS 'produce' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
           
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            
            
            //NSString *str= [[NSString alloc] initWithFormat:@"%@/%@-%@", field2Str,field3Str,field4Str];
            [produce addObject:field3Str];
            [produceqty addObject:field4Str];
            [produceNo addObject:field0Str];
           //NSLog(@"%@",produceNo);
            
        }
    }

}
-(void)bakingDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM info WHERE Type IS 'baking' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            [bakingNo addObject:field0Str];
            
            //NSString *str= [[NSString alloc] initWithFormat:@"%@/%@-%@", field2Str,field3Str,field4Str];
            [baking addObject:field3Str];
            [bakingqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)seasoningDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'seasoning' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            
            [seasoningNo addObject:field0Str];
            [seasoning addObject:field3Str];
            [seasoningqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)iwmDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'iwm store' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            
            [iwmNo addObject:field0Str];
            [iwm addObject:field3Str];
            [iwmqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)dairyDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'dairy' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            
            [dairyNo addObject:field0Str];
            [dairy addObject:field3Str];
            [dairyqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)proteinDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'protein' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [proteinNo addObject:field0Str];
            [protein addObject:field3Str];
            [proteinqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)grainsDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'grains' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [grainsNo addObject:field0Str];
            [grains addObject:field3Str];
            [grainsqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)toppingsDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM info WHERE Type IS 'toppings' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [toppingsNo addObject:field0Str];
            [toppings addObject:field3Str];
            [toppingsqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)meatDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'meat' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [meatNo addObject:field0Str];
            [meat addObject:field3Str];
            [meatqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)ethnicDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'ethnic' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [ethnicNo addObject:field0Str];
            [ethnic addObject:field3Str];
            [ethnicqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)nutsDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'nuts' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [nutsNo addObject:field0Str];
            [nuts addObject:field3Str];
            [nutsqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)saucesDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'sauces' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [saucesNo addObject:field0Str];
            [sauces addObject:field3Str];
            [saucesqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)seafoodDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'sea food' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [seafoodNo addObject:field0Str];
            [seafood addObject:field3Str];
            [seafoodqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)condimentsDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'condiments' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [condimentsNo addObject:field0Str];
            [condiments addObject:field3Str];
            [condimentsqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)freezerDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'freezer' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [freezerNo addObject:field0Str];
            [freezer addObject:field3Str];
            [freezerqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)healthDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'health' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [healthNo addObject:field0Str];
            [health addObject:field3Str];
            [healthqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)waterDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'water' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [waterNo addObject:field0Str];
            [water addObject:field3Str];
            [waterqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)tcDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'tea/coffee' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [teaNo addObject:field0Str];
            [tea addObject:field3Str];
            [teaqty addObject:field4Str];
            
            
        }
    }
   // NSLog(@"%@",tea);
}
-(void)wfDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM info WHERE Type IS 'walden farms' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [waldenfarmsNo addObject:field0Str];
            [waldenfarms addObject:field3Str];
            [waldenfarmsqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)cgDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'canned goods' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [cannedNo addObject:field0Str];
            [canned addObject:field3Str];
            [cannedqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)otherDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM info WHERE Type IS 'other' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [otherNo addObject:field0Str];
            [other addObject:field3Str];
            [otherqty addObject:field4Str];
            
            
        }
    }
    //NSLog(@"%@",other);
    
}
-(void)breakfastDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'breakfast' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [breakfastNo addObject:field0Str];
            [breakfast addObject:field3Str];
            [breakfastqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)dressingDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'dressing' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [dressingNo addObject:field0Str];
            [dressing addObject:field3Str];
            [dressingqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)frozenDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'frozen' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [frozenNo addObject:field0Str];
            [frozen addObject:field3Str];
            [frozenqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)pastaDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'pasta' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [pastaNo addObject:field0Str];
            [pasta addObject:field3Str];
            [pastaqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)brothDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'broth' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [brothNo addObject:field0Str];
            [broth addObject:field3Str];
            [brothqty addObject:field4Str];
            
            
        }
    }
    
}





-(void)vegDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'vegetarian' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [vegetarianNo addObject:field0Str];
            [vegetarian addObject:field3Str];
            [vegetarianqty addObject:field4Str];
            
            
        }
    }
    
}
-(void)dlDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'deli' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [deliNo addObject:field0Str];
            [deli addObject:field3Str];
            [deliqty addObject:field4Str];
            
            
        }
    }
    
}

-(void)doneDataLoading
{
    NSString *sql=[NSString stringWithFormat:@"SELECT *  FROM info WHERE Type IS 'done' ORDER BY Name COLLATE NOCASE ASC"];
    sqlite3_stmt  *statement;
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            
            
            
            char *field3=(char *) sqlite3_column_text(statement, 2);
            NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 3);
            NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            [doneNo addObject:field0Str];
            [done addObject:field3Str];
            [doneQty addObject:field4Str];
            
            
        }
    }
    
}

-(void)check
{   i=0;
    nameArray=[[NSMutableArray alloc]init];
    arrayDictionary1=[[NSMutableDictionary alloc]init];
    arrayDictionary2=[[NSMutableDictionary alloc]init];
    arrayDictionary3=[[NSMutableDictionary alloc]init];
    arrayDictionary4=[[NSMutableDictionary alloc]init];
    arrayDictionary5=[[NSMutableDictionary alloc]init];
    arrayDictionary6=[[NSMutableDictionary alloc]init];
    arrayDictionary7=[[NSMutableDictionary alloc]init];
    arrayDictionary8=[[NSMutableDictionary alloc]init];
    arrayDictionary9=[[NSMutableDictionary alloc]init];
    arrayDictionary10=[[NSMutableDictionary alloc]init];
    arrayDictionary11=[[NSMutableDictionary alloc]init];
    arrayDictionary12=[[NSMutableDictionary alloc]init];
    arrayDictionary13=[[NSMutableDictionary alloc]init];
    arrayDictionary14=[[NSMutableDictionary alloc]init];
    arrayDictionary15=[[NSMutableDictionary alloc]init];
    arrayDictionary16=[[NSMutableDictionary alloc]init];
    arrayDictionary17=[[NSMutableDictionary alloc]init];
    arrayDictionary18=[[NSMutableDictionary alloc]init];
    arrayDictionary19=[[NSMutableDictionary alloc]init];
    arrayDictionary20=[[NSMutableDictionary alloc]init];
    arrayDictionary21=[[NSMutableDictionary alloc]init];
    arrayDictionary22=[[NSMutableDictionary alloc]init];
    arrayDictionary23=[[NSMutableDictionary alloc]init];
    arrayDictionary24=[[NSMutableDictionary alloc]init];
    arrayDictionary25=[[NSMutableDictionary alloc]init];
    arrayDictionary26=[[NSMutableDictionary alloc]init];
    arrayDictionary27=[[NSMutableDictionary alloc]init];
    arrayDictionary28=[[NSMutableDictionary alloc]init];
     doneDictionary=[[NSMutableDictionary alloc]init];
  
    
    productArray=[[NSMutableArray alloc]init];
    quantityArray=[[NSMutableArray alloc]init];
    if (produce.count!=0) {
        
        [nameArray addObject:@"produce"];
        i++;
        [arrayDictionary1 setObject:produce forKey:@"PRODUCTS" ];
        [arrayDictionary1 setObject:produceqty forKey:@"QUANTITY" ];
        [arrayDictionary1 setObject:produceNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary1];
        //[quantityArray addObject:arrayDictionary1];
    }
    if (baking.count!=0) {
        
        [nameArray addObject:@"baking"];
        i++;
        [arrayDictionary2 setObject:baking forKey:@"PRODUCTS" ];
        [arrayDictionary2 setObject:bakingqty forKey:@"QUANTITY" ];
        [arrayDictionary2 setObject:bakingNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary2];
    }
    if (seasoning.count!=0) {
        
        [nameArray addObject:@"seasoning"];
        i++;
        [arrayDictionary3 setObject:seasoning forKey:@"PRODUCTS" ];
        [arrayDictionary3 setObject:seasoningqty forKey:@"QUANTITY" ];
        [arrayDictionary3 setObject:seasoningNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary3];
    }
    if (iwm.count!=0) {
        
        [nameArray addObject:@"iwm store"];
        i++;
        [arrayDictionary4 setObject:iwm forKey:@"PRODUCTS" ];
        [arrayDictionary4 setObject:iwmqty forKey:@"QUANTITY" ];
        [arrayDictionary4 setObject:iwmNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary4];
    }
    if (dairy.count!=0) {
        
        [nameArray addObject:@"dairy"];
        i++;
        [arrayDictionary5 setObject:dairy forKey:@"PRODUCTS" ];
        [arrayDictionary5 setObject:dairyqty forKey:@"QUANTITY" ];
        [arrayDictionary5 setObject:dairyNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary5];
    }
    if (protein.count!=0) {
        
        [nameArray addObject:@"protein"];
        i++;
        [arrayDictionary6 setObject:protein forKey:@"PRODUCTS" ];
        [arrayDictionary6 setObject:proteinqty forKey:@"QUANTITY" ];
        [arrayDictionary6 setObject:proteinNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary6];

    }
    if (grains.count!=0) {
        
        [nameArray addObject:@"grains"];
        i++;
        [arrayDictionary7 setObject:grains forKey:@"PRODUCTS" ];
        [arrayDictionary7 setObject:grainsqty forKey:@"QUANTITY" ];
          [arrayDictionary7 setObject:grainsNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary7];

    }
    if (toppings.count!=0) {
        
        [nameArray addObject:@"toppings"];
        i++;
        [arrayDictionary8 setObject:toppings forKey:@"PRODUCTS" ];
        [arrayDictionary8 setObject:toppingsqty forKey:@"QUANTITY" ];
        [arrayDictionary8 setObject:toppingsNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary8];
    }
    if (meat.count!=0) {
        
        [nameArray addObject:@"meat"];
        i++;
        [arrayDictionary9 setObject:meat forKey:@"PRODUCTS" ];
        [arrayDictionary9 setObject:meatqty forKey:@"QUANTITY" ];
         [arrayDictionary9 setObject:meatNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary9];

    }
    if (ethnic.count!=0) {
        [nameArray addObject:@"ethnic"];

        i++;
        [arrayDictionary10 setObject:ethnic forKey:@"PRODUCTS" ];
        [arrayDictionary10 setObject:ethnicqty forKey:@"QUANTITY" ];
         [arrayDictionary10 setObject:ethnicNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary10];
    }
    if (nuts.count!=0) {
        
        [nameArray addObject:@"nuts"];
        i++;
        [arrayDictionary11 setObject:nuts forKey:@"PRODUCTS" ];
        [arrayDictionary11 setObject:nutsqty forKey:@"QUANTITY" ];
        [arrayDictionary11 setObject:nutsNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary11];
    }
    if (sauces.count!=0) {
        
        [nameArray addObject:@"sauces"];
        i++;
        [arrayDictionary12 setObject:sauces forKey:@"PRODUCTS" ];
        [arrayDictionary12 setObject:saucesqty forKey:@"QUANTITY" ];
        [arrayDictionary12 setObject:saucesNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary12];

    }
    if (seafood.count!=0) {
        
        [nameArray addObject:@"sea food"];
        i++;
        [arrayDictionary13 setObject:seafood forKey:@"PRODUCTS" ];
        [arrayDictionary13 setObject:seafoodqty forKey:@"QUANTITY" ];
         [arrayDictionary13 setObject:seafoodNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary13];

    }
    if (condiments.count!=0) {
        
        [nameArray addObject:@"condiments"];
        i++;
        [arrayDictionary14 setObject:condiments forKey:@"PRODUCTS" ];
        [arrayDictionary14 setObject:condimentsqty forKey:@"QUANTITY" ];
        [arrayDictionary14 setObject:condimentsNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary14];

    }
    if (freezer.count!=0) {
        
        [nameArray addObject:@"freezer"];
        i++;
        [arrayDictionary15 setObject:freezer forKey:@"PRODUCTS" ];
        [arrayDictionary15 setObject:freezerqty forKey:@"QUANTITY" ];
        [arrayDictionary15 setObject:freezerNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary15];

    }
    if (health.count!=0) {
        
        [nameArray addObject:@"health"];
        i++;
        [arrayDictionary16 setObject:health forKey:@"PRODUCTS" ];
        [arrayDictionary16 setObject:healthqty forKey:@"QUANTITY" ];
        [arrayDictionary16 setObject:healthNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary16];

    }
    if (water.count!=0) {
        
        [nameArray addObject:@"water"];
        i++;
        [arrayDictionary17 setObject:water forKey:@"PRODUCTS" ];
        [arrayDictionary17 setObject:waterqty forKey:@"QUANTITY" ];
        [arrayDictionary17 setObject:waterNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary17];

    }
    if (tea.count!=0) {
        
        [nameArray addObject:@"tea/coffee"];
        i++;
        [arrayDictionary18 setObject:tea forKey:@"PRODUCTS" ];
        [arrayDictionary18 setObject:teaqty forKey:@"QUANTITY" ];
        [arrayDictionary18 setObject:teaNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary18];

    }
    if (waldenfarms.count!=0) {
        
        [nameArray addObject:@"walden farms"];
        i++;
        [arrayDictionary19 setObject:waldenfarms forKey:@"PRODUCTS" ];
        [arrayDictionary19 setObject:waldenfarmsqty forKey:@"QUANTITY" ];
         [arrayDictionary19 setObject:waldenfarmsNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary19];


    }
    if (canned.count!=0) {
        
        [nameArray addObject:@"canned goods"];
        i++;
        [arrayDictionary20 setObject:canned forKey:@"PRODUCTS" ];
        [arrayDictionary20 setObject:cannedqty forKey:@"QUANTITY" ];
         [arrayDictionary20 setObject:cannedNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary20];


    }
    if (other.count!=0) {
        
        [nameArray addObject:@"other"];
        i++;
        [arrayDictionary21 setObject:other forKey:@"PRODUCTS" ];
        [arrayDictionary21 setObject:otherqty forKey:@"QUANTITY" ];
         [arrayDictionary21 setObject:otherNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary21];


    }
    if (breakfast.count!=0) {
        
        [nameArray addObject:@"breakfast"];
        i++;
        [arrayDictionary22 setObject:breakfast forKey:@"PRODUCTS" ];
        [arrayDictionary22 setObject:breakfastqty forKey:@"QUANTITY" ];
        [arrayDictionary22 setObject:breakfastNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary22];

    }
    if (dressing.count!=0) {
        
        [nameArray addObject:@"dressings"];
        i++;
        [arrayDictionary23 setObject:dressing forKey:@"PRODUCTS" ];
        [arrayDictionary23 setObject:dressingqty forKey:@"QUANTITY" ];
        [arrayDictionary23 setObject:dressingNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary23];


    }
    if (frozen.count!=0) {
        
        [nameArray addObject:@"frozen"];
        i++;
        [arrayDictionary24 setObject:frozen forKey:@"PRODUCTS" ];
        [arrayDictionary24 setObject:frozenqty forKey:@"QUANTITY" ];
        [arrayDictionary24 setObject:frozenNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary24];

    }
    if (pasta.count!=0) {
        [nameArray addObject:@"pasta"];
        i++;
        [arrayDictionary25 setObject:pasta forKey:@"PRODUCTS" ];
        [arrayDictionary25 setObject:pastaqty forKey:@"QUANTITY" ];
         [arrayDictionary25 setObject:pastaNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary25];


    }
    if (broth.count!=0) {
        [nameArray addObject:@"broth"];
 
        i++;
        [arrayDictionary26 setObject:broth forKey:@"PRODUCTS" ];
        [arrayDictionary26 setObject:brothqty forKey:@"QUANTITY" ];
         [arrayDictionary26 setObject:brothNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary26];

    }
    if (vegetarian.count!=0) {
        
        [nameArray addObject:@"vegetarian"];
        i++;
        [arrayDictionary27 setObject:vegetarian forKey:@"PRODUCTS" ];
        [arrayDictionary27 setObject:vegetarianqty forKey:@"QUANTITY" ];
        [arrayDictionary27 setObject:vegetarianNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary27];


    }
    if (deli.count!=0) {
        
        [nameArray addObject:@"deli"];
        i++;
        [arrayDictionary28 setObject:deli forKey:@"PRODUCTS" ];
        [arrayDictionary28 setObject:deliqty forKey:@"QUANTITY" ];
        [arrayDictionary28 setObject:deliNo forKey:@"NO" ];
        [productArray addObject:arrayDictionary28];

    }
    if (done.count!=0) {
        
               
        [nameArray addObject:@"done"];
        i++;
        [doneDictionary setObject:done forKey:@"PRODUCTS" ];
        [doneDictionary setObject:doneQty forKey:@"QUANTITY" ];
        [doneDictionary setObject:doneNo forKey:@"NO" ];
        [productArray addObject:doneDictionary];
        
    }

    //NSLog(@"%d",i);
[self load];
    //[bigImage removeFromSuperview];
}
-(void)noItemsAdded
{
    if (i==0) {
        
        [bigImage removeFromSuperview];
    [listTable removeFromSuperview];
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        if (screenBounds.size.height == 568)
        {
            bigImage=[[UIImageView alloc]initWithFrame:CGRectMake(14, 102, 292, 400)];
           [bigImage setImage:[UIImage imageNamed:@"IM_i5_grocery-noitems-pic.png"]];
        }
        else{
             bigImage=[[UIImageView alloc]initWithFrame:CGRectMake(12, 97, 296, 324)];
            [bigImage setImage:[UIImage imageNamed:@"IM_grocery_no-items.png"]];
        }
   // bigImage=[[UIImageView alloc]initWithFrame:CGRectMake(12, 97, 296, 324)];
    //[bigImage setImage:[UIImage imageNamed:@"IM_grocery_no-items.png"]];
    [self.view addSubview:bigImage];
}
//    else
//    {
//        listTable =[[UITableView alloc]initWithFrame:CGRectMake(12, 100, 296, 320)];
//        [listTable setBackgroundColor:[UIColor lightGrayColor]];
//        listTable.delegate=self;
//        listTable.separatorStyle=UITableViewCellSeparatorStyleNone;
//        // [listTable setSeparatorColor:[UIColor lightGrayColor]];
//        listTable.dataSource=self;
//        //    UIImageView *frame=[[UIImageView alloc ]initWithFrame:CGRectMake(10, 97, 300, 326)];
//        //    [frame setImage:[UIImage imageNamed:@"IM_grocerylist_listbox_frame-overlay.png" ]];
//        
//        //[listTable setShowsVerticalScrollIndicator:NO ];
//        [self.view addSubview:listTable];
//    }
}
#pragma mark Table view methods
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView  {
   // [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    return i;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {

    
                
NSDictionary *dictionary = [productArray objectAtIndex:section];
    array = [dictionary objectForKey:@"PRODUCTS"];
     //NSLog(@"ppppp%d",[array count]);
    return [array count];

   

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
        UILabel *te2 = (UILabel *)[cell.contentView viewWithTag:99999];
        [te2 removeFromSuperview];
        te2 = nil;
        UIButton *te3 = (UIButton *)[cell.contentView viewWithTag:999999];
        [te3 removeFromSuperview];
        te3 = nil;
        UIButton *te4 = (UIButton *)[cell.contentView viewWithTag:9999999];
        [te4 removeFromSuperview];
        te4 = nil;
        UILabel *te5 = (UILabel *)[cell.contentView viewWithTag:99999999];
        [te5 removeFromSuperview];
        te5 = nil;
        UIButton *te6 = (UIButton *)[cell.contentView viewWithTag:9999999999];
        [te6 removeFromSuperview];
        te6 = nil;
    }
UIImageView *productimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0 ,cell.frame.size.width,55 )];
    [productimage setTag:999];
    [productimage setImage:[UIImage imageNamed:@"IM_grocery-list_single-cell.jpg"]];
    [cell.contentView addSubview:productimage];
    
    NSDictionary *dictionary = [productArray objectAtIndex:indexPath.section];
    //array3=[[NSMutableArray alloc]init];
    //NSLog(@"%@",dictionary);
    
    array = [dictionary objectForKey:@"PRODUCTS"];
    array2 = [dictionary objectForKey:@"QUANTITY"];
    array3=[dictionary objectForKey:@"NO"];
  //  NSLog(@" i m array 3 :%@",array3);
    NSString *cellValue = [array objectAtIndex:indexPath.row];
   // NSLog(@"%@",cellValue);
    NSString *cellValue2 = [array2 objectAtIndex:indexPath.row];
    cellValue=[cellValue stringByReplacingOccurrencesOfString:@"786" withString:@""];
  // NSString* abcd = [array3 objectAtIndex:indexPath.row];
  // NSLog(@"grt:%@",abcd);
      //  NSLog(@"number of occurences %d", occurrences);
    
    NSArray *sub=[cellValue2 componentsSeparatedByString:@","];
   // NSLog(@"%@",sub);
    
   
    NSArray *sortedArray;
    sortedArray = [sub sortedArrayUsingSelector:@selector(compare:)];
     //NSLog(@"hello%@",sortedArray);
    
    NSMutableArray *sub2=[NSMutableArray arrayWithArray:sortedArray];
    NSMutableString *sub3=[[NSMutableString alloc]init];
    bool j=YES;
    for (int u=0; u<[sub2 count]; u++) {
        int occurrences = 0;
        for(NSString *string in sub2)
        {
           // NSLog(@"%d",u);
            
            occurrences += ([string isEqualToString:[sub2 objectAtIndex:u] ]?1:0);
            
            
        }
        u=u+occurrences-1;
        //NSLog(@"###%d",occurrences);
        NSString *newString;
        if (occurrences>1) {
            
        
        newString=[[NSString alloc]initWithFormat:@"%@ (*%d)",[sub2 objectAtIndex:u-1],occurrences ];
        }else
        {
            newString=[[NSString alloc]initWithFormat:@"%@",[sub2 objectAtIndex:u]];
        }
        if (j==NO) {
            [sub3 appendString:@","];
        }
        [sub3 appendString:newString];
        j=NO;
    }
    
   // NSLog(@"44444%@",sub3);
    
   productName=[[UILabel alloc]initWithFrame:CGRectMake(45, 0 ,210,35 )];
    if (cellValue.length < 33) {
         productName=[[UILabel alloc]initWithFrame:CGRectMake(45, 0 ,210,30 )];
    }
    if ([cellValue isEqualToString:@"Apples, cored and cut into pieces"]) {
         productName=[[UILabel alloc]initWithFrame:CGRectMake(45, 0 ,210,30 )];
    }
    if (cellValue2.length == 0) {
        productName=[[UILabel alloc]initWithFrame:CGRectMake(45, 0 ,210,55 )];
    }
    
    [productName setTag:9999];
    productName.backgroundColor=[UIColor clearColor];
    productName.numberOfLines=3;
   productName.adjustsFontSizeToFitWidth=YES;
    productName.font=[UIFont systemFontOfSize:14];
    if (cellValue.length > 62)
    {
         productName.font=[UIFont systemFontOfSize:12];
    }
    if (cellValue.length > 75)
    {
        productName.font=[UIFont systemFontOfSize:9.5];
    }
     
    productName.minimumFontSize=5;
    productName.textColor = [UIColor blackColor];
    
   [cell.contentView addSubview:productName];
    
    
//    UILabel *noLabel=[[UILabel alloc]initWithFrame:CGRectMake(259, 15, 20  , 20)];
//    [noLabel setBackgroundColor:[UIColor clearColor]];
//    [noLabel setTag:99999999];
//    //NSString *jString=[[NSString alloc]initWithFormat:@"%d",occurrences ];
//   // NSLog(@"%d",j);
//    //noLabel.text=jString;
//    //if (occurrences==1) {
//         noLabel.text=@"";
//    //}
//    noLabel.textColor=[UIColor blackColor];
//    noLabel.textAlignment=UITextAlignmentCenter;
//    [cell.contentView addSubview:noLabel];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     productQty=[[UILabel alloc]initWithFrame:CGRectMake(45, 35 ,210,20 )];
    if (cellValue.length < 33) {
        productQty=[[UILabel alloc]initWithFrame:CGRectMake(45, 25 ,210,20 )];
    }
    if ([cellValue isEqualToString:@"Apples, cored and cut into pieces"]) {
       productQty=[[UILabel alloc]initWithFrame:CGRectMake(45, 25 ,210,20 )];
    }
    [productQty setTag:99999];
    productQty.backgroundColor=[UIColor clearColor];
   // productQty.numberOfLines=3;
    productQty.adjustsFontSizeToFitWidth=YES;
    productQty.font=[UIFont systemFontOfSize:12];
    productQty.minimumFontSize=10.0;
    productQty.textColor = [UIColor blackColor];
    
    [cell.contentView addSubview:productQty];

    productName.text = cellValue;
    productQty.text=sub3;
   
    UIImage *image;
    NSString *str = [NSString stringWithFormat:@"%@",[[self.Bool objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
	if([str isEqualToString:@"check"])
        image = [UIImage imageNamed:@"IM_grocerylist_checkbox.png"];
    
    
    else
        
        image = [UIImage imageNamed:@"IM_grocerylist_checkbox-checked.png"];
    ///[checkbutton setImage:[UIImage imageNamed:@"IM_grocerylist_checkbox.png"] forState:UIControlStateNormal];
    checkbutton=[[UIButton alloc]initWithFrame:CGRectMake(10, 15, 25, 25)];
    //[checkbutton setTag:abcd];
    [checkbutton setImage:image forState:UIControlStateNormal];
    [checkbutton setImage:[UIImage imageNamed:@"IM_grocerylist_checkbox-checked.png"  ]forState:UIControlStateHighlighted];
    checkbutton.titleLabel.text = cellValue;
    // [checkbutton addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
    
    [checkbutton setTag:((indexPath.section & 0xFFFF) << 16) |
     (indexPath.row & 0xFFFF)];
    [cell.contentView addSubview:checkbutton];
//    UIButton *more=[[UIButton alloc]initWithFrame:CGRectMake(255, 15, 25, 25)];
//    [more setTag:9999999];
//    [more setImage:[UIImage imageNamed:@"IM_grocerylist_icon-more.png"] forState:UIControlStateNormal];
   [checkbutton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.contentView addSubview:more];
    
   // if ([[NSUserDefaults standardUserDefaults]boolForKey:@"done"]==YES) {
    
    if ([done count]>0) {
        
    
    
        if (indexPath.section==[nameArray count]-1) {
            
             checkButtonDone=[[UIButton alloc]initWithFrame:CGRectMake(10, 15, 25, 25)];
            [checkButtonDone setTag:9999999999];
            productQty.textColor = [UIColor lightGrayColor];
              productName.textColor = [UIColor lightGrayColor];
            [checkButtonDone setImage:[UIImage imageNamed:@"IM_grocerylist_checkbox-completed.png"] forState:UIControlStateNormal];
            checkButtonDone.enabled=NO;
            checkButtonDone.userInteractionEnabled=NO;
             [checkButtonDone addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
           //cell.userInteractionEnabled=NO;
            [cell.contentView addSubview:checkButtonDone];
//            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"done"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
            
        
    }
    }
    
    
    return cell;
}

-(void)doneAction
{
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if(section == 0)
		return @"hello";
	else
		return @"hello";
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self tableView:tableView titleForHeaderInSection:section] != nil) {
        return SectionHeaderHeight;
    }
    else {
        // If no section header title, no section header needed
        return 0;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 296, 20)];

    UIImageView *headingImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 296, 20)];
    
    [headingImage setImage:[UIImage imageNamed:@"IM_grocery-div_green.png"]];
     [customView addSubview:headingImage];
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 256, 20)];
    nameLabel.backgroundColor=[UIColor clearColor];
    [headingImage addSubview:nameLabel];
    nameLabel.textAlignment=UITextAlignmentCenter;
    nameLabel.font=[UIFont boldSystemFontOfSize:14];
    
    nameLabel.textColor=[UIColor whiteColor];
    for (int j=0; j<i;j++) {
       if(section == j)
       {
        nameLabel.text=[[nameArray objectAtIndex:j]uppercaseString];
           if ([done count]>0) {
               
               if(j==i-1)
               {
               
                   nameLabel.textColor=[UIColor blackColor];
   
           
               }}
       }
        
        
    }
    
    return customView;
}



-(void)buttonTapped:(UIButton *)sender
{
   // NSLog(@"%@",sender.titleLabel.text);
   // [checkbutton setImage:[UIImage imageNamed:@"IM_grocerylist_checkbox-checked.png"] forState:UIControlStateSelected];
    NSUInteger section = ((sender.tag >> 16) & 0xFFFF);
    NSUInteger row     = (sender.tag & 0xFFFF);
    //NSLog(@"%d %d",section,row);
    //NSInteger section;
    NSDictionary *dictionary = [productArray objectAtIndex:section];
    array = [dictionary objectForKey:@"PRODUCTS"];
    array2 = [dictionary objectForKey:@"QUANTITY"];
    array3 = [dictionary objectForKey:@"NO"];
   // NSLog(@"%@",[array3 objectAtIndex:row]);
    
   // NSLog(@"%d",[sender tag]);
    
    if([[[self.Bool objectAtIndex:section] objectAtIndex:row]isEqualToString:@"check"])
              {
                   [[self.Bool objectAtIndex:section] replaceObjectAtIndex:row withObject:@"checked"];
                  
            NSString *no=[[NSString alloc]initWithFormat:@"%@",[array3 objectAtIndex:row]];
                 // NSLog(@"%@",no);
    //NSString *nameString=[[NSString alloc]initWithFormat:@"%@",sender.titleLabel.text ];
                 NSString *nameString2=[[NSString alloc]initWithFormat:@"%@786",sender.titleLabel.text ];
                  // NSLog(@"%@",nameString2);
    //[listTable reloadData];
    NSString *insertSQL=[NSString stringWithFormat:@"UPDATE info SET Type=('%@'), Name=('%@') WHERE No IS '%@'",@"done",nameString2,no];
    sqlite3_stmt  *statement1;
    
    
    
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(db, insert_stmt,
                       -1, &statement1, NULL);
    if (sqlite3_step(statement1) == SQLITE_DONE)
    {
         //NSLog(@"%@",@"contact added");
        
    }
    
    else
        
    {
        
        NSLog(@"%@",@"failed");
        
    }
                 

    [self newfunction];
             
              
              
              
              
              
              
              
              
              
              
              }
    //[listTable reloadData];
    
    
      //[checkbutton setImage:[UIImage imageNamed:@"IM_grocerylist_checkbox-checked.png"] forState:UIControlStateSelected];
    
//        if([[[self.Bool objectAtIndex:section] objectAtIndex:row]isEqualToString:@"check"])
//        {   
//
////            [[self.Bool objectAtIndex:section] replaceObjectAtIndex:row withObject:@"checked"];
////            [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.9]];
////            [products addObject:[array objectAtIndex:row]];
////            //[array removeObjectAtIndex:row];
////             //[productsQty addObject:[array2 objectAtIndex:row]];
////            [[self.Bool objectAtIndex:section] replaceObjectAtIndex:row withObject:@"check"];
////                      // NSLog(@"array is %@",products);
////            [listTable reloadData];
//                        // NSLog(@"%d",[sender tag]);
//            
//        }
//        else
//        {
//            [products removeObject:[array objectAtIndex:row]];
//            [productsQty removeObject:[array2 objectAtIndex:row]];
//            
//            NSLog(@"array is %@",products);
//            //NSLog(@"%d",[sender tag]);
//       
//
//      }
    // 
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //bPFlipsideViewController *bp =[entries objectAtIndex:indexPath.row];
        NSUInteger section = indexPath.section ;
       // NSUInteger row     = (sender.tag & 0xFFFF);
        NSDictionary *dictionary = [productArray objectAtIndex:section];
      
        array = [dictionary objectForKey:@"PRODUCTS"];
        array2 = [dictionary objectForKey:@"QUANTITY"];
      
        NSString* abc = [array objectAtIndex:indexPath.row];
       // NSLog(@"Deleted %@" , abc);
        
        

        
        [self deleteData:[NSString stringWithFormat:@"DELETE  FROM info WHERE Name IS '%s'",
                          [abc
                           UTF8String  ]]];
        [array removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath ] withRowAnimation:UITableViewRowAnimationRight];
        //[[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
        [self newfunction];
        
    }
}

-(void)deleteData:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(db, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK); {
        //NSLog(@"person deleted");
        //[listTable reloadData];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{   [self noClicked];
    [listTable removeFromSuperview];
    [frame removeFromSuperview];
}
-(void)viewDidUnload
{
    [self setEmailButtonGrocery:nil];
    [self setClearButtonGrocery:nil];
    [self setAddButtonGrocery:nil];
    
    
    [vegetarian removeAllObjects];
    [vegetarianqty removeAllObjects];
    [vegetarianNo removeAllObjects];
    
    [deli removeAllObjects];
    [deliNo removeAllObjects];
    
    [deliqty removeAllObjects];
    
    [seasoning removeAllObjects];
     [seasoningNo removeAllObjects];
    [seasoningqty removeAllObjects];
    
    [produce removeAllObjects];
    [produceNo removeAllObjects];
    [produceqty removeAllObjects];
    

    
 
    
  [baking removeAllObjects];
    [bakingNo removeAllObjects];
    [bakingqty removeAllObjects];
    
   [ iwmNo removeAllObjects];
    [ iwm removeAllObjects];
  [ iwmqty removeAllObjects];
    
 [  dairy removeAllObjects];
     [  dairyNo removeAllObjects];
[dairyqty removeAllObjects];
    
[protein removeAllObjects];
    [proteinNo removeAllObjects];
  [proteinqty removeAllObjects];
    
   [grains removeAllObjects];
     [grainsNo removeAllObjects];
  [grainsqty removeAllObjects];
    
  [toppings removeAllObjects];
    [toppingsNo removeAllObjects];
 [   toppingsqty removeAllObjects];
    
[meat removeAllObjects];
    [meatNo removeAllObjects];
 [ meatqty removeAllObjects];
    
[ethnic removeAllObjects];
    [ethnicNo removeAllObjects];
  [ ethnicqty removeAllObjects];
    
 [  nuts removeAllObjects];
     [  nutsNo removeAllObjects];
[nutsqty removeAllObjects];
    
 [sauces removeAllObjects];
    [saucesNo removeAllObjects];
[saucesqty removeAllObjects];
    
   [seafood removeAllObjects];
     [seafoodNo removeAllObjects];
  [seafoodqty removeAllObjects];
    
  [ condimentsqty removeAllObjects];
     [ condimentsNo removeAllObjects];
 [condiments removeAllObjects];
    
 [  freezer removeAllObjects];
 [ freezerqty removeAllObjects];
     [ freezerNo removeAllObjects];
    
[  health removeAllObjects];
    [  healthNo removeAllObjects];
[   healthqty removeAllObjects];
    
[  water removeAllObjects];
    [  waterNo removeAllObjects];
    [waterqty removeAllObjects];
    
 [  tea removeAllObjects];
    [  teaNo removeAllObjects];
 [  teaqty removeAllObjects];
    
    
[ waldenfarms removeAllObjects];
    [ waldenfarmsNo removeAllObjects];
[  waldenfarmsqty removeAllObjects];
    
 [  canned removeAllObjects];
     [  cannedNo removeAllObjects];
[cannedqty removeAllObjects];
    
[   other removeAllObjects];
    [   otherNo removeAllObjects];
[otherqty removeAllObjects];
    
[ breakfast removeAllObjects];
    [ breakfastNo removeAllObjects];
[breakfastqty removeAllObjects];
    
[   dressing removeAllObjects];
    [   dressingNo removeAllObjects];
[  dressingqty removeAllObjects];
    
[frozen removeAllObjects];
    [frozenNo removeAllObjects];
[  frozenqty removeAllObjects];
    
[pasta removeAllObjects];
    [pastaNo removeAllObjects];
[pastaqty removeAllObjects];
    
 [ broth removeAllObjects];
     [ brothNo removeAllObjects];
 [brothqty removeAllObjects];
 
 [ nameArray removeAllObjects];
 
[ products removeAllObjects];
    [ productsNo removeAllObjects];
[ productsQty removeAllObjects];


[allArray removeAllObjects];
[allQuantityArray removeAllObjects];
    
    
 [  array removeAllObjects];
[array2 removeAllObjects];
 
 [ sectionArray removeAllObjects];
 
 [ arrayDictionary1 removeAllObjects];
[arrayDictionary2 removeAllObjects];
 [  arrayDictionary3 removeAllObjects];
[   arrayDictionary4 removeAllObjects];
[  arrayDictionary5 removeAllObjects];
[ arrayDictionary6 removeAllObjects];
[   arrayDictionary7 removeAllObjects];
[   arrayDictionary8 removeAllObjects];
[  arrayDictionary9 removeAllObjects];
 [ arrayDictionary10 removeAllObjects];
[arrayDictionary11 removeAllObjects];
[arrayDictionary12 removeAllObjects];
[arrayDictionary13 removeAllObjects];
[   arrayDictionary14 removeAllObjects];
[arrayDictionary15 removeAllObjects];
[arrayDictionary16 removeAllObjects];
[ arrayDictionary17 removeAllObjects];
[arrayDictionary18 removeAllObjects];
[  arrayDictionary19 removeAllObjects];
[  arrayDictionary20 removeAllObjects];
[  arrayDictionary21 removeAllObjects];
[  arrayDictionary22 removeAllObjects];
[arrayDictionary23 removeAllObjects];
    [ arrayDictionary24 removeAllObjects];
   [  arrayDictionary25 removeAllObjects];
  [   arrayDictionary26 removeAllObjects];
 [    arrayDictionary27 removeAllObjects];
[     arrayDictionary28 removeAllObjects];
    
    
    
  [productArray removeAllObjects];
   [quantityArray removeAllObjects];
     [emailArray removeAllObjects];
     [nameArray removeAllObjects];
    
    productName.text=@"";
    productQty.text=@"";

}
- (IBAction)clearDatabase:(id)sender {
    tabbarItem=YES;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        fadeScreen=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
        [fadeScreen setImage:[UIImage imageNamed:@"IM_i5_screen-fader.png"]];
        fadeScreen.userInteractionEnabled=YES;
        clearImage=[[UIImageView alloc]initWithFrame:CGRectMake(40, 200, 240, 180)];
        [clearImage setImage:[UIImage imageNamed:@"IM_i5_popup-clear.png"]];
        clearImage.userInteractionEnabled=YES;
        [fadeScreen addSubview:clearImage];
        clearNo=[[UIButton alloc]initWithFrame:CGRectMake(20, 115, 85    , 35)];
        [clearNo setImage:[UIImage imageNamed:@"IM_grocery-bt_0001_Label-copy-7.png"]forState:UIControlStateNormal];
        [clearNo setImage:[UIImage imageNamed:@"IM_grocery-bt_0000_Label-copy-11.png"]forState:UIControlStateHighlighted];
        [clearNo addTarget:self action:@selector(noClicked) forControlEvents:UIControlEventTouchUpInside];
        [clearImage addSubview:clearNo];
        clearYes=[[UIButton alloc]initWithFrame:CGRectMake(133, 115, 85    , 35)];
        [clearYes setImage:[UIImage imageNamed:@"IM_grocery-bt_0003_Label-copy-6.png"]forState:UIControlStateNormal];
        [clearYes setImage:[UIImage imageNamed:@"IM_grocery-bt_0002_Label-copy-12.png"]forState:UIControlStateHighlighted];
        [clearYes addTarget:self action:@selector(yesClicked) forControlEvents:UIControlEventTouchUpInside];
        [clearImage addSubview:clearYes];
        [self.view addSubview:fadeScreen];
        
    }
    else
    {
        fadeScreen=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
        [fadeScreen setImage:[UIImage imageNamed:@"IM_i5_screen-fader.png"]];
        fadeScreen.userInteractionEnabled=YES;
        clearImage=[[UIImageView alloc]initWithFrame:CGRectMake(40, 150, 240, 180)];
        [clearImage setImage:[UIImage imageNamed:@"IM_i5_popup-clear.png"]];
        clearImage.userInteractionEnabled=YES;
        [fadeScreen addSubview:clearImage];
        clearNo=[[UIButton alloc]initWithFrame:CGRectMake(20, 115, 85    , 35)];
        [clearNo setImage:[UIImage imageNamed:@"IM_grocery-bt_0001_Label-copy-7.png"]forState:UIControlStateNormal];
        [clearNo setImage:[UIImage imageNamed:@"IM_grocery-bt_0000_Label-copy-11.png"]forState:UIControlStateHighlighted];
        [clearNo addTarget:self action:@selector(noClicked) forControlEvents:UIControlEventTouchUpInside];
        [clearImage addSubview:clearNo];
        clearYes=[[UIButton alloc]initWithFrame:CGRectMake(133, 115, 85    , 35)];
        [clearYes setImage:[UIImage imageNamed:@"IM_grocery-bt_0003_Label-copy-6.png"]forState:UIControlStateNormal];
        [clearYes setImage:[UIImage imageNamed:@"IM_grocery-bt_0002_Label-copy-12.png"]forState:UIControlStateHighlighted];
        [clearYes addTarget:self action:@selector(yesClicked) forControlEvents:UIControlEventTouchUpInside];
        [clearImage addSubview:clearYes];
        [self.view addSubview:fadeScreen];
    }

    
//    clearImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
//    [clearImage setImage:[UIImage imageNamed:@"IM_clear-popup-bg.png"]];
//    clearImage.userInteractionEnabled=YES;
//    [self.view addSubview:clearImage];
//    clearNo=[[UIButton alloc]initWithFrame:CGRectMake(60, 250, 85    , 35)];
//    [clearNo setBackgroundImage:[UIImage imageNamed:@"IM_grocery-bt_0001_Label-copy-7.png"]forState:UIControlStateNormal];
//    [clearNo setBackgroundImage:[UIImage imageNamed:@"IM_grocery-bt_0000_Label-copy-11.png"]forState:UIControlStateHighlighted];
//    [clearNo addTarget:self action:@selector(noClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:clearNo];
//    clearYes=[[UIButton alloc]initWithFrame:CGRectMake(175, 250, 85    , 35)];
//    [clearYes setBackgroundImage:[UIImage imageNamed:@"IM_grocery-bt_0003_Label-copy-6.png"]forState:UIControlStateNormal];
//    [clearYes setBackgroundImage:[UIImage imageNamed:@"IM_grocery-bt_0002_Label-copy-12.png"]forState:UIControlStateHighlighted];
//    [clearYes addTarget:self action:@selector(yesClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:clearYes];

    [Flurry logEvent:@"Clear Grocery Button Pressed"];
    
}
-(void)yesClicked
{
    [self noClicked];
    
    [self deleteTable:[NSString stringWithFormat:@"DELETE FROM info"]];
    [listTable reloadData];
    //listTable.frame = CGRectMake(-100,-100, 0, 0);
    //[listTable removeFromSuperview];
    [self newfunction];
}
-(void)noClicked
{
    tabbarItem=NO;
    [fadeScreen removeFromSuperview];
    [frame removeFromSuperview];
    [clearYes removeFromSuperview];
     [clearNo removeFromSuperview];
    [clearImage removeFromSuperview];
    
}


- (IBAction)email:(id)sender {
    
    
    
    if ([MFMailComposeViewController canSendMail])
            
        {
            
            emailArray=[[NSMutableArray alloc]init];
            
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            
            
            
            mailer.mailComposeDelegate = self;
            
            
            
            [mailer setSubject:@"Ideal-Meals"];
            
            
            
            NSArray *toRecipients = [NSArray arrayWithObjects:@"", nil];
            
            [mailer setToRecipients:toRecipients];
            
            
            
           // UIImage *myImage = [UIImage imageNamed:@"mailShareicon.jpg"];
            
            //NSData *imageData = UIImagePNGRepresentation(myImage);
            
            //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"icon57"];
            
            NSString *sql=[NSString stringWithFormat:@"SELECT   *  FROM info ORDER BY Type COLLATE NOCASE ASC"];
            sqlite3_stmt  *statement;
            
            int o=1;
            
            if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
                while (sqlite3_step(statement)==SQLITE_ROW) {
                    
                    
                    
                    char *field1=(char *) sqlite3_column_text(statement, 1);
                    NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
                    
                    char *field3=(char *) sqlite3_column_text(statement, 3);
                    NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
                    
                    char *field2=(char *) sqlite3_column_text(statement, 2);
                    NSString *field2Str=[[ NSString alloc]initWithUTF8String:field2];
                    
                    
                    NSArray *sub=[field3Str componentsSeparatedByString:@","];
                    // NSLog(@"%@",sub);
                    
                    
                    NSArray *sortedArray;
                    sortedArray = [sub sortedArrayUsingSelector:@selector(compare:)];
                    //NSLog(@"hello%@",sortedArray);
                    
                    NSMutableArray *sub2=[NSMutableArray arrayWithArray:sortedArray];
                    NSMutableString *sub3=[[NSMutableString alloc]init];
                    bool j=YES;
                    for (int u=0; u<[sub2 count]; u++) {
                        int occurrences = 0;
                        for(NSString *string in sub2)
                        {
                            // NSLog(@"%d",u);
                            
                            occurrences += ([string isEqualToString:[sub2 objectAtIndex:u] ]?1:0);
                            
                            
                        }
                        u=u+occurrences-1;
                        //NSLog(@"###%d",occurrences);
                        NSString *newString;
                        if (occurrences>1) {
                            
                            
                            newString=[[NSString alloc]initWithFormat:@"%@ (*%d)",[sub2 objectAtIndex:u-1],occurrences ];
                        }else
                        {
                            newString=[[NSString alloc]initWithFormat:@"%@",[sub2 objectAtIndex:u]];
                        }
                        if (j==NO) {
                            [sub3 appendString:@","];
                        }
                        [sub3 appendString:newString];
                        j=NO;

                    }
                    
                    NSString *str= [[NSString alloc] initWithFormat:@"%d: %@ %@ - %@",o, field2Str,sub3,field1Str];
                  
                    
                    str=[str stringByReplacingOccurrencesOfString:@"to taste,to taste" withString:@""];
                    if (![field1Str isEqual:@"done"])
                    {
                        if (![field1Str isEqual:@"water"]) {
                            
                       
                            o++;
                         [emailArray addObject:str];
                        }}
                
                    
                }
                
            }

            
           // NSLog(@"%@",emailArray);
            
            NSString *string = [emailArray componentsJoinedByString:@"\n\n"];
          //  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:emailArray];
            
            [mailer setMessageBody:string isHTML:NO];
            
            //NSData *imageData = UIImagePNGRepresentation(myImage);
            
         //   [mailer addAttachmentData:data mimeType:@"image/png" fileName:@"icon57"];
            
            
            
            [self presentViewController:mailer animated:YES completion:nil];
            
        }
        
        else
            
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                  
                                                            message:@"You need to Login to your account first "
                                  
                                                           delegate:nil
                                  
                                                  cancelButtonTitle:@"OK"
                                  
                                                  otherButtonTitles:nil];
            
            [alert show];
            
        }
        
        
        
        
        [Flurry logEvent:@"Email Grocery Button Pressed"];
        
        
    }
    
    
    
    
    
    
    
        
 
    
    
    
    
    
    
    
    
//}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    
    switch (result)
    
    {
            
        case MFMailComposeResultCancelled:
            
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            
            break;
            
        case MFMailComposeResultSaved:
            
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            
            break;
            
        case MFMailComposeResultSent:
            
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            
           // mailButton.enabled=NO;
            
            
            
            
            
            break;
            
        case MFMailComposeResultFailed:
            
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            
            break;
            
        default:
            
            NSLog(@"Mail not sent.");
            
            break;
            
    }
    
    
    
    // Remove the mail view
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)deleteTable:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(db, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK); {
        //NSLog(@"person deleted");
        [listTable reloadData];
    }
    
}

- (IBAction)addAIngridient:(id)sender {
     base=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [base setImage:[UIImage imageNamed:@"IM_iP4_ADD-item_grocery-bg.jpg"]];
    base.userInteractionEnabled=YES;
     [self.view addSubview:base];
    
     labeltimer3=    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hideSaveButton) userInfo:nil repeats:YES];
    compare=[[UITextView alloc]initWithFrame:CGRectMake(10    , 82    , 280, 110)];
    nameOfIngridient=[[UILabel alloc]initWithFrame:CGRectMake(20, 89, 70, 20)];
    nameOfIngridient.text=@"Name";
    nameOfIngridient.textColor=[UIColor lightGrayColor];
    nameOfIngridient.backgroundColor=[UIColor clearColor];
    [self.view addSubview:nameOfIngridient];
   labeltimer=    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showOrHide) userInfo:nil repeats:YES];
    [compare setBackgroundColor:[UIColor clearColor]];
    compare.autocorrectionType = UITextAutocorrectionTypeNo;
    //[compare.markedTextRange=100];
    compare.returnKeyType=UIReturnKeyDone;
    compare.font=[UIFont systemFontOfSize:16];
    compare.text=@"";
    compareQty=[[UITextView alloc]initWithFrame:CGRectMake(10    , 194    , 280, 100)];
    [compareQty setBackgroundColor:[UIColor clearColor]];
    ingridientQuantity=[[UILabel alloc]initWithFrame:CGRectMake(20, 202, 70, 20)];
    ingridientQuantity.text=@"Quantity";
    ingridientQuantity.textColor=[UIColor lightGrayColor];
    ingridientQuantity.backgroundColor=[UIColor clearColor];
  labeltimer2=  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(show2) userInfo:nil repeats:YES];
    [self.view addSubview:ingridientQuantity];
    compareQty.autocorrectionType = UITextAutocorrectionTypeNo;
    //[compare.markedTextRange=100];
    compareQty.returnKeyType=UIReturnKeyDone;
    compareQty.font=[UIFont systemFontOfSize:16];
    compareQty.text=@"";
    
    compare.delegate=self;
     compareQty.delegate=self;
    
//    NSRange *range=100;
//    NSString *replacementText=[[NSString alloc]initWithFormat:@""];
//    [compare.text stringByReplacingCharactersInRange:*range withString:replacementText];
    // compare text
    //compare.placeholder=@"Name";
   // compare.textInputView=UIViewAnimationCurveLinear;
    [self.view addSubview:compare];
    [self.view addSubview:compareQty];
//    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
//    [name setBackgroundColor:[UIColor blackColor]];
//    name.text=@"Name";
//    [compare addSubview:name];
    
[compare becomeFirstResponder];
    saveButton=[[UIButton alloc]initWithFrame:CGRectMake(245, 7, 65, 33)];
   // [saveButton setBackgroundColor:[UIColor yellowColor]];
   // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setImage:[UIImage imageNamed:@"IM_save-bt.png"]forState:UIControlStateNormal];
    [saveButton setImage:[UIImage imageNamed:@"IM_save-bt_press.png"]forState:UIControlStateHighlighted];
    [saveButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
   // saveButton.userInteractionEnabled=YES;
    [self.view addSubview:saveButton];
    
    
    backButton=[[UIButton alloc]initWithFrame:CGRectMake(6, 7, 58, 33)];
    // [saveButton setBackgroundColor:[UIColor yellowColor]];
    // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"IDMLS_back-button.png"]forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"IDMLS_back-button-press.png"]forState:UIControlStateHighlighted];
[backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // saveButton.userInteractionEnabled=YES;
    [self.view addSubview:backButton];

    
//    NSString *logic=[[NSString alloc]init];
//    logic=compare.text;
//    NSLog(@"%@",logic);
    
    [Flurry logEvent:@"Add Grocery Button Pressed"];
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabbarItem==YES) {
        return NO;
    }
    
    //tabbarItem=NO;
    
    return YES;
}

-(void)hideSaveButton
{
    NSString *chk=[[NSString alloc]initWithFormat:@"%@",[compare text] ];
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [chk stringByTrimmingCharactersInSet:whitespace];
    
    
  
    
    
    if (trimmed.length>0) {
        saveButton.enabled=YES;
        
    }
    else
    {
        saveButton.enabled=NO;
    }

}

-(void)show2
{
    NSString *chk=[[NSString alloc]initWithFormat:@"%@",[compareQty text] ];
    
    
    if (chk.length>0) {
        ingridientQuantity.hidden=YES;
        
    }
    else
    {
        ingridientQuantity.hidden=NO;
    }

}
-(void)showOrHide
{
    NSString *chk=[[NSString alloc]initWithFormat:@"%@",[compare text] ];
    
    
    if (chk.length>0) {
        nameOfIngridient.hidden=YES;
        
    }
    else
    {
        nameOfIngridient.hidden=NO;
    }
}




-(void)search
{
          NSArray *productsPredefined=[[NSArray alloc]initWithObjects: 
                              
                   /// baking begins here
                               @"carob chips",
                               @"melted coconut oil",
                               @"Splenda or Stevia",
                               @"olive oil cooking spray",
                               @"Walden Farms Apple Butter",
                               @"baking powder",
                               @"baking soda",
                               @"unsweetened cocoa powder",
                               @"rice vinegar",
                               @"apple cider vinegar",
                               @"dried coconut",
                               @"walnut oil",
                               @"chicken bouillon concentrate",
                               @"white wine vinegar",
                               @"ice vinegar",
                               @"cornstarch",
                               @"baking powder",
                               @"pure maple syrup",
                               @"baking powder",
                               @"baking soda",
                               @"olive oil cooking spray",
                               @"vegetable oil",
                               @"vegetable broth",
                               @"dried coconut ",
                               @"vanilla extract",
                               @"unrefined coconut oil",
                               @"chocolate chips",
                               @"quinoa flour",
                               @"coconut flour",
                               @"whole wheat flour",
                               @"baking soda",
                        @"pecans",
    
   
    
                              
                               
                  ///nuts begin here
                               @"sunflower seeds",
                               @"macadamia nuts",
                               @"cashews",
                               @"sesame seeds",
                               @"pine nuts",
                               @"almonds",
                               @"walnuts",
                               @"pumpkin seeds",
                               @"almond flour",
                               @"peanut butter",
     
    
                            
                          // ethnic begins here
                               @"fish sauce",
                               @"sesame oil",
                               @"white miso",
                               @"dark sesame oil",
                               @"green salsa",
                               @"chili sauce",
                               @"soy sauce",
                               @"light soy sauce",
                               @"tahini",
   
                       
                          //freezer begins here
                               @"frozen mixed berries",
                               @"frozen cauliflower steamers",
                               @"frozen collard greens",
                               @"frozen blueberries",
                               @"frozen strawberries",
                               @"frozen broccoli florets",
                               @"frozen green peppers",
                               @"frozen snow peas",
                               @"frozen mushrooms",
                               @"frozen peeled shrimp",
                               @"frozen corn kernels",
                               @"frozen raspberries",
                               @"frozen spinach",
                               @"sofrito seasoning",
                               @"recaito seasoning",
    
   
    
                           // pasta begins here
                               @"whole wheat orzo",
                               
                           // broth begins here
                               @"chicken broth",
                               
                           //canned goods
                               @"diced tomatoes",
                               @"stewed tomatoes",
                               @"tomato paste",
                               @"chopped tomatoes",
                               @"diced tomatoes",
                               
                           //grains
                               @"tofu",
                            //seasoning
                               @"garlic powder",
                               @"chili powder",
                               @"sea salt",
                               @"pepper",
                               @"vanilla extract",
                               @"cinnamon and nutmeg",
                               @"cinnamon",
                               @"ground flax seed",
                               @"sea salt",
                               @"braggs",
                               @"red pepper flakes",
                               @"sian spice",
                               @"vegetable broth",
                               @"light soy sauce",
                               @"chili sauce",
                               @"ground pepper",
                               @"chopped fresh oregano",
                               @"vanilla bean",
                               @"dried basil",
                               @"thyme",
                               @"vanilla extract",
                               @"butter extract",
                               @"ground flax seed",
                               @"red pepper flakes",
                               @"garlic powder",
                               @"cream of tarter",
                               @"cinnamon",
                               @"vanilla extract",
                               @"rice vinegar",
                               @"sesame seeds",
                               @"crushed red pepper",
                               @"soy sauce",
                               @"garlic salt",
                               @"Mrs. Dash Garlic",
                               @"white wine vinegar",
                               @"onion powder",
                               @"redmond’s sea salt",
                               @"olive oil",
                               @"dried parsley",
                               @"dijon mustard",
                               @"apple cider vinegar",
                               @"low-sodium soy sauce",
                               @"bay leaf",
                               @"black pepper",
                               @"paprika",
                               @"tamari",
                               @"ground red pepper",
                               @"Chicken broth",
                               @"cayenne",
                               @"all spice",
                               @"apple cider vinegar",
                               @"ground tumeric",
                               @"mild curry powder",
                               @"ground mustard",
                               @"ground ginger",
                               @"sumac powder",
                               @"vegetable stock",
                               @"smoked paprika",
                               @"dried oregano",
                               @"dried rosemary",
                               @"dried thyme",
                               @"celery salt",
                               @"rosemary & garlic seasoning",
                               @"cajun seasoning",
                               @"dried thyme",
                               @"fennel seeds",
                               @"fresh chopped thyme",
                               @"oregano",
                               @"red pepper flakes",
                               @"cumin",
                               @"rosemary blend",
                               @"hot paprika",
                               @"reduced sodium beef broth",
                               @"worcestershire sauce",
                               @"white pepper",
                               @"curry powder",
                               @"pumpkin pie spice",
                               @"vanilla extract",
                               @"pumpkin pie spice",
                               @"nutmeg",
                               @"cinnamon",
                               @"cream of tarter",
                               @"ground cumin",
                               @"vanilla extract",
                               @"italian seasoning",
                               @"black pepper",
                               @"lemon pepper seasoning",
                               @"sazon",
                               @"fennel seeds",
                               @"real sea salt",
                               @"crushed pepper",
                               @"dried basil",
                               @"dried thyme",
                               @"nutmeg",
                               @"vanilla extract",
                               @"real sea salt",
                               @"cayenne pepper",
    
    
                            //condiments begin here
                               @"hot sauce",
                               @"dijon mustard",
                               @"brown mustard",
                               @"spicy mustard",
                               @"grainy mustard",
                               @"mustard",
                               @"brown spicy mustard",
                               @"real maple syrup",
                               @"walden farms peanut spread",
                               
                             // tea coffee
                               @"instant coffee",
                               @"chai tea",

                            //grains:
                               @"rolled oats",
                               @"steel-cut oats",
                               
                               
                             //meat:
                               @"ground turkey",
                               @"lean ground beef",
                               @"turkey bacon",
                               @"boneless skinless chicken breast",
                               @"turkey breast",
                               @"ground chicken breast",
                               @"turkey",
                               @"lean ground beef",
                               @"chicken",
                               @"skinless chicken breast",
                               @"skinless, bone-in chicken thighs",
                               @"chicken breasts",
                               @"pork loin",
                               @"turkey breast",
                               @"round steak",
                               @"turkey bacon",
                               @"uncooked chicken",
                               @"beef stew meat",
                               @"lean steak",
                               @"pepperoni",
                               @"turkey pepperoni",
                               @"boneless pork",
                               @"ground beef",
                               @"boneless pork loin chops",
                               @"pork shoulder roast",
                               @"italian turkey sausage",
                               @"breakfast sausage",
                               @"chicken breasts",
                               @"turkey breast",
                        @"sodium natural ham",
    
   
                            //Seafood:
                               @"shrimp",
                               @"cod fillet",
                               @"salmon steaks",
                               @"shrimp",
                               @"wild salmon",
                               @"salmon",
                               @"bay",
                               @"sea scallops",
                             //walden farms
                               @"Walden Farms pancake syrup",
                            //deli:
                               @"deli ham",
                               
                               
                             //helth:
                               @"ground flax seed",
                               
                               
                            //dairy:
                              
                               @"cottage cheese",
                               @"egg whites",
                               @"butter",
                               @"parmesan cheese",
                               @"heavy cream",
                               @"butter",
                               @"shredded sharp cheddar",
                               @"plain greek yogurt",
                               @"eggs",
                               @"hard boiled eggs",
                               @"dill pickle",
                               @"vanilla greek yogurt",
                               @"plain greek yogurt",
                               @"milk",
                               @"almond milk",
                               @"egg",
                               @"greek yogurt",
                               @"mozzarella cheese",
                               @"melted butter",
                              
    
                            //IWM store:
                               @"approved crispy cereal",
                               @"approved apple cinnamon soy puffs",
                               @"approved vanilla pudding",
                               @"approved vanilla protein powder",
                               @"walden farms mayo",
                               @"walden farms syrup",
                               @"vanilla cream liquid stevia drops",
                               @"walden farms bbq sauce",
                               @"approved strawberry pudding",
                               @"walden farms blue cheese dressing",
                               @"approved wildberry yogurt",
                               @"approved chocolate drink mix",
                               @"approved banana pudding",
                               @"walden farms chocolate dip",
                               @"approved ready made chocolate drink",
                               @"chocolate drink mix",
                               @"approved vanilla pudding",
                               @"walden farms peanut spread",
                               @"walden farms chocolate syrup",
                               @"approved chocolate pancake",
                               @"approved raspberry jello",
                               @"approved chocolate pudding",
                               @"walden farms chocolate syrup",
                               @"walden farms raspberry jam",
                               @"approved plain crepe or pancake",
                               @"approved maple oatmeal",
                               @"approved cappuccino mix",
                               @"approved cookies and cream protein bar",
                               @"approved wildberry yogurt or vanilla pudding",
                               @"walden farms pancake syrup",
                               @"approved peach and mango drink",
                               @"approved wildberry yogurt or vanilla pudding",
                               @"approved plain crepe or pancake",
                               @"approved oatmeal",
                               @"approved butterscotch pudding",
                               @"approved maple oatmeal",
                               @"approved peach and mango drink",
                               @"approved potato purée",
                               @"approved plain crepe or pancake",
                               @"approved rotini",
                               @"approved southwest cheese curls",
                               @"approved pina colada",
                               @"approved cappuccino mix",
                               @"favorite bars",
                               @"approved salt & vinegar ridges",
                               @"approved pudding",
                               @"approved broccoli cheese soup",
    
    
    
                               
                            //Protein:
                               @"vanilla protein powder",
                               
                               
                            //Dressing:
                               @"walden farms balsamic vinegar dressing",
                               
                               
                            //Sauces:
                               @"all-fruit preserves",
                               @"wing sauce",
                               @"no sugar added bruschetta",
                               @"bruschetta",
                               @"hot sauce",
                               @"pizza sauce",
                               @"spaghetti sauce",
                               @"spaghetti sauce with no sugar added",
                               @"tomato sauce with no added sugar",
                               @"tomato sauce",
                               @"horseradish",
                               @"tomato sauce with no sugar added",
                               @"tomato sauce",
                          
                              // Produce
                               @"green cabbage",
                               @"cilantro",
                               @"green onions",
                               @"mushroom",
                               @"grated cauliflower",
                               @"cabbage",
                               @"tomatoes",
                               @"broccoli florets",
                               @"cauliflower florets",
                               @"celery",
                               @"cauliflower",
                               @"garlic cloves",
                               @"garlic",
                               @"limes",
                               @"lemons",
                               @"red onion",
                               @"serrano chili pepper",
                               @"fresh cilantro",
                               @"cucumber",
                               @"bok choy",
                               @"scallions",
                               @"green onions",
                               @"lemon wedges",
                               @"lime juice",
                               @"fresh cilantro",
                               @"lime wedges",
                               @"cilantro leaves",
                               @"fresh ginger",
                               @"ginger",
                               @"mild salsa",
                               @"fresh cilantro",
                               @"Jalapeno peppers",
                               @"large zucchinis",
                               @"zucchinis",
                               @"zucchini",
                               @"fresh spinach",
                               @"spinach",
                               @"onions",
                               @"chives",
                               @"parsley",
                               @"red onion",
                               @"cherry tomatoes",
                               @"cucumbers",
                               @"pint cherry tomatoes",
                               @"vidalia onion",
                               @"fresh parsley leaves",
                               @"okra",
                               @"onion",
                               @"lemon juice",
                               @"roma tomatoes",
                               @"cucumber",
                               @"red onion",
                               @"parsley",
                               @"lemon",
                               @"celery",
                               @"green peppers",
                               @"lime juice",
                               @"rainbow chard",
                               @"eggplant",
                               @"fresh basil",
                               @"zucchini",
                               @"yellow squash",
                               @"shallots",
                               @"tomato",
                               @"fresh basil",
                               @"ripe bananas",
                               @"bananas",
                               @"unsweetened applesauce",
                               @"raisins",
                               @"turnips",
                               @"green pepper",
                               @"stalk celery",
                               @"vine-ripe tomatoes",
                               @"basil",
                               @"basil leaves",
                               @"oregano leaves",
                               @"rosemary leaves",
                               @"small clove garlic",
                               @"brussels sprouts",
                               @"spinach",
                               @"broccoli",
                               @"eggplant",
                               @"yellow squash",
                               @"zucchini",
                               @"fresh basil",
                               @"red bell pepper",
                               @"small tomato",
                               @"small onion",
                               @"cucumbers",
                               @"radishes",
                               @"tomatoes",
                               @"grilled yellow pepper",
                               @"red onion",
                               @"lemon juice",
                               @"sage",
                               @"thyme",
                               @"rosemary",
                               @"raw broccoli florets",
                               @"red bell pepper",
                               @"green bell pepper",
                               @"orange bell pepper",
                               @"ginger root",
                               @"green beans",
                               @"turnips",
                               @"plum tomatoes",
                               @"white onion",
                               @"garlic",
                               @"pitted dates",
                               @"blueberries",
                               @"strawberries",
                               @"blackberries",
                               @"raspberries",
                               @"leeks",
                               @"celery stalks",
                               @"green pepper",
                               @"green onions",
                               @"fresh parsley",
                               @"large green peppers",
                               @"salsa",
                               @"cilantro",
                               @"kale",
                               @"stalk celery",
                               @"banana",
                               @"apple",
                               @"fresh lemon",
                               @"pitted dates",
                               @"bananas",
                               @"green beans",
                               @"zest of a lemon",
                               @"zucchini",
                               @"ginger root",
                               @"kale",
                               @"avocado",
                               @"carrot",
                               @"cucumber",
                               @"red onion",
                               @"collard greens",
                               @"bean sprouts",
                               @"large zucchini",
                               @"lemon juice",
                               @"herbs",
                               @"ginger",
                               @"lemon juice",
                               @"rosemary",
                               @"shallots",
                               @"cabbage",
                               @"lemon juice",
                               @"garlic",
                               @"limes",
                               @"fresh cilantro",
                               @"green tomatoes",
                               @"red pepper",
                               @"poblano pepper",
                               @"chopped garlic",
                               @"small garlic clove",
                               @"ginger",
                               @"fresh ginger",
                               @"garlic",
                               @"seeded cucumber",
                               @"green onions",
                               @"onion",
                               @"fennel bulbs",
                               @"thyme",
                               @"zest",
                               @"celery heart stalks",
                               @"grated ginger",
                               @"red pepper",
                               @"yellow pepper",
                               @"roma tomatoes",
                               @"zucchini",
                               @"grated parmesan cheese",
                               @"clove garlic",
                               @"whole large zucchini",
                               @"yellow onion",
                               @"basil leaves",
                               @"shallot",
                               @"portobello mushrooms",
                               @"lime",
                               @"cloves garlic",
                               @"celery stalks",
                               @"chopped mushrooms",
                               @"soybean sprouts",
                               @"green peppers",
                               @"green onions",
                               @"fresh ginger",
                               @"cloves garlic",
                               @"chopped spinach",
                               @"chopped peppers",
                               @"mixed berries",
                               @"pitted dates",
                               @"cherry tomatoes",
                               @"fresh dill",
                               @"bell peppers",
                               @"watermelon radishes",
                               @"cauliflower",
                               @"chopped spinach",
                               @"shallot",
                               @"lemon zest",
                               @"snow peas",
                               @"baby bella mushrooms",
                               @"shallots",
                               @"portobello mushroom caps",
                               @"sweet red pepper strips",
                               @"cubed zucchini",
                               @"turnip",
                               @"yellow squash",
                               @"large roma tomatoes",
                               @"fresh cilantro",
                               @"chile peppers",
                               @"slaw mix",
                               @"green beans",
                               @"okra",
                               @"chopped tomatoes",
                               @"bok choy",
                               @"fresh ginger",
                               @"pitted dates",
                               @"strawberries",
                               @"purple onion",
                               @"celery stalks",
                               @"lemon or lime",
                               @"handful of chopped fresh mint",
                               @"chopped red onion",
                               @"sweet potato",
                               @"shredded cabbage",
                               @"yellow bell pepper",
                               @"radishes",
                               @"firm silken tofu",
                               @"lemon juice",
                               @"roasted red [peppers",
                               @"garlic minced",
                               @"lime juice",
                               @"raw spinach",
                               @"yellow banana peppers",
                               @"eggplant",
                               @"collard leaves",
                               @"grated zucchini",
                               @"dried cranberries",
                               nil];
  
    // NSLog(@"%d",[productsPredefined count]);
    NSArray *type=[[NSArray alloc]initWithObjects:

                   
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   @"baking",
                   
                   
                   
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   @"nuts",
                   
                   
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   @"ethnic",
                   
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   @"freezer",
                   
                   @"pasta",
                   
                   @"broth",
                   
                   @"canned goods",
                    @"canned goods",
                    @"canned goods",
                    @"canned goods",
                    @"canned goods",
                   
                   @"grains",
                   
                   
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                   @"seasoning",
                
                   
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   @"condiments",
                   
                   @"tea/coffee",
                   @"tea/coffee",
                   
                    @"grains",
                    @"grains",
                   
                   
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   @"meat",
                   

                   @"sea food",
                   @"sea food",
                   @"sea food",
                   @"sea food",
                   @"sea food",
                   @"sea food",
                   @"sea food",
                   @"sea food",
                   
                   
                   @"walden farms",
                   
                   @"deli",
                   
                   @"health",
                   
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   @"dairy",
                   
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",

                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",

                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                   @"iwm store",
                 
                   @"protein",
                   
                   @"dressing",
                   
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   @"sauces",
                   
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   @"produce",
                   nil];
    
    
               
                   
                 

    NSString *name=[[NSString alloc]initWithFormat:@"%@",[compare text] ] ;

    name=[name lowercaseString];
    NSString *qty=[[NSString alloc]initWithFormat:@"%@",[compareQty text] ] ;
   
    
    // NSLog(@"%@",qty);
     //NSLog(@"%@",name);

    
  int w = [productsPredefined indexOfObject:name];
    //NSLog(@"%d",w);
    
    if(NSNotFound == w) {
        NSLog(@"not found");
        
        NSString *sql=[NSString stringWithFormat:@"INSERT INTO info('Type','Name','Quantity')VALUES ('%@','%@','%@')",@"other",name,qty];
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            
            sqlite3_close(db);
            NSAssert(0, @"could not update table");
            
        }
        
        
        
      
        [self back];
        
        
    }else
    {
    NSString *value=[[NSString alloc]initWithFormat:@"%@",[type objectAtIndex:w]];
   // NSLog(@"%@",value);
    
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO info('Type','Name','Quantity')VALUES ('%@','%@','%@')",value,name,qty];
    char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
            
            sqlite3_close(db);
            NSAssert(0, @"could not update table");
            
        }
        
        
       
       
        [self back];
        
          //[self newfunction];
       // [listTable reloadData];
        
        
    }
     [self back];
    [Flurry logEvent:@"Save(Grocery) Button Pressed"];
}

-(void)back
{   [labeltimer invalidate];
    [labeltimer2 invalidate];
     [labeltimer3 invalidate];
    [base removeFromSuperview];
    [backButton removeFromSuperview];
    [saveButton removeFromSuperview];
    [compare removeFromSuperview];
    [compareQty removeFromSuperview];
    [ingridientQuantity removeFromSuperview];
    [nameOfIngridient removeFromSuperview];
    [compare resignFirstResponder];
     [self newfunction];
    
}






























@end


