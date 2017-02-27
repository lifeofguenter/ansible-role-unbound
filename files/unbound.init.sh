#!/bin/sh

### BEGIN INIT INFO
# Provides:          unbound
# Required-Start:    $network $remote_fs $syslog
# Required-Stop:     $network $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO
# pidfile: /run/unbound.pid

NAME="unbound"
DESC="DNS server"
DAEMON="/usr/sbin/unbound"
PIDFILE="/run/unbound.pid"

HELPER="/usr/lib/unbound/package-helper"

test -x $DAEMON || exit 0

. /lib/lsb/init-functions

# Override this variable by editing or creating /etc/default/unbound.
DAEMON_OPTS=""

if [ -f /etc/default/unbound ]; then
    . /etc/default/unbound
fi

case "$1" in
    start)
        log_daemon_msg "Starting $DESC" "$NAME"
        #$HELPER chroot_setup
        #$HELPER root_trust_anchor_update 2>&1 | logger -p daemon.info -t unbound-anchor
        if start-stop-daemon --start --quiet --oknodo --pidfile $PIDFILE --name $NAME --startas $DAEMON -- $DAEMON_OPTS; then
            #$HELPER resolvconf_start
            log_end_msg 0
        else
            log_end_msg 1
        fi
        ;;

    stop)
        log_daemon_msg "Stopping $DESC" "$NAME"
        if start-stop-daemon --stop --quiet --oknodo --pidfile $PIDFILE --name $NAME --retry 5; then
            #$HELPER resolvconf_stop
            log_end_msg 0
        else
            log_end_msg 1
        fi
        ;;

    restart|force-reload)
        log_daemon_msg "Restarting $DESC" "$NAME"
        start-stop-daemon --stop --quiet --pidfile $PIDFILE --name $NAME --retry 5
        #$HELPER resolvconf_stop
        if start-stop-daemon --start --quiet --oknodo --pidfile $PIDFILE --name $NAME --startas $DAEMON -- $DAEMON_OPTS; then
            #$HELPER chroot_setup
            #$HELPER resolvconf_start
            log_end_msg 0
        else
            log_end_msg 1
        fi
        ;;

    reload)
        log_daemon_msg "Reloading $DESC" "$NAME"
        if start-stop-daemon --stop --pidfile $PIDFILE --signal 1; then
            #$HELPER chroot_setup
            log_end_msg 0
        else
            log_end_msg 1
        fi
        ;;

    status)
        status_of_proc -p $PIDFILE $DAEMON $NAME && exit 0 || exit $?
        ;;

    *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart|status|reload|force-reload}" >&2
        exit 1
        ;;
esac

exit 0
