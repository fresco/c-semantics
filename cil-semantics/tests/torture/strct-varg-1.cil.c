/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 6 "../../lib/includes/stdarg.h"
typedef __builtin_va_list va_list;
#line 4 "strct-varg-1.c"
struct s {
   int x ;
   int y ;
};
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
#line 6 "strct-varg-1.c"
void f(int attr  , ...) 
{ struct s va_values ;
  va_list va ;
  void *tmp ;
  void *tmp___0 ;
  void *tmp___1 ;

  {
#line 12
  __va_start(& va, (void *)(& attr));
#line 14
  if (attr != 2) {
#line 15
    abort();
  }
#line 17
  tmp = __va_arg(& va);
#line 17
  va_values = *((struct s *)tmp);
#line 18
  if (va_values.x != 43690) {
#line 19
    abort();
  } else {
#line 18
    if (va_values.y != 21845) {
#line 19
      abort();
    }
  }
#line 21
  tmp___0 = __va_arg(& va);
#line 21
  attr = *((int *)tmp___0);
#line 22
  if (attr != 3) {
#line 23
    abort();
  }
#line 25
  tmp___1 = __va_arg(& va);
#line 25
  va_values = *((struct s *)tmp___1);
#line 26
  if (va_values.x != 65535) {
#line 27
    abort();
  } else {
#line 26
    if (va_values.y != 4369) {
#line 27
      abort();
    }
  }
#line 29
  __va_end(& va);
#line 30
  return;
}
}
#line 32 "strct-varg-1.c"
int main(void) 
{ struct s a ;
  struct s b ;

  {
#line 36
  a.x = 43690;
#line 37
  a.y = 21845;
#line 38
  b.x = 65535;
#line 39
  b.y = 4369;
#line 41
  f(2, a, 3, b);
#line 42
  exit(0);
}
}
