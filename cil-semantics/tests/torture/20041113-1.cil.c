/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 6 "../../lib/includes/stdarg.h"
typedef __builtin_va_list va_list;
#line 17 "../../lib/includes/stdlib.h"
extern void exit(int status ) ;
#line 21
extern void abort(void) ;
#line 25 "../../lib/includes/stdarg.h"
extern void *__va_arg(va_list *ap ) ;
#line 30
extern void __va_start(va_list *ap , void *pN ) ;
#line 4 "20041113-1.c"
void test(int x  , ...) 
{ va_list ap ;
  void *tmp ;
  void *tmp___0 ;
  void *tmp___1 ;
  void *tmp___2 ;

  {
#line 8
  __va_start(& ap, (void *)(& x));
#line 9
  tmp = __va_arg(& ap);
#line 9
  if (*((int *)tmp) != 1) {
#line 10
    abort();
  }
#line 11
  tmp___0 = __va_arg(& ap);
#line 11
  if (*((int *)tmp___0) != 2) {
#line 12
    abort();
  }
#line 13
  tmp___1 = __va_arg(& ap);
#line 13
  if (*((int *)tmp___1) != 3) {
#line 14
    abort();
  }
#line 15
  tmp___2 = __va_arg(& ap);
#line 15
  if (*((int *)tmp___2) != 4) {
#line 16
    abort();
  }
#line 17
  return;
}
}
#line 19 "20041113-1.c"
double a  =    40.0;
#line 21 "20041113-1.c"
int main(int argc , char **argv ) 
{ 

  {
#line 23
  test(0, 1, 2, 3, (int )(a / 10.0));
#line 24
  exit(0);
}
}
