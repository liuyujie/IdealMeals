//
//  IMProducts.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 18/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMProducts.h"
#import "IMProductList.h"

@interface IMProducts ()

@end

@implementation IMProducts
@synthesize ALphaPL,UnrestrictedPL,RestrictedPL,drinksPL,chipsPL,entreesPL,barsPl,puddingsPL,puffsPL;
- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"product-2.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"product.png"]];
    }else
    {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IM_i5_icons_0007_PRODUCTS.png"]
                          withFinishedUnselectedImage:[UIImage imageNamed:@"IM_i5_icons_0006_PRODUCTS-copy.png"]];
    }}
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [ALphaPL setExclusiveTouch:YES];
    [UnrestrictedPL setExclusiveTouch:YES];
    [RestrictedPL setExclusiveTouch:YES];
    [drinksPL setExclusiveTouch:YES];
    [entreesPL setExclusiveTouch:YES];
    [barsPl setExclusiveTouch:YES];
    [puddingsPL setExclusiveTouch:YES];
    [chipsPL setExclusiveTouch:YES];
    [puffsPL setExclusiveTouch:YES];
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

- (IBAction)Alphabetical:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"alphabetical"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:69 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Flurry logEvent:@"Alphabetical(Products) Button Pressed"];

     [self performSegueWithIdentifier:@"productList" sender:nil];
    
}
- (IBAction)productListUnrestricted:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"unrestricted"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:38 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Flurry logEvent:@"Unrestricted(Products) Button Pressed"];

     [self performSegueWithIdentifier:@"productList" sender:nil];
}
- (IBAction)productListRestricted:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"restricted"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:31 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     [Flurry logEvent:@"Restricted(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
}
- (IBAction)drinks:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"drinks"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:15 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Flurry logEvent:@"Drinks(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
    
}

- (IBAction)entrees:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"entrees"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:18 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     [Flurry logEvent:@"Entrees(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
}
- (IBAction)bars:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"bars"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:11 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Flurry logEvent:@"Bars(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
}
- (IBAction)puddings:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"puddings"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:8 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     [Flurry logEvent:@"Pudding(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
}


- (IBAction)chips:(id)sender {
    NSString *newString=[[NSString alloc]initWithFormat:@"chips"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
     [[NSUserDefaults standardUserDefaults]setInteger:5 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Flurry logEvent:@"Chips(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
}



- (IBAction)puffs:(id)sender {
  
    NSString *newString=[[NSString alloc]initWithFormat:@"puffs"];
    [[NSUserDefaults standardUserDefaults]setObject:newString forKey:@"match"];
    [[NSUserDefaults standardUserDefaults]setInteger:4 forKey:@"cells"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     [Flurry logEvent:@"Puffs(Products) Button Pressed"];
     [self performSegueWithIdentifier:@"productList" sender:nil];
}







-(void)viewDidUnload
{
    [self setPuffsPL:nil];
    [self setChipsPL:nil];
    [self setPuddingsPL:nil];
    [self setBarsPl:nil];
    [self setEntreesPL:nil];
    [self setDrinksPL:nil];
    [self setRestrictedPL:nil];
    [self setUnrestrictedPL:nil];
    [self setALphaPL:nil];
    [products removeAllObjects];
}

@end

