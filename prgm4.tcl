set ns [new Simulator]

#set up trace files
set traceFile [open 4.tr w]
$ns trace-all $traceFile
set namFile [open 4.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns namFile traceFile
	$ns flush-trace
	#close the trace file
	close $traceFile
	close $namFile
		exec awk -f prgm4.awk 4.tr &
		exec nam 4.nam &
	exit 0
}
#create for nodes
for {set i 0} {$i < 7} {incr i} {
	set n($i) [$ns node]
}
for {set i 1} {$i < 4} {incr i} {
	$ns duplex-link $n($i) $n(0) 1Mb 10ms DropTail
}

$ns duplex-link $n(4) $n(0) 5Mb 100ms DropTail
$ns duplex-link $n(5) $n(0) 10Mb 100ms DropTail
$ns duplex-link $n(6) $n(0) 5Mb 90ms DropTail

Agent/Ping instproc recv {from rtt} {
	$self instvar node_
	puts "node [$node_ id] received ping answer from \
	$from with round-trip-time $rtt ms."
}	
 
 for {set i 1} {$i < 7} {incr i} {
 	set pingAgent($i) [new Agent/Ping]
 		$ns attach-agent $n($i) $pingAgent($i)
}
for {set i 1} {$i < 6} {incr i} {
 	$ns queue-limit $n(0) $n($i) 2
 }
$ns queue-limit $n(0) $n(6) 1

$ns connect $pingAgent(1) $pingAgent(4)
$ns connect $pingAgent(2) $pingAgent(5)
$ns connect $pingAgent(3) $pingAgent(6)

$ns at 0.1 "$pingAgent(1) send"
$ns at 0.5 "$pingAgent(2) send"
$ns at 0.5 "$pingAgent(3) send"
$ns at 1.0 "$pingAgent(4) send"
$ns at 1.0 "$pingAgent(5) send"
$ns at 1.0 "$pingAgent(6) send"
$ns at 1.1 "$pingAgent(1) send"
$ns at 1.5 "$pingAgent(2) send"
$ns at 1.5 "$pingAgent(3) send"
$ns at 1.5 "$pingAgent(4) send"
$ns at 2.0 "$pingAgent(5) send"
$ns at 2.0 "$pingAgent(6) send"
$ns at 3.0 "finish"

$ns run
