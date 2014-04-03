//
//  RESTHelper.m
//  iOSContactViewerREST
//
//  Created by Diorelle Ramos on 3/29/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import "RESTHelper.h"


@interface RESTHelper ()

-(NSDictionary *)getResponse:(NSURL *)fromURL withMethod:(NSString *)method;
-(NSString *) buildContactQueryString:(Contact *) contact;
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
    for(NSDictionary *retContact in contacts){
        NSString *contactId = [retContact objectForKey:@"_id"];
        NSString *title = [retContact objectForKey:@"title"];
        NSString *name = [retContact objectForKey:@"name"];
        NSString *phone = [retContact objectForKey:@"phone"];
        NSString *email = [retContact objectForKey:@"email"];
        NSString *twitter = [retContact objectForKey:@"twitterId"];
        
        //create contact object & init
        Contact *contactObj = [[Contact alloc] init];
        contactObj.contactId = contactId;
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

-(NSString *) buildContactQueryString:(Contact *) contact
{
    NSString *cqs =[NSString stringWithFormat:@"groupId=53228dbfad0b4b2e7f000003&title=%@&name=%@&phone=%@&email=%@&twitterId=%@", contact.title, contact.name, contact.phone, contact.email, contact.twitterId];
    NSString* formattedCqs = [cqs stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return formattedCqs;
}
-(void)addContact:(Contact *)contact
{
    NSString *contactQueryString = [self buildContactQueryString:contact ];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts?key=%@&%@",apiKey,contactQueryString]];
    [self getResponse:url withMethod:@"POST"];
}

-(void)updateContact:(Contact *)contact
{
    NSString *contactQueryString = [self buildContactQueryString:contact ];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts/%@?key=%@&&%@",contact.contactId,apiKey,contactQueryString]];
    [self getResponse:url withMethod:@"PUT"];
}

-(void)deleteContact:(Contact *)contact
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://contacts.tinyapollo.com/contacts/%@?key=%@",contact.contactId,apiKey]];
    [self getResponse:url withMethod:@"DELETE"];

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
