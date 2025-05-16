AC_INIT([alpha], [0.1])
AC_PROG_CC
AC_CONFIG_SRCDIR([src])

AC_CHECK_PROGS([LD], [ld])
AC_CHECK_PROGS([MAKE], [make])
AC_CHECK_PROGS([NASM], [nasm])
AC_CHECK_PROGS([PATCH], [patch])
AC_CHECK_PROGS([RM], [rm])

# Check for required tools
AS_IF([test -z "$LD"], [AC_MSG_ERROR([ld is required but not found])])
AS_IF([test -z "$LD"], [AC_MSG_ERROR([make is required but not found])])
AS_IF([test -z "$NASM"], [AC_MSG_ERROR([nasm is required but not found])])
AS_IF([test -z "$PATCH"], [AC_MSG_ERROR([patch is required but not found])])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
