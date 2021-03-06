
rm -rf $HOME/pfiles
export ISDC_ENV=/home/integral/osa
source $ISDC_ENV/bin/isdc_init_env.sh

export INTEGRAL_DDCACHE_ROOT=/data/ddcache
export CURRENT_IC=/data/ic_tree_current
export INTEGRAL_DATA=/data/rep_base_prod
export REP_BASE_PROD=/data/rep_base_prod

export F90=gfortran #f95
export F95=gfortran #f95
export F77=gfortran #f95
export CC="gcc" # -Df2cFortran"
export CXX="g++" # -Df2cFortran"
source $HOME/root/bin/thisroot.sh

