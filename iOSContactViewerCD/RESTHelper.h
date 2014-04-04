//
//  RESTHelper.h
//  iOSContactViewerREST
//
//  Created by Diorelle Ramos on 3/29/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface RESTHelper : NSObject

-(NSMutableArray *)getContacts;
-(void)addContact:(Contact *)contact;
-(void)updateContact:(Contact *)contact;
-(void)deleteContact:(Contact *)contact;

@end
