//
//  ViewController.h
//  DukeCodes
//
//  Created by Wei Deng on 6/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate> {
    NSArray *keys;
    NSArray *objs;
    NSDictionary *dict;
    NSMutableArray *autocompleteMajor;
    NSMutableArray *pastMajors;
    UITableView *autocompleteTableView;

}

- (IBAction)changeGreeting:(id)sender;
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (copy, nonatomic) NSString *majorName;
@property (copy, nonatomic) NSArray *keys;
@property (copy, nonatomic) NSArray *objs;
@property (copy, nonatomic) NSDictionary *dict;
@property (nonatomic, retain) NSMutableArray *autocompleteMajor;
@property (copy, nonatomic) NSArray *pastMajors;
@property (nonatomic, retain) UITableView *autocompleteTableView;



@end
