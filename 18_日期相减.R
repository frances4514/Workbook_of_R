# 两个日期
# 函数Sys.Date()输出当天日期
today <- Sys.Date()
birthday <- as.Date('2000-12-24')

# 两个日期相减可得相差的天数
days <- today - birthday
days

# 输出某天是周几
format(today, format='%A')
format(birthday, format='%A')

# 作者出生在周几？
author_birth <- as.Date('1956-10-12')
format(author_birth, format='%A')
