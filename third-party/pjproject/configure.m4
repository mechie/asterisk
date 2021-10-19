#
# If this file is changed, be sure to run ASTTOPDIR/bootstrap.sh
# before committing.
#

AC_DEFUN([_PJPROJECT_CONFIGURE],
[
	if test "${ac_mandatory_list#*PJPROJECT*}" != "$ac_mandatory_list" ; then
		AC_MSG_ERROR(--with-pjproject and --with-pjproject-bundled can't both be specified)
	fi

	ac_mandatory_list="$ac_mandatory_list PJPROJECT"
	PJPROJECT_DIR="${ac_top_build_prefix}third-party/pjproject"

	AC_MSG_CHECKING(for embedded pjproject (may have to download))
	AC_MSG_RESULT(configuring)

	if test "x${DOWNLOAD_TO_STDOUT}" = "x" ; then
		AC_MSG_ERROR(A download utility (wget, curl, or fetch) is required to download bundled pjproject)
	fi
	if test "${BZIP2}" = ":" ; then
		AC_MSG_ERROR(bzip2 is required to extract the pjproject tar file)
	fi
	if test "${TAR}" = ":" ; then
		AC_MSG_ERROR(tar is required to extract the pjproject tar file)
	fi
	if test "${PATCH}" = ":" ; then
		AC_MSG_ERROR(patch is required to configure bundled pjproject)
	fi
	if test "${SED}" = ":" ; then
		AC_MSG_ERROR(sed is required to configure bundled pjproject)
	fi
	if test "${NM}" = ":" ; then
		AC_MSG_ERROR(nm is required to build bundled pjproject)
	fi
	if test "${MD5}" = ":" ; then
		AC_MSG_ERROR(md5sum is required to build bundled pjproject)
	fi
	if test "${CAT}" = ":" ; then
		AC_MSG_ERROR(cat is required to build bundled pjproject)
	fi
	if test "${CUT}" = ":" ; then
		AC_MSG_ERROR(cut is required to build bundled pjproject)
	fi
	if test "${GREP}" = ":" ; then
		AC_MSG_ERROR(grep is required to build bundled pjproject)
	fi

	AC_ARG_VAR([PJPROJECT_CONFIGURE_OPTS],[Additional configure options to pass to bundled pjproject])
	this_host=$(./config.sub $(./config.guess))
	if test "$build" != "$this_host" ; then
		PJPROJECT_CONFIGURE_OPTS+=" --build=$build_alias"
	fi
	if test "$host" != "$this_host" ; then
		PJPROJECT_CONFIGURE_OPTS+=" --host=$host_alias"
	fi
	# This was a copy of the autoconf generated code from the root ./configure.
	# Hopefully, when you read this, the code is still the same.
	if test "${with_ssl+set}" = set; then :
		case $with_ssl in
		n|no)
		PJPROJECT_CONFIGURE_OPTS+=" --disable-ssl"
		;;
		y|ye|yes)
		# This is the default value in PJProject and means "autodetect".
		# In Asterisk, "./configure --with-ssl" means "must be present".
		PJPROJECT_CONFIGURE_OPTS+=" --enable-ssl"
		;;
		*)
		PJPROJECT_CONFIGURE_OPTS+=" --with-ssl=${with_ssl}"
		;;
		esac
	fi

	export TAR PATCH SED NM EXTERNALS_CACHE_DIR AST_DOWNLOAD_CACHE DOWNLOAD_TO_STDOUT DOWNLOAD_TIMEOUT DOWNLOAD MD5 CAT CUT GREP
	export NOISY_BUILD AST_DEVMODE
	${GNU_MAKE} --quiet --no-print-directory -C ${PJPROJECT_DIR} \
		PJPROJECT_CONFIGURE_OPTS="$PJPROJECT_CONFIGURE_OPTS" \
		EXTERNALS_CACHE_DIR="${EXTERNALS_CACHE_DIR:-${AST_DOWNLOAD_CACHE}}" \
		configure
	if test $? -ne 0 ; then
		AC_MSG_RESULT(failed)
		AC_MSG_NOTICE(Unable to configure ${PJPROJECT_DIR})
		AC_MSG_ERROR(Re-run the ./configure command with 'NOISY_BUILD=yes' appended to see error details.)
	fi

	AC_MSG_CHECKING(for bundled pjproject)

	PJPROJECT_INCLUDE=$(${GNU_MAKE} --quiet --no-print-directory -C ${PJPROJECT_DIR} PJPROJECT_CONFIGURE_OPTS="$PJPROJECT_CONFIGURE_OPTS" EXTERNALS_CACHE_DIR="${EXTERNALS_CACHE_DIR:-${AST_DOWNLOAD_CACHE}}" echo_cflags)
	PJPROJECT_CFLAGS="$PJPROJECT_INCLUDE"
	PBX_PJPROJECT=1

	AC_DEFINE([HAVE_PJPROJECT], 1, [Define if your system has PJPROJECT])
	AC_DEFINE([HAVE_PJPROJECT_BUNDLED], 1, [Define if your system has PJPROJECT_BUNDLED])

	AC_DEFINE([HAVE_PJSIP_DLG_CREATE_UAS_AND_INC_LOCK], 1, [Define if your system has pjsip_dlg_create_uas_and_inc_lock declared.])
	AC_DEFINE([HAVE_PJ_TRANSACTION_GRP_LOCK], 1, [Define if your system has pjsip_tsx_create_uac2 declared.])
	AC_DEFINE([HAVE_PJSIP_REPLACE_MEDIA_STREAM], 1, [Define if your system has PJSIP_REPLACE_MEDIA_STREAM declared])
	AC_DEFINE([HAVE_PJSIP_GET_DEST_INFO], 1, [Define if your system has pjsip_get_dest_info declared.])
	AC_DEFINE([HAVE_PJ_SSL_CERT_LOAD_FROM_FILES2], 1, [Define if your system has pj_ssl_cert_load_from_files2 declared.])
	AC_DEFINE([HAVE_PJSIP_EXTERNAL_RESOLVER], 1, [Define if your system has pjsip_endpt_set_ext_resolver declared.])
	AC_DEFINE([HAVE_PJSIP_TLS_TRANSPORT_PROTO], 1, [Define if your system has PJSIP_TLS_TRANSPORT_PROTO])
	AC_DEFINE([HAVE_PJSIP_EVSUB_GRP_LOCK], 1, [Define if your system has PJSIP_EVSUB_GRP_LOCK])
	AC_DEFINE([HAVE_PJSIP_INV_SESSION_REF], 1, [Define if your system has PJSIP_INV_SESSION_REF])
	AC_DEFINE([HAVE_PJSIP_AUTH_CLT_DEINIT], 1, [Define if your system has pjsip_auth_clt_deinit declared.])
	AC_DEFINE([HAVE_PJSIP_TSX_LAYER_FIND_TSX2], 1, [Define if your system has pjsip_tsx_layer_find_tsx2 declared.])
	AC_DEFINE([HAVE_PJSIP_INV_ACCEPT_MULTIPLE_SDP_ANSWERS], 1, [Define if your system has HAVE_PJSIP_INV_ACCEPT_MULTIPLE_SDP_ANSWERS declared.])
	AC_DEFINE([HAVE_PJSIP_ENDPOINT_COMPACT_FORM], 1, [Define if your system has HAVE_PJSIP_ENDPOINT_COMPACT_FORM declared.])

	AC_SUBST([PJPROJECT_BUNDLED])
	AC_SUBST([PJPROJECT_DIR])
	AC_SUBST([PBX_PJPROJECT])
	AC_SUBST([PJPROJECT_LIB])
	AC_SUBST([PJPROJECT_INCLUDE])
	AC_SUBST([PJPROJECT_CONFIGURE_OPTS])
	AC_MSG_RESULT(yes)
])

AC_DEFUN([PJPROJECT_CONFIGURE],
[
	if test "$PJPROJECT_BUNDLED" = "yes" ; then
		_PJPROJECT_CONFIGURE()
	fi
])
