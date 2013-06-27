//
//  ViewController.m
//  DukeCodes
//
//  Created by Wei Deng on 6/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize majorName;
@synthesize pastMajors;
@synthesize autocompleteMajor;
@synthesize autocompleteTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //List the majors
    self.pastMajors = [[NSMutableArray alloc] initWithObjects:@"African & African American Studies", @"Arts History", @"Arts History/Visual Arts", @"Asian & Middle Easter Studies", @"Biology", @"Biomedical Engineering", @"Biophysics", @"Canadian Studies", @"Chemistry",@"Civil and Environmental Engineering", @"Classical Languages", @"Classical Civilization", @"Computational Biology and Bioinformatics", @"Computer Science", @"Cultural Anthropology", @"Dance", @"Earth and Ocean Sciences", @"Economics", @"Education", @"Electrical and Computer Engineering", @"Engineering", @"English", @"Environmental Sciences", @"Environmental Sciences and Policy", @"Evolutionary Anthropology", @"French", @"German", @"History", @"Interdepartmental Major", @"International Comparative Studies", @"Italian", @"Linguistics", @"Literature", @"Mathematics", @"Mechanical Engineering", @"Medieval and Renaissance Studies", @"Music", @"Neuroscience", @"Other", @"Philosophy", @"Photography", @"Physics", @"Political Science", @"Program II", @"Psychology", nil];
    
    
    keys = [NSArray arrayWithObjects:@"African & African American Studies", @"Arts History", @"Arts History/Visual Arts", @"Asian & Middle Easter Studies", @"Biology", @"Biomedical Engineering", @"Biophysics", @"Canadian Studies", @"Chemistry",@"Civil and Environmental Engineering", @"Classical Languages", @"Classical Civilization", @"Computational Biology and Bioinformatics", @"Computer Science", @"Cultural Anthropology", @"Dance", @"Earth and Ocean Sciences", @"Economics", @"Education", @"Electrical and Computer Engineering", @"Engineering", @"English", @"Environmental Sciences", @"Environmental Sciences and Policy", @"Evolutionary Anthropology", @"French", @"German", @"History", @"Interdepartmental Major", @"International Comparative Studies", @"Italian", @"Linguistics", @"Literature", @"Mathematics", @"Mechanical Engineering", @"Medieval and Renaissance Studies", @"Music", @"Neuroscience", @"Other", @"Philosophy", @"Photography", @"Physics", @"Political Science", @"Program II", @"Psychology", nil];
    
    objs = [NSArray arrayWithObjects:@"1", @"2", @"4", @"5", @"7", @"43", @"57", @"8", @"9", @"44", @"21", @"10", @"97", @"12", @"13", @"52", @"15", @"16", @"89", @"45", @"42", @"17", @"19", @"18", @"6", @"36", @"20", @"22", @"48", @"11", @"37", @"24", @"25", @"26", @"46", @"27", @"28", @"94", @"50", @"29", @"98", @"30", @"31", @"47", @"32", nil];
    dict = [NSMutableDictionary dictionaryWithObjects:objs forKeys:keys];

    
    
    self.autocompleteMajor = [[NSMutableArray alloc] init];
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, 120) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    
    [self.view addSubview:autocompleteTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Clear the screen
- (IBAction)changeGreeting:(id)sender {
    self.textField.text = nil;
    self.textField.placeholder = @"Enter your major";
    self.label.text = nil;
    autocompleteTableView.hidden = YES;
}


- (void)dealloc {
    //    [textField dealloc];
    //    [pastMajors dealloc];
    //    [autocompleteMajor dealloc];
    //    [autocompleteTableView dealloc];
    //    [super dealloc];
}

//remove keypad from UI
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    NSLog(@"%@",@"searchAutocompleteEntriesWithSubstring is called");
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteMajor removeAllObjects];
    for(NSString *curString in pastMajors) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompleteMajor addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@",@"shouldChangeCharactersInRange is called");
    autocompleteTableView.hidden = NO;
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    NSString *substring = [NSString stringWithString:textField.text];
 
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

//Autocomplete table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteMajor.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [autocompleteMajor objectAtIndex:indexPath.row];
    return cell;
}

//After selecting a table row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.textField.text = selectedCell.textLabel.text;
    autocompleteTableView.hidden = YES;
    self.majorName = self.textField.text;
    
    NSString *nameString = self.majorName;
    NSString *output = [dict objectForKey: nameString];
    if (output == nil) {
        output = @"This major does not exist";
    }
    if ([nameString length] == 0) {
        output = @"You need to select a major!";
    }
    NSLog(@"%@",output);
    self.label.text = output;
}


@end
