      subroutine siftdy( chrtdy )
c
c  return the machine_name-time-date-year character string.
c
c  output: chrtdy = character*40 representation of m-t-d-y.
c
c  it is recommended that mtdy-stamps be included on all SIFS files,
c  along with the program name that created the file.  the chrtdy
c  string returned is limited to 40 characters so that both sets of
c  information will fit within one title(*) record:
c
c     title(1:40)=program_name_and_function ; title(41:80)=chrtdy
c
c  since the generation of this data is very machine dependent, local
c  copies of this routine, or the local interface routines on which
c  it relys, may have to be maintained on each machine at a
c  particular site.
c
c  recommended format: machine_id   [wkd] hh:mm:ss [TMZ] dd-mmm-yyyy
c
c  [wkd] is optional and is the 3-char day of the week,
c  hh is the 24 hour time, [TMZ] is optional and is the local time
c  zone, and mmm is the 3-char month abbrieviation.
c  Please do not use the 2-digit month value so as to avoid confusion
c  between dd-mm and mm-dd.  The order of these date parameters is not
c  important, as long as they are unambigious.  yyyy is either the
c  4-digit gregorian year, or its 2-digit abbreviation.
c
c  19-oct-01 f90 code added. -rls
c  03-sep-91 cray uname call added. -rls
c  13-mar-91 posix code added. -rls
c  08-oct-90 (columbus day) written by ron shepard.
c
       implicit logical(a-z)
      character*(*) chrtdy
c
c     # warning: case dependent code
c     # please do not change the case of the parameter constants and
c     # character data arrays in this program.
c
      character*(*) site
*@ifdef argonne
*      parameter( site = 'ANL' )
*@elif defined  fsu
*      parameter( site = 'FSU' )
*@elif defined  osu
*      parameter( site = 'OSU' )
*@elif defined  wien
*      parameter( site = 'Wien' )
*@else
      parameter( site = 'Site=?' )
