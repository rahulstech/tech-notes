### Context
Suppose i am storing credit debit details for my day to day transactions. also i want to group these transaction in some topics like "Expenses Of January", "Health Expeses", "Grocery Bills" etc. In each group  i can add both credit an debit transactions. So i also want the total credit and total bebit separately for each group.

### SQL Table Design
I will create two tables `transactions` and `groups`. For simplicity i assume that each transaction belongs to only one group. Terefore ther i _one-to-many_ relation from `groups` to `transaction`. Below are the **SQLite** tables:
```sql
create table `transactions` (
    `id` integer primary key autincrement, 
    `gid` integer not null references `groups`(`id`) on delete cascade,
    `amount` real not null,
    `datetime` text not null, 
    `type` text not null, -- either CREDIT or DEBIT
    `note` text
)
```
Since i want total credit and total debit for each groups, i need to calculate the sum of amount of  credit and debit type transactions for each corresponding transaction. But when this sum will be calculated and how can i store the aggregate value needs some design considerations:

1. I can add two columns in `groups` table to store total credits and total debits seperately. i need to update these column values each time there is a change in a `transactions` table like insert update or delete. since these operations occures frequently therefore i need to update the `groups` table frequently. in case of system failure `groups` table may not be updated. this leads to inconsistent data in groups table which is a serious problem. therefore this is not a good idea. 
here is the table design
```sql
create table `groups` (
    `id` integer primary key autoincrement,
    `name` text not null,
    `total_credit` real not null default 0,
    `total_debit` real not null default 0
)
```

2. I can create a view that holdes all the columns of `groups` with two extra virtual columns for aggregate credit and debit amounts of corresponsing transactions. 
    **Pros**
    - realtime total credit and total debit
    - no inconsistent data in `groups` table as it does not holds the total credit and debit value
    **Cons**
    - total credit and debit are calculated each time when queries therefore if there is huge number of transactions, like millions,  for groups the aggregate function may fail
Here is the table and view design
```sql
-- groups table

create table `groups` (
    `id` integer primary key autoincrement,
    `name` text not null
)

-- group_with_totals view

create view `group_with_totals` as
select `groups`.*,
case `t`.`type` when 'CREDIT' then `t`.`amount` else 0 end as `total_credit`,
case `t`.`type` when 'DEBIT' then `t`.`amount` else 0 end as `total_debit`
from `groups` left join `transactions` as `t` on `groups`.`id` = `t`.`gid` 
```

3. I can write select query for perticular group id. This is good when there is no complex where clause. Otherwise select query will be more complex.
Besides the same problem of aggregate of millions of rows just line 2 is also a problem here.

### Decession
Since total credit and total debit are dependent of transactions table and transactions table changes frequently, therefore
maintaining the aggregate values in groups table make the system complex as well as inconsistent. This design is suitable if 
changes in transactions table is not frequent. But this is not the case here. Second and third can be used in my case. But which one?
It depends weather i need any complex where clause or not. If yes then view is better option if not then i can simply go with select query.