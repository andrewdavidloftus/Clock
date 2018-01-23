function analogClock(startTime)
%% Input
% Default start time is 12:00:00
% Input should be a string of format: 'hh:mm:ss'
if ~exist('startTime')
      startTime = '12:00:00';
end
%% QUALITY VARIABLE
% This variable should be set from 1 to 100 and will vastly change the
% quality and loading speed of the simulation. A value of 50 is
% recommended. Poly count will increase by an order of magnitude when
% increased by 10.
quality = 50;
%% User Interface Control
hourChime = uicontrol('Style', 'popup','String', {'Grandfather','Bell Tower','Hello Moto','Peter','Tardis','Sexy Saxaphone','Keyboard Cat'},'Position', [200 20 100 20]);
txt = uicontrol('Style','text','Position',[200 40 100 20],'String','Hourly Chime Type');
sld = uicontrol('Style', 'slider','Min',0,'Max',1,'Value',1,'Position',[320 20 100 20]); 
txt = uicontrol('Style','text','Position',[320 40 100 20],'String','Sound Volume');
speed = uicontrol('Style', 'popup','String', {'Slower','Normal','Faster','''Fastest'' (Mutes Ticking Noise)','Hyperspeed'},'Value',2,'Position', [90 20 100 20]);
txt = uicontrol('Style','text','Position',[90 40 100 20],'String','Speed');
pauser = uicontrol('Style', 'togglebutton','Min',true,'Max',false,'Value',0,'String', 'Start/Stop','Position', [10 20 70 20]);    
closer = uicontrol('Style', 'togglebutton','Min',true,'Max',false,'Value',0,'String', 'Close','Position', [440 20 70 20]);    

%% Get time
times = strsplit(startTime,':');
hour = str2num(times{1});
mins = str2num(times{2});
sec = str2num(times{3});
time = hour+mins/60+sec/3600;


%% Plot initialization
plotClock(quality);
axis([-1.5 1.5 -.2 0 -1.5 1.5]);
axis square;
xlabel('x Axis');
ylabel('y Axis');
zlabel('z Axis');
axis off;
%% Hands
[xx, yy, zz] = cylinder(linspace(1,1,20));
xx = xx./10;
zz = zz;
yy = 0.*yy-.031;
% Second Hand
freezeColors;
sCyl = surf(xx/10,yy,.9.*zz);
colormap([200/255  40/255  40/255]);
freezeColors;
% Minute Hand
mCyl = surf(xx/5,yy,.9.*zz);
colormap([240/255  240/255  240/255]);
freezeColors;
% Hour Hand
hCyl = surf(xx/5,yy,2.*zz./3);
colormap([240/255  240/255  240/255]);
freezeColors;
direction = [0 1 0];

%% Sun and Moon Dial
img = imread('SunMoonDial.png');
[XData,YData,ZData] = cylinder(1:2);
% 'a' is the depth of the dial into the clock
a = -.0223;
% 'b' is the radius of the dial
b = .48;
dial = surf('XData',[-b b; -b b],'YData',[a a; a a],'ZData',[b b; -b -b],'CData',flipdim(img,1),'FaceColor','texturemap','EdgeColor','none');
rotate(dial,direction,180);
%% Current Time
secRot = (sec)*360/60;
minRot = (mins)*360/60+(sec)*6/60;
if hour == 0;
    hour = 24;
end
dayRot = (hour)*360/24+(mins)*30/60+(sec)*30/3600;
hour = mod(hour,12);
hourRot = (hour)*360/12+(mins)*30/60+(sec)*30/3600;
rotate(sCyl,direction,secRot);
rotate(mCyl,direction,minRot);
rotate(hCyl,direction,hourRot);
rotate(dial,direction,dayRot);
mins = mins + sec/60;
%% Animation
%shading interp;
%'a' is a scalable value for the framerate(how short pauses
%are) Do not set 'a' below one. Bigger 'a' means smoother/faster framerate
% a = 1 is suggested, as the tick tock sound speed does not correct itself
% with larger values of a
a = 1;
while ~closer.Value
    title('MATLAB Clock','fontSize',16);
    while ~closer.Value & ~pauser.Value
        pause(1);
    end
    if speed.Value < 4;
        if speed.Value == 1
            spee = .25;
        elseif speed.Value == 2
            spee = 1;
        elseif speed.Value == 3
            spee = 20; 
        end
        rotate(sCyl,direction,(360/(60*a)));
        rotate(mCyl,direction,(360/(60*60*a)));
        rotate(hCyl,direction,(360/(60*60*12*a)));
        rotate(dial,direction,(360/(24*60*60*a)));
        pause(1/(spee*a));
        sec = sec+1;
        if mod(sec,2) == 0
            playSound(1,sld.Value,0);
        elseif mod(sec,2) == 1
            playSound(2,sld.Value,0);
        end
        mins = mins+1/60;
        if mins > 59.99
            playSound(3,sld.Value,hourChime.Value);
            mins = 0;
        end
    elseif speed.Value == 4
        rotate(sCyl,direction,(360/(60*a)));
        rotate(mCyl,direction,(360/(60*60*a)));
        rotate(hCyl,direction,(360/(60*60*12*a)));
        rotate(dial,direction,(360/(24*60*60*a)));
        pause(1/(a*100));
        mins = mins+1/60;
        if mins > 59.99
            playSound(3,sld.Value,hourChime.Value);
            mins = 0;
        end
     elseif speed.Value == 5
         % 'z' controls how fast hyperspeed is.. Large z = faster movement
        z = 30;
        mins = mins+(z/60);
        if mins > 59.99
            mins = mod(mins,60);
        end
        rotate(sCyl,direction,(z*360/(60)));
        rotate(mCyl,direction,(z*360/(60*60)));
        rotate(hCyl,direction,(z*360/(60*60*12)));
        rotate(dial,direction,(z*360/(24*60*60)));
        pause(.001);
    end 
end
close('all');
end