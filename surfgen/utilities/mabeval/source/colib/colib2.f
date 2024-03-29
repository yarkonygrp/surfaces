      subroutine aiclos( unit )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: aiclos
c version: 1.0                        date: 10/13/88
c author: eric stahlberg - ohio state university
c purpose: this routine will close a file used for asynchronous i/o.
c
c parameters:
c     unit:    unit number for file to be opened
c
      implicit integer(a-z)
c
      integer unit
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
*@ifdef debug
*      print *, 'aiclos: unit=',unit
*@endif
c
c close a regular file
c
      close(unit=unit)
c
      return
      end
      subroutine aiopen( unit, filnam, length )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: aiopen
c version: 1.0                        date: 10/13/88
c author: eric stahlberg - ohio state university
c purpose: this routine will open a file for asynchronous i/o.
c          record length is in real*8 words for machines
c          which require this value.
c          if an error occurs, bummer is called with an
c          encoded error number: ioerr*100+unit
c parameters:
c     filnam: external file name to associate with unit
c     unit:    unit number for file to be opened
c     length:  length of direct access records in real*8 words
c
      implicit integer(a-z)
c
      integer unit,length
      character*(*) filnam
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      integer ioerr
c
*@ifdef debug
*      print *, 'aiopen: unit=,filnam=,length=',
*     + unit,filnam,' ',length
*@endif
*@ifdef reference
*CC      asynchronous i/o for this case is not implmented because
*CC      calling program calls in wrong order. should be fixed
*CC      when calling programs are rewritten.
*      open(unit=unit,form='unformatted',status='unknown',
*     + sync='asynchronous',file=filnam,iostat=ioerr,err=900)
*@else
c
c open regular file
c
      open(unit=unit,access='sequential',form='unformatted',status=
     +  'unknown',file=filnam,iostat=ioerr,err=900)
*@endif
      return
c
 900  continue
      call bummer('i/o error in openda, (ioerr*100+unit)=',
     & (ioerr*100+unit), faterr )
      end
      subroutine airead( unit, buffer, buflen )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: airead
c version: 1.0                        date: 10/13/88
c author: eric stahlberg - ohio state university
c purpose: this routine will read a record from an asynchronous file
c          buffer length is in real*8 words.
c          if an error occurs, bummer is called with an
c          encoded error number: ioerr*100+unit
c parameters:
c     unit:    unit number for file to be opened
c     buffer:  buffer to read record into
c     buflen:  length of buffer to be read
c
      implicit integer(a-z)
c
      integer unit,buflen
      real*8 buffer(buflen)
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      integer ioerr
c
*@ifdef debug
*      print *, 'airead: unit=, buflen=',unit,buflen
*@endif
*@ifdef reference
*C      asynchronous i/o for this case is not implmented because
*C      calling program calls in wrong order. should be fixed
*C      when calling programs are rewritten.
*      read (unit=unit,iostat=ioerr,err=900,wait=.false.) buffer
*@else
c
c read regular file
c
      read (unit=unit,iostat=ioerr,err=900) buffer
*@endif
c
      return
c
 900  continue
      call bummer('i/o error in airead, (ioerr*100+unit)=',
     & (ioerr*100+unit), faterr )
      end
      subroutine aiwait( unit )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: aiwait
c version: 1.0                        date: 10/13/88
c author: eric stahlberg - ohio state university
c purpose: this routine will wait for an asynchronous file
c
c parameters:
c     unit:    unit number for file to be opened
c
      implicit integer(a-z)
c
      integer unit,ioerr
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
*@ifdef debug
*      print *, 'aiwait: unit=',unit
*@endif
c
c
*@ifdef reference
*      wait(unit,iostat=ioerr)
*      if (ierr.ne.0) goto 900
*@endif
      return
c
 900  call bummer('aiwait: i/o error, (ioerr*100+unit)=',
     & (ioerr*100+unit), faterr )
      end
      subroutine aiwrit( unit, buffer, buflen )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: aiwrit
c version: 1.0                        date: 10/13/88
c author: eric stahlberg - ohio state university
c purpose: this routine will write a record to an asynchronous file
c          buffer length is in real*8 words.
c          if an error occurs, bummer is called with an
c          encoded error number: ioerr*100+unit
c parameters:
c     unit:    unit number for file to be opened
c     buffer:  buffer to read record into
c     buflen:  length of buffer to be read
c
      implicit integer(a-z)
c
      integer unit,buflen
      real*8 buffer(buflen)
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      integer ioerr
c
*@ifdef debug
*      print *, 'aiwrit: unit=, buflen=',unit,buflen
*@endif
*@ifdef  reference
*C      asynchronous i/o for this case is not implmented because
*C      calling program calls in wrong order. should be fixed
*C      when calling programs are rewritten.
*      write (unit=unit,iostat=ioerr,err=900,wait=.false.) buffer
*@else
c
c write regular file
c
      write (unit=unit,iostat=ioerr,err=900) buffer
