function [nb_frame, nb_detected_object, xbody, ybody, ang_body, xtail,...
    ytail, ang_tail] = extract_parameters_from_fast_track(s)

% Input:
%      - s: obtain with this code (path and file of tracking result from
%      FastTtrack):
%           t = readtable(fullfile(path,file),'Delimiter','\t');
%           s = table2array(t);

% Output:
%      - nb_frame: number of frame of the movie
%      - nb_detected_object: number of object detected by fasttrack
%      - xbody, ybody: coordinate of the body ellipse center
%      - ang_body: angle in rad of the body ellispe
%      - ang_tail: angle in rad of the tail ellipse

% determine number of tracked object
nb_detected_object = max(s(:,end))+1;

% determine number of frame
nb_frame = max(s(:,end-1))+1;

% extract parameters of interest
xbody = nan(nb_detected_object,nb_frame);
ybody = xbody;
ang_body = xbody;
ang_tail = xbody;
xtail = xbody;
ytail = xbody;

i = 1;
for i = 1:nb_frame
    f = find(s(:,end-1) == i-1);
    fi = s(f,end)+1;
    xbody(fi,i) = s(f,7);
    ybody(fi,i) = s(f,8);
    ang_body(fi,i) = s(f,9);
    xtail(fi,i) = s(f,4);
    ytail(fi,i) = s(f,5);
    ang_tail(fi,i) = s(f,6);
end