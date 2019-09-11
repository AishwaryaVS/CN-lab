BEGIN{
	telnetPackets=0;
	ftpPackets=0;
	telnetSize=0;
	ftpSize=0;
	totalTelnet=0;
	ftpTotal=0;
	
}
{
	event=$1;
	
	pkttype= $5;
	
	fromnode=$9;
	
	tonode=$10;
	
	pktsize=$6;
	
	if(event == "r" && pkttype == "tcp" && fromnode == "0.0" && tonode == "1.0")
	{
	
	telnetPackage++;
	
	telnetSize = pktsize;
	
	}
	
	if(event == "r" && pkttype == "tcp" && fromnode == "1.0" && tonode == "3.1")
	{
		ftpPackets++;
		
		ftpSize = pktsize;
	}
}
END{
	totalTlnet=telnetPackets*telnetSize*8;
	
	ftpTotal=ftpPackets*ftpSize*8;
	
	printf("the throughput of ftp application is %d\n",ftpTotal);
	
       printf("the throughput of TELNET application is %d\n",totalTelnet);
}

