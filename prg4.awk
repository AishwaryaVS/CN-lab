BEGIN{
	count=0;
	event=$1;
	if(event=="d")
	{
		count++;
	}
}
END{
	print("No. of packets dropped: %d\n",count);
}
