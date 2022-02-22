//
//  InProgressViewController.h
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import <UIKit/UIKit.h>
#import "editDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,editDelegate>
@property (weak, nonatomic) IBOutlet UITableView *progressTable;

@end

NS_ASSUME_NONNULL_END
