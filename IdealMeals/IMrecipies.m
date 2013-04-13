//
//  IMrecipies.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 18/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMrecipies.h"
#import "IMrecipieDescription.h"
#import "IMrecipieList.h"
@interface IMrecipies ()

@end

@implementation IMrecipies
@synthesize phase1Recipies,phase3Recipies,healthRecipies,allRecipies;
- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"recipies-2.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"recipies.png"]];
    }else
    {

        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IM_i5_icons_0003_RECIPES.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"IM_i5_icons_0002_RECIPES-copy.png"]];}
        

    }
    return self;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
  
    
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)allRecipies:(id)sender {
     NSString *string=[[NSString alloc ]initWithFormat:@"ALL"];
    cellNo=198;
    [[NSUserDefaults standardUserDefaults]setInteger:cellNo forKey:@"cell"];
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"name"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
     //[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    [Flurry logEvent:@"All Recipies Button Pressed"];
    [self  performSegueWithIdentifier:@"recipies" sender:self];
     
   
}
- (IBAction)phase1:(id)sender {
     NSString *string=[[NSString alloc ]initWithFormat:@"PHASE 1 and 2"];
    cellNo=172;
    [[NSUserDefaults standardUserDefaults]setInteger:cellNo forKey:@"cell"];
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"name"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    [Flurry logEvent:@"Phase 1 and 2 Recipies Button Pressed"];
     [self  performSegueWithIdentifier:@"recipies" sender:self];
    
}
- (IBAction)phase3:(id)sender {
     NSString *string=[[NSString alloc ]initWithFormat:@"PHASE 3"];
    cellNo=183;
    [[NSUserDefaults standardUserDefaults]setInteger:cellNo forKey:@"cell"];
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"name"];
     
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Flurry logEvent:@"Phase 3 Recipies Button Pressed"];
    [self  performSegueWithIdentifier:@"recipies" sender:self];
}
- (IBAction)healthy:(id)sender {
     NSString *string=[[NSString alloc ]initWithFormat:@"HEALTHY MAINTENANCE"];
    cellNo=195;
    [[NSUserDefaults standardUserDefaults]setInteger:cellNo forKey:@"cell"];
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"name"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
     [Flurry logEvent:@"Healthy Maintenance Recipies Button Pressed"];
    [self  performSegueWithIdentifier:@"recipies" sender:self];
}


-(void)viewWillAppear:(BOOL)animated
{
    [allRecipies setExclusiveTouch:YES];
    [phase1Recipies setExclusiveTouch:YES];
    [phase3Recipies setExclusiveTouch:YES];
    [healthRecipies setExclusiveTouch:YES];
    
    UIStoryboardSegue *segue;
    IMProductList *vc = [segue destinationViewController];
    
    [vc.products removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:vc.products forKey:@"productArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   // NSLog(@"%@hhhh",vc.products);
}


- (void)viewDidUnload {
    [self setAllRecipies:nil];
    [self setPhase1Recipies:nil];
    [self setPhase3Recipies:nil];
    [self setHealthRecipies:nil];
    [super viewDidUnload];
}
@end