*@endif
      return
c
 900  continue
      call bummer('i/o error in airead, (ioerr*100+unit)=',
     & (ioerr*100+unit), faterr )
      end
      subroutine closda( unit, delflg, parm )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: closda
c version: 1.2                        date: 12/17/90
c author: eric stahlberg - ohio state university
c purpose: this routine will close a direct access file. the
c          file may be deleted if delflg is set to 'delete'.
c          vector
c paramters:
c     unit: unit number of file to close
c     delflg: flag to indicate deletion of file upon close
c     parm: value employed by certain machines in closing
c
      implicit integer(a-z)
c
c     mapunit(origunit,sequenceunits)
c     reqperunit (origunit)
      integer maxfilesize
c     maximum file size in bytes
*@ifdef int64
      parameter (maxfilesize = 1000*8*1024*1024*250 )
*@elif defined  (rs6000) || defined (macabsoft) || defined (largefiles) 
*c     # 32-bit integers, but supports large files - disable splitting.
*      parameter (maxfilesize = 0)
*@else
*C     # 32-bit integers and 2GB max filesize limit.
*      parameter (maxfilesize = 8*1024*1024*250 )
*@endif
c     parameter (maxfilesize = 1024*512 )
      integer maxunits,maxsequnits
      parameter (maxunits=99,maxsequnits=4)
      integer mapunit(maxunits,maxsequnits)
      integer recperunit(maxunits),firstfreebl
      character*30 filename(maxunits)
      common /mapping/ mapunit,recperunit,firstfreebl,filename

      integer unit, parm
      character*(*) delflg
c
c common block for unit information
      integer         mxunit
      parameter       (mxunit=99)
c recnum retains next record to be written
c reclen retains record length in open
c seqwrt retains true if sequential write is to be enforced
      integer         recnum(mxunit)
      integer         reclen(mxunit)
      logical         seqwrt(mxunit)
      common  /esio88/   recnum, reclen, seqwrt
      save    /esio88/
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      logical  streq
      external streq
c
c
c perform error checking
c
*@ifdef debug
*       print *, 'closda: unit=, delflg=, parm=',unit,delflg,' ',parm
*@endif
      if (unit.gt.mxunit.or.unit.le.0) goto 910
c
c no error detection is done on the close. an error in this routine
c will give more information from a system abend.
c
*@ifdef ibmcms
*      call uclose(unit,parm,ierr)
*C     parm = 2  close and retain
*C            4  close and delete
*      if (ierr.ne.0) then
*        call bummer('closda: error in uclose, (ierr*100+unit)=',
*     +  (ierr*100+unit), faterr )
*      endif
*@else
      if ( streq( delflg, 'delete' ) ) then
        do ii=1,maxsequnits
           if (mapunit(unit,ii).gt.0) then
             close (unit=mapunit(unit,ii),status='delete')
           endif
        enddo
      else
        do ii=1,maxsequnits
           if (mapunit(unit,ii).gt.0) then
             close (unit=mapunit(unit,ii))
           endif
        enddo
      endif
*@endif
      return
 910  continue
      call bummer('closda: invalid unit', unit, nfterr)
      return
      end
      subroutine getvec(
     & unit,   lenrec, logrec, loglen,
     & vector, start,  length )
c
c     getvec : subroutine to access word addressable information
c              residing on direct access file
c
c     written by: eric stahlberg (in consulation with ron shepard)
c     date:       september 1990
c     version:    1.1
c
      implicit integer(a-z)
c
      integer unit,logrec,loglen,start,length,lenrec
      real*8 vector(*)
c
c     unit  : unit number
c     logrec: logical record number
c     loglen: logical record length
c     vector: data
c     start : start of data in logical record
c     length: length of record in logical data
c
c     local variables
c
      integer rcode(4)
c
*@ifdef debug
*      write(*,*) 'getvec:unit,lenrec,logrec,loglen,start,'
*     .  ,'length,', unit,lenrec,logrec,loglen,start,length
*@endif
      call readvc(
     & unit,   lenrec, vector, start,
     & length, logrec, loglen, rcode )
c
      return
      end
      subroutine inivec( offset, number )
c
c     inivec: initialize vector i/o interface routines for
c             segmented writing
c
c     written by: eric stahlberg
c     date:       september 1990
c     version:    1.1
c
      implicit integer(a-z)
c
      integer offset(*),number
c
c     offset  : integer offset of breaks in logical record
c     number  : number of breaks
c
      integer maxbrk,nbreak,breaks
      parameter (maxbrk=100)
      common /esio90/ nbreak, breaks(maxbrk)
      save   /esio90/
