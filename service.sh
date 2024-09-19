#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

sleep 5

# CPU SET
for cpus in /sys/devices/system/cpu
    do
        echo 1 > "$cpus/cpu0/online"
        echo 1 > "$cpus/cpu1/online"
        echo 1 > "$cpus/cpu2/online"
        echo 1 > "$cpus/cpu3/online"
        echo 1 > "$cpus/cpu4/online"
        echo 1 > "$cpus/cpu5/online"
        echo 1 > "$cpus/cpu6/online"
        echo 1 > "$cpus/cpu7/online"
    done
    
#  Governor CPU0
chmod 644 /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor

#  Governor CPU6
chmod 644 /sys/devices/system/cpu/cpufreq/policy6/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor

#  Governor CPU4
chmod 644 /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor

#  Governor CPU7
chmod 644 /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor

# GPU 
echo "performance" > /sys/class/devfreq/mtk-dvfsrc-devfreq/governor
echo "performance" > /sys/class/devfreq/13000000.mali/governor
echo "coarse_demand" > /sys/class/misc/mali0/device/power_policy
echo "-1" > /proc/gpufreqv2/fix_target_opp_index

# CPU SET
chmod 644 /sys/devices/system/cpu/*/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/*/cpufreq/scaling_min_freq
for maf0 in /sys/devices/system/cpu
    do
        echo 20000000 > "$maf0/cpu0/cpufreq/scaling_max_freq"
        echo 20000000 > "$maf0/cpu1/cpufreq/scaling_max_freq"
        echo 20000000 > "$maf0/cpu2/cpufreq/scaling_max_freq"
        echo 20000000 > "$maf0/cpu3/cpufreq/scaling_max_freq"
        echo 20000000 > "$maf0/cpu4/cpufreq/scaling_max_freq"
        echo 20000000 > "$maf0/cpu5/cpufreq/scaling_max_freq"
    done
    for mif0 in /sys/devices/system/cpu
    do
        echo 500000 > "$mif0/cpu0/cpufreq/scaling_min_freq"
        echo 500000 > "$mif0/cpu1/cpufreq/scaling_min_freq"
        echo 500000 > "$mif0/cpu2/cpufreq/scaling_min_freq"
        echo 500000 > "$mif0/cpu3/cpufreq/scaling_min_freq"
        echo 500000 > "$mif0/cpu4/cpufreq/scaling_min_freq"
        echo 500000 > "$mif0/cpu5/cpufreq/scaling_min_freq"
    done
    for maf6 in /sys/devices/system/cpu
    do
        echo 22000000 > "$maf6/cpu6/cpufreq/scaling_max_freq"
        echo 22000000 > "$maf6/cpu7/cpufreq/scaling_max_freq"
    done
    for mif6 in /sys/devices/system/cpu
    do
        echo 725000 > "$mif6/cpu6/cpufreq/scaling_min_freq"
        echo 725000 > "$mif6/cpu7/cpufreq/scaling_min_freq"
    done
chmod 444 /sys/devices/system/cpu/*/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/*/cpufreq/scaling_min_freq

# CPU SET
for cs in /dev/cpuset
    do
        echo 0-7 > "$vm/cpus"
        echo 0-5 > "$vm/background/cpus"
        echo 0-3 > "$vm/system-background/cpus"
        echo 0-7 > "$vm/foreground/cpus"
        echo 0-7 > "$vm/top-app/cpus"
        echo 0-3 > "$vm/restricted/cpus"
        echo 0-7 > "$vm/camera-daemon/cpus"
        echo 0 > "$vm/memory_pressure_enabled"
        echo 0 > "$vm/sched_load_balance"
        echo 0 > "$vm/foreground/sched_load_balance"
        echo 0 > "$vm/foreground-l/sched_load_balance"
        echo 0 > "$vm/dex2oat/sched_load_balance"
    done
    for cc in /dev/cpuctl
    do
        echo 1 > "$cc/rt/cpu.uclamp.latency_sensitive"
        echo 1 > "$cc/foreground/cpu.uclamp.latency_sensitive"
        echo 1 > "$cc/nnapi-hal/cpu.uclamp.latency_sensitive"
        echo 1 > "$cc/pnpmgr_fg/cpu.uclamp.latency_sensitive"
        echo 1 > "$cc/dex2oat/cpu.uclamp.latency_sensitive"
        echo 1 > "$cc/top-app/cpu.uclamp.latency_sensitive"
        echo 100 > "$cc/foreground/cpu.uclamp.max"
        echo 100 > "$cc/top-app/cpu.uclamp.max"
        echo 100 > "$cc/cpuctl/top-app/cpu.uclamp.min"
        echo 100 > "$cc/foreground/cpu.uclamp.min"
    done

