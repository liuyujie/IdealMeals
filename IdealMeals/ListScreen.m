//
//  ListScreen.m
//  Movie Quotes
//
//  Created by Samar's Mac on 21/11/12.
//  Copyright (c) 2012 contact@click-labs.com. All rights reserved.
//

#import "ListScreen.h"
#import "searchScreen.h"
#import "favouriteScreen.h"
#import "HelpScreen.h"
#import "shakeScreen.h"
#import "UpgradeScreen.h"
#import "MoreScreen.h"
#import "InfoScreen.h"
@interface ListScreen ()

@end

@implementation ListScreen
@synthesize listJson;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    bannerViews = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerViews.adUnitID = @"a150cb026a52b75";
    // [bannerView setBackgroundColor:[UIColor redColor]];
    bannerViews.rootViewController = self;
    
    [bannerViews loadRequest:[GADRequest request]];
    selectedListArray=[[NSMutableArray alloc]init];
    
       
    
    quoteListArray=[listJson valueForKey:@"quotes"];
    movieListArray=[listJson valueForKey:@"movies"];
    yearListArray=[listJson valueForKey:@"year"];

     
    
    
    
    dumyQuoteListArray=[[NSMutableArray alloc]init];
    for(int i=0;i<quoteListArray.count;i++){
    s = [NSString stringWithFormat:@"%@",[quoteListArray objectAtIndex:i]];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"'"];
     s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    //dumyQuoteListArray = [[NSArray alloc]initWithObjects:s, nil];
    [dumyQuoteListArray addObject:s];

    }
 
    if( !Bool ) Bool =[[NSMutableArray alloc]init];
    for(int i=0;i< [quoteListArray count] ;i++)
    {
        [Bool addObject:@"0"];
    }

  

    
	// Do any additional setup after loading the view.

    backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    [backgroundImageView setUserInteractionEnabled:YES];
    [self.view addSubview:backgroundImageView];
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"Pro"])
    {
        NSLog(@"its free version");
        [backgroundImageView addSubview:bannerViews];
        
    }
    else
    {
        NSLog(@"its pro version");
        
    }

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        
        if(![[NSUserDefaults standardUserDefaults]boolForKey:@"Pro"])
        {
            NSLog(@"its free version");
            listTable =[[UITableView alloc]initWithFrame:CGRectMake(5, 140, 310, 330)];
            
            [backgroundImageView setImage:[UIImage imageNamed:@"listBackgroundi5.jpg"]];
            
        }
        else
        {
            NSLog(@"its pro version");
            listTable =[[UITableView alloc]initWithFrame:CGRectMake(5, 96, 310, 380)];
            
            [backgroundImageView setImage:[UIImage imageNamed:@"listBackgroundProi5.jpg"]];
        }

               
        
        shakeButton= [[UIButton alloc]initWithFrame:CGRectMake(96, 480, 128, 62)];
        
        helpButton=[[UIButton alloc]initWithFrame:CGRectMake(195, 487, 125, 43)];
        
        listButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 530, 80, 38)];
        
        searchButton =[[UIButton alloc]initWithFrame:CGRectMake(80, 530, 80, 37)];
        
        favButton =[[UIButton alloc]initWithFrame:CGRectMake(160, 530, 80, 38)];
        
        
        
        moreButton =[[UIButton alloc]initWithFrame:CGRectMake(240, 530, 80, 38)];
        
        backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 487, 120, 43)];
        
        
        
        //buttons to save others buttons from being clicked
        
        rightButton =[[UIButton alloc]initWithFrame:CGRectMake(195, 480, 35, 30)];
        [rightButton setUserInteractionEnabled:YES];
        [rightButton setBackgroundColor:[UIColor clearColor]];
        
        leftButton =[[UIButton alloc]initWithFrame:CGRectMake(90, 480, 30, 30)];
        [leftButton setUserInteractionEnabled:YES];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        
        btmButton =[[UIButton alloc]initWithFrame:CGRectMake(130, 530, 60, 8)];
        [btmButton setUserInteractionEnabled:YES];
        [btmButton setBackgroundColor:[UIColor clearColor]];
        btn1 =[[UIButton alloc]initWithFrame:CGRectMake(100, 510, 20, 20)];
        [btn1 setUserInteractionEnabled:YES];
        [btn1 setBackgroundColor:[UIColor clearColor]];
        
        btn2 =[[UIButton alloc]initWithFrame:CGRectMake(195, 510, 25, 20)];
        [btn2 setUserInteractionEnabled:YES];
        [btn2 setBackgroundColor:[UIColor clearColor]];
        
        btn3 =[[UIButton alloc]initWithFrame:CGRectMake(65, 486, 30, 10)];
        [btn3 setUserInteractionEnabled:YES];
        [btn3 setBackgroundColor:[UIColor clearColor]];
        
        
        btn4 =[[UIButton alloc]initWithFrame:CGRectMake(225, 486, 30, 10)];
        [btn4 setUserInteractionEnabled:YES];
        [btn4 setBackgroundColor:[UIColor clearColor]];
    }
    
    
    else{
        //iphone4
        
        
        
        if(![[NSUserDefaults standardUserDefaults]boolForKey:@"Pro"])
        {
            NSLog(@"its free version");
            listTable =[[UITableView alloc]initWithFrame:CGRectMake(5, 140, 310, 250)];
            [backgroundImageView setImage:[UIImage imageNamed:@"listBackgroundi4.jpg"]];
        }
        else
        {
            NSLog(@"its pro version");
            listTable =[[UITableView alloc]initWithFrame:CGRectMake(5, 96, 310, 290)];
            [backgroundImageView setImage:[UIImage imageNamed:@"listBackgroundProi4.jpg"]];
        }

       
        shakeButton= [[UIButton alloc]initWithFrame:CGRectMake(95, 390, 128, 62)];
        
        helpButton=[[UIButton alloc]initWithFrame:CGRectMake(195, 398, 125, 43)];
        
        backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 398, 125, 45)];
              
        listButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 442, 80, 38)];
      
        
        searchButton =[[UIButton alloc]initWithFrame:CGRectMake(80, 442, 80, 37)];
               
        
        favButton =[[UIButton alloc]initWithFrame:CGRectMake(160, 441, 80, 38)];
              
        
        moreButton =[[UIButton alloc]initWithFrame:CGRectMake(240, 442, 80, 38)];
               
        rightButton =[[UIButton alloc]initWithFrame:CGRectMake(193, 390, 35, 30)];
        [rightButton setUserInteractionEnabled:YES];
        [rightButton setBackgroundColor:[UIColor clearColor]];
        
        leftButton =[[UIButton alloc]initWithFrame:CGRectMake(93, 390, 30, 30)];
        [leftButton setUserInteractionEnabled:YES];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        
        btmButton =[[UIButton alloc]initWithFrame:CGRectMake(145, 443, 30, 8)];
        [btmButton setUserInteractionEnabled:YES];
        [btmButton setBackgroundColor:[UIColor clearColor]];
        btn1 =[[UIButton alloc]initWithFrame:CGRectMake(100, 420, 20, 20)];
        [btn1 setUserInteractionEnabled:YES];
        [btn1 setBackgroundColor:[UIColor clearColor]];
        
        btn2 =[[UIButton alloc]initWithFrame:CGRectMake(193, 420, 25, 20)];
        [btn2 setUserInteractionEnabled:YES];
        [btn2 setBackgroundColor:[UIColor clearColor]];
        
        btn3 =[[UIButton alloc]initWithFrame:CGRectMake(65, 400, 30, 10)];
        [btn3 setUserInteractionEnabled:YES];
        [btn3 setBackgroundColor:[UIColor clearColor]];
        
        
        btn4 =[[UIButton alloc]initWithFrame:CGRectMake(225, 400, 30, 10)];
        [btn4 setUserInteractionEnabled:YES];
        [btn4 setBackgroundColor:[UIColor clearColor]];
        
       
               
    
    }

    
    listButton.enabled=NO;
     listTable.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableBackgroundi4.png"]];

    [shakeButton setImage:[UIImage imageNamed:@"shakei4.png"] forState:UIControlStateNormal];
    [shakeButton setImage:[UIImage imageNamed:@"shake-onclicki4.png"] forState:UIControlStateHighlighted];
    [helpButton setImage:[UIImage imageNamed:@"helpi4.png"] forState:UIControlStateNormal];
    [helpButton setImage:[UIImage imageNamed:@"help-onclicki4.png"] forState:UIControlStateHighlighted];
    [moreButton setImage:[UIImage imageNamed:@"morei4.png"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"more-onclicki4.png"] forState:UIControlStateHighlighted];
    [favButton setImage:[UIImage imageNamed:@"favoritei4.png"] forState:UIControlStateNormal];
    [favButton setImage:[UIImage imageNamed:@"favorite-onclicki4.png"] forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"backi4.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back-onclicki4.png"] forState:UIControlStateHighlighted];
    [listButton setImage:[UIImage imageNamed:@"listi4.png"] forState:UIControlStateNormal];
    [listButton setImage:[UIImage imageNamed:@"list-onclicki4.png"] forState:UIControlStateHighlighted];
    [searchButton setImage:[UIImage imageNamed:@"searchi4.png"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"search-onclicki4.png"] forState:UIControlStateHighlighted];
    

    
    [shakeButton addTarget:self action:@selector(infoScreen) forControlEvents:UIControlEventTouchUpInside];
    [shakeButton setUserInteractionEnabled:YES];
    
    [listButton addTarget:self action:@selector(listScreen) forControlEvents:UIControlEventTouchUpInside];
    [listButton setUserInteractionEnabled:NO];
    
    [favButton addTarget:self action:@selector(favScreen) forControlEvents:UIControlEventTouchUpInside];
    [favButton setUserInteractionEnabled:YES];
    
    [searchButton addTarget:self action:@selector(searchScreen) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setUserInteractionEnabled:YES];
    
    [helpButton addTarget:self action:@selector(helpScreen) forControlEvents:UIControlEventTouchUpInside];
    [helpButton setUserInteractionEnabled:YES];
    
    [backButton addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [backButton setUserInteractionEnabled:YES];
    [moreButton addTarget:self action:@selector(moreScreen) forControlEvents:UIControlEventTouchUpInside];

    listTable.delegate=self;
    listTable.dataSource=self;
    
    [listTable setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:listTable];
 
    [self.view addSubview:shakeButton];
    [self.view addSubview:helpButton];
    [self.view addSubview:backButton];
    [self.view addSubview:favButton];
    [self.view addSubview:searchButton];
    [self.view addSubview:listButton];
    [self.view addSubview:moreButton];
    [self.view addSubview:rightButton];
    [self.view addSubview:leftButton];
    [self.view addSubview:btmButton];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
    [self.view addSubview:btn5];
    [self.view addSubview:btn6];
    
    
}
- (BOOL)textFieldShouldReturn:(UISearchBar *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)moreScreen
{
    [self performSegueWithIdentifier:@"more" sender:self];
    
}


