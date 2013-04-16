//
//  IMFirstViewController.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 17/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMmeals.h"
#import "IMProductList.h"
unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
@interface IMmeals ()

@end

@implementation IMmeals
@synthesize bottomView;
@synthesize calView;
@synthesize monthTitle;
@synthesize currentDate,left,right,dateLabel,addAMeal,monthButton,datePicker,accessory1,deleteButton1,saveButton,mailButton;
@synthesize accessory2,accessory3,accessory4;
@synthesize deleteButton2,deleteButton3,deleteButton4,transform;

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Meals-21.png"]
                          withFinishedUnselectedImage:[UIImage imageNamed:@"Meals21.png"]];
        }else
        {
        
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IM_i5_icons_0001_MEALS.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"IM_i5_icons_0000_MEALS-copy.png"]];    }}
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
          //NSLog(@"table created 2");
        
    }
    
    
}

-(void)createTable3:(NSString *)tableName

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
         //NSLog(@"table created 3");
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getTags];
    [self fillCalendar];
    UIStoryboardSegue *segue;
    IMProductList *vc = [segue destinationViewController];
     [self.tabBarController setDelegate:self];
    [vc.products removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:vc.products forKey:@"productArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
  //  NSLog(@"%@hhhh",vc.products);
    
}

- (void)viewDidLoad
{
    [self openDB];
    [self createTable2:@"calendar" withField1:@"Date" withField2:@"Breakfast" withField3:@"Lunch" withField4:@"Dinner" withField5:@"Other"];
    
    [self createTable3:@"email" withField1:@"Date" withField2:@"Breakfast" withField3:@"Lunch" withField4:@"Dinner" withField5:@"Other"];
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [self.tabBarController setDelegate:self];
    
    
    meals=[[NSArray alloc]initWithObjects:@"Breakfast",@"Lunch",@"Dinner",@"Other", nil];
    
    //self.tabBarController.selectedIndex=4;
   // newView=[[IMdayview alloc]init];
    dayArray=[[NSMutableArray alloc]init];
	//self.navigationItem.title = @"Calendar";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, d MMM"];
    
    
	// set today
	today = [[NSDate alloc] initWithTimeIntervalSinceNow:1];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init] ;
    [dateFormatter2 setDateFormat:@"MMM d, yyyy"];
    dateForPicker=[[NSString alloc]init];
    dateForPicker = [dateFormatter2 stringFromDate:today];
    
    [[NSUserDefaults standardUserDefaults]setObject:dateForPicker forKey:@"datePickerDate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    string = [dateFormatter stringFromDate:today];
    //NSLog(@"%@",string);
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"todaydate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //NSLog(@"today date is %@",today);
    
	//set the default calendar type
	calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
	//set the current day to show the calendar
	NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
	[components setDay:1];
    [self getTags];
	self.currentDate = [calendar dateFromComponents:components];
	
	[self fillCalendar];
    [self todayDate];
   //; [super viewDidLoad];
    
  [super viewDidLoad];
 
}


- (IBAction)mailSavedPortion:(id)sender {
    
    
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
        
        NSString *sql=[NSString stringWithFormat:@"SELECT   *  FROM email "];
        sqlite3_stmt  *statement;
        
        int o=1;
        
        if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                char *field0=(char *) sqlite3_column_text(statement, 0);
                NSString *field0Str=[[ NSString alloc]initWithUTF8String:field0];
                
                char *field1=(char *) sqlite3_column_text(statement, 1);
                NSString *field1Str=[[ NSString alloc]initWithUTF8String:field1];
                
                char *field2=(char *) sqlite3_column_text(statement, 2);
                NSString *field2Str=[[ NSString alloc]initWithUTF8String:field2];
                
                char *field3=(char *) sqlite3_column_text(statement, 3);
                NSString *field3Str=[[ NSString alloc]initWithUTF8String:field3];
                
                char *field4=(char *) sqlite3_column_text(statement, 4);
                NSString *field4Str=[[ NSString alloc]initWithUTF8String:field4];
                
               
                field1Str=[field1Str stringByReplacingOccurrencesOfString:@"Nothing planned." withString:@"n/a"];
                field2Str=[field2Str stringByReplacingOccurrencesOfString:@"Nothing planned." withString:@"n/a"];
                field3Str=[field3Str stringByReplacingOccurrencesOfString:@"Nothing planned." withString:@"n/a"];
                field4Str=[field4Str stringByReplacingOccurrencesOfString:@"Nothing planned." withString:@"n/a"];
                
                field1Str=[NSString stringWithFormat:@"[%@] (B)",field1Str];
                field2Str=[NSString stringWithFormat:@"[%@] (L)",field2Str];
                field3Str=[NSString stringWithFormat:@"[%@] (D)",field3Str];
                field4Str=[NSString stringWithFormat:@"[%@] (O)",field4Str];
                
                
                
                NSString *str= [[NSString alloc] initWithFormat:@"%d:  %@ :- %@ , %@ , %@ , %@",o, field0Str,field1Str,field2Str,field3Str,field4Str];
                
                
                [emailArray addObject:str];
               
                o++;
                
            }
            
        }
        
        
        // NSLog(@"%@",emailArray);
        
        NSString *string1 = [emailArray componentsJoinedByString:@"\n\n"];
        //  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:emailArray];
        
        [mailer setMessageBody:string1 isHTML:NO];
        
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
    
    
    
    
    
    [Flurry logEvent:@"Meal Plans email Button Pressed"];
    
}










-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabBarItem==YES) {
        return NO;
    }
    
   // tabBarItem=NO;
   
     return YES;
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
        {
            
            NSString *deleteQuery=[NSString stringWithFormat:@"DELETE FROM email"];
            char *error;
           if (sqlite3_exec(db, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
           }
            
        }
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



-(void)fetchFromDatabse
{
    
    breakfastString= [[NSString alloc]init];
    lunchString= [[NSString alloc]init];
    dinnerString= [[NSString alloc] init];
    otherString= [[NSString alloc] init];
    
   // NSLog(@"%@",dateForDatabase);
    NSString *sql=[NSString stringWithFormat:@"SELECT   *  FROM calendar WHERE  Date IS '%@'",dateForDatabase];
    sqlite3_stmt  *statement;
    
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            
            char *field1=(char *) sqlite3_column_text(statement, 1);
            NSString *field1Str= field1 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field1];
            
            char *field2=(char *) sqlite3_column_text(statement, 2);
            NSString *field2Str = field2 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field2];
            
            char *field3=(char *) sqlite3_column_text(statement, 3);
            NSString *field3Str= field3 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field3];
            
            char *field4=(char *) sqlite3_column_text(statement, 4);
            NSString *field4Str= field4 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field4];
            
           
            
            
            
            breakfastString= [[NSString alloc] initWithFormat:@"%@", field1Str];
             lunchString= [[NSString alloc] initWithFormat:@"%@", field2Str];
             dinnerString= [[NSString alloc] initWithFormat:@"%@", field3Str];
             otherString= [[NSString alloc] initWithFormat:@"%@", field4Str];
          
            
        }
        
    }

 //   NSLog(@"%@",breakfastString);
    //NSLog(@"%@",lunchString);
  ////  NSLog(@"%@",dinnerString);
   // NSLog(@"%@",otherString);
}




- (void)fillCalendar
{//UIView *calendarContainer;
	
    CGFloat orgx;
    CGFloat orgy;
    CGRect dayVFrame;
    // this is the placeholder for the calendar
	UIView *calendarContainer = calView.superview;
	// main view (screen view)
    UIView *view ;
    // [view setFrame:CGRectMake(0, 0, 300, 400)];
	view = calendarContainer.superview;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
          dayVFrame = CGRectMake(0, 200, self.calView.frame.size.width, self.calView.frame.size.height);
    }
    else
    {
      dayVFrame = CGRectMake(0, 96, self.calView.frame.size.width, self.calView.frame.size.height); 
    }
	
	//CGRect dayVFrame = CGRectMake(0, 0,300,400) ;
	// creating a new calendar, I will add all the days in this view
	[calView removeFromSuperview];
	//[calView release];
	calView = [[UIView alloc] initWithFrame:dayVFrame];
	[calView setBackgroundColor:calView.backgroundColor];
	
	// add this calendar inside the placeholder
	[calendarContainer addSubview:calView];
	
	// setting up the month title
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"MMMM yyyy"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        monthTitle.font=[UIFont systemFontOfSize:35];
        
    }else
    {
    monthTitle.font=[UIFont systemFontOfSize:20];
    }
    monthTitle.textColor=[self getColorByRed:46 green:79 blue:103];
	NSString *rg=[df stringFromDate:currentDate];
    [monthTitle setText:[rg uppercaseString]];
	//[df release];
    
	
	// extracting components from date
	NSDateComponents *components = [calendar components:units fromDate:currentDate];
	
	// change for the first day
	[components setDay:1];
	
	
	// update the component
	components = [calendar components:units fromDate:[calendar dateFromComponents:components]];
	
	[components setDay:-[components weekday]+2];
	
	int lessDay = [components day];
	int month = [components month];
	int year = [components year];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        orgx=55;
        orgy=43;
    }
    else
    {
    
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
         orgx=16;
        orgy=40;
    }
    else
    {
	
        orgx=16;
        orgy=0;
	}}
	int m=month;
	for (int week=0; week<6 && month==m; week++)
	{
		for (int d=0; d<7; d++)
		{
			[components setDay:lessDay];
			
			int d =[[calendar components:units fromDate:[calendar dateFromComponents:components]] day];
			m =[[calendar components:units fromDate:[calendar dateFromComponents:components]] month];
			int y =[[calendar components:units fromDate:[calendar dateFromComponents:components]] year];
			dateString=[[NSString alloc]initWithFormat:@"%d-%d-%d ",d,month,year];
			//NSLog(@"%@",dateString);
            
           // [dayArray addObject:dateString];
			
			UIButton *button = [self createBtn:d orgx:orgx orgy:orgy];
            
            
			if ((m<month && y==year) || y<year) {
				[button addTarget:self action:@selector(prevMonth:) forControlEvents:UIControlEventTouchDown];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                 [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                [imageMeal removeFromSuperview];
                [button setBackgroundImage:[UIImage imageNamed:@"IM_i4_cal-el_0010_Shape-31-copy-11.png"] forState:UIControlStateNormal];
                //[imageLunch removeFromSuperview];
                //[imageSanck removeFromSuperview];
                //[imageDinner removeFromSuperview];
				//[button setTitleColor:[self getColorByRed:141 green:148 blue:157] forState:UIControlStateNormal];
               
			}else if ((m>month && y==year)|| y>year) {
				[button addTarget:self action:@selector(nextMonth:) forControlEvents:UIControlEventTouchDown];
                [ button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                [imageMeal removeFromSuperview];
                 [button setBackgroundImage:[UIImage imageNamed:@"IM_i4_cal-el_0010_Shape-31-copy-11.png"] forState:UIControlStateNormal];
                //[imageLunch removeFromSuperview];
                //[imageSanck removeFromSuperview];
                //[imageDinner removeFromSuperview];
				//[button setTitleColor:[self getColorByRed:141 green:148 blue:157] forState:UIControlStateNormal];
			}else {
				//[button addTarget:self action:@selector(prevMonth:) forControlEvents:UIControlEventTouchDown];
			}
        
			[calView addSubview:button];
           // calView.userInteractionEnabled=YES;
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            {
                orgx+=94;
            }else
            {
			orgx+=42;
			}
                lessDay++;
		}
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            
            orgx=55;
            orgy+=100;
        }
        else{
		orgy+=48;
		orgx=16;
        }
				[components setDay:lessDay];
		m =[[calendar components:units fromDate:[calendar dateFromComponents:components]] month];
	}
	
	[self.left setFrame:CGRectMake(0, 10, 20, 20)];
	//[UIView beginAnimations: nil context: nil];
	//[UIView setAnimationDuration: 1.5];
	//NSLog(@"%f",orgx);
    //NSLog(@"%f",orgy);
	[self.calView setFrame:CGRectMake(self.calView.frame.origin.x,
									  self.calView.frame.origin.y,
									  self.calView.frame.size.width,
									  orgy)];
   
	//[calView setBackgroundColor:[UIColor redColor]];
//	[calView.layer removeAllAnimations];
	//put the height of the header;
	orgy += calendarContainer.frame.origin.y;
	int remaningH = view.frame.size.height-orgy;
	
	[self.bottomView setFrame:CGRectMake(self.bottomView.frame.origin.x,
										 orgy,
										 self.bottomView.frame.size.width,
										 remaningH)];

	
	
}


