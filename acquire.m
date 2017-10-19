function acquire()
 u1 = udp('10.188.20.187', 'RemotePort', 8866, 'LocalPort', 8844);
fopen(u1);
[vid,src] = startkinect();
trigger(vid);
[IM,~,metaData]=getdata(vid,1,'uint8');

fprintf(u1, 'Ready for data transfer.')
end