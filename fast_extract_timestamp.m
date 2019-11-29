function [t]=fast_extract_timestamp(timestamp_seq)

% return the time values from a stack of 4 pixels, formatted in Fbits
N = 4;              % Number of pixels containing the time information
F = 8;              % Format of the image is F-bit.
Ntimes=size(timestamp_seq,3);

%=== Get the timestamp of the frame ===================================

b = zeros(F*N,Ntimes);
for j = 1:N
    tmp = dec2bin(timestamp_seq(1,j,:), F);
     for k = 1:F
         b((j-1)*F + k,:) = str2num(tmp(:,k));
    end
end

for i = 1:7
    sec(i,:) = num2str(b(i,:)');
end
Second_count = bin2dec(sec');
    
for i = 8:20
    cyc(i,:) = num2str(b(i,:)');
end
Cycle_count = bin2dec(cyc');

t = Second_count + Cycle_count/8000 ;

end