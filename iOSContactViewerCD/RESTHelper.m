//
//  RESTHelper.m
//  iOSContactViewerREST
//
//  Created by Diorelle Ramos on 3/29/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import "Contact.h"
#import "RESTHelper.h"


@interface RESTHelper ()

-(NSDictionary *)getResponse:(NSURL *)fromURL withMethod:(NSString *)method;

@end

@implementation RESTHelper

NSString *apiKey = @"appydays";

-(NSMutableArray *)getContacts
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts?key=%@",apiKey]];
    NSDictionary *responseDict = [self getResponse:url withMethod:@"GET"];
    
    NSArray *contacts = [responseDict objectForKey:@("contacts")];
    NSMutableArray * _contacts= [[NSMutableArray alloc]init];
    
    //parse dictionary
    for(NSDictionary *contact in contacts){
        NSString *title = [contact objectForKey:@"title"];
        NSString *name = [contact objectForKey:@"name"];
        NSString *phone = [contact objectForKey:@"phone"];
        NSString *email = [contact objectForKey:@"email"];
        NSString *twitter = [contact objectForKey:@"twitterId"];
        
        //create contact object & init
        Contact *contactObj = [[Contact alloc] init];
        contactObj.title = title;
        contactObj.name = name;
        contactObj.phone = phone;
        contactObj.email = email;
        contactObj.twitterId = twitter;
        
        //add contact object to contact array
        [_contacts addObject:contactObj];
    }
    
    return _contacts;
}

-(void)addContact
{

}

-(void)updateContact
{
    
}

-(void)deleteContact
{
    
}

-(NSDictionary *)getResponse:(NSURL *)fromURL withMethod:(NSString *)method
{
    //init request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:fromURL];
    [request setHTTPMethod:method];
    
    //init response
    NSHTTPURLResponse *response = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    return responseDict;
}
@end
