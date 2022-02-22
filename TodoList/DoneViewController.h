//
//  DoneViewController.h
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end

NS_ASSUME_NONNULL_END