c
      integer i
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      if (number.gt.maxbrk) then
         call bummer('inivec: insuff. word-addressable breaks',
     &    number, faterr )
      endif
c
      nbreak = number
      do 10 i = 1, number
         breaks(i) = offset(i) + 1
10    continue
      return
      end
      subroutine openda( unit, filnam, length, scrtch, seqflg )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: openda
c version: 1.2                        date: 12/17/90
c author: eric stahlberg - ohio state university
c purpose: this routine will open a direct access file. if seqflg
c          is set to 'seqwrt' , then sequential writing of da
c          records will be enforced. record length is in real*8
c          words. if an error occurs, bummer is called with an
c          encoded error number: ioerr*100+unit
c parameters:
c     filnam: external file name to associate with unit
c     unit:    unit number for file to be opened
c     length:  length of direct access records in real*8 words
c     seqflg:  flag to indicate sequential write of records to
c              be enforced. enforcement if seqflg='seqwrt'
c     scrtch: flag for scratch files. unit to be opened is scratch
c              if scrtch='scratch'
c
      implicit integer(a-z)
c
ctm
c     mapunit(origunit,sequenceunits)
c     reqperunit (origunit)
      integer maxfilesize
c     maximum file size in bytes
*@ifdef int64
      parameter (maxfilesize = 1000*8*1024*1024*250 )
*@elif defined  (rs6000) || defined (macabsoft) || defined (largefiles) 
*c     # 32-bit integers, but supports large files - disable splitting.
*      parameter (maxfilesize = 0)
*@else
*C     # 32-bit integers and 2GB max filesize limit.
*      parameter (maxfilesize = 8*1024*1024*250 )
*@endif
c     parameter (maxfilesize = 1024*512*4 )
      integer maxunits,maxsequnits
      parameter (maxunits=99,maxsequnits=4)
c     mapunit(i,k) contains the real unit numbers associated
c                  with unit i
      integer mapunit(maxunits,maxsequnits)
c     recperunit(i) contains the recordlength associated with unit i
c     firstfreebl  is the lowest free unit number available
      integer recperunit(maxunits),firstfreebl
      character*30 filename(maxunits)
      common /mapping/ mapunit,recperunit,firstfreebl,filename
ctm
      integer unit,length
      character*(*) filnam,seqflg,scrtch
*@ifdef ibmcms
*      character*80  text
*@endif
c
c common block for unit information
      integer         mxunit
      parameter       (mxunit=99)
c recnum retains next record to be accessed
c reclen retains record length in open
c seqwrt retains true if sequential write is to be enforced
      integer         recnum(mxunit)
      integer         reclen(mxunit)
      logical         seqwrt(mxunit)
      common  /esio88/   recnum, reclen, seqwrt
      save    /esio88/
c
*@ifdef ibmmvs
*      integer         ibmlen
*      parameter (ibmlen=2932)
*@endif
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      integer ioerr
      integer lrecl
      logical  streq
      external streq
      integer  fstrlen
      external fstrlen
      logical firstcall
      data firstcall/.true./
      save firstcall

      if (firstcall) then
c  initialize maparrays
       call izero_wr(maxunits*maxsequnits,mapunit,1)
       call izero_wr(maxunits,recperunit,1)
       do ii=1,maxunits
        filename(ii)='#'
       enddo
       firstcall=.false.
       firstfreebl=86
      endif


c
*@ifdef debug
*       write (*,*)  'openda: unit=,filnam=,length=,seqflg=,scrtch=',
*     + unit,filnam,' ',length,seqflg,' ',scrtch
*@endif
c
c perform error checking and info assignments
       if (unit.gt.mxunit.or.unit.lt.0) goto 910
       if ( streq( seqflg, 'seqwrt' ) ) then
          seqwrt(unit)=.true.
       else
          seqwrt(unit)=.false.
       endif
       if (firstfreebl.gt.99-maxsequnits)
     .  call bummer('too many calls to openda',firstfreebl,2)
       reclen(unit)=length
       recnum(unit)=1
c
*@ifdef largefiles
       recperunit(unit)=1024*1024*1024
*@else
*      recperunit(unit)=(maxfilesize/(8*reclen(unit)))
*@endif

*@ifdef rclu8
*C 
*      lrecl=length
*@elif defined rclu4
*C  vax,decalpha,sgipower
*      lrecl=2*length
*@else
      lrecl=8*length
*@endif
      if ( .not. streq( scrtch, 'scratch' ) ) then
c
c open regular file
c
      mapunit(unit,1)=unit
      filename(unit)=filnam(1:fstrlen(filnam))
      open(unit=unit,access='direct',form='unformatted',status=
     +  'unknown',file=filnam,iostat=ioerr,recl=lrecl,err=900)
c
      else
      mapunit(unit,1)=unit
      filename(unit)=filnam(1:fstrlen(filnam))
