#create a simulator object
set ns [new Simulator]
$ns color 2 red

#Tell the simulator to use static routing
$ns rtproto Static

#set up trace files
set traceFile [open 1.tr w]
$ns trace-all $traceFile

set namFile [open out1.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns namFile traceFile
	
	$ns flush-trace
	
	#close the trace file
	close $traceFile
	close $namFile
	#exec awk -f stats.awk 1.tr &
	exec nam out1.nam & 
	
	exit 0
}

#setup # nodes
set n(1) [$ns node]
set n(2) [$ns node]
set n(3) [$ns node]

# set up duplex links 
$ns duplex-link $n(1) $n(2) 0.5Mb 20ms DropTail
$ns duplex-link $n(2) $n(3) 0.5Mb 20ms DropTail
$ns queue-limit $n(1) $n(2) 10
$ns queue-limit $n(2) $n(3) 10

#aesthetics
#source(udp)
$n(1) shape hexagon
$n(1) color red
#destination(udp)
$n(2) shape square
$n(2) color blue


#create a udp agent and attach it to node n(1)
set udp0 [new Agent/UDP]
$ns attach-agent $n(1) $udp0

#create a cbr traffic source and attch it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetsize_ 512
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

#create a null agent and attch it to node 3
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

#create the traffic source with traffic sink and assign flow id color
$ns connect $udp0 $null0
$udp0 set fid_ 2

#simulation events
$ns at 0.5 "$cbr0 start"
$ns at 2.0 "$cbr0 stop"
$ns at 2.0 "finish"
$ns run
