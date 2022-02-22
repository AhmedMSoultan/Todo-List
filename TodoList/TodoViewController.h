//
//  TodoViewController.h
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import <UIKit/UIKit.h>
#import "addDelegate.h"
#import "editDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface TodoViewController : UIViewController <addDelegate,UISearchBarDelegate,editDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

NS_ASSUME_NONNULL_END