c     open(unit=unit,access='direct',form='unformatted',status=
c    +  'scratch',iostat=ioerr,recl=lrecl,err=900)
      open(unit=unit,access='direct',form='unformatted',status=
     +  'unknown',file=filnam,iostat=ioerr,recl=lrecl,err=900)
      endif
      return
c
 900  continue
      call bummer('openda: (ioerr*100+unit)=',(ioerr*100+unit),faterr)
 910  continue
      call bummer('openda: bad unit number',unit,faterr)
      end
      subroutine putvec(
     & unit,   lenrec, logrec, loglen,
     & vector, start,  length, icode  )
c
c     putvec : subroutine to place word addressable information
c              residing on direct access file
c
c     written by: eric stahlberg (in consultation with ron shepard)
c     date:       december 1990
c     version:    1.2
c
c
      implicit integer(a-z)
c
      integer unit,logrec,loglen,start,length,icode,lenrec
      real*8 vector(*)
c
c     unit  : unit number
c     logrec: logical record number
c     loglen: logical record length
c     vector: data
c     start : start of data in logical record
c     length: length of record in logical data
c     icode : initialization code (defined below)
c             icode=0 : no initialization
c             icode=1 : initialize record with breakpoints
c                       listed in common esio90
c             icode=2 : fully initialize the entire record
c
c     local variables
c
      integer ncodev,irecd,ibrk,ntime,rcode(4),precd
      real*8 data(8*4096)
c
c     # common information
c
c     # positions of breaks when writing data in offset form
c     #  - used for icode = 2 only
c
      integer breaks,nbreak,maxbrk
      parameter (maxbrk=100)
      common /esio90/ nbreak, breaks(maxbrk)
      save   /esio90/
c
c     # bummer error types
      integer    wrnerr,   nfterr,   faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
c     accounting information
c
      integer    maxvec
      parameter (maxvec=500)
      integer   vtotal,    codev(maxvec),   times(maxvec)
      save      vtotal,    codev,           times
      data      vtotal/0/, codev/maxvec*0/, times/maxvec*0/
c
c
*@ifdef debug
*      write(*,*) 'putvec:unit,lenrec,logrec,loglen,start,'
*     .  ,'length,icode ', unit,lenrec,logrec,loglen,start,length,
*     . icode
*@endif
      if ((unit.le.0).or.(unit.ge.100)) then
         call bummer('putvec: bad unit number', unit, faterr )
      endif
c
c     # search initialized vector list for current vector
c
      ncodev = logrec*100 + unit
      precd = 0
      do 10 irecd=1,vtotal
         if (codev(irecd).eq.ncodev) then
            precd = irecd
            goto 15
         endif
10    continue
c
      if (precd.eq.0) then
         vtotal = vtotal + 1
         precd  = vtotal
         codev(precd) = ncodev
         times(precd) = 0
      endif
      if (vtotal.gt.maxvec) then
         call bummer('putvec: max number vectors exceeded',
     &    maxvec, faterr )
      endif
15    continue
      times(precd) = times(precd) + 1
      ntime = times(precd)
c
c     write(0,*) 'putvec: icode,ntime=',icode,ntime
      if ( ntime .eq. 1 ) then
c        # first time for this vector.  initialize if necessary.
         if ( icode .eq. 0 ) then
c           # best case: no initialiation requested
         elseif ( icode .eq. 1 ) then
c           # initialize break records only
            do 100 ibrk = 1, nbreak
               call writvc(
     &          unit,   lenrec, data,   breaks(ibrk),
     &          1,      logrec, loglen, 0,
     &          rcode  )
100         continue
         elseif ( icode .eq. 2 ) then
            call wzero(8*4096,data,1)
c           # initialize every record
            write(6,*) 'initializing every record, lenrec=',lenrec,
     .       ' loglen=', loglen
            do 200 ibrk = 1, loglen, lenrec
               call writvc(
     &          unit,   lenrec, data,   ibrk,
     &          min(lenrec,8*4096,loglen+1-ibrk),logrec, loglen, 0,
     &          rcode  )
200         continue
         else
            call bummer('putvec: invalid icode ', icode, faterr )
         endif
      endif
c
*@ifdef debug
*      write(*,*)'putvec/writvc unit,logrec,start,ilen',
*     . unit,logrec,start,length
*@endif
*@ifdef debug
*      call writex(vector,length)
*@endif
*
      call writvc(
     & unit,   lenrec, vector, start,
     & length, logrec, loglen, icode,
     & rcode  )
c
      return
      end
      subroutine readda( unit, record, buffer, buflen )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: readda
c version: 1.2                        date: 12/17/90
c author: eric stahlberg - ohio state university
c purpose: this routine will read a given vector from a
c          direct access file. the length of the vector is given
c          in minimum necessary real*8 words to access the entire
c          vector. io errors reported in encoded form: ioerr*100+unit
c parameters:
c     unit:   unit number of file to be read
c     record: record number to be read
c     buffer: buffer to read record into
c     buflen: number of real*8 words to read from record
c
      implicit integer(a-z)
