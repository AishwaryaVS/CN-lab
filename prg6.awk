BEGIN{
	FTPPackets=0;
	FTPSize=0;
	cbrSize=0;
	cbrPackets=0;
}
{
	event=$1;
	pkttype=$5;
	pktsize=$6;
	if(event=="r" && pkttype=="tcp")
	{
		FTPPackets++;
		FTPSize=pktsize;
	}
	if(event=="r" && pkttype=="cbr")
	{
	cbrPackets++;
	cbrSize=pktsize;
	}
}
END{
	totalFTP=FTPPackets*FTPSize;
	totalCBR=cbrPackets*cbrSize;
	printf("the throughput of ftp application is %d Bytes per second\n",
	totalFTP/123.0);
	printf("the throughput of CBR application is %d Bytes per second\n",
	totalCBR/124.4);
}