-(void)infoScreen
{
    [self performSegueWithIdentifier:@"shake" sender:self];
}

-(void)listScreen
{
    [self performSegueWithIdentifier:@"list" sender:self];
    
}
-(void)favScreen
{
    
       
    [self performSegueWithIdentifier:@"fav" sender:self];
    
}

-(void)searchScreen
{
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"Pro"])
    {
        [self performSegueWithIdentifier:@"search" sender:self];
        
    }
    else
    {
        
        UIAlertView *upgradeAlert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Do You want to Upgrade your app to  enable Search Options?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        [upgradeAlert show];
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"YES"])
    {
        [self performSegueWithIdentifier:@"upgrade" sender:self];
    }
}

-(void)helpScreen
{
    
    [self performSegueWithIdentifier:@"help" sender:self];
}

-(void)backClicked
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--------------------------TableView____________________________//


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section    {
    return quoteListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        UITextView *te = (UITextView *)[cell.contentView viewWithTag:1];
        [te removeFromSuperview];
        te = nil;
        UITextView *te1 = (UITextView *)[cell.contentView viewWithTag:2];
        [te1 removeFromSuperview];
        te1 = nil;
        UITextView *te2 = (UITextView *)[cell.contentView viewWithTag:3];
        [te2 removeFromSuperview];
        te2 = nil;
        
        UIImageView *img1=(UIImageView *)[cell.contentView viewWithTag:8];
        [img1 removeFromSuperview];
        
        UIImageView *img2=(UIImageView *)[cell.contentView viewWithTag:7];
        [img2 removeFromSuperview];
        
        UIScrollView *scr=(UIScrollView *)[cell.contentView viewWithTag:21];
        [scr removeFromSuperview];
        

    
    }
        
    UITextField *quoteView=[[UITextField alloc] init ];
    quoteView.frame=CGRectMake(5, 5, 290, 20);
    [quoteView setBackgroundColor:[UIColor clearColor]];
    [quoteView setTag:1];
    //quoteView.editable=NO;
    [quoteView setText:[quoteListArray objectAtIndex:indexPath.row]];
    quoteView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [quoteView setTextAlignment:NSTextAlignmentCenter];
    [quoteView setUserInteractionEnabled:NO];
    [cell.contentView addSubview:quoteView];
      UIImageView * divider1=[[UIImageView alloc]initWithFrame:CGRectMake(135, 22, 8, 3)];
    //[divider1 setBackgroundColor:[UIColor greenColor]];
    [divider1 setImage:[UIImage imageNamed:@"divider-signi4.png"]];
    [divider1 setTag:8];
    [cell.contentView addSubview:divider1];
    
    //s = [NSString stringWithFormat:@"%@",[quoteListArray objectAtIndex:indexPath.row]];
   // NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"'"];
    //s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    //[quoteView setText:s];
   // NSLog(@"s=====%@",s);
    
    UITextField *movieView=[[UITextField alloc] init ];
      movieView.frame=CGRectMake(5,  28, 259, 20);
    [movieView setBackgroundColor:[UIColor clearColor]];
    [movieView setTag:2];
    [movieView setTextAlignment:NSTextAlignmentCenter];
    [movieView setUserInteractionEnabled:NO];

    [movieView setText:[movieListArray objectAtIndex:indexPath.row]];
    [movieView setTextAlignment:NSTextAlignmentCenter];
    movieView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [cell.contentView addSubview:movieView];
  

  UIImageView *  divider2=[[UIImageView alloc]initWithFrame:CGRectMake(135, 50, 8, 3)];
    //[divider2 setBackgroundColor:[UIColor orangeColor]];
    [divider2 setImage:[UIImage imageNamed:@"divider-signi4.png"]];
    //[divider2 setBackgroundColor:[UIColor redColor]];
    [divider2 setTag:7];
   // [cell.contentView addSubview:divider2];
    [cell.contentView addSubview:divider2];
    
    UITextField *yearView=[[UITextField alloc] init ];
    yearView.frame=CGRectMake(5,55, 259, 15);
    [yearView setBackgroundColor:[UIColor clearColor]];
    [yearView setText:[yearListArray objectAtIndex:indexPath.row]];
    [yearView setTextAlignment:NSTextAlignmentCenter];
    yearView.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [yearView setTag:3];
    [yearView setUserInteractionEnabled:NO];
   
    [cell.contentView addSubview:yearView];
   
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    
    
    
    UIImage *image;
	if([[Bool objectAtIndex:indexPath.row]isEqualToString:@"1"])
        image = [UIImage imageNamed:@"checked.png"];
    
    
    else
        image = [UIImage imageNamed:@"unchecked.png"];

	button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 10.0, image.size.width, image.size.height);
	button.frame = frame;
	[button setTag:((indexPath.section & 0xFFFF) << 16) |
     (indexPath.row & 0xFFFF)];
    
    [button setImage:image forState:UIControlStateNormal];
	[button setSelected:NO];
    
	// set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
	
    [button addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    cell.accessoryView = button;

      return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)checkButtonTapped:(UIButton *)sender
{

    NSUInteger section = ((sender.tag >> 16) & 0xFFFF);
    NSUInteger row     = (sender.tag & 0xFFFF);
    NSLog(@"Button in section %i on row %i was pressed.", section, row);
    
    quote = [NSString stringWithFormat:@"%@",[dumyQuoteListArray objectAtIndex:row]] ;
    movie = [NSString stringWithFormat:@"%@",[movieListArray objectAtIndex:row]] ;
    year = [NSString stringWithFormat:@"%@",[yearListArray objectAtIndex:row]] ;
  //  NSLog(@"%@ %@ %@",quote,movie,year);
    
    
    
    
    s = [NSString stringWithFormat:@"%@",quote];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"'"];
    s = [[s componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
       if([[Bool objectAtIndex:row]isEqualToString:@"0"])
    {
        NSLog(@"path -----  %@",databasePath);
        
    
        [Bool replaceObjectAtIndex:row withObject:@"1"];
        
        databasePath=[[NSUserDefaults standardUserDefaults]valueForKey:@"databasepath"];
        sqlite3_stmt    *statement;
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &MovieQuotesDB) == SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO QuotesTable (ID,Quotes, Movies, Year) VALUES (?,\"%@\", \"%@\", \"%@\")",s, movie, year];
           // NSLog(@"INSERT Query   %@",insertSQL);
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_int64 sqlite3_last_insert_rowid(sqlite3*);
            
            
            sqlite3_prepare_v2(MovieQuotesDB, insert_stmt,
                               -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"value is saved");
            } else {
                NSLog(@"value is not saved");
            }
            sqlite3_finalize(statement);
            sqlite3_close(MovieQuotesDB);
        }
        
    }
    
    
    else
    {
        
        // [button setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        // [arr removeObject:string];
        [Bool replaceObjectAtIndex:row withObject:@"0"];
        
        
        databasePath = [[NSUserDefaults standardUserDefaults]valueForKey:@"databasepath"];
        //-- --- - - -- ---------- - ------
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt    *statement=nil;
        
        if (sqlite3_open(dbpath, &MovieQuotesDB) == SQLITE_OK)
        {
            // NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(MovieQuotesDB));
            
            NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM QuotesTable"];
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(MovieQuotesDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                NSString*  ids=[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                [idArray addObject:[NSString stringWithFormat:@"%@", ids ]];
                }
                sqlite3_finalize(statement);
            }
            //sqlite3_close(MovieQuotesDB);
        }
        
        
        //--Retrieve the values of database
        
       // NSLog(@"%@",idArray);
        //[idArray removeObjectAtIndex:row];
       // NSLog(@"%@",idArray);
        
        if (sqlite3_open(dbpath, &MovieQuotesDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM  QuotesTable WHERE Quotes=\'%@\'",[dumyQuoteListArray objectAtIndex:row]];
            const char *query_stmt = [querySQL UTF8String];
            sqlite3_prepare_v2(MovieQuotesDB, query_stmt,-1, &statement, NULL);
            if (sqlite3_step(statement) != SQLITE_DONE)
            {
                NSLog(@"Problem with prepare statement: %s", sqlite3_errmsg(MovieQuotesDB));
            }
            else
            {
                NSLog(@"Record Deleted");
            }

            // sqlite3_close(mydatabase);
        }sqlite3_close(MovieQuotesDB);
        
        //[self updateId];
    }
    
    //[idArray removeAllObjects];
    
    [listTable reloadData];
    

	
   
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //index=[NSString stringWithFormat:@"%d",indexPath.row ]  ;
    //NSLog(@"index=%@",index);
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"listcellclicked"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [selectedListArray addObject:[quoteListArray objectAtIndex:indexPath.row]];
    [selectedListArray addObject:[movieListArray objectAtIndex:indexPath.row]];
    [selectedListArray addObject:[yearListArray objectAtIndex:indexPath.row]];
   // NSLog(@"selectedarray=%@",selectedListArray);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self performSegueWithIdentifier:@"info" sender:self];
}