c
ctm
c     mapunit(origunit,sequenceunits)
c     reqperunit (origunit)
      integer maxunits,maxsequnits
      parameter (maxunits=99,maxsequnits=4)
      integer mapunit(maxunits,maxsequnits)
      integer recperunit(maxunits),firstfreebl
      character*30 filename(maxunits)
      common /mapping/ mapunit,recperunit,firstfreebl,filename
ctm

      integer unit,record,buflen
      real*8 buffer ( buflen )
c
c common block for unit information
      integer         mxunit
      parameter       (mxunit=99)
c recnum retains next record to be accessed
c reclen retains record length in open
c seqwrt retains true if sequential write is to be enforced
      integer         recnum(mxunit)
      integer         reclen(mxunit)
      logical         seqwrt(mxunit)
      common  /esio88/   recnum, reclen, seqwrt
      save    /esio88/
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      integer ioerr
      character*40 filnamn
c
*@ifdef debug
*      print*,'readda: unit=,record=,buflen=',unit,record,buflen
*@endif
c
c
c perform error checking
c
      if (unit.gt.mxunit.or.unit.le.0) goto 910
      if (buflen.ne.reclen(unit)) goto 920
      if (seqwrt(unit)) goto 930
ctm
c      map from unit to correct sequnit
       rectmp = (record-1)/recperunit(unit) +1
       if (rectmp.gt.maxsequnits)
     . call bummer('could not open more files',rectmp,2)
       unitnew= mapunit(unit,rectmp )
c################
       if (unitnew.le.0) then
c    must open new file
*@if defined  (decalpha) || defined ( sgipower )
*         lrecl=2*buflen
*@else
         lrecl=8*buflen
*@endif
      write(filnamn,'(a,a1,i1)')
     . filename(unit)(1:fstrlen(filename(unit)))
     .     ,'_',rectmp
      if (firstfreebl.eq.99)
     . call bummer('no more unit numbers available',firstfreebl,2)
      mapunit(unit,rectmp)=firstfreebl
      firstfreebl=firstfreebl+1
      unitnew= mapunit(unit,rectmp )
      write(6,*) 'info: opening file ',filnamn,' unit=',unitnew
      open(unit=unitnew,access='direct',form='unformatted',status=
     +  'unknown',file=filnamn,iostat=ioerr,recl=lrecl,err=900)
       endif
c#################
       recnew = record - (rectmp-1)*recperunit(unit)
c!!       write(6,*) rectmp,unit,unitnew,record,recnew
       read (unitnew, rec = recnew ,iostat=ioerr, err=900) buffer
c      call writex(buffer,buflen,'readda')
ctm
c point to next record
 902  recnum(unit)=record+1
c
      return
 899  format(' current reclen=',i10/
     & ' opened reclen=',i10/' recnum=',i10)
c
c error conditions
 900  continue
      write(*,899) reclen(unit),buflen,record
      call bummer('readda: i/o error,  (ioerr*100+unit)=',
     & (ioerr*100+unit), faterr )
 910  continue
      call bummer('readda: invalid unit number ',unit,faterr)
 920  continue
      write(*,899) reclen(unit),buflen,record
      call bummer('readda: buffer length gt record length ',unit,faterr)
 930  continue
      write(*,899) reclen(unit),buflen,record
      call bummer('readda: unit opened for seq. write',unit,faterr)
      end
      subroutine readvc(
     & unit,   reclen, vector, start,
     & length, logrec, loglen, rcode )
c
c     readvc
c     version 1.2               date: 12:17:90
c     eric stahlberg - ohio state university
c
c
c     subroutine to read in a segment from a da file
c
c     unit : unit number to read from
c     vector: vector to return read information in
c     start  : starting word of data
c     length : length of data to read
c     loglen : length of a logical record
c     logrec : logical record number

c     rcode  : list of return codes from routine
c
      implicit integer(a-z)
c
      integer unit,length,logrec,loglen,reclen,start
      integer rcode(4)
      real*8 vector(*)
c
      integer vecpos, first1, last1, first, last, dafrst, dalast
c
c     common block for direct access buffer
c     should be tuned to optimal values for particular machines
c
      real*8 iobuf
      integer buflen
      parameter (buflen=8*4096)
      common / dabuf / iobuf(buflen)
c
      integer numset, lencpy, irec
c
c     # bummer error types
      integer    wrnerr,   nfterr,   faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
