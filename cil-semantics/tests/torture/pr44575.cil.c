/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 6 "../../lib/includes/stdarg.h"
typedef __builtin_va_list va_list;
#line 7 "pr44575.c"
struct S {
   float a[3] ;
};
#line 21 "../../lib/includes/stdlib.h"
extern void abort(void) ;
#line 25 "../../lib/includes/stdarg.h"
extern void *__va_arg(va_list *ap ) ;
#line 30
extern void __va_start(va_list *ap , void *pN ) ;
#line 35
extern void __va_end(va_list *ap ) ;
#line 6 "pr44575.c"
int fails  =    0;
#line 8 "pr44575.c"
struct S a[5]  ;
#line 10 "pr44575.c"
void check(int z  , ...) 
{ struct S arg ;
  struct S *p ;
  va_list ap ;
  int j ;
  int k ;
  int i ;
  void *tmp ;

  {
#line 15
  j = 0;
#line 15
  k = 0;
#line 17
  __va_start(& ap, (void *)(& z));
#line 18
  i = 2;
#line 18
  while (i < 4) {
#line 20
    p = (struct S *)0;
#line 21
    j ++;
#line 22
    k += 2;
#line 23
    switch ((z << 4) | i) {
    case 18: 
    case 19: 
#line 27
    p = & a[2];
#line 28
    tmp = __va_arg(& ap);
#line 28
    arg = *((struct S *)tmp);
#line 29
    break;
    default: 
#line 31
    fails ++;
#line 32
    break;
    }
#line 34
    if (p) {
#line 34
      if (p->a[2] != arg.a[2]) {
#line 35
        fails ++;
      }
    }
#line 36
    if (fails) {
#line 37
      break;
    }
#line 18
    i ++;
  }
#line 39
  __va_end(& ap);
#line 40
  return;
}
}
#line 42 "pr44575.c"
int main(void) 
{ 

  {
#line 44
  a[2].a[2] = (float )-49026;
#line 45
  check(1, a[2], a[2]);
#line 46
  if (fails) {
#line 47
    abort();
  }
#line 48
  return (0);
}
}