/*-(void)updateId
{
    //globalVariable *obj=[globalVariable getInstance];
    
    //--updating id in database
      
    databasePath = [[NSUserDefaults standardUserDefaults]valueForKey:@"databasepath"];
    
    //--Retrieve the values of database
    
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt *statement = nil;
    
    if (sqlite3_open(dbpath, &MovieQuotesDB) == SQLITE_OK)
    {
        for(int i = 0;i<[idArray count];i++)
        {
            //   NSLog(@"replace %@ with %d",[idArray objectAtIndex:i  ],i+1);
            NSString *querySQL = [NSString stringWithFormat: @"UPDATE QuotesTable SET ID =%d WHERE ID = %@",i+1,[idArray objectAtIndex:i]];
           // NSLog(@"Update query = %@",querySQL);
            //NSLog(@"Data = %@",querySQL);
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(MovieQuotesDB ,query_stmt , -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSLog(@"updated");
                }
                
                sqlite3_finalize(statement);
            }
            // sqlite3_close(mydatabase);
            
        }sqlite3_close(MovieQuotesDB);
        
    }
}
*/

//-------------------------Shaking function_______________

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [listTable reloadData];
    selectedListArray=nil;
    selectedListArray=[[NSMutableArray alloc]init];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
    
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"strt");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self performSegueWithIdentifier:@"shake" sender:self];
        
    }
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"list"])
    {
        ListScreen  *list=[segue destinationViewController];
        list.listJson=listJson;
        
    }
    
    
    if([segue.identifier isEqualToString:@"search"])
    {
        searchScreen  *search=[segue destinationViewController];
        search.listJson=listJson;
        
    }
    
    if([segue.identifier isEqualToString:@"fav"])
    {
        favouriteScreen  *fav=[segue destinationViewController];
        fav.listJson=listJson;
        
    }
    
    
    if([segue.identifier isEqualToString:@"help"])
    {
        HelpScreen  *hlp=[segue destinationViewController];
        hlp.listJson=listJson;
    }
    
    if([segue.identifier isEqualToString:@"shake"])
    {
        shakeScreen *shake=[segue destinationViewController];
        shake.listJson=listJson;
        
    }
    
    if([segue.identifier isEqualToString:@"upgrade"])
    {
        //NSLog(@"upjson=%@",listJson);
        UpgradeScreen *up=[segue destinationViewController];
        up.listJson=listJson;
        
    }
    
    if([segue.identifier isEqualToString:@"more"])
    {
        MoreScreen *more=[segue destinationViewController];
        more.listJson=listJson;
        
    }
    
    if([segue.identifier isEqualToString:@"info"])
    {
        InfoScreen  *info=[segue destinationViewController];
        //NSLog(@"yeararray=%@",selectedArray);
        info.selectedListArray=selectedListArray;
        info.listJson=listJson;
        info.listQuoteArray=quoteListArray;
        info.listMovieArray=movieListArray;
        info.listYearArray=yearListArray;
        //info.index=index;
    }



    
}



@end
