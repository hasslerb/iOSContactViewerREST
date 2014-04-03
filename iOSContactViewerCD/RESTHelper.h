//
//  RESTHelper.h
//  iOSContactViewerREST
//
//  Created by Diorelle Ramos on 3/29/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RESTHelper : NSObject

-(NSMutableArray *)getContacts;
-(void)addContact;
-(void)updateContact;
-(void)deleteContact;

@end
