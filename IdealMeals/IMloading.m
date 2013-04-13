//
//  IMloading.m
//  IdealMeals
//
//  Created by Samar's Mac Mini on 19/01/13.
//  Copyright (c) 2013 Samar's Mac . All rights reserved.
//

#import "IMloading.h"

@interface IMloading ()

@end

@implementation IMloading
@synthesize Loading;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
{
     [Loading setImage:[UIImage imageNamed:@"ipad-splash-screen.jpg"]];
}else{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if (screenBounds.size.height == 568)
    {
         [Loading setImage:[UIImage imageNamed:@"IM_i5_splash.jpg"]];
        
    }
    else
    {
    [Loading setImage:[UIImage imageNamed:@"IM_iP4_loading.jpg"]];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self loading];
}
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loading];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loading
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
   
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
         [self performSegueWithIdentifier:@"loadingIpad" sender:nil];
    }
    
    
    else
    {if (screenBounds.size.height == 568)
    {
        [self performSegueWithIdentifier:@"loading5" sender:nil];
        
    }
    
    else
    {
    
    [self performSegueWithIdentifier:@"loading" sender:nil];
    }}
}
- (void)viewDidUnload {
    [self setLoading:nil];
    [super viewDidUnload];
}
@end
