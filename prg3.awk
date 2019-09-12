BEGIN{
	TCPSent = 0;
	TCPReceived = 0;
	TCPLost=0;
	UDPSent=0;
	UDPReceived =0;
	UDPLost =0;
	totalSent=0;
	totalReceived=0;
	totalLost =0;
}
{
	packetType =$5
	event =$1
	if(packetType =="tcp")
	{
		if(event =="+")
		TCPSent++;
		else if(event =="r")
		TCPReceived++;
		else if(event =="d")
		TCPLost++;
	}
	else if(packetType =="cbr")
	{
		if(event =="+")
		{
			UDPSent++;
		}
		else if(event =="r")
		UDPReceived++;
		else if(event =="d")
		UDPLost++;
	}
}
END{
totalSent = TCPSent + UDPSent;
totalLost =TCPLost + UDPLost;
printf("TCP packets sent: %d\n",TCPSent);
printf("TCP packets received: %d\n",TCPReceived);
printf("TCP packets dropped: %d\n",TCPLost);
printf("UDP packets sent: %d\n",UDPSent);
printf("UDP packets receieved: %d\n",UDPReceived);
printf("UDP packets lost: %d\n",UDPLost);
printf("Total sent: %d\n",totalSent);
printf("Total Dropped: %d\n",totalDropped);
}