# Dislowpower
for dlp in /proc/displowpower
    do
        echo 1 > "$dlp/hrt_lp"
        echo 1 > "$dlp/idlevfp"
        echo 100 > "$dlp/idletime"
    done
    
# scheduler
for sch in /proc/sys/kernel
    do
        echo 500000 > "$sch/sched_migration_cost_ns"
        echo 5 > "$sch/perf_cpu_time_max_percent"
        echo 1000000 > "$sch/sched_latency_ns"
        echo 1024 > "$sch/sched_util_clamp_max"
        echo 1024 > "$sch/sched_util_clamp_min"
        echo 1 > "$sch/sched_tunable_scaling"
        echo 0 > "$sch/sched_child_runs_first"
        echo 0 > "$sch/sched_energy_aware"
        echo 1 > "$sch/sched_util_clamp_min_rt_default"
        echo 4194304 > "$sch/sched_deadline_period_max_us"
        echo 100 > "$sch/sched_deadline_period_min_us"
        echo 0 > "$sch/sched_schedstats"
    done
    for sda in /sys/block/sda/queue
    do
        echo 0 > "$sda/add_random"
        echo 0 > "$sda/iostats"
        echo 1 > "$sda/nomerges"
        echo 0 > "$sda/rq_affinity"
        echo 1 > "$sda/rotational"
        echo 128 > "$sda/nr_requests"
        echo 2048 > "$sda/read_ahead_kb"
    done
    for sdb in /sys/block/sdb/queue
    do
        echo 0 > "$sdb/add_random"
        echo 0 > "$sdb/iostats"
        echo 1 > "$sdb/nomerges"
        echo 0 > "$sdb/rq_affinity"
        echo 1 > "$sdb/rotational"
        echo 128 > "$sdb/nr_requests"
        echo 2048 > "$sdb/read_ahead_kb"
    done
    for sdc in /sys/block/sdc/queue
    do
        echo 0 > "$sdc/add_random"
        echo 0 > "$sdc/iostats"
        echo 1 > "$sdc/nomerges"
        echo 0 > "$sdc/rq_affinity"
        echo 1 > "$sdc/rotational"
        echo 128 > "$sdc/nr_requests"
        echo 2048 > "$sdc/read_ahead_kb"
    done

# Power Level
for pl in /sys/devices/system/cpu/perf
    do
        echo 1 > "$pl/gpu_pmu_enable"
        echo -1 > "$pl/gpu_pmu_period"
        echo 1 > "$pl/fuel_gauge_enable"
        echo teo > "$pl/current_governor"
        echo 1 > "$pl/enable"
        echo 1 > "$pl/charger_enable"
    done
echo "on" > /sys/devices/system/cpu/power/control

# VirtualMemory
for vm in /proc/sys/vm
    do
        echo 20 > "$vm/dirty_background_ratio"
        echo 35 > "$vm/dirty_ratio"
        echo 120 > "$vm/vfs_cache_pressure"
        echo 300 > "$vm/dirty_expire_centisecs"
        echo 5000 > "$vm/dirty_writeback_centisecs"
        echo 0 > "$vm/oom_dump_tasks"
        echo 0 > "$vm/page-cluster"
        echo 0 > "$vm/block_dump"
        echo 10 > "$vm/stat_interval"
        echo 0 > "$vm/compaction_proactiveness"
        echo 1 > "$vm/watermark_boost_factor"
        echo 40 > "$vm/watermark_scale_factor"
        echo 2 > "$vm/drop_caches"
    done
    for sw in /dev/memcg
    do
        echo 20 > "$sw/memory.swappiness"
        echo 30 > "$sw/apps/memory.swappiness"
        echo 35 > "$sw/system/memory.swappiness"
    done
    
# Scheduler I/O
echo "deadline" > /sys/block/sda/queue/scheduler
echo "deadline" > /sys/block/sdb/queue/scheduler
echo "deadline" > /sys/block/sdc/queue/scheduler

#printk
echo "0 0 0 0" > /proc/sys/kernel/printk
echo "1" > /sys/module/printk/parameters/console_suspend
echo "1" > /sys/module/printk/parameters/ignore_loglevel
echo "0" > /sys/module/printk/parameters/time
echo "off" > /proc/sys/kernel/printk_devkmsg

# Networking tweaks
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
echo "1" > /proc/sys/net/ipv4/tcp_low_latency
echo "1" > /proc/sys/net/ipv4/tcp_ecn
echo "1" > /proc/sys/net/ipv4/tcp_sack
echo "1" > /proc/sys/net/ipv4/tcp_timestamps

