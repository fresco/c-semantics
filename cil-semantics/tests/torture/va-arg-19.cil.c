/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 6 "../../lib/includes/stdarg.h"
typedef __builtin_va_list va_list;
#line 4 "va-arg-19.c"
typedef int TYPE;
#line 17 "../../lib/includes/stdlib.h"
extern void exit(int status ) ;
#line 21
extern void abort(void) ;
#line 25 "../../lib/includes/stdarg.h"
extern void *__va_arg(va_list *ap ) ;
#line 30
extern void __va_start(va_list *ap , void *pN ) ;
#line 35
extern void __va_end(va_list *ap ) ;
#line 6 "va-arg-19.c"
void vafunction(char *dummy  , ...) 
{ va_list ap ;
  void *tmp ;
  void *tmp___0 ;
  void *tmp___1 ;
  void *tmp___2 ;
  void *tmp___3 ;
  void *tmp___4 ;
  void *tmp___5 ;
  void *tmp___6 ;
  void *tmp___7 ;

  {
#line 10
  __va_start(& ap, (void *)(& dummy));
#line 11
  tmp = __va_arg(& ap);
#line 11
  if (*((TYPE *)tmp) != 1) {
#line 12
    abort();
  }
#line 13
  tmp___0 = __va_arg(& ap);
#line 13
  if (*((TYPE *)tmp___0) != 2) {
#line 14
    abort();
  }
#line 15
  tmp___1 = __va_arg(& ap);
#line 15
  if (*((TYPE *)tmp___1) != 3) {
#line 16
    abort();
  }
#line 17
  tmp___2 = __va_arg(& ap);
#line 17
  if (*((TYPE *)tmp___2) != 4) {
#line 18
    abort();
  }
#line 19
  tmp___3 = __va_arg(& ap);
#line 19
  if (*((TYPE *)tmp___3) != 5) {
#line 20
    abort();
  }
#line 21
  tmp___4 = __va_arg(& ap);
#line 21
  if (*((TYPE *)tmp___4) != 6) {
#line 22
    abort();
  }
#line 23
  tmp___5 = __va_arg(& ap);
#line 23
  if (*((TYPE *)tmp___5) != 7) {
#line 24
    abort();
  }
#line 25
  tmp___6 = __va_arg(& ap);
#line 25
  if (*((TYPE *)tmp___6) != 8) {
#line 26
    abort();
  }
#line 27
  tmp___7 = __va_arg(& ap);
#line 27
  if (*((TYPE *)tmp___7) != 9) {
#line 28
    abort();
  }
#line 29
  __va_end(& ap);
#line 30
  return;
}
}
#line 33 "va-arg-19.c"
int main(void) 
{ 

  {
#line 35
  vafunction((char *)"", 1, 2, 3, 4, 5, 6, 7, 8, 9);
#line 36
  exit(0);
#line 37
  return (0);
}
}