c     underlying design
c
c     calculate record numbers which contain the range of
c     desired information
c
c     perform consistency checks
c
*@ifdef debug
*       write(*,*)'readvc:unit,logrec,start,length ',unit,logrec,start,
*     +               length
*@endif
      if (buflen.lt.reclen) then
         call bummer('readvc: buflen too short',buflen,faterr)
      elseif (logrec.le.0) then
         call bummer('readvc: invalid logical record',logrec,faterr)
      elseif ((logrec.ne.1).and.(loglen.le.0)) then
         call bummer('readvc: invalid logical length',loglen,faterr)
      elseif (((start+length-1).gt.loglen).and.(loglen.gt.0)) then
         call bummer('readvc: read beyond end of logical record',
     +    loglen, faterr )
      endif
c
c     set up addressing information
c
      numset = (loglen - 1) / reclen + 1
c
c     calculate records offset into a vector set
c
      first = (start - 1) /reclen + 1
      first1 = start - (first - 1) * reclen
c
      last = (start + length - 2) / reclen + 1
      last1 = start + length - 1 - (last - 1) * reclen
c
c     calculate true direct access record of start
c
      dafrst = numset * (logrec - 1) + first
      dalast = numset * (logrec - 1) + last
c
c     # special cases: 1 ) irec = dafrst
c     #                2 ) irec = dalast
c     #                3 ) irec = in between
c     #                4 ) dafrst = dalast
c
      vecpos = 1
      if (dafrst.eq.dalast) then
         call readda( unit, dafrst, iobuf, reclen )
         lencpy = last1 - first1 + 1
         call dcopy_wr( lencpy,  iobuf(first1), 1,  vector(vecpos), 1 )
      else
         do 10 irec = dafrst,dalast
            if (irec.eq.dalast) then
c
c              read in record at end and copy portion to return vector
c
               call readda( unit, irec, iobuf, reclen )
               lencpy = last1
               call dcopy_wr( lencpy,  iobuf(1), 1,  vector(vecpos), 1 )
               vecpos = vecpos + lencpy
            elseif (irec.eq.dafrst) then
c
c              read in record at beginning and copy portion
c              to return vector
c
               call readda( unit, irec, iobuf, reclen )
               lencpy = reclen - first1 + 1
               call dcopy_wr( lencpy, iobuf(first1), 1, vector(vecpo
     + s), 1 )
*
               vecpos = vecpos + lencpy
            else
c
c              read in record at correct location in return vector
c
               call readda( unit, irec, vector(vecpos), reclen )
               vecpos = vecpos + reclen
            endif
10       continue
      endif
c
c     set up return codes describing information location
c
      rcode(1) = dafrst
      rcode(2) = dalast
      rcode(3) = first1
      rcode(4) = last1
c
*@ifdef debug
*       write(*,*) ' readvc: unit,logrec,rcode ',unit,logrec,
*     .  rcode,' length=',length
*       call writex(vector,length)
*@endif
      return
      end
      subroutine seqrbf( unit, buffer, buflen )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: seqrbf
c version: 1.0                        date: 8/24/88
c author: eric stahlberg - ohio state university
c purpose: this routine will read a given vector from a
c          sequential file. the length of the vector is given
c          in minimum necessary real*8 words to access the entire
c          vector
c parameters:
c     unit:   unit number to read from
c     buffer: buffer to transfer information to
c     buflen: number of real*8 words to read from file
c
      implicit integer(a-z)
c
      integer unit, buflen
      real*8 buffer ( buflen )
c
*@ifdef debug
*      print *,'seqrbf: unit=, buflen=',unit,buflen
*@endif
c
      read (unit) buffer
c
      return
      end
      subroutine seqwbf( unit, buffer, buflen )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: seqwbf
c version: 1.0                        date: 8/24/88
c author: eric stahlberg - ohio state university
c purpose: this routine will write a given vector to a
c          sequential file. the length of the vector is given
c          in minimum necessary real*8 words to access the entire
c          vector
c parameters:
c     unit:   unit number to be written
c     buffer: buffer to be written
c     buflen: number of real*8 words to write to file
c
      implicit integer(a-z)
c
      integer unit, buflen
      real*8 buffer ( buflen )
c
*@ifdef debug
*      print *,'seqwbf: unit=, buflen=',unit,buflen
*@endif
c
      write (unit) buffer
      return
      end
      subroutine writda( unit, record, buffer, buflen )
c
c----------------------------------------------------------
c this is a primitive i/o routine to be used by all higher
c level routines requiring i/o of this type. machine i/o
c peculiarites are meant to reside in these routines only.
c----------------------------------------------------------
c
c routine name: writda
c version: 1.2                        date: 12/17/90
c author: eric stahlberg - ohio state university
c purpose: this routine will write a given vector to a
c          direct access file. the length of the vector is given
c          in minimum necessary real*8 words to access the entire
c          vector. io errors reported in encoded form: 100*ioerr+unit
c parameters:
c     unit:  unit number to write to
c     record: record number to be written
c     buffer: buffer to be written on record
c     buflen: length of buffer in real*8 words
c
      implicit integer(a-z)