- (UIButton*) createBtn:(int)day orgx:(CGFloat)orgx orgy:(CGFloat)orgy{
   // int todayTag=[[NSUserDefaults standardUserDefaults]integerForKey:@"todayTag"];
	UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
     NSDateFormatter *dateFormatMonth = [[NSDateFormatter alloc] init];
    [dateFormatMonth setDateFormat:@"MM"];
    [dateFormat setDateFormat:@"yyyy"];
    NSString *dateTag = [dateFormatMonth stringFromDate:currentDate];
    int month=[dateTag intValue];
    if (month==1) {
        month +=12;
    }
    
    
    NSString *dateTag1 = [dateFormat stringFromDate:currentDate];
    int year =[dateTag1 intValue];
  //  NSLog(@"datefor tag is %d-%d=%d",day,month,year);
    int buttonTag=day+((month*month*month*month)*year) ;
    //NSLog(@"button tags is %d",buttonTag);
    imageMeal=[[UIImageView alloc]initWithFrame:CGRectMake(0  ,32, 38, 13)];
   
    //imageMeal.backgroundColor = [UIColor blackColor];
    imageMeal.userInteractionEnabled = NO;
    imageMeal.exclusiveTouch = NO;
    [button1 addSubview:imageMeal];
	[button1 setBackgroundImage:[UIImage imageNamed:@"IM_i4_cal-el_0010_Shape-31-copy-11.png"] forState:UIControlStateNormal];
    
	[button1 setBackgroundImage:[UIImage imageNamed:@"calender_bg_orange.png"] forState:UIControlStateHighlighted];
	// Configure title(s)
	[button1 setTitle:[NSString stringWithFormat:@"%d", day] forState:UIControlStateNormal];
    [button1 setTag:buttonTag];
    //[button1 setTitleColor:[self getColorByRed:141 green:148 blue:157] forState:UIControlStateNormal];
     [button1 setTitleColor:[self getColorByRed:46 green:79 blue:103] forState:UIControlStateNormal];
	button1.userInteractionEnabled=YES;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
	[button1.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
	}
    else
    {
        [button1.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }
    
    [button1 addTarget:self action:@selector(showDateOnClickAndSave:) forControlEvents:UIControlEventTouchUpInside];
  
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        button1.frame=CGRectMake(orgx, orgy, 94, 100);
        
    }else{
	button1.frame=CGRectMake(orgx, orgy, 38, 45);
    }
    
    int occurrences = 0;
    
    NSString *buttonTagString=[[NSString alloc]initWithFormat:@"%d",buttonTag ];
    //NSLog(@"%@",tagArray);
    //NSLog(@"%@",buttonTagString);
    for(NSString *string2 in tagArray){
        
        occurrences += ([string2 isEqualToString:buttonTagString] ?1:0);
    }


    
    if (occurrences==1) {
         [imageMeal setImage:[UIImage imageNamed:@"IdealMeals_assigned-icon.png"]];    }
	
	return button1;
}

-(void)getTags
{
    NSDate *newDate ;
    int month;
    int day;
    int year;
    tagArray=[[NSMutableArray alloc]init];
    NSString *sql=[NSString stringWithFormat:@"SELECT   *  FROM calendar"];
    sqlite3_stmt  *statement;
    NSMutableArray *newArray=[[NSMutableArray alloc]init];
    NSString *field0Str;
   
    
    if (sqlite3_prepare(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            char *field0=(char *) sqlite3_column_text(statement, 0);
            field0Str=[[ NSString alloc]initWithUTF8String:field0];
            
            char *field1=(char *) sqlite3_column_text(statement, 1);
             NSString *field1Str= field1 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field1];
            char *field2=(char *) sqlite3_column_text(statement, 2);
            NSString *field2Str = field2 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field2];
            char *field3=(char *) sqlite3_column_text(statement, 3);
             NSString *field3Str= field3 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field3];
            char *field4=(char *) sqlite3_column_text(statement, 4);
           NSString *field4Str= field4 == NULL ? nil :[[ NSString alloc]initWithUTF8String:field4];            
            
//             if (field1Str ==(id)[NSNull null] &&field2Str ==(id)[NSNull null]&&field3Str ==(id)[NSNull null]&&field4Str ==(id)[NSNull null])
//             {
            if (field1Str.length==0 && field2Str.length==0&&field3Str .length==0&&field4Str.length==0) {
                
               // NSLog(@"empty");
             }
            else{
            
             [newArray addObject:field0Str];
             
             }
    
            
            }
        }
    
    // NSLog(@"%@",newArray);
    for (int r=0; r<[newArray count]; r++) {
        
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init] ;
    [dateFormatter2 setDateFormat:@"MMM d, yyyy"];
        NSString *newString=[[NSString alloc]initWithFormat:@"%@",[newArray objectAtIndex:r] ];
    NSDate *calendarButton=[dateFormatter2 dateFromString:newString];
        int daysToAdd = 0;
        newDate = [calendarButton dateByAddingTimeInterval:60*60*24*daysToAdd];
       // NSLog(@"%@",newDate);
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatMonth = [[NSDateFormatter alloc] init];
        NSDateFormatter *dateFormatYear = [[NSDateFormatter alloc] init];
        [dateFormatMonth setDateFormat:@"MM"];
        [dateFormatYear setDateFormat:@"yyyy"];
        [dateFormat setDateFormat:@"dd"];
        NSString *dayTag = [dateFormat stringFromDate:newDate];
        NSString *monthTag = [dateFormatMonth stringFromDate:newDate];
        NSString *yearTag = [dateFormatYear stringFromDate:newDate];
        
        month=[monthTag intValue];
        day=[dayTag intValue];
        year=[yearTag intValue];
        if (month==1) {
            month +=12;
                }

          int buttonTag=day+((month*month*month*month)*year);
        NSString *tagString=[[NSString alloc]initWithFormat:@"%d",buttonTag ];
        [tagArray addObject:tagString];
        
    }
    
    //NSLog(@"%@",tagArray);
    
//    NSLog(@"%d",day);
//     NSLog(@"%d",month);
//     NSLog(@"%d",year);

    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [dayImageView removeFromSuperview];
    [selection removeFromSuperview];
    [self backFromAdd];
    [self back];
    [self noClicked];
}
- (UIColor*)getColorByRed:(float)r green:(float)g blue:(float)b{
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
   // return [UIColor whiteColor];
}

- (void)setCurrentDate:(NSDate *)value {
	
	//[currentDate release];
	currentDate = value;
	
	// redraw the calendar
	[self reloadCalendar];
	[self currentDateHasChanged];
}

- (IBAction)nextMonth:(id)action{
	// extracting components from date
	NSDateComponents *components = [calendar components:units fromDate:currentDate];
	components.month = components.month + 1;
	self.currentDate = [calendar dateFromComponents:components];
}

- (IBAction)prevMonth:(id)action{
	// extracting components from date
	NSDateComponents *components = [calendar components:units fromDate:currentDate];
	components.month = components.month - 1;
	self.currentDate = [calendar dateFromComponents:components];
}

- (void)reloadCalendar {

  
	[self.calView setFrame:CGRectMake(self.calView.frame.origin.x,
									  self.calView.frame.origin.y + self.calView.frame.size.height,
									  self.calView.frame.size.width,
									  self.calView.frame.size.height)];
	 
	// resizing the bottom view as well
	int orgy = -200+ self.calView.frame.size.height;
	int remaningH = calView.superview.superview.frame.size.height-orgy;
	
	[self.bottomView setFrame:CGRectMake(self.bottomView.frame.origin.x,
										 orgy,
										 self.bottomView.frame.size.width,
										 remaningH)];
     [self fillCalendar];
  //  [calView.layer removeAllAnimations];

	
}

