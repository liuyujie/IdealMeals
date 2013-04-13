//
//  IMhome.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 18/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMhome.h"

@interface IMhome ()

@end

@implementation IMhome
- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"About-2.png"]
                      withFinishedUnselectedImage:[UIImage imageNamed:@"About.png"]];
    }else
    {
        [ self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"IM_i5_icons_0005_ABOUT.png"]
                       withFinishedUnselectedImage:[UIImage imageNamed:@"IM_i5_icons_0004_ABOUT-copy.png"]];
    }}
    return self;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

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
- (IBAction)website:(id)sender {
     [Flurry logEvent:@"Website Button Pressed"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.idealweightmanagement.com"]];
}
- (IBAction)check:(id)sender {
  
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                       //  bundle:nil];
    
    
//    IMProducts *viewController =
//    [storyboard instantiateViewControllerWithIdentifier:@""];
//    [self presentViewController:viewController animated:YES completion:NULL];
     self.tabBarController.selectedIndex = 3;
    
    //[[self navigationController] pushViewController:self.tabBarController animated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    UIStoryboardSegue *segue;
    IMProductList *vc = [segue destinationViewController];
    
    [vc.products removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:vc.products forKey:@"productArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   // NSLog(@"%@hhhh",vc.products);
}

@end