ctm
c     mapunit(origunit,sequenceunits)
c     reqperunit (origunit)
      integer maxunits,maxsequnits
      parameter (maxunits=99,maxsequnits=4)
      integer mapunit(maxunits,maxsequnits)
      integer recperunit(maxunits),firstfreebl
      character*30 filename(maxunits)
      common /mapping/ mapunit,recperunit,firstfreebl,filename

      character*40 filnamn
ctm
*
      integer unit,record,buflen
      real*8 buffer ( buflen )
c
c common block for unit information
      integer         mxunit
      parameter       (mxunit=99)
c recnum retains next record to be accessed
c reclen retains record length in open
c seqwrt retains true if sequential write is to be enforced
      integer         recnum(mxunit)
      integer         reclen(mxunit)
      logical         seqwrt(mxunit)
      common  /esio88/   recnum, reclen, seqwrt
      save    /esio88/
c
c     # bummer error types
      integer wrnerr, nfterr, faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
      integer ioerr
c
      integer  fstrlen
      external fstrlen
c
*@ifdef debug
*        print*,'writda: unit=,record=,buflen=',unit,record,buflen
*@endif
c
c perform error checking
c
      if (unit.gt.mxunit) goto 910
      if (buflen.ne.reclen(unit)) goto 920
      if ((record.ne.recnum(unit)).and.(seqwrt(unit))) goto 930
c
ctm
c     map from unit to correct sequnit
      if (recperunit(unit).le.0)
     . call bummer('invalid call to writda',0,2)
      rectmp = (record-1)/recperunit(unit) +1
      if (rectmp.gt.maxsequnits)
     . call bummer('could not open more files',rectmp,2)
      unitnew= mapunit(unit,rectmp )
c################
       if (unitnew.le.0) then
c    must open new file
*@if defined  (decalpha) || defined ( sgipower )
*         lrecl=2*buflen
*@else
         lrecl=8*buflen
*@endif
      write(filnamn,'(a,a1,i1)')
     . filename(unit)(1:fstrlen(filename(unit)))
     .     ,'_',rectmp
      if (firstfreebl.eq.99)
     . call bummer('no more unit numbers available',firstfreebl,2)
      mapunit(unit,rectmp)=firstfreebl
      firstfreebl=firstfreebl+1
      unitnew= mapunit(unit,rectmp )
      write(6,*) 'info: opening file ',filnamn,' unit=',unitnew
      open(unit=unitnew,access='direct',form='unformatted',status=
     +  'unknown',file=filnamn,iostat=ioerr,recl=lrecl,err=900)
       endif
c#################
       recnew = record - (rectmp-1)*recperunit(unit)
      write (unitnew, rec=recnew, iostat=ioerr, err=900 ) buffer
c      call writex(buffer,buflen,'writda')
ctm
c
c point to next record
c for sequential writes, this will increment the count in recnum
c for random writes, this will point 1 record beyond that written
c
      recnum(unit)=record+1
c
      return
 899  format(' current reclen=',i10/
     & ' opened reclen=',i10/' recnum=',i10)
c
c error conditions
 900  continue
      write (*,899) reclen(unit),buflen,record
      call bummer('writda: i/o error, (ioerr*100+unit)=',
     & (ioerr*100+unit),faterr)
 910  continue
      call bummer('writda: invalid unit number ',unit,faterr)
 920  continue
      write (*,899) reclen(unit),buflen,record
      call bummer('writda: buffer length ne record length ',unit,faterr)
 930  continue
      write (*,899) reclen(unit),buflen,record
      call bummer('writda: records out of order ',unit,faterr)
      end
      subroutine writvc(
     & unit,   reclen, vector, start,
     & ilen,   logrec, loglen, icode,
     & rcode )
c
c     writvc
c     version 2.0               date: 12:17:90
c     eric stahlberg - ohio state university
c
c subroutine to update a segment from a da file
c
c     unit   : unit number to read from
c     vector : vector to return read information in
c     start  : starting word of data in logical record
c     ilen   : length of data to write
c            : if length = 0, then do no write
c     loglen : length of a logical record
c     logrec : logical record number
c     icode  : function code for reading fragments
c     rcode  : integer array of return codes
c
c     special note: some o/s machine combinations do not allow
c     reading a record which has not already been initialized.
c     a method has been adopted to address this issue.  in
c     these cases, there must be a test to check if a read can
c     be done prior to updating. this will be apparent in the
c     following code.
c
      implicit integer(a-z)
c
      integer unit,ilen,logrec,loglen,start,reclen
      integer rcode(4),icode
      real*8 vector(*)
c
      integer vecpos, first1, last1, first, last, dafrst, dalast
      integer length
      logical rlead,rtrail