# CPU Parameter Enable
echo "1" > /sys/module/mtk_core_ctl/parameters/policy_enable
echo "1" > /sys/devices/system/cpu/cpu4/core_ctl/enable
echo "1" > /sys/devices/system/cpu/cpu7/core_ctl/enable
echo "1" > /sys/devices/system/cpu/cpu6/core_ctl/enable
echo "1" > /sys/devices/system/cpu/cpu4/core_ctl/core_ctl_boost
echo "1" > /sys/devices/system/cpu/cpu6/core_ctl/core_ctl_boost
echo "1" > /sys/devices/system/cpu/cpu7/core_ctl/core_ctl_boost

fstrim -v /cache
fstrim -v /metadata
fstrim -v /data

# Trace Konfigurasi
echo "1" > /sys/kernel/tracing/tracing_on
echo "perf" > /sys/kernel/tracing/trace_clock
echo "1" > /sys/kernel/thermal_trace/enable

echo "0" > /sys/kernel/cm_mgr/dbg_cm_mgr
echo "0" > /sys/module/task_turbo/parameters/feats
echo true > /sys/kernel/mm/swap/vma_ra_enabled

# Memory Optimized
echo "always" > /sys/kernel/mm/transparent_hugepage/enabled
echo "always" > /sys/kernel/mm/transparent_hugepage/shmem_enabled

#. COMMONS MEDIATEK

# PPM Policy
echo 1 > /proc/ppm/enabled
echo 0 0 > /proc/ppm/policy_status
echo 1 1 > /proc/ppm/policy_status
echo 2 0 > /proc/ppm/policy_status
echo 3 0 > /proc/ppm/policy_status
echo 4 0 > /proc/ppm/policy_status
echo 5 0 > /proc/ppm/policy_status
echo 6 1 > /proc/ppm/policy_status
echo 7 1 > /proc/ppm/policy_status
echo 8 0 > /proc/ppm/policy_status
echo 9 1 > /proc/ppm/policy_status
echo "1 -1" > /proc/ppm/policy/hard_userlimit_max_cpu_freq
echo "0 -1" > /proc/ppm/policy/hard_userlimit_max_cpu_freq
echo "1 -1" > /proc/ppm/policy/hard_userlimit_min_cpu_freq
echo "0 -1" > /proc/ppm/policy/hard_userlimit_min_cpu_freq

# EAS
echo "0" > /sys/devices/system/cpu/eas/enable 
echo "1" > /proc/cpufreq/cpufreq_sched_disable

# stune boost
echo "0" > /dev/stune/background/schedtune.boost
echo "0" > /dev/stune/foreground/schedtune.boost
echo "0" > /dev/stune/rt/schedtune.boost
echo "0" > /dev/stune/top-app/schedtune.boost
echo "1" > /dev/stune/schedtune.boost
echo "1" > /dev/stune/nnapi-hal/schedtune.boost
echo "0" > /dev/stune/nnapi-hal/schedtune.prefer_idle
echo "0" > /dev/stune/top-app/schedtune.prefer_idle
echo "0" > /dev/stune/background/schedtune.prefer_idle
echo "0" > /dev/stune/foreground/schedtune.prefer_idle
echo "0" > /dev/stune/rt/schedtune.prefer_idle
echo "0" > /dev/stune/schedtune.prefer_idle

#Swapiness
echo "100" > /proc/sys/vm/swappiness

# mmcblk0
echo "0" > /sys/block/mmcblk0/queue/add_random
echo "0" > /sys/block/mmcblk0/queue/iostats
echo "1" > /sys/block/mmcblk0/queue/nomerges
echo "0" > /sys/block/mmcblk0/queue/rotational
echo "1" > /sys/block/mmcblk0/queue/rq_affinity
echo "128" > /sys/block/mmcblk0/queue/nr_requests
echo "2048" > /sys/block/mmcblk0/queue/read_ahead_kb

# Iowait ( 4+4 )
echo "1" > /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable
echo "1" > /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable

# CPU mode
echo 3 > /proc/cpufreq/cpufreq_power_mode
echo 1 > /proc/cpufreq/cpufreq_cci_mode

# Toucpanel
echo 1 > /proc/touchpanel/oppo_tp_direction
echo 0 > /proc/touchpanel/oppo_tp_limit_enable
echo 1 > /proc/touchpanel/oplus_tp_direction
echo 0 > /proc/touchpanel/oplus_tp_limit_enable
echo 1 > /proc/touchpanel/game_switch_enable

echo "1" > /sys/kernel/fast_charge/force_fast_charge

# This script will be executed in late_start service mode
# More info in the main Magisk thread