*@endif
c
*@ifdef f90 .and. unix
c     # f90 code with hostnm()
      integer  hostnm
      external hostnm
      integer :: time(8), ierr
      intrinsic date_and_time, len
      character(len=3), parameter :: month(12) = (/
     & 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
     & 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' /)
c
c     # use the 2-digit year to make more space for the hostname.
      character(len=*), parameter :: cfmt=
     & "(2(i2.2,':'),i2.2,'.',i3.3,i3.2,'-',a3,'-',i2.2)"
c
      ierr = hostnm( chrtdy(1:17) )
      if ( ierr .ne. 0 ) then
c        # pack the error code into chrtdy(:)
         write( chrtdy(1:17),'(a9,i8.8)' ) 'hostnm()=', ierr
      endif
      chrtdy(18:18) = ' '
      call date_and_time( values=time )
      write( chrtdy(19:40), fmt=cfmt)
     & time(5), time(6), time(7), time(8), time(3),
     & month(time(2)), (time(1)-2000)
*@elif defined  (f90) || defined ( f95)
*CC     # plain portable f90 code
*      integer :: time(8)
*      intrinsic date_and_time, len
*      character(len=3), parameter :: month(12) = (/
*     & 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
*     & 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' /)
*CC
*CC     # no hostname, so use 4-digit year and append site string instead
*      character(len=*), parameter :: cfmt=
*     & "(2(i2.2,':'),i2.2,'.',i3.3,i3.2,'-',a3,'-',i4.4)"
*CC
*      call date_and_time( values=time )
*      write( chrtdy, fmt=cfmt)
*     & time(5), time(6), time(7), time(8), time(3),
*     & month(time(2)), time(1)
*      chrtdy(25:25) = ' '
*      chrtdy(26:40) = site
*@elif defined  ( t3e64) || defined ( t3d )
*CC
*      integer jutsname, ierr, lenn, mm
*      character*8 cdate8
*      character*3 month(12)
*CC
*      data month/
*     & 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
*     & 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' /
*CC
*CC     # create the utsname structure.
*      call pxfstructcreate( 'utsname', jutsname, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy, '(a,i9)' ) 'pxfstructcreate() error=', ierr
*         return
*      endif
*CC
*CC     # set the values of the utsname structure.
*      call pxfuname( jutsname, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy, '(a,i9)' ) 'pxfuname() error=', ierr
*         goto 9999
*      endif
*CC
*CC     # extract the nodename element, truncating at 20 characters.
*      call pxfstrget( jutsname, 'nodename', chrtdy(1:20), lenn, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy, '(a,i9)' ) 'pxfstrget() error=', ierr
*         goto 9999
*      endif
*CC
*CC     # make sure undefined characters are set to spaces.
*      chrtdy( min(lenn,20)+1 :) = ' '
*CC
*CC     # get the current time and date.
*        call clock(cdate8)
*        write( chrtdy(22:30), '(a1,a8)'   ) ' ', cdate8
*        call date(cdate8)
*         write( cdate8,        '(a8)'      ) cdate8
*        read(  cdate8(1:2),   '(i2)'      ) mm
*        chrtdy(32:40) = cdate8(4:5) // '-'
*     & //             month(mm)   // '-' // cdate8(7:8)
*9999  continue
*CC     # structure cleanup.
*      call pxfstructfree( jutsname, ierr )
*@elif defined  posix
*CC
*      integer jutsname, ierr, lenn
*      integer iatime(9)
*      character*3 month(12)
*CC
*      data month/
*     & 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
*     & 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' /
*CC
*CC     # create the utsname structure.
*      call pxfstructcreate( 'utsname', jutsname, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy, '(a,i9)' ) 'pxfstructcreate() error=', ierr
*         return
*      endif
*CC
*CC     # set the values of the utsname structure.
*      call pxfuname( jutsname, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy, '(a,i9)' ) 'pxfuname() error=', ierr
*         goto 9999
*      endif
*CC
*CC     # extract the nodename element, truncating at 20 characters.
*      call pxfstrget( jutsname, 'nodename', chrtdy(1:20), lenn, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy, '(a,i9)' ) 'pxfstrget() error=', ierr
*         goto 9999
*      endif
*CC
*CC     # make sure undefined characters are set to spaces.
*      chrtdy( min(lenn,20)+1 :) = ' '
*CC
*CC     # get the current time and date.
*      call pxflocaltime( iatime, ierr )
*      if ( ierr .ne. 0 ) then
*CC        # encode the error number and return.
*         write( chrtdy(21:40), '(a11,i9)' ) 'time_error=', ierr
*         goto 9999
*      endif
*CC
*CC        # return time in the format "hh:mm:ss dd-mmm-yyyy".
*      write( chrtdy(21:40),
*     & '(i2.2,a1,i2.2,a1,i2.2,1x,i2.2,a1,a3,a1,i4.4)' )
*     & iatime(3), ':', iatime(2), ':', 'iatime(1)',
*     & iatime(4), '-', month(iatime(5)), '-', iatime(6)
*CC
*9999  continue
*CC     # structure cleanup.
*      call pxfstructfree( jutsname, ierr )
*@elif defined  vax
*CC     # can't get the machine_id easily, so punt.
*      chrtdy = site // ' vax'
*      call time( chrtdy( 22:29) )
*      call date( chrtdy(32:) )
*@elif defined  cray
*CC     # 03-sep-91 unicos 6.0 uname() call added. -rls
*CC     # 23-oct-90 cray version written by ron shepard.
*CC     # can't access unicos date() from fortran.
*CC     # must use clock() and date() instead.
*CC     # braindamaged clock() and date() return hollerith strings. -rls
*      integer  clock, date,  fstrlen
*      external clock, date, uname, fstrlen
*      integer     isys, inode, imach
*      character*9 sys,  node,  mach
*      integer mm
*CC     # need to convert ambigous  mm/dd/yy into dd-mmm-yy.
*      character*8 cdate8
*      character*3 month(12)
*      data month/
*     & 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
*     & 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' /
*CC
*CC     # get the system and node name; use cdate8 for scratch.
*      call uname( sys, node, cdate8, cdate8, mach )
*CC     # pack into the first 21 spaces of chrtdy(:).
*      isys  = fstrlen( sys )
*      inode = fstrlen( node )
*      imach = fstrlen( mach )
*      chrtdy = node(:inode) // ' ' // sys(:isys) // ' ' // mach(:imach)
*CC     # pack time and date info into chrtdy(:).
*      write( chrtdy(22:30), '(a1,a8)'   ) ' ', clock()
*      write( cdate8,        '(a8)'      ) date()
*      read(  cdate8(1:2),   '(i2)'      ) mm
*      chrtdy(32:40) = cdate8(4:5) // '-'
*     & //             month(mm)   // '-' // cdate8(7:8)
*@elif defined  ( delta) || defined ( paragon)
*      integer i
*      do 2788 i = 1,40
*         chrtdy(i:i) = '?'
* 2788 continue
*@elif defined  unix
*CC
*CC     # generic bsd  version.
*CC     # see also $COLUMBUS/special//* for library
*CC     # routines to support the following machines:
*CC     #    IBM RS/6000
*CC     #    Cray Y-MP, Cray 2 (optional, the cray may also use the mdc
*CC     #                       block in this routine.)
*CC     #    Fujitsu VP2000
*CC
*      integer ierr, i
*CC
*      character*24     fdate
*      integer  hostnm
*      external hostnm, fdate
*CC
*      ierr = hostnm( chrtdy(1:16) )
*      if ( ierr .ne. 0 ) then
*CC        # pack the error code into chrtdy(*)
*         write( chrtdy(1:16),'(a9,i7.7)' )'hostnm()=', ierr
*      endif
*CC
*CC     # change nulls to spaces.  this code assumes that ichar()
*CC     # returns the ascii character value.
*CC
*      do 10 i = 1, 16
*         if ( ichar( chrtdy(i:i) ) .eq. 0 ) then
*            chrtdy(i:i) = ' '
*         endif
*10    continue
*      chrtdy(17:) = fdate()
*@else
*CC
*CC     # default code: just return a dummy string.
*CC
*      chrtdy = site // 'Machine=?  ??:??:?? ??-???-??'
*@endif
c
      return
      end