- (void)currentDateHasChanged {
	// do some job when the date change
	
	//NSLog(@"date changed");
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)todayDate
{   NSDateFormatter *dateFormatDay = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatYear = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatMonth = [[NSDateFormatter alloc] init];
     [dateFormatDay setDateFormat:@"dd"];
    [dateFormatMonth setDateFormat:@"MM"];
    [dateFormatYear setDateFormat:@"yyyy"];
    NSString *dayString = [dateFormatDay stringFromDate:today];
    int day=[dayString intValue];
    
    
    NSString *monthString = [dateFormatMonth stringFromDate:today];
    int month =[monthString intValue];
    if (month==1) {
        month+=12;
    }
    NSString *yearString = [dateFormatYear stringFromDate:today];
    int year =[yearString intValue];
    //  NSLog(@"datefor tag is %d-%d=%d",day,month,year);
    int buttonTag=day+((month*month*month*month)*year);

    //NSLog(@"today button tag is %d ",buttonTag);
    [[NSUserDefaults standardUserDefaults]setInteger:buttonTag forKey:@"todayTag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)viewDidUnload {
    [super viewDidUnload];
	
    
	self.calView = nil;
	self.monthTitle = nil;
	self.bottomView = nil;
	self.bottomViewLeft = nil;
    [dayImageView removeFromSuperview];
	
}

- (void)saveData {
    
     tabBarItem=NO;
    NSString *sql=[NSString stringWithFormat:@"INSERT INTO email('Date','Breakfast','Lunch','Dinner','Other')VALUES ('%@','%@','%@','%@','%@')",[dateLabel text],[breakfastLabel text],[lunchLabel text],[dinnerLabel text],[otherLabel text]];
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)!= SQLITE_OK) {
        
        //            sqlite3_close(db);
        //            NSAssert(0, @"could not update table");
        
        NSString *insertSQL=[NSString stringWithFormat:@"UPDATE email SET Breakfast=('%@'),Lunch=('%@'),Dinner=('%@'),Other=('%@')  WHERE Date IS ('%@')",[breakfastLabel text],[lunchLabel text],[dinnerLabel text],[otherLabel text],[dateLabel text]];
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
    
    [self noClicked];
     [Flurry logEvent:@"Meal Save Button Pressed"];
}



-(void)noClicked
{
    tabBarItem=NO;
    [fadeScreen removeFromSuperview];
    [clearNo removeFromSuperview];
    [clearYes removeFromSuperview];
}
-(void)savePopUp

