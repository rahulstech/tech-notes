/* 
    In any of the datetime function if i provide illegal value then mysql does not throw any error but it produce unexpected result. 
    To solve this problem i have two solutions
    1. cast the string to DATETIME using CAST('datetime string' as DATETIME). it will change to string to DATETIME 
        if the string is in a valid date or time or date and time format. otherwise returns null
    
    2. use str_to_date('datetime string', 'the expected format of the string'). it parse the string if the datetime format matches
        the given format in second parameter and returns datetime otherwise null.
    
    after converting the string into datetime type i can use it in any date time function without any unexpected result
    becuse for any invalid datetime string result will be null
 */

/* CURRENT_DATE, CURRENT_DATE(), CURDATE() all are same and returns the current date in the format yyyy-mm-dd */
select CURRENT_DATE();

/* CURRENT_TIME, CURRENT_TIME(), CURTIME() all are same and returns the current time in 24 hours format hh:mm:ss in GMT  timezone */
select CURRENT_TIME;

/* 
    CURRENT_TIME(fsp) returns current time in 24 hours hh:mm:ss.ssss int GMT timezone with upto fsp precision microseconds.
    valid fsp can be 0 to 6
 */
select CURRENT_TIME(4)

/*
    CURRENT_TIMESTAMP, NOW(), CURRENT_TIMESTAMP() all are same and returns current date and time in format yyyy-mm-dd hh:mm:ss
    time is in 24 hours format in GMT timezone. if i do CURRENT_TIMESTAMP(fsp) then it will also add the microseconds upto fsp
    precision.
 */
select CURRENT_TIMESTAMP;

/* DAY() or DAYOFMONTH() returns the day of month from 1 to 31. it accepts string, datetime or date*/
select day('2025-05-06');

/* DAYOFYEAR() returns day of year as integer. it accepts string, datetime or date */
select DAYOFYEAR('2025-02-02'); /* returns 33 */

/* DAYOFWEEK() returns the day of week as integer. it accepts string, datetime and date */
select DAYOFWEEK('2025-02-02'); /* return 1. it is sunday and by default mysql first day of week is sunday so 1 is sunday and 7 is saturday */

/* MONTH() returns the month of year from 1 to 12. it accepts string datetime or date */
select month('2025-05-06');

/* YEAR() returns the year. it accepts string datetime or date */
select YEAR('2025-05-06');

/* 
    HOUR() returns the hour. it accepts string datetime or time. time not necessarily be in 24 hours format.
    for example: 243 hours 30 minutes and 55 seconds if written like 243:30:55 then this function retunrs 243
 */
select HOUR('05:09:56');

/* MINUTE() returns the minute. it accpets string, datetime or time */
select MINUTE('14:05:06')

/* SECOND() retuns the second of minute. it accpets string, datetime and time */
select SECOND('15:05:06')

/* MICROSEOND() retunr the microsecond in 6 digits. it accepts string, datetime and time */
select MICROSEOND('15:56:08.4456') /* returns 445600 */

/* DAYNAME() retuns the week day name. it accepts string datetime or date */
select DAYNAME('2025-02-02'); /* return Sunday*/

/* MONTHNAME() returns the month name. it accepts string, datetime or date */
select MONTHNAME('2025-06-04') /* return June */



