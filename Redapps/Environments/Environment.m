//
//  Environment.m
//  
//
//  Created by Ryan Copley on 3/30/12.
//  Copyright (c) 2012 Redapps. All rights reserved.
//
//  This file pulls information from the Environments property list and returns URLs
//  for database and Reachability based on whether the app is built for debugging or release.

#import "Environment.h"

@implementation Environment
static Environment *sharedInstance = nil;


//Initializes the shared instance with my variables from the plist
-(void)initSharedInstance {
    //Reference the main bundle and grab the current config variable and the path to the plist
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *config = [[mainBundle infoDictionary] objectForKey:@"Configuration"];
    NSString *path = [mainBundle pathForResource:@"Environments" ofType:@"plist"];
    
    //Grab the dictionary from the plist for the current build config
    NSDictionary *environments = [[[NSDictionary alloc] initWithContentsOfFile:path] objectForKey:@"Debug"];
    /*
    Shit like this:
     self.agencyID = [environments valueForKey:@"agencyID"];
     */
    
}

//Just a class method to retrieve the shared instance
//Call this when you need to use any of the shared variables
//(ex. [Environment sharedInstance].apiURL)
+(Environment *)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
            [sharedInstance initSharedInstance];
        }
    }
    return sharedInstance;
}
    
@end