{
    tabBarItem=YES;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        fadeScreen=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
        [fadeScreen setImage:[UIImage imageNamed:@"IM_i5_screen-fader.png"]];
        fadeScreen.userInteractionEnabled=YES;
        savePopUp=[[UIImageView alloc]initWithFrame:CGRectMake(40, 200, 240, 180)];
        [savePopUp setImage:[UIImage imageNamed:@"IM_i5_popup-save.png"]];
        savePopUp.userInteractionEnabled=YES;
        [fadeScreen addSubview:savePopUp];
        clearNo=[[UIButton alloc]initWithFrame:CGRectMake(20, 115, 85    , 35)];
        [clearNo setImage:[UIImage imageNamed:@"IM_cancel-bt-popup.png"]forState:UIControlStateNormal];
        [clearNo setImage:[UIImage imageNamed:@"IM_cancel-bt-popup_press.png"]forState:UIControlStateHighlighted];
        [clearNo addTarget:self action:@selector(noClicked) forControlEvents:UIControlEventTouchUpInside];
        [savePopUp addSubview:clearNo];
        clearYes=[[UIButton alloc]initWithFrame:CGRectMake(133, 115, 85    , 35)];
        [clearYes setImage:[UIImage imageNamed:@"IM_save-bt-popup.png"]forState:UIControlStateNormal];
        [clearYes setImage:[UIImage imageNamed:@"IM_save-bt-popup_press.png"]forState:UIControlStateHighlighted];
        [clearYes addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
        [savePopUp addSubview:clearYes];
        [self.view addSubview:fadeScreen];

    }
    else
    {
        fadeScreen=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
        [fadeScreen setImage:[UIImage imageNamed:@"IM_i5_screen-fader.png"]];
        fadeScreen.userInteractionEnabled=YES;
        savePopUp=[[UIImageView alloc]initWithFrame:CGRectMake(40, 150, 240, 180)];
        [savePopUp setImage:[UIImage imageNamed:@"IM_i5_popup-save.png"]];
        savePopUp.userInteractionEnabled=YES;
        [fadeScreen addSubview:savePopUp];
        clearNo=[[UIButton alloc]initWithFrame:CGRectMake(20, 115, 85    , 35)];
        [clearNo setImage:[UIImage imageNamed:@"IM_cancel-bt-popup.png"]forState:UIControlStateNormal];
        [clearNo setImage:[UIImage imageNamed:@"IM_cancel-bt-popup_press.png"]forState:UIControlStateHighlighted];
        [clearNo addTarget:self action:@selector(noClicked) forControlEvents:UIControlEventTouchUpInside];
        [savePopUp addSubview:clearNo];
        clearYes=[[UIButton alloc]initWithFrame:CGRectMake(133, 115, 85    , 35)];
        [clearYes setImage:[UIImage imageNamed:@"IM_save-bt-popup.png"]forState:UIControlStateNormal];
        [clearYes setImage:[UIImage imageNamed:@"IM_save-bt-popup_press.png"]forState:UIControlStateHighlighted];
        [clearYes addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
        [savePopUp addSubview:clearYes];
        [self.view addSubview:fadeScreen];
    }
}

-(void)addAView
{
    
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        
        dayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768 , 975)];
        [dayImageView setImage:[UIImage imageNamed:@"My-calendar.jpg"]];
        
        monthImage=[[UIImageView alloc]initWithFrame:CGRectMake(126  , 900, 183, 44)];
        [monthImage setImage:[UIImage imageNamed:@"Day-month2.png"]];
        [dayImageView addSubview:monthImage];
        monthButton=[UIButton buttonWithType:UIButtonTypeCustom];
        monthButton=[[UIButton alloc]initWithFrame:CGRectMake(217, 900, 91, 44)];
        // [monthButton setBackgroundImage:[UIImage imageNamed:@"IM_current-date_box-50.png"]forState:UIControlStateNormal];
        [monthButton addTarget:self action:@selector(monthSelected) forControlEvents:UIControlEventTouchUpInside];
        [dayImageView addSubview:monthButton];
        mailButton=[[UIButton alloc]initWithFrame:CGRectMake(335, 195, 100    , 90)];
        [mailButton setBackgroundImage:[UIImage imageNamed:@"IM__0001_Vector-Smart-Object.png"]forState:UIControlStateNormal];
        [mailButton setBackgroundImage:[UIImage imageNamed:@"IM__0000_Vector-Smart-Object-copy-5.png"]forState:UIControlStateHighlighted];
        [mailButton addTarget:self action:@selector(savePopUp) forControlEvents:UIControlEventTouchUpInside];
        
        
        [dayImageView addSubview:mailButton];
        dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(150, 130, 468, 50)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        dateLabel.textAlignment=UITextAlignmentCenter;
        dateLabel.textColor=[self getColorByRed:46 green:79 blue:103];
        dateLabel.font = [UIFont systemFontOfSize:35];
        [dayImageView addSubview:dateLabel];
        
        
        
        addAMeal=[[UIButton alloc]initWithFrame:CGRectMake(400, 900, 100, 44)];
        [addAMeal setBackgroundImage:[UIImage imageNamed:@"IM_addmeal-button.png"]forState:UIControlStateNormal];
        [addAMeal setBackgroundImage:[UIImage imageNamed:@"IM_addmeal-button-press.png"]forState:UIControlStateHighlighted];
        [addAMeal addTarget:self action:@selector(pushMyNewViewController) forControlEvents:UIControlEventTouchUpInside];
        [addAMeal setExclusiveTouch:YES];
        [dayImageView addSubview:addAMeal];
        
        
        breakfastImage=[[UIImageView alloc]initWithFrame:CGRectMake(115, 320, 540, 100)];
        [breakfastImage setImage:[UIImage imageNamed:@"IM__0005_BREAKFAST.png"]];
        breakfastImage.userInteractionEnabled=YES;
        [dayImageView addSubview:breakfastImage];
        
        
        LeftGesturesRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed1)];
        [LeftGesturesRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [breakfastImage addGestureRecognizer:LeftGesturesRecognizer];
        
        breakfastLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 390, 100)];
        breakfastLabel.textColor=[UIColor blackColor];
        [breakfastLabel setBackgroundColor:[UIColor blackColor]];
        breakfastLabel.textAlignment=UITextAlignmentLeft;
        breakfastLabel.numberOfLines=3;
        //[breakfastLabel setFont:[UIFont systemFontOfSize:30]];
        breakfastLabel.text=breakfastString;
        if ([breakfastString isEqualToString:@"(null)"]||[breakfastString isEqualToString:@""]) {
            breakfastLabel.text=@"Nothing planned.";
            breakfastLabel.textColor=[UIColor lightGrayColor];
            breakfastLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        breakfastLabel.font = [UIFont systemFontOfSize:22];
        
        
        [breakfastImage addSubview:breakfastLabel];
        
        
        
        lunchImage=[[UIImageView alloc]initWithFrame:CGRectMake(115, 430, 540, 100)];
        [lunchImage setImage:[UIImage imageNamed:@"IM__0004_LUNCH.png"]];
        lunchImage.userInteractionEnabled=YES;
        [dayImageView addSubview:lunchImage];
        
        
        
        lunchLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 390, 100)];
        lunchLabel.textColor=[UIColor blackColor];
        [lunchLabel setBackgroundColor:[UIColor clearColor]];
        lunchLabel.textAlignment=UITextAlignmentLeft;
        lunchLabel.numberOfLines=3;
        lunchLabel.text=lunchString;
        if ([lunchString isEqualToString:@"(null)"]||[lunchString isEqualToString:@""]) {
            lunchLabel.text=@"Nothing planned.";
            lunchLabel.textColor=[UIColor lightGrayColor];
            lunchLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        lunchLabel.font = [UIFont systemFontOfSize:22];
        
        
        [lunchImage addSubview:lunchLabel];
        
        LeftGesturesRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed2)];
        [LeftGesturesRecognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [lunchImage addGestureRecognizer:LeftGesturesRecognizer1];
        
        dinnerImage=[[UIImageView alloc]initWithFrame:CGRectMake(115, 540, 540, 100)];
        [dinnerImage setImage:[UIImage imageNamed:@"IM__0003_DINNER.png"]];
        dinnerImage.userInteractionEnabled=YES;
        [dayImageView addSubview:dinnerImage];
        
        
        
        
        dinnerLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 390, 100)];
        dinnerLabel.textColor=[UIColor blackColor];
        [dinnerLabel setBackgroundColor:[UIColor clearColor]];
        dinnerLabel.textAlignment=UITextAlignmentLeft;
        dinnerLabel.text=dinnerString;
        dinnerLabel.numberOfLines=3;
        if ([dinnerString isEqualToString:@"(null)"]||[dinnerString isEqualToString:@""]) {
            dinnerLabel.text=@"Nothing planned.";
            dinnerLabel.textColor=[UIColor lightGrayColor];
            dinnerLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        dinnerLabel.font = [UIFont systemFontOfSize:22];
        
        [dinnerImage addSubview:dinnerLabel];
        
        LeftGesturesRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed3)];
        [LeftGesturesRecognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [dinnerImage addGestureRecognizer:LeftGesturesRecognizer2];
        
        otherImage=[[UIImageView alloc]initWithFrame:CGRectMake(115, 650, 540, 100)];
        [otherImage setImage:[UIImage imageNamed:@"IM__0002_OTHER.png"]];
        otherImage.userInteractionEnabled=YES;
        [dayImageView addSubview:otherImage];
        
        
        
        
        otherLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 390, 100)];
        otherLabel.textColor=[UIColor blackColor];
        [otherLabel setBackgroundColor:[UIColor clearColor]];
        otherLabel.textAlignment=UITextAlignmentLeft;
        otherLabel.numberOfLines=3;
        otherLabel.text=otherString;
        if ([otherString isEqualToString:@"(null)" ]||[otherString isEqualToString:@""]) {
            otherLabel.text=@"Nothing planned.";
            otherLabel.textColor=[UIColor lightGrayColor];
            otherLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        otherLabel.font = [UIFont systemFontOfSize:22];
        
        [otherImage addSubview:otherLabel];
        
        LeftGesturesRecognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed4)];
        [LeftGesturesRecognizer3 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [otherImage addGestureRecognizer:LeftGesturesRecognizer3];
        
        
        deleteButton1=[[UIButton alloc]initWithFrame:CGRectMake(450, 25, 0    , 50)];
        [deleteButton1 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton1 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
        deleteButton1.hidden=YES;
        [breakfastImage addSubview:deleteButton1];
        
        deleteButton2=[[UIButton alloc]initWithFrame:CGRectMake(450, 25, 0    , 50)];
        [deleteButton2 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton2 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton2 addTarget:self action:@selector(deletePressed2) forControlEvents:UIControlEventTouchUpInside];
        deleteButton2.hidden=YES;
        [lunchImage addSubview:deleteButton2];
        
        deleteButton3=[[UIButton alloc]initWithFrame:CGRectMake(450, 25, 0    , 50)];
        [deleteButton3 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton3 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton3 addTarget:self action:@selector(deletePressed3) forControlEvents:UIControlEventTouchUpInside];
        deleteButton3.hidden=YES;
        [dinnerImage addSubview:deleteButton3];
        
        deleteButton4=[[UIButton alloc]initWithFrame:CGRectMake(450, 25, 0    , 50)];
        [deleteButton4 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //[deleteButton4 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton4 addTarget:self action:@selector(deletePressed4) forControlEvents:UIControlEventTouchUpInside];
        deleteButton4.hidden=YES;
        [otherImage addSubview:deleteButton4];
        
        //    accessory1=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory1 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory1 addTarget:self action:@selector(accessoryPressed1) forControlEvents:UIControlEventTouchUpInside];
        //    accessory1.hidden=NO;
        //    [breakfastImage addSubview:accessory1];
        //
        //    accessory2=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory2 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory2 addTarget:self action:@selector(accessoryPressed2) forControlEvents:UIControlEventTouchUpInside];
        //    [lunchImage addSubview:accessory2];
        //
        //    accessory3=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory3 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory3 addTarget:self action:@selector(accessoryPressed3) forControlEvents:UIControlEventTouchUpInside];
        //    [dinnerImage addSubview:accessory3];
        //
        //    accessory4=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory4 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory4 addTarget:self action:@selector(accessoryPressed4) forControlEvents:UIControlEventTouchUpInside];
        //    [otherImage addSubview:accessory4];
        
        removeDelete1=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete1 setBackgroundColor:[UIColor clearColor]];
        [removeDelete1 addTarget:self action:@selector(removeDelete1) forControlEvents:UIControlEventTouchUpInside];
        [breakfastImage addSubview:removeDelete1];
        
        removeDelete2=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete2 setBackgroundColor:[UIColor clearColor]];
        [removeDelete2 addTarget:self action:@selector(removeDelete2) forControlEvents:UIControlEventTouchUpInside];
        [lunchImage addSubview:removeDelete2];
        
        
        removeDelete3=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete3 setBackgroundColor:[UIColor clearColor]];
        [removeDelete3 addTarget:self action:@selector(removeDelete3) forControlEvents:UIControlEventTouchUpInside];
        [dinnerImage addSubview:removeDelete3];
        
        removeDelete4=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete4 setBackgroundColor:[UIColor clearColor]];
        [removeDelete4 addTarget:self action:@selector(removeDelete4) forControlEvents:UIControlEventTouchUpInside];
        [otherImage addSubview:removeDelete4];
        
        
        
        dayImageView.userInteractionEnabled=YES;
        [self.view addSubview:dayImageView];

        
    }
    else
    {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        
        dayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
        [dayImageView setImage:[UIImage imageNamed:@"IM_i5_day-bg.jpg"]];
        
        monthImage=[[UIImageView alloc]initWithFrame:CGRectMake(50  , 447, 133, 35)];
        [monthImage setImage:[UIImage imageNamed:@"IM_cal-view-switch_day.png"]];
        [dayImageView addSubview:monthImage];
        monthButton=[UIButton buttonWithType:UIButtonTypeCustom];
        monthButton=[[UIButton alloc]initWithFrame:CGRectMake(120, 447, 66, 35)];
        // [monthButton setBackgroundImage:[UIImage imageNamed:@"IM_current-date_box-50.png"]forState:UIControlStateNormal];
        [monthButton addTarget:self action:@selector(monthSelected) forControlEvents:UIControlEventTouchUpInside];
        [dayImageView addSubview:monthButton];
        mailButton=[[UIButton alloc]initWithFrame:CGRectMake(136, 127, 50    , 40)];
        [mailButton setBackgroundImage:[UIImage imageNamed:@"IM__0001_Vector-Smart-Object.png"]forState:UIControlStateNormal];
        [mailButton setBackgroundImage:[UIImage imageNamed:@"IM__0000_Vector-Smart-Object-copy-5.png"]forState:UIControlStateHighlighted];
        [mailButton addTarget:self action:@selector(savePopUp) forControlEvents:UIControlEventTouchUpInside];
        
        
        [dayImageView addSubview:mailButton];
        dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 68, 220, 40)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        dateLabel.textAlignment=UITextAlignmentCenter;
        dateLabel.textColor=[self getColorByRed:46 green:79 blue:103];
        dateLabel.font = [UIFont systemFontOfSize:21];
        [dayImageView addSubview:dateLabel];
        
        
        
        addAMeal=[[UIButton alloc]initWithFrame:CGRectMake(200, 447, 100, 35)];
        [addAMeal setBackgroundImage:[UIImage imageNamed:@"IM_addmeal-button.png"]forState:UIControlStateNormal];
        [addAMeal setBackgroundImage:[UIImage imageNamed:@"IM_addmeal-button-press.png"]forState:UIControlStateHighlighted];
        [addAMeal addTarget:self action:@selector(pushMyNewViewController) forControlEvents:UIControlEventTouchUpInside];
        [addAMeal setExclusiveTouch:YES];
        [dayImageView addSubview:addAMeal];
        
        
        breakfastImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 185, 290, 53)];
        [breakfastImage setImage:[UIImage imageNamed:@"IM__0005_BREAKFAST.png"]];
        breakfastImage.userInteractionEnabled=YES;
        [dayImageView addSubview:breakfastImage];
        
        
        LeftGesturesRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed1)];
        [LeftGesturesRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [breakfastImage addGestureRecognizer:LeftGesturesRecognizer];
        
        breakfastLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
        breakfastLabel.textColor=[UIColor blackColor];
        [breakfastLabel setBackgroundColor:[UIColor clearColor]];
        breakfastLabel.textAlignment=UITextAlignmentLeft;
        breakfastLabel.numberOfLines=3;
        breakfastLabel.text=breakfastString;
        if ([breakfastString isEqualToString:@"(null)"]||[breakfastString isEqualToString:@""]) {
            breakfastLabel.text=@"Nothing planned.";
            breakfastLabel.textColor=[UIColor lightGrayColor];
            breakfastLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        breakfastLabel.font = [UIFont systemFontOfSize:14];
        
        
        [breakfastImage addSubview:breakfastLabel];
        
        
        
        lunchImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 243, 290, 53)];
        [lunchImage setImage:[UIImage imageNamed:@"IM__0004_LUNCH.png"]];
        lunchImage.userInteractionEnabled=YES;
        [dayImageView addSubview:lunchImage];
        
        
        
        lunchLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
        lunchLabel.textColor=[UIColor blackColor];
        [lunchLabel setBackgroundColor:[UIColor clearColor]];
        lunchLabel.textAlignment=UITextAlignmentLeft;
        lunchLabel.numberOfLines=3;
        lunchLabel.text=lunchString;
        if ([lunchString isEqualToString:@"(null)"]||[lunchString isEqualToString:@""]) {
            lunchLabel.text=@"Nothing planned.";
            lunchLabel.textColor=[UIColor lightGrayColor];
            lunchLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        lunchLabel.font = [UIFont systemFontOfSize:14];
        
        
        [lunchImage addSubview:lunchLabel];
        
        LeftGesturesRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed2)];
        [LeftGesturesRecognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [lunchImage addGestureRecognizer:LeftGesturesRecognizer1];
        
        dinnerImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 301, 290, 53)];
        [dinnerImage setImage:[UIImage imageNamed:@"IM__0003_DINNER.png"]];
        dinnerImage.userInteractionEnabled=YES;
        [dayImageView addSubview:dinnerImage];
        
        
        
        
        dinnerLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
        dinnerLabel.textColor=[UIColor blackColor];
        [dinnerLabel setBackgroundColor:[UIColor clearColor]];
        dinnerLabel.textAlignment=UITextAlignmentLeft;
        dinnerLabel.text=dinnerString;
        dinnerLabel.numberOfLines=3;
        if ([dinnerString isEqualToString:@"(null)"]||[dinnerString isEqualToString:@""]) {
            dinnerLabel.text=@"Nothing planned.";
            dinnerLabel.textColor=[UIColor lightGrayColor];
            dinnerLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        dinnerLabel.font = [UIFont systemFontOfSize:14];
        
        [dinnerImage addSubview:dinnerLabel];
        
        LeftGesturesRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed3)];
        [LeftGesturesRecognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [dinnerImage addGestureRecognizer:LeftGesturesRecognizer2];
        
        otherImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 359, 290, 53)];
        [otherImage setImage:[UIImage imageNamed:@"IM__0002_OTHER.png"]];
        otherImage.userInteractionEnabled=YES;
        [dayImageView addSubview:otherImage];
        
        
        
        
        otherLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
        otherLabel.textColor=[UIColor blackColor];
        [otherLabel setBackgroundColor:[UIColor clearColor]];
        otherLabel.textAlignment=UITextAlignmentLeft;
        otherLabel.numberOfLines=3;
        otherLabel.text=otherString;
        if ([otherString isEqualToString:@"(null)" ]||[otherString isEqualToString:@""]) {
            otherLabel.text=@"Nothing planned.";
            otherLabel.textColor=[UIColor lightGrayColor];
            otherLabel.textAlignment=UITextAlignmentCenter;
        }
        
        
        otherLabel.font = [UIFont systemFontOfSize:14];
        
        [otherImage addSubview:otherLabel];
        
        LeftGesturesRecognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed4)];
        [LeftGesturesRecognizer3 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
        [otherImage addGestureRecognizer:LeftGesturesRecognizer3];
        
        
        deleteButton1=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0    , 33)];
        [deleteButton1 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton1 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
        deleteButton1.hidden=YES;
        [breakfastImage addSubview:deleteButton1];
        
        deleteButton2=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton2 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton2 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton2 addTarget:self action:@selector(deletePressed2) forControlEvents:UIControlEventTouchUpInside];
        deleteButton2.hidden=YES;
        [lunchImage addSubview:deleteButton2];
        
        deleteButton3=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton3 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton3 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton3 addTarget:self action:@selector(deletePressed3) forControlEvents:UIControlEventTouchUpInside];
        deleteButton3.hidden=YES;
        [dinnerImage addSubview:deleteButton3];
        
        deleteButton4=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton4 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //[deleteButton4 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton4 addTarget:self action:@selector(deletePressed4) forControlEvents:UIControlEventTouchUpInside];
        deleteButton4.hidden=YES;
        [otherImage addSubview:deleteButton4];
        
        //    accessory1=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory1 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory1 addTarget:self action:@selector(accessoryPressed1) forControlEvents:UIControlEventTouchUpInside];
        //    accessory1.hidden=NO;
        //    [breakfastImage addSubview:accessory1];
        //
        //    accessory2=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory2 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory2 addTarget:self action:@selector(accessoryPressed2) forControlEvents:UIControlEventTouchUpInside];
        //    [lunchImage addSubview:accessory2];
        //
        //    accessory3=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory3 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory3 addTarget:self action:@selector(accessoryPressed3) forControlEvents:UIControlEventTouchUpInside];
        //    [dinnerImage addSubview:accessory3];
        //
        //    accessory4=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
        //    [accessory4 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
        //    [accessory4 addTarget:self action:@selector(accessoryPressed4) forControlEvents:UIControlEventTouchUpInside];
        //    [otherImage addSubview:accessory4];
        
        removeDelete1=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete1 setBackgroundColor:[UIColor clearColor]];
        [removeDelete1 addTarget:self action:@selector(removeDelete1) forControlEvents:UIControlEventTouchUpInside];
        [breakfastImage addSubview:removeDelete1];
        
        removeDelete2=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete2 setBackgroundColor:[UIColor clearColor]];
        [removeDelete2 addTarget:self action:@selector(removeDelete2) forControlEvents:UIControlEventTouchUpInside];
        [lunchImage addSubview:removeDelete2];
        
        
        removeDelete3=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete3 setBackgroundColor:[UIColor clearColor]];
        [removeDelete3 addTarget:self action:@selector(removeDelete3) forControlEvents:UIControlEventTouchUpInside];
        [dinnerImage addSubview:removeDelete3];
        
        removeDelete4=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
        [removeDelete4 setBackgroundColor:[UIColor clearColor]];
        [removeDelete4 addTarget:self action:@selector(removeDelete4) forControlEvents:UIControlEventTouchUpInside];
        [otherImage addSubview:removeDelete4];
        
        
        
        dayImageView.userInteractionEnabled=YES;
        [self.view addSubview:dayImageView];

        
    }
    else
    {
        
    
    
    
    
    dayImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
    [dayImageView setImage:[UIImage imageNamed:@"IM_iP4_DAY-bg.jpg"]];
    
    monthImage=[[UIImageView alloc]initWithFrame:CGRectMake(50  , 390, 133, 35)];
    [monthImage setImage:[UIImage imageNamed:@"IM_cal-view-switch_day.png"]];
    [dayImageView addSubview:monthImage];
    monthButton=[UIButton buttonWithType:UIButtonTypeCustom];
    monthButton=[[UIButton alloc]initWithFrame:CGRectMake(120, 390, 66, 35)];
    // [monthButton setBackgroundImage:[UIImage imageNamed:@"IM_current-date_box-50.png"]forState:UIControlStateNormal];
    [monthButton addTarget:self action:@selector(monthSelected) forControlEvents:UIControlEventTouchUpInside];
    [dayImageView addSubview:monthButton];
    mailButton=[[UIButton alloc]initWithFrame:CGRectMake(136, 95, 50    , 40)];
    [mailButton setBackgroundImage:[UIImage imageNamed:@"IM__0001_Vector-Smart-Object.png"]forState:UIControlStateNormal];
    [mailButton setBackgroundImage:[UIImage imageNamed:@"IM__0000_Vector-Smart-Object-copy-5.png"]forState:UIControlStateHighlighted];
    [mailButton addTarget:self action:@selector(savePopUp) forControlEvents:UIControlEventTouchUpInside];
    
    
    [dayImageView addSubview:mailButton];
    dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 47, 220, 40)];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    dateLabel.textAlignment=UITextAlignmentCenter;
    dateLabel.textColor=[self getColorByRed:46 green:79 blue:103];
    dateLabel.font = [UIFont systemFontOfSize:21];
    [dayImageView addSubview:dateLabel];
    
    
    
    addAMeal=[[UIButton alloc]initWithFrame:CGRectMake(200, 390, 100, 35)];
    [addAMeal setBackgroundImage:[UIImage imageNamed:@"IM_addmeal-button.png"]forState:UIControlStateNormal];
    [addAMeal setBackgroundImage:[UIImage imageNamed:@"IM_addmeal-button-press.png"]forState:UIControlStateHighlighted];
    [addAMeal addTarget:self action:@selector(pushMyNewViewController) forControlEvents:UIControlEventTouchUpInside];
    [dayImageView addSubview:addAMeal];

    
    breakfastImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 150, 290, 53)];
    [breakfastImage setImage:[UIImage imageNamed:@"IM__0005_BREAKFAST.png"]];
    breakfastImage.userInteractionEnabled=YES;
    [dayImageView addSubview:breakfastImage];

    
    LeftGesturesRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed1)];
    [LeftGesturesRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
    [breakfastImage addGestureRecognizer:LeftGesturesRecognizer];
    
    breakfastLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
    breakfastLabel.textColor=[UIColor blackColor];
    [breakfastLabel setBackgroundColor:[UIColor clearColor]];
    breakfastLabel.textAlignment=UITextAlignmentLeft;
    breakfastLabel.numberOfLines=3;
    breakfastLabel.text=breakfastString;
    if ([breakfastString isEqualToString:@"(null)"]||[breakfastString isEqualToString:@""]) {
        breakfastLabel.text=@"Nothing planned.";
        breakfastLabel.textColor=[UIColor lightGrayColor];
         breakfastLabel.textAlignment=UITextAlignmentCenter;
    }

    
    breakfastLabel.font = [UIFont systemFontOfSize:14];
    
    
    [breakfastImage addSubview:breakfastLabel];
    
    
    
    lunchImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 208, 290, 53)];
     [lunchImage setImage:[UIImage imageNamed:@"IM__0004_LUNCH.png"]];
     lunchImage.userInteractionEnabled=YES;
    [dayImageView addSubview:lunchImage];
    
   
    
    lunchLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
    lunchLabel.textColor=[UIColor blackColor];
    [lunchLabel setBackgroundColor:[UIColor clearColor]];
    lunchLabel.textAlignment=UITextAlignmentLeft;
     lunchLabel.numberOfLines=3;
    lunchLabel.text=lunchString;
    if ([lunchString isEqualToString:@"(null)"]||[lunchString isEqualToString:@""]) {
        lunchLabel.text=@"Nothing planned.";
        lunchLabel.textColor=[UIColor lightGrayColor];
           lunchLabel.textAlignment=UITextAlignmentCenter;
    }

    
    lunchLabel.font = [UIFont systemFontOfSize:14];
    
    
    [lunchImage addSubview:lunchLabel];
    
    LeftGesturesRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed2)];
    [LeftGesturesRecognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
    [lunchImage addGestureRecognizer:LeftGesturesRecognizer1];
    
    dinnerImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 266, 290, 53)];
      [dinnerImage setImage:[UIImage imageNamed:@"IM__0003_DINNER.png"]];
     dinnerImage.userInteractionEnabled=YES;
    [dayImageView addSubview:dinnerImage];
    
    
    
    
    dinnerLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
    dinnerLabel.textColor=[UIColor blackColor];
    [dinnerLabel setBackgroundColor:[UIColor clearColor]];
    dinnerLabel.textAlignment=UITextAlignmentLeft;
    dinnerLabel.text=dinnerString;
    dinnerLabel.numberOfLines=3;
    if ([dinnerString isEqualToString:@"(null)"]||[dinnerString isEqualToString:@""]) {
        dinnerLabel.text=@"Nothing planned.";
        dinnerLabel.textColor=[UIColor lightGrayColor];
         dinnerLabel.textAlignment=UITextAlignmentCenter;
    }

    
    dinnerLabel.font = [UIFont systemFontOfSize:14];
    
    [dinnerImage addSubview:dinnerLabel];
    
    LeftGesturesRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed3)];
    [LeftGesturesRecognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
    [dinnerImage addGestureRecognizer:LeftGesturesRecognizer2];
    
    otherImage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 324, 290, 53)];
      [otherImage setImage:[UIImage imageNamed:@"IM__0002_OTHER.png"]];
     otherImage.userInteractionEnabled=YES;
    [dayImageView addSubview:otherImage];
    
    
    
    
    otherLabel=[[UILabel alloc]initWithFrame:CGRectMake(74, 0, 210, 53)];
    otherLabel.textColor=[UIColor blackColor];
    [otherLabel setBackgroundColor:[UIColor clearColor]];
    otherLabel.textAlignment=UITextAlignmentLeft;
     otherLabel.numberOfLines=3;
    otherLabel.text=otherString;
    if ([otherString isEqualToString:@"(null)" ]||[otherString isEqualToString:@""]) {
          otherLabel.text=@"Nothing planned.";
        otherLabel.textColor=[UIColor lightGrayColor];
         otherLabel.textAlignment=UITextAlignmentCenter;
    }
    
    
    otherLabel.font = [UIFont systemFontOfSize:14];

    [otherImage addSubview:otherLabel];
    
    LeftGesturesRecognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(accessoryPressed4)];
    [LeftGesturesRecognizer3 setDirection:(UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft)];
    [otherImage addGestureRecognizer:LeftGesturesRecognizer3];
   
    
    deleteButton1=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0    , 33)];
    [deleteButton1 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
  //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
    [deleteButton1 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
    deleteButton1.hidden=YES;
    [breakfastImage addSubview:deleteButton1];
    
    deleteButton2=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
    [deleteButton2 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
  //  [deleteButton2 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
     [deleteButton2 addTarget:self action:@selector(deletePressed2) forControlEvents:UIControlEventTouchUpInside];
    deleteButton2.hidden=YES;
    [lunchImage addSubview:deleteButton2];
    
    deleteButton3=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
    [deleteButton3 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
  //  [deleteButton3 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
     [deleteButton3 addTarget:self action:@selector(deletePressed3) forControlEvents:UIControlEventTouchUpInside];
    deleteButton3.hidden=YES;
    [dinnerImage addSubview:deleteButton3];
    
    deleteButton4=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
    [deleteButton4 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
    //[deleteButton4 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
     [deleteButton4 addTarget:self action:@selector(deletePressed4) forControlEvents:UIControlEventTouchUpInside];
    deleteButton4.hidden=YES;
    [otherImage addSubview:deleteButton4];
    
//    accessory1=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
//    [accessory1 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
//    [accessory1 addTarget:self action:@selector(accessoryPressed1) forControlEvents:UIControlEventTouchUpInside];
//    accessory1.hidden=NO;
//    [breakfastImage addSubview:accessory1];
//    
//    accessory2=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
//    [accessory2 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
//    [accessory2 addTarget:self action:@selector(accessoryPressed2) forControlEvents:UIControlEventTouchUpInside];
//    [lunchImage addSubview:accessory2];
//    
//    accessory3=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
//    [accessory3 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
//    [accessory3 addTarget:self action:@selector(accessoryPressed3) forControlEvents:UIControlEventTouchUpInside];
//    [dinnerImage addSubview:accessory3];
//    
//    accessory4=[[UIButton alloc]initWithFrame:CGRectMake(258, 16.5, 20    , 20)];
//    [accessory4 setImage:[UIImage imageNamed:@"IM_delete-button-indicator.png"]forState:UIControlStateNormal];
//    [accessory4 addTarget:self action:@selector(accessoryPressed4) forControlEvents:UIControlEventTouchUpInside];
//    [otherImage addSubview:accessory4];
    
    removeDelete1=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
    [removeDelete1 setBackgroundColor:[UIColor clearColor]];
    [removeDelete1 addTarget:self action:@selector(removeDelete1) forControlEvents:UIControlEventTouchUpInside];
    [breakfastImage addSubview:removeDelete1];
    
    removeDelete2=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
    [removeDelete2 setBackgroundColor:[UIColor clearColor]];
    [removeDelete2 addTarget:self action:@selector(removeDelete2) forControlEvents:UIControlEventTouchUpInside];
    [lunchImage addSubview:removeDelete2];
    
    
    removeDelete3=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
    [removeDelete3 setBackgroundColor:[UIColor clearColor]];
    [removeDelete3 addTarget:self action:@selector(removeDelete3) forControlEvents:UIControlEventTouchUpInside];
    [dinnerImage addSubview:removeDelete3];
    
    removeDelete4=[[UIButton alloc]initWithFrame:CGRectMake(70, 0, 170    , 53)];
    [removeDelete4 setBackgroundColor:[UIColor clearColor]];
    [removeDelete4 addTarget:self action:@selector(removeDelete4) forControlEvents:UIControlEventTouchUpInside];
    [otherImage addSubview:removeDelete4];
    
    
    
    dayImageView.userInteractionEnabled=YES;
    [self.view addSubview:dayImageView];
    

    }}

}

-(void)removeDelete1{
    
    deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
     deleteButton3.hidden=YES;
     deleteButton4.hidden=YES;
    //accessory1.hidden=NO;

    [UIView animateWithDuration:0.2 animations:^{
      
        
        [deleteButton1 setFrame:CGRectMake(288, 11.5,0 , 33)];
   
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                           
                         }
                     }
     
     ];

    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton2 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
   
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton3 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
   
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton4 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    

    
}
-(void)removeDelete2{

    deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
    deleteButton3.hidden=YES;
    deleteButton4.hidden=YES;
    //accessory1.hidden=NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton1 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton2 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton3 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton4 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    


}

-(void)removeDelete3{
    
    deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
    deleteButton3.hidden=YES;
    deleteButton4.hidden=YES;
    //accessory1.hidden=NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton1 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton2 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton3 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton4 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
}

-(void)removeDelete4{
    
    deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
    deleteButton3.hidden=YES;
    deleteButton4.hidden=YES;
    //accessory1.hidden=NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton1 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton2 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton3 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton4 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];
    

    
}


-(void)deletePressed1
{
    deleteButton1.hidden=YES;
   // self.transform = CGAffineTransformScale(self.transform, 0.01, 0.01);
    [UIView animateWithDuration:0.2 animations:^{
      
        
        [deleteButton1 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                            
                         }
                     }
     
     ];
   // [deleteButton1 removeFromSuperview];

    NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Breakfast=('%@') WHERE Date IS ('%@')",@"",dateForDatabase];
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

    breakfastLabel.text=@"Nothing planned.";
    breakfastLabel.textColor=[UIColor lightGrayColor];
    breakfastLabel.textAlignment=UITextAlignmentCenter;
    
    //deleteButton1.hidden=YES;
    accessory1.hidden=NO;
    
    if ([breakfastLabel.text isEqualToString:@"Nothing planned."]&&[lunchLabel.text isEqualToString:@"Nothing planned."]&&[dinnerLabel.text isEqualToString:@"Nothing planned."]&&[otherLabel.text isEqualToString:@"Nothing planned."]) {
        
        NSString *insertSQL=[NSString stringWithFormat:@"DELETE FROM calendar WHERE Date IS ('%@')",dateForDatabase];
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
     [Flurry logEvent:@"Meal delete Button Pressed"];
}

-(void)deletePressed2
{
     deleteButton2.hidden=YES;
   
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton2 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];

    
    NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Lunch=('%@') WHERE Date IS ('%@')",@"",dateForDatabase];
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
    
    lunchLabel.text=@"Nothing planned.";
    lunchLabel.textColor=[UIColor lightGrayColor];
    lunchLabel.textAlignment=UITextAlignmentCenter;
    
    
   
    accessory2.hidden=NO;
    
    if ([breakfastLabel.text isEqualToString:@"Nothing planned."]&&[lunchLabel.text isEqualToString:@"Nothing planned."]&&[dinnerLabel.text isEqualToString:@"Nothing planned."]&&[otherLabel.text isEqualToString:@"Nothing planned."]) {
        
        NSString *insertSQL=[NSString stringWithFormat:@"DELETE FROM calendar WHERE Date IS ('%@')",dateForDatabase];
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

[Flurry logEvent:@"Meal delete Button Pressed"];
}
-(void)deletePressed3
{
     deleteButton3.hidden=YES;
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton3 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];

    
    NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Dinner=('%@') WHERE Date IS ('%@')",@"",dateForDatabase];
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
    
    dinnerLabel.text=@"Nothing planned.";
    dinnerLabel.textColor=[UIColor lightGrayColor];
    dinnerLabel.textAlignment=UITextAlignmentCenter;
    
    
  
    accessory3.hidden=NO;
    
    
    if ([breakfastLabel.text isEqualToString:@"Nothing planned."]&&[lunchLabel.text isEqualToString:@"Nothing planned."]&&[dinnerLabel.text isEqualToString:@"Nothing planned."]&&[otherLabel.text isEqualToString:@"Nothing planned."]) {
        
        NSString *insertSQL=[NSString stringWithFormat:@"DELETE FROM calendar WHERE Date IS ('%@')",dateForDatabase];
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
[Flurry logEvent:@"Meal delete Button Pressed"];

}
-(void)deletePressed4
{
  deleteButton4.hidden=YES;
    [UIView animateWithDuration:0.2 animations:^{
        
        
        [deleteButton4 setFrame:CGRectMake(288, 11.5,0 , 33)];
        
        
    }
                     completion:^ (BOOL finished){
                         if (finished) {
                             
                         }
                     }
     
     ];

    
    
    NSString *insertSQL=[NSString stringWithFormat:@"UPDATE calendar SET Other=('%@') WHERE Date IS ('%@')",@"",dateForDatabase];
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
    
    otherLabel.text=@"Nothing planned.";
    otherLabel.textColor=[UIColor lightGrayColor];
    otherLabel.textAlignment=UITextAlignmentCenter;

    
    
    deleteButton4.hidden=YES;
    accessory4.hidden=NO;
    
    
    if ([breakfastLabel.text isEqualToString:@"Nothing planned."]&&[lunchLabel.text isEqualToString:@"Nothing planned."]&&[dinnerLabel.text isEqualToString:@"Nothing planned."]&&[otherLabel.text isEqualToString:@"Nothing planned."]) {
        
        NSString *insertSQL=[NSString stringWithFormat:@"DELETE FROM calendar WHERE Date IS ('%@')",dateForDatabase];
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

[Flurry logEvent:@"Meal delete Button Pressed"];
}

-(void)accessoryPressed1
{
   
    [self removeDelete1];
    
    if (!deleteButton1) {
    
    
        deleteButton1=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton1 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton1 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
        
        [breakfastImage addSubview:deleteButton1];
    
    }
    deleteButton1.hidden=NO;
    [UIView animateWithDuration:0.3f animations:^{
        // [self.view addSubview:image1];
        
        [deleteButton1 setFrame:CGRectMake(228, 11.5, 60    , 33)];
        // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:fourthCard cache:YES];
      // deleteButton1.transform = CGAffineTransformScale(self.transform, 50, 50);
        
        // fourthCard.transform = CGAffineTransformMakeRotation(1.57);
        
        
    }];
    
 

    //deleteButton1=nil;
    
    //NSLog(@"hello1");
    
    accessory1.hidden=YES;
    //deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
    deleteButton3.hidden=YES;
    deleteButton4.hidden=YES;
}

-(void)accessoryPressed2
{ [self removeDelete1];
    if (!deleteButton2) {
        
        
        deleteButton2=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton2 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton2 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
        
        [lunchImage addSubview:deleteButton2];
        
    }
    deleteButton2.hidden=NO;
    [UIView animateWithDuration:0.3f animations:^{
        // [self.view addSubview:image1];
        
        [deleteButton2 setFrame:CGRectMake(228, 11.5, 60    , 33)];
        // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:fourthCard cache:YES];
        // deleteButton1.transform = CGAffineTransformScale(self.transform, 50, 50);
        
        // fourthCard.transform = CGAffineTransformMakeRotation(1.57);
        
        
    }];
    
    

    
    
    
    //NSLog(@"hello2");
     deleteButton2.hidden=NO;
    deleteButton1.hidden=YES;
   // deleteButton2.hidden=YES;
    deleteButton3.hidden=YES;
     deleteButton4.hidden=YES;
     accessory2.hidden=YES;
}

-(void)accessoryPressed3
{ [self removeDelete1];
    if (!deleteButton3) {
        
        
        deleteButton3=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton3 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton3 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
        
        [dinnerImage addSubview:deleteButton3];
        
    }
    deleteButton3.hidden=NO;
    [UIView animateWithDuration:0.3f animations:^{
        // [self.view addSubview:image1];
        
        [deleteButton3 setFrame:CGRectMake(228, 11.5, 60    , 33)];
        // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:fourthCard cache:YES];
        // deleteButton1.transform = CGAffineTransformScale(self.transform, 50, 50);
        
        // fourthCard.transform = CGAffineTransformMakeRotation(1.57);
        
        
    }];

    
    
    //NSLog(@"hello3");
     deleteButton3.hidden=NO;
     accessory3.hidden=YES;
    
    deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
    //deleteButton3.hidden=YES;
    deleteButton4.hidden=YES;
}

-(void)accessoryPressed4
{ [self removeDelete1];
    if (!deleteButton4) {
        
        
        deleteButton4=[[UIButton alloc]initWithFrame:CGRectMake(288, 11.5, 0 , 33)];
        [deleteButton4 setImage:[UIImage imageNamed:@"IM_delete_button.png"]forState:UIControlStateNormal];
        //  [deleteButton1 setBackgroundImage:[UIImage imageNamed:@"IM_buttn_delete-press.png"]forState:UIControlStateHighlighted];
        [deleteButton4 addTarget:self action:@selector(deletePressed1) forControlEvents:UIControlEventTouchUpInside];
        
        [otherImage addSubview:deleteButton4];
        
    }
    deleteButton4.hidden=NO;
    [UIView animateWithDuration:0.3f animations:^{
        // [self.view addSubview:image1];
        
        [deleteButton4 setFrame:CGRectMake(228, 11.5, 60    , 33)];
        // [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:fourthCard cache:YES];
        // deleteButton1.transform = CGAffineTransformScale(self.transform, 50, 50);
        
        // fourthCard.transform = CGAffineTransformMakeRotation(1.57);
        
        
    }];

    //NSLog(@"hello4");
     deleteButton4.hidden=NO;
     accessory4.hidden=YES;
    deleteButton1.hidden=YES;
    deleteButton2.hidden=YES;
    deleteButton3.hidden=YES;
    //deleteButton4.hidden=YES;
}
- (void)pushMyNewViewController
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
        
        selection=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 525)];
        [selection setImage:[UIImage imageNamed:@"IM_i5_add-meal-separate_bg.jpg"]];
        [self.view addSubview:selection];
        
        
        selectADate=[[UIButton alloc]initWithFrame:CGRectMake(20, 135, 120    , 32)];
        [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_set-date.png"]forState:UIControlStateNormal];
        [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-date-press.png"]forState:UIControlStateHighlighted];
        [selectADate addTarget:self action:@selector(initialiseDatePicker) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectADate];
        
        selectAMeal=[[UIButton alloc]initWithFrame:CGRectMake(20, 179, 120    , 32)];
        [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal.png"]forState:UIControlStateNormal];
        [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal-press.png"]forState:UIControlStateHighlighted];
        [selectAMeal addTarget:self action:@selector(initialiseMealPicker) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectAMeal];
        
     
         selfAdd=[[UIButton alloc]initWithFrame:CGRectMake(20, 290, 280    , 45)];
        [selfAdd setBackgroundImage:[UIImage imageNamed:@"IM_i5_addmeal-bt_0005_QUICK-ADD.png"]forState:UIControlStateNormal];
        [selfAdd setBackgroundImage:[UIImage imageNamed:@"IM_i5_addmeal-bt_0002_QUICK-ADD-copy.png"]forState:UIControlStateHighlighted];
        [selfAdd addTarget:self action:@selector(quickAdd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selfAdd];
        
        
        selectFromRecipies=[[UIButton alloc]initWithFrame:CGRectMake(20, 350, 280    , 45)];
       
        [selectFromRecipies setBackgroundImage:[UIImage imageNamed:@"IM_i5_addmeal-bt_0004_RECIPES.png"]forState:UIControlStateNormal];
        [selectFromRecipies setBackgroundImage:[UIImage imageNamed:@"IM_i5_addmeal-bt_0001_RECIPES-copy.png"]forState:UIControlStateHighlighted];
        [selectFromRecipies addTarget:self action:@selector(recipiesSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectFromRecipies];
        
        
         selectFromProducts=[[UIButton alloc]initWithFrame:CGRectMake(20, 410, 280    , 45)];
        [selectFromProducts setBackgroundImage:[UIImage imageNamed:@"IM_i5_addmeal-bt_0003_PRODUCT-LIST.png"]forState:UIControlStateNormal];
        [selectFromProducts setBackgroundImage:[UIImage imageNamed:@"IM_i5_addmeal-bt_0000_PRODUCT-LIST-copy.png"]forState:UIControlStateHighlighted];
        [selectFromProducts addTarget:self action:@selector(productlistSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectFromProducts];
        

        
               
        pickerBackButton=[[UIButton alloc]initWithFrame:CGRectMake(6, 5, 58, 33)];
        // [saveButton setBackgroundColor:[UIColor yellowColor]];
        // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button.png"]forState:UIControlStateNormal];
        [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button-press.png"]forState:UIControlStateHighlighted];
        [pickerBackButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        // saveButton.userInteractionEnabled=YES;
        [self.view addSubview:pickerBackButton];
        
        datePickerLabel =[[UILabel alloc]initWithFrame:CGRectMake(160, 135, 135, 30)];
        datePickerLabel.textAlignment=UITextAlignmentCenter ;
        
        
        [datePickerLabel setBackgroundColor:[UIColor clearColor]];
        NSString *newString=[[NSUserDefaults standardUserDefaults]objectForKey:@"datePickerDate"];
        
        
        datePickerLabel.text=newString;
        [self.view addSubview:datePickerLabel];
        
        mealPicker =[[UILabel alloc]initWithFrame:CGRectMake(160, 179, 135, 30)];
        [mealPicker setBackgroundColor:[UIColor clearColor]];
        mealPicker.textAlignment=UITextAlignmentCenter ;
        //NSString *newString1=[[NSUserDefaults standardUserDefaults]objectForKey:@"meal"];
        mealPicker.text=@"Breakfast";
        
        selection.userInteractionEnabled=YES;
        [self.view addSubview:mealPicker];

        
        
    }
    else
    {
    selection=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 431)];
    [selection setImage:[UIImage imageNamed:@"IM_addmeal_bg.jpg"]];
    [self.view addSubview:selection];
    
    
    selectADate=[[UIButton alloc]initWithFrame:CGRectMake(20, 113, 120    , 32)];
    [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_set-date.png"]forState:UIControlStateNormal];
    [selectADate setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-date-press.png"]forState:UIControlStateHighlighted];
    [selectADate addTarget:self action:@selector(initialiseDatePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectADate];
    
    selectAMeal=[[UIButton alloc]initWithFrame:CGRectMake(20, 157, 120    , 32)];
    [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal.png"]forState:UIControlStateNormal];
    [selectAMeal setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_set-meal-press.png"]forState:UIControlStateHighlighted];
     [selectAMeal addTarget:self action:@selector(initialiseMealPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectAMeal];
    
           selfAdd=[[UIButton alloc]initWithFrame:CGRectMake(20, 250, 280    , 40)];
        [selfAdd setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_0009_QUICK-ADD.png"]forState:UIControlStateNormal];
        [selfAdd setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_0004_QUICK-ADD-copy.png"]forState:UIControlStateHighlighted];
        [selfAdd addTarget:self action:@selector(quickAdd) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selfAdd];
        
         selectFromRecipies=[[UIButton alloc]initWithFrame:CGRectMake(20, 305, 280    , 40)];
        [selectFromRecipies setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_0006_RECIPES.png"]forState:UIControlStateNormal];
        [selectFromRecipies setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_0001_RECIPES-copy.png"]forState:UIControlStateHighlighted];
        [selectFromRecipies addTarget:self action:@selector(recipiesSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectFromRecipies];
        
       selectFromProducts=[[UIButton alloc]initWithFrame:CGRectMake(20, 360, 280    , 40)];
        [selectFromProducts setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_0005_PRODUCT-LIST.png"]forState:UIControlStateNormal];
        [selectFromProducts setBackgroundImage:[UIImage imageNamed:@"IM_add-meal_bt_0000_PRODUCT-LIST-copy.png"]forState:UIControlStateHighlighted];
        [selectFromProducts addTarget:self action:@selector(productlistSelected) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectFromProducts];
        
        

    
    pickerBackButton=[[UIButton alloc]initWithFrame:CGRectMake(6, 5, 58, 33)];
    // [saveButton setBackgroundColor:[UIColor yellowColor]];
    // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button.png"]forState:UIControlStateNormal];
    [pickerBackButton setImage:[UIImage imageNamed:@"IDMLS_back-button-press.png"]forState:UIControlStateHighlighted];
    [pickerBackButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    // saveButton.userInteractionEnabled=YES;
    [self.view addSubview:pickerBackButton];

    datePickerLabel =[[UILabel alloc]initWithFrame:CGRectMake(160, 113, 135, 30)];
    datePickerLabel.textAlignment=UITextAlignmentCenter ;
    
    
    [datePickerLabel setBackgroundColor:[UIColor clearColor]];
    NSString *newString=[[NSUserDefaults standardUserDefaults]objectForKey:@"datePickerDate"];
    
    
    datePickerLabel.text=newString;
    [self.view addSubview:datePickerLabel];
    
    mealPicker =[[UILabel alloc]initWithFrame:CGRectMake(160, 157, 135, 30)];
    [mealPicker setBackgroundColor:[UIColor clearColor]];
    mealPicker.textAlignment=UITextAlignmentCenter ;
    //NSString *newString1=[[NSUserDefaults standardUserDefaults]objectForKey:@"meal"];
    mealPicker.text=@"Breakfast";

    [self.view addSubview:mealPicker];
    selection.userInteractionEnabled=YES;
    }
    [Flurry logEvent:@"Add a Meal Button Pressed"];
    
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

- (IBAction)datePickerChanged: (id)sender
{
    if ( [ datePicker.date timeIntervalSinceNow ] < 0 )
        datePicker.date = today;
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
{tabBarItem=NO;
    NSString * latestDate=[[NSString alloc]initWithFormat:@"%@",[datePickerLabel text] ];
    NSString * latestMeal=[[NSString alloc]initWithFormat:@"%@",[mealPicker text] ];
    [[NSUserDefaults standardUserDefaults]setObject:latestDate forKey:@"latest"];
     [[NSUserDefaults standardUserDefaults]setObject:latestMeal forKey:@"meal"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [pickerBase removeFromSuperview];
    [datePicker removeFromSuperview];
    [inputAccView removeFromSuperview];
    [cityPicker removeFromSuperview];
    [fadeScreen removeFromSuperview];
}
-(void)initialiseMealPicker
{tabBarItem=YES;
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


-(void)quickAdd
{
    
    base=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [base setImage:[UIImage imageNamed:@"IM_iP4_quick_add-bg.jpg"]];
   
    [self.view addSubview:base];
    

    compare=[[UITextView alloc]initWithFrame:CGRectMake(10    , 82    , 295, 175)];
      
    [compare setBackgroundColor:[UIColor clearColor]];
    compare.autocorrectionType = UITextAutocorrectionTypeNo;
    //[compare.markedTextRange=100];
    compare.returnKeyType=UIReturnKeyDone;
    compare.font=[UIFont systemFontOfSize:16];
    compare.text=@"";
       compare.delegate=self;
   
    
    //    NSRange *range=100;
    //    NSString *replacementText=[[NSString alloc]initWithFormat:@""];
    //    [compare.text stringByReplacingCharactersInRange:*range withString:replacementText];
    // compare text
    //compare.placeholder=@"Name";
    // compare.textInputView=UIViewAnimationCurveLinear;
    [self.view addSubview:compare];
 
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
      [saveButton addTarget:self action:@selector(saveToDatabase) forControlEvents:UIControlEventTouchUpInside];
   // [saveButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    // saveButton.userInteractionEnabled=YES;
    [self.view addSubview:saveButton];
    
    
    backButton=[[UIButton alloc]initWithFrame:CGRectMake(6, 7, 58, 33)];
    // [saveButton setBackgroundColor:[UIColor yellowColor]];
    // saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"IDMLS_back-button.png"]forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"IDMLS_back-button-press.png"]forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backFromAdd) forControlEvents:UIControlEventTouchUpInside];
    // saveButton.userInteractionEnabled=YES;
    [self.view addSubview:backButton];
    
    
    //    NSString *logic=[[NSString alloc]init];
    //    logic=compare.text;
    //    NSLog(@"%@",logic);
     base.userInteractionEnabled=YES;
     [Flurry logEvent:@"Save(Quick Add) Button Pressed"];
    
}


-(void) onTimer:(NSTimer *)timer1{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [compare.text stringByTrimmingCharactersInSet:whitespace];
    
    if (![breakfastLabel.text isEqualToString:@"Nothing planned."] || ![lunchLabel.text isEqualToString:@"Nothing planned."]|| ![dinnerLabel.text isEqualToString:@"Nothing planned."] || ![otherLabel.text isEqualToString:@"Nothing planned."]) {
        mailButton.enabled=YES;
    }else
    {
        mailButton.enabled=NO;
    }
    
    if (trimmed.length>0) {
        saveButton.enabled=YES;
    }else
    {
        saveButton.enabled=NO;
    }
}
-(void)saveToDatabase
{
    NSString *arrayString=[[NSString alloc]initWithFormat:@"%@",compare.text ];
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
    [self backFromAdd];
    [self back];
    [dayImageView removeFromSuperview];
    [self viewWillAppear:YES];
}

-(void)backFromAdd
{ 
    [base removeFromSuperview];
    [backButton removeFromSuperview];
    [saveButton removeFromSuperview];
    [compare removeFromSuperview];
   
    
}

-(void)recipiesSelected
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"dateSelector"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.tabBarController.selectedIndex=2;
    [self back];
    [dayImageView removeFromSuperview];
    [Flurry logEvent:@"Select from Recipies Button Pressed"];
    
}


-(void)productlistSelected
{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"mealSelector"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
     self.tabBarController.selectedIndex=3;
    [self back];
    [dayImageView removeFromSuperview];
    [Flurry logEvent:@"Select from Products Button Pressed"];
    
}




-(void)back
{
    [self removePicker];
    [selection removeFromSuperview];
    [pickerBackButton removeFromSuperview];
    [selectADate removeFromSuperview];
    [selectAMeal removeFromSuperview];
     [selfAdd removeFromSuperview];
     [selectFromProducts removeFromSuperview];
     [selectFromRecipies removeFromSuperview];
    [datePickerLabel removeFromSuperview];
    [mealPicker removeFromSuperview];
}




- (IBAction)addAMeal:(id)sender {
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init] ;
    [dateFormatter2 setDateFormat:@"MMM d, yyyy"];
    dateForDatabase=[[NSString alloc]init];
    dateForDatabase = [dateFormatter2 stringFromDate:today];
   
    [self fetchFromDatabse];
    NSString *labelString=[[NSString alloc]init];
    labelString= [[NSUserDefaults standardUserDefaults]objectForKey:@"todaydate"];
    //NSLog(@"%@",labelString);
    
    [self addAView];
    dateLabel.text=labelString;
    
   
    // NSLog(@"%@",dateForDatabase);
     
      [Flurry logEvent:@"Day Button Pressed"];

}
-(void)monthSelected
{
    [dayImageView removeFromSuperview];
    [self viewWillAppear:YES];
    [Flurry logEvent:@"Month Button Pressed"];
}
-(void)showDateOnClickAndSave:(id)sender
{
    NSString *date;
    NSString *year;
    date=[[sender titleLabel]text];
    
    year=monthTitle.text;
    date=[[date stringByAppendingString:@"-"]stringByAppendingString:year];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM yyyy"];
    NSDate *buttonDate = [dateFormatter dateFromString:date];
   
 // NSLog(@"%@",date);
    NSDate *PubDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MMMM yyyy"];
    PubDate=[formatter dateFromString:date];
    int daysToAdd = 0;
    NSDate *newDate = [PubDate dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    //NSDate *todaysDate = [NSDate date];
   // NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:1];
    //NSDate *targetDate = [gregorian dateByAddingComponents:dateComponents toDate:buttonDate  options:0];
   // NSLog(@"%@",newDate);
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init] ;
    [dateFormatter2 setDateFormat:@"MMM d, yyyy"];
    dateForDatabase=[[NSString alloc]init];
    dateForDatabase = [dateFormatter2 stringFromDate:newDate];
    
   // NSLog(@"%@",dateForDatabase);
    
    //NSLog(@"%@jkl",targetDate);
   // [dateComponents release];
    //[gregorian release];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init] ;
   [dateFormatter1 setDateFormat:@"EEEE, d MMM"];
    NSString* dateString2 = [dateFormatter1 stringFromDate:buttonDate];
    //int i=[sender tag];
    //NSLog(@"%@",dateString2);
        
  //  NSLog(@"button tag %d",i);
    
    [self fetchFromDatabse];
    
    
    [self addAView];
    dateLabel.text=dateString2;
    [Flurry logEvent:@"Calender Button Pressed"];

    
}






@end
