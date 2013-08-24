/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 17 "../../lib/includes/stdlib.h"
extern void exit(int status ) ;
#line 21
extern void abort(void) ;
#line 15 "../../lib/includes/string.h"
extern char *strchr(char const   *s , int c ) ;
#line 4 "20000112-1.c"
static int special_format(char const   *fmt ) 
{ char *tmp ;
  char *tmp___0 ;
  char *tmp___1 ;
  char *tmp___2 ;
  int tmp___3 ;

  {
#line 8
  tmp = strchr(fmt, '*');
#line 8
  if ((unsigned long )tmp != (unsigned long )((char *)0)) {
#line 8
    tmp___3 = 1;
  } else {
#line 8
    tmp___0 = strchr(fmt, 'V');
#line 8
    if ((unsigned long )tmp___0 != (unsigned long )((char *)0)) {
#line 8
      tmp___3 = 1;
    } else {
#line 8
      tmp___1 = strchr(fmt, 'S');
#line 8
      if ((unsigned long )tmp___1 != (unsigned long )((char *)0)) {
#line 8
        tmp___3 = 1;
      } else {
#line 8
        tmp___2 = strchr(fmt, 'n');
#line 8
        if ((unsigned long )tmp___2 != (unsigned long )((char *)0)) {
#line 8
          tmp___3 = 1;
        } else {
#line 8
          tmp___3 = 0;
        }
      }
    }
  }
#line 8
  return (tmp___3);
}
}
#line 14 "20000112-1.c"
int main(void) 
{ int tmp ;
  int tmp___0 ;

  {
#line 16
  tmp = special_format("ee");
#line 16
  if (tmp) {
#line 17
    abort();
  }
#line 18
  tmp___0 = special_format("*e");
#line 18
  if (! tmp___0) {
#line 19
    abort();
  }
#line 20
  exit(0);
}
}
