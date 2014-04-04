//
//  MasterViewController.m
//  iOSContactViewerCD
//
//  Created by Diorelle Ramos on 3/25/14.
//  Copyright (c) 2014 Diorelle Ramos. All rights reserved.
//

#import "MasterViewController.h"
#import "Contact.h"
#import "RESTHelper.h"

@interface MasterViewController (){
    NSMutableArray *_contacts;
    RESTHelper *_restHelper;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)refreshTableView;
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //init _helper
    _restHelper = [[RESTHelper alloc]init];
    
    //init _contacts;
    _contacts = [_restHelper getContacts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [[self.fetchedResultsController sections] count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Contact *contact = [_contacts objectAtIndex:indexPath.row];
        [_restHelper deleteContact:contact];
        [self refreshTableView];
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Contact *contactDetail = [_contacts objectAtIndex:indexPath.row];
        DetailViewController *detailView = [[DetailViewController alloc]init];
        detailView = segue.destinationViewController;
        detailView.contactDetail = contactDetail;
        detailView.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"addContact"]) {
        AddContactViewController *controller = [[AddContactViewController alloc]init];
        controller = segue.destinationViewController;
        controller.delegate = self;
        
    }
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Contact *contactObject = [_contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = [[contactObject valueForKey:@"name"] description];
}

- (void)addContactViewControllerSave:(Contact *)contact {
    
    // save context and dismiss
    [_restHelper addContact:contact];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self refreshTableView];
}

- (void)addContactViewControllerCancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)detailViewDidSave:(Contact *)contact {
    
    [_restHelper updateContact:contact];
    [self.navigationController popViewControllerAnimated:YES];
    [self refreshTableView];
}

- (void)refreshTableView {
    _contacts = [_restHelper getContacts];
    [self.tableView reloadData];
}
@end
