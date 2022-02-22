//
//  todoItem.m
//  TodoList
//
//  Created by Ahmed Soultan on 27/01/2022.
//

#import "todoItem.h"

@implementation todoItem


- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_descrip forKey:@"descrip"];
    [encoder encodeObject:_priority forKey:@"priority"];
    [encoder encodeObject:_priorityImg forKey:@"priorityImg"];
    [encoder encodeObject:_date forKey:@"date"];
    [encoder encodeInt:_itemIndex forKey:@"itemIndex"];
    [encoder encodeObject:_key forKey:@"key"];
    
}
- (instancetype)initWithCoder:(NSCoder *)decoder{
    if((self = [super init])){
        _name = [decoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _descrip = [decoder decodeObjectOfClass:[NSString class] forKey:@"descrip"];
        _priority = [decoder decodeObjectOfClass:[NSString class] forKey:@"priority"];
        _priorityImg = [decoder decodeObjectOfClass:[NSString class] forKey:@"priorityImg"];
        _date = [decoder decodeObjectOfClass:[NSString class] forKey:@"date"];
        _itemIndex = [decoder decodeIntForKey:@"itemIndex"];
        _key = [decoder decodeObjectOfClass:[NSString class] forKey:@"key"];
    }
    return  self;
}
+ (BOOL)supportsSecureCoding{
    return  YES;
}

@end