c
c     buffer should be tuned to appropriate values for machines
c     (see also readvc)
c
      integer buflen
      parameter (buflen=8*4096)
      real*8 iobuf(buflen)
c
      integer numset, lencpy, irec
c
c     # bummer error types
      integer    wrnerr,   nfterr,   faterr
      parameter (wrnerr=0, nfterr=1, faterr=2)
c
c     underlying design
c
c     calculate record numbers which contain the range of
c     desired information
c
c     perform error checking
c
*@ifdef debug
*      write(*,*)'writvc unit,logrec,start,ilen',unit,logrec,start,ilen
*@endif
      length = abs(ilen)
*@ifdef debug
*      call writex(vector,length)
*@endif
c
      if (buflen.lt.reclen) then
         call bummer('writvc: buflen too short ',buflen,faterr)
      elseif (logrec.le.0) then
         call bummer('writvc: invalid logical record',logrec,faterr)
      elseif ((logrec.ne.1).and.(loglen.le.0)) then
         call bummer('writvc: invalid logical record length',
     &    loglen, faterr )
      elseif (((start+length-1).gt.loglen).and.(loglen.gt.0)) then
         call bummer ('writvc: write beyond end of logical record',
     +                loglen, faterr )
      endif
c
      if (ilen.le.0) then
         return
      endif
c
c     set up fragment pre-reading control
c     binary representation...
c     00 = (0) no read leading or trailing fragment
c     01 = (1) no read leading, do read trailing
c     10 = (2) read leading, no read trailing
c     11 = (3) read leading and trailing fragments
c
       rlead  = ((icode / 2) .eq. 1)
       rtrail = (mod(icode,2) .eq. 1)
c
c     set up addressing information
c
      numset = (loglen - 1) / reclen + 1
c
c     calculate records offset into a vector set
c
      first = (start - 1) / reclen + 1
      first1 = start - (first - 1) * reclen
c
      last = (start + length - 2 ) / reclen + 1
      last1 = start + length - 1 - (last - 1) * reclen
c
c     calculate true direct access record of start
c
      dafrst = numset * (logrec - 1) + first
      dalast = numset * (logrec - 1) + last
c
c     # special cases: 1 ) irec = dafrst
c     #                2 ) irec = dalast
c     #                3 ) irec = in between
c
      vecpos = 1
      if (dafrst.eq.dalast) then
c
c        required information resides on one physical record only
c        three cases:
c        #1) no leading fragments
c        #2) no trailing fragments
c        #3) both leading and trailing fragments
c
         if (first1.eq.1) then
            if ( ((last1.ne.reclen) .and.
     &       ((start+length-1).ne.loglen)) .and. rtrail ) then
               call readda( unit, dafrst, iobuf, reclen )
            endif
         elseif ((last1.eq.reclen) .or.
     &       ((start+length-1).eq.loglen)) then
            if ((first1.ne.1).and.rlead) then
               call readda( unit, dafrst, iobuf, reclen )
            endif
         elseif (rlead.or.rtrail) then
            call readda( unit, dafrst, iobuf, reclen )
         endif
         lencpy = last1 - first1 + 1
         call dcopy_wr( lencpy,  vector(vecpos), 1,  iobuf(first1), 1 )
         call writda( unit, dafrst, iobuf, reclen )
      else
c
c        information spans multiple physical records
c
         do 10 irec = dafrst,dalast
            if (irec.eq.dalast) then
c
c              read in record at end and copy in new portion
c
               if ((((start+length-1).ne.loglen).and.
     +          (last1.ne.reclen)).and.rtrail) then
                  call readda( unit, irec, iobuf, reclen )
               endif
               lencpy = last1
               call dcopy_wr( lencpy, vector(vecpos), 1, iobuf(1), 1 )
c
c              write out updated record
c
               call writda( unit, irec, iobuf, reclen )
               vecpos = vecpos + lencpy
            elseif (irec.eq.dafrst) then
c
c              read in record at beginning and copy in new portion
c
               if ((first1.ne.1).and.rlead) then
                  call readda( unit, irec, iobuf, reclen )
               endif
               lencpy = reclen - first1 + 1
               call dcopy_wr( lencpy, vector(vecpos), 1, iobuf(first
     + 1), 1 )
*
c
c              write out updated record
c
               call writda( unit, irec, iobuf, reclen )
               vecpos = vecpos + lencpy
            else
c
c              write out record at correct location in vector
c
               call writda( unit, irec, vector(vecpos), reclen )
               vecpos = vecpos + reclen
            endif
10       continue
      endif
c
c     set return codes to status of file access
c
      rcode(1) = dafrst
      rcode(2) = dalast
      rcode(3) = first1
      rcode(4) = last1
*@ifdef debug
*      write(*,*) 'writvc: unit,logrec,rcode ',unit,logrec,rcode
*@endif
c
      return
      end
