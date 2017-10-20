%function acquire()
u2 = udp('10.188.18.215', 'RemotePort', 8844, 'LocalPort', 8866,'outputbuffersize',1024)
if strcmp(u2.status,'closed')
    fopen(u2);
end
[vid,src] = startkinect();
start(vid);
tracking = false;
while(~tracking)
    trigger(vid);
    [IM,~,metaData]=getdata(vid,1,'uint8');
    if any(metaData.IsSkeletonTracked)
        tracking= true;
    end
end

data = double(reshape(metaData.JointWorldCoordinates(:,:,metaData.IsSkeletonTracked),1,[]));
fwrite(u2, data,'double')

%% cleanup
stop(vid)
fclose(u2)

%end