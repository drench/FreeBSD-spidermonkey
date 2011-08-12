# Ports collection makefile for:	spidermonkey
# Date created:		Fri Apr 18, 2003
# Whom:			Dan Rench <citric@cubicone.tmetic.com>
#
# $FreeBSD: ports/lang/spidermonkey/Makefile,v 1.25 2009/06/23 19:47:12 pgollucci Exp $

PORTNAME=	spidermonkey
DISTVERSION=	1.8.5
CATEGORIES=	lang
MASTER_SITES=	${MASTER_SITE_MOZILLA_EXTENDED}
MASTER_SITE_SUBDIR=	js
DISTNAME=	js185-1.0.0

MAINTAINER=	citric@cubicone.tmetic.com
COMMENT=	A standalone JavaScript interpreter from the Mozilla project

LIB_DEPENDS=	nspr4.1:${PORTSDIR}/devel/nspr

CONFLICTS=	njs-[0-9]*

MAKE_ARGS+=	JS_THREADSAFE=YES \
		PROG_LIBS="-lreadline -ltermcap -lm ${PTHREAD_LIBS}" \
		LDFLAGS="-L${LOCALBASE}/lib"
CFLAGS+=	-I${LOCALBASE}/include/nspr

USE_GMAKE=	YES
MAKEFILE=	Makefile.ref
ALL_TARGET=	${OPSYS}`${UNAME} -r`_DBG.OBJ/js
MAKE_ENV+=	CCC="${CXX}"
USE_LDCONFIG=	yes
SRC_DIR=	js-${DISTVERSION}/js/src

JSH=		jsapi.h jsarena.h jsarray.h jsatom.h jsautocfg.h jsbool.h \
		jsclist.h jscntxt.h jscompat.h jsconfig.h jsdate.h jsdhash.h \
		jsdtoa.h jsemit.h jsexn.h jsfun.h jsgc.h jshash.h jsinterp.h \
		jsiter.h jslibmath.h jslock.h jslong.h jsmath.h jsnum.h jsobj.h \
		jsopcode.h jsosdep.h jsotypes.h jsparse.h jsprvtd.h jspubtd.h \
		jsregexp.h jsscan.h jsscope.h jsscript.h jsstr.h jstypes.h \
		jsxdrapi.h jsxml.h \
		jsproto.tbl

PLIST_FILES=	bin/js lib/libjs.so lib/libjs.so.1 ${JSH:S,^,include/,}
WRKSRC=		${WRKDIR}/${SRC_DIR}
EXTRACT_AFTER_ARGS=| ${TAR} -xf - \
		--exclude js/jsd

do-configure:
	${CP} ${WRKSRC}/config/Linux_All.mk \
		${WRKSRC}/config/${OPSYS}`${UNAME} -r`.mk && \

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/${OPSYS}`${UNAME} -r`_DBG.OBJ/js \
		${PREFIX}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/${OPSYS}`${UNAME} -r`_DBG.OBJ/libjs.so \
		${PREFIX}/lib
	${LN} -sf ${PREFIX}/lib/libjs.so ${PREFIX}/lib/libjs.so.1
	${CP} ${WRKSRC}/${OPSYS}`${UNAME} -r`_DBG.OBJ/jsautocfg.h ${WRKSRC}
	@${INSTALL_DATA} ${JSH:S,^,${WRKSRC}/,} ${PREFIX}/include/

OPTIONS=   UTF8 "Enable UTF8 support" Off

.include <bsd.port.options.mk>

.if defined(WITH_UTF8)
CFLAGS+=   -DJS_C_STRINGS_ARE_UTF8
.endif

.include <bsd.port.mk>
