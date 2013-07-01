//
//  Environment.m
//
//
//  Created by Ryan Copley on 3/30/12.
//  Copyright (c) 2012 Redapps. All rights reserved.
//
//  This file pulls information from the Environments property list and returns URLs
//  for database and Reachability based on whether the app is built for debugging or release.

#import <Foundation/Foundation.h>

@interface Environment : NSObject

-(void)initSharedInstance;
+(Environment *)sharedInstance;

@end
