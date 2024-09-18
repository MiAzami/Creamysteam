#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# GED Hal ( Kernel) 
for gedh in /sys/kernel/ged/hal
    do
        echo 90 > "$gedh/gpu_boost_level"
    done

# GED Parameter (Module) 
for gedp in /sys/module/ged/parameters
    do
        echo 90 > "$gedp/ged_smart_boost"
        echo 1 > "$gedp/enable_gpu_boost"
        echo 90 > "$gedp/ged_boost_enable"
        echo 1 > "$gedp/boost_gpu_enable"
        echo 0 > "$gedp/is_GED_KPI_enabled"
        echo 1 > "$gedp/gx_game_mode"
        echo 90 > "$gedp/gx_force_cpu_boost"
        echo 90 > "$gedp/boost_amp"
        echo 90 > "$gedp/boost_extra"
        echo 0 > "$gedp/boost_gpu_enable"
        echo 1 > "$gedp/boost_cpu_enable"
        echo 90 > "$gedp/gx_force_cpu_boost"
        echo 90 > "$gedp/cpu_boost_policy"
	done

# FPSGo (PNPMGR) 
for pnp in /sys/pnpmgr
    do
        echo 1 > "$pnp/fpsgo_boost/boost_mode"
        echo 1 > "$pnp/install"
        echo 1 > "$pnp/mwn"
    done
    
# MTKFPS GO Parameter
for fpsp in /sys/module/mtk_fpsgo/parameters
    do
        echo 90 > "$fpsp/boost_affinity"
        echo 80 > "$fpsp/xgf_uboost"
    done
    

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
