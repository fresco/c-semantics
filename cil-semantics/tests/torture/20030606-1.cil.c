/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

#line 8 "../../lib/includes/string.h"
typedef unsigned int size_t___0;
#line 16
extern void *memset(void *ptr , int value , size_t___0 num ) ;
#line 17 "../../lib/includes/stdlib.h"
extern void exit(int status ) ;
#line 21
extern void abort(void) ;
#line 4 "20030606-1.c"
int *foo(int *x , int b ) 
{ int *tmp ;
  int *tmp___0 ;

  {
#line 7
  tmp = x;
#line 7
  x ++;
#line 7
  *tmp = 55;
#line 8
  if (b) {
#line 9
    tmp___0 = x;
#line 9
    x ++;
#line 9
    *tmp___0 = b;
  }
#line 11
  return (x);
}
}
#line 14 "20030606-1.c"
int main(void) 
{ int a[5] ;
  int *tmp ;
  int *tmp___0 ;

  {
#line 18
  memset((void *)(a), 1, (unsigned int )sizeof(a));
#line 20
  tmp = foo(a, 0);
#line 20
  if (tmp - a != 1) {
#line 21
    abort();
  } else {
#line 20
    if (a[0] != 55) {
#line 21
      abort();
    } else {
#line 20
      if (a[1] != a[4]) {
#line 21
        abort();
      }
    }
  }
#line 23
  memset((void *)(a), 1, (unsigned int )sizeof(a));
#line 25
  tmp___0 = foo(a, 2);
#line 25
  if (tmp___0 - a != 2) {
#line 26
    abort();
  } else {
#line 25
    if (a[0] != 55) {
#line 26
      abort();
    } else {
#line 25
      if (a[1] != 2) {
#line 26
        abort();
      }
    }
  }
#line 28
  exit(0);
}
}
