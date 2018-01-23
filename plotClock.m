function plotClock(quality)
hold on;
view(3);
axis square;
alpha = 1;
%% Just messing around with lighting here
light('Position',[-30 -5 -30],'Style','infinite')
lighting gouraud;
material dull;
%% Clock Face
[x,y,z] = sphere(quality*10);
y = y.*.03;
mask = y > 0;
x(mask) = 0;
y(mask) = 0;
z(mask) = 0;
% Hole in Face
circleMask = (x).^2+(z).^2 <= .5^2;
ringMask = (x).^2+(z).^2 <= .55^2 & (x).^2+(z).^2 >= .5^2 | ((x).^2+(z-.5).^2 <= .45^2 & (x).^2+(z-.5).^2 >= .4^2 & (x).^2+(z).^2 <= .5^2) |  ((x).^2+(z+.5).^2 <= .45^2 & (x).^2+(z+.5).^2 >= .4^2 & (x).^2+(z).^2 <= .5^2);
upperMask = (x).^2+(z-.5).^2 <= .4^2;
lowerMask = (x).^2+(z+.5).^2 <= .4^2;
x2 = x;
y2 = y;
z2 = z;
x2(~ringMask) = 0;
y2(~ringMask) = 0;
z2(~ringMask) = 0;
x(circleMask&upperMask) = 0;
y(circleMask&upperMask) = 0;
z(circleMask&upperMask) = 0;
x(circleMask&lowerMask) = 0;
y(circleMask&lowerMask) = 0;
z(circleMask&lowerMask) = 0;
surf(x,y,z,'faceLighting','gouraud','FaceAlpha',alpha);
colormap([20/255  20/255  20/255]);
freezeColors;
surf(x2,y2,z2,'faceLighting','gouraud','FaceAlpha',alpha);
colormap([.7*230/255 .7*180/255 .7*100/255]);
freezeColors;
% Middle Bezel
[x,y,z] = sphere(50);
y = y.*.02;
mask = y > 0;
x(mask) = 0;
y(mask) = 0;
z(mask) = 0;
mask = x.^2+z.^2 <= .8^2 & z > 0;
x(mask) = 0;
y(mask) = 0;
z(mask) = 0;
surf(x,y-.005,z,'FaceAlpha',alpha);
colormap([.7*230/255 .7*180/255 .7*100/255]);
freezeColors;
%% Tick Marks
[xx, yy, zz] = cylinder(linspace(1,1,20));
%%%%%%%%%%%%%%%%
% Second Ticks %
%%%%%%%%%%%%%%%%
% 'w' is a scale factor for width of the tick marks, bigger w = narrower
% ticks
w = 80;
xx = xx./w;
% 'l' is a scale factor for the length of the tickmarks, 0 to 1 scale
l = .8;
zz = 2*l.*zz-l;
yy = 0.*yy-.02;
% THIS MASK only exists to make the pattern in the middle of the face be
% shown, as the golden bezel usually covers them up. It also makes it more
% narrow in the center.
mask = (xx).^2+(zz).^2 <= .5^2 & zz>0;
xx(mask) = .8.*xx(mask);
temp = xx;
xx = zz;
zz = temp;
yy(mask) = yy(mask) - .005;
% End mask
l1 = surf(xx,yy,zz);
direction = [0 1 0];
l2 = surf(xx,yy,zz);
rotate(l2,direction,6);
l3 = surf(xx,yy,zz);
rotate(l3,direction,12);
l4 = surf(xx,yy,zz);
rotate(l4,direction,18);
l5 = surf(xx,yy,zz);
rotate(l5,direction,24);
l6 = surf(xx,yy,zz);
rotate(l6,direction,30);
l7 = surf(xx,yy,zz);
rotate(l7,direction,36);
l8 = surf(xx,yy,zz);
rotate(l8,direction,42);
l9 = surf(xx,yy,zz);
rotate(l9,direction,48);
l10 = surf(xx,yy,zz);
rotate(l10,direction,54);
l11 = surf(xx,yy,zz);
rotate(l11,direction,60);
l12 = surf(xx,yy,zz);
rotate(l12,direction,66);
l13 = surf(xx,yy,zz);
rotate(l13,direction,72);
l14 = surf(xx,yy,zz);
rotate(l14,direction,78);
l15 = surf(xx,yy,zz);
rotate(l15,direction,84);
l16 = surf(xx,yy,zz);
rotate(l16,direction,90);
l17 = surf(xx,yy,zz);
rotate(l17,direction,96);
l18 = surf(xx,yy,zz);
rotate(l18,direction,102);
l19 = surf(xx,yy,zz);
rotate(l19,direction,108);
l20 = surf(xx,yy,zz);
rotate(l20,direction,114);
l21 = surf(xx,yy,zz);
rotate(l21,direction,120);
l22 = surf(xx,yy,zz);
rotate(l22,direction,126);
l23 = surf(xx,yy,zz);
rotate(l23,direction,132);
l24 = surf(xx,yy,zz);
rotate(l24,direction,138);
l25 = surf(xx,yy,zz);
rotate(l25,direction,144);
l26 = surf(xx,yy,zz);
rotate(l26,direction,150);
l27 = surf(xx,yy,zz);
rotate(l27,direction,156);
l28 = surf(xx,yy,zz);
rotate(l28,direction,162);
l29 = surf(xx,yy,zz);
rotate(l29,direction,168);
l30 = surf(xx,yy,zz);
rotate(l30,direction,174);
l31 = surf(xx,yy,zz);
rotate(l31,direction,180);
colormap([200/255 200/255 200/255]);
freezeColors;
%%%%%%%%%%%%%%
% Hour Ticks %
%%%%%%%%%%%%%%
[xx, yy, zz] = cylinder(linspace(1,1,20));
% 'w' is a scale factor for width of the tick marks, bigger w = narrower
% ticks
w = 40;
xx = xx./w;
% 'l' is a scale factor for the length of the tickmarks, 0 to 1 scale
l = .8;
zz = 2*l.*zz-l;
yy = 0.*yy-.025;
mask = xx.^2+zz.^2 <= .7^2;
xx(mask) = 0;
yy(mask) = 0;
zz(mask) = 0;
surf(xx,yy,zz);
direction = [0 1 0];
l2 = surf(xx,yy,zz);
rotate(l2,direction,30);
l3 = surf(xx,yy,zz);
rotate(l3,direction,60);
l4 = surf(xx,yy,zz);
rotate(l4,direction,90);
l5 = surf(xx,yy,zz);
rotate(l5,direction,120);
l6 = surf(xx,yy,zz);
rotate(l6,direction,150);
colormap([150/255 150/255 150/255]);
freezeColors
[x,y,z] = cylinder([.8,.9],24);
surf(x,0.*z-.015,y);
colormap([230/255 180/255 100/255]);
freezeColors;

%% Torus Bezel
theta = linspace(0,2*pi);
r = linspace(pi,2*pi);
[rr,tt] = meshgrid(r,theta);
zz = sin(rr);
% 'a' is a scale factor (inverse, so big a = small bezel) for the thickness of the bezel
a = 8;
[X,Y,Z] = pol2cart(tt,rr./(a*pi)+(1-1/a),zz.*.02);
surf(X,Z,Y,'faceLighting','gouraud');
b = linspace(.4,.7);
b = b';
colormap([b,b,b]);
freezeColors;

%% Other Designs
% Sphere Dots
% 'a' is a value for the face number for the sphere. Try 'a' with values
% between 3 and 10.
% 'b' is a value for the size of the spheres
% 'c' is a value for how much the spheres come out
a = 10;
b = .025;
c = .001;
[x,z,y] = sphere(a);
mask = y > 0;
x(mask) = NaN;
y(mask) = NaN;
dz(mask) = NaN;
x = b.*x;
y = c.*y;
z = b.*z;
y = y-.03;
surf(x,y,z+.03);
surf(x,y,z-.03);

surf(x+.0605,y+.00020,z+.035);
surf(x+.1210,y+.00030,z+.045);
surf(x+.1815,y+.00065,z+.060);
surf(x+.2420,y+.00110,z+.090);
surf(x+.3024,y+.00180,z+.130);
surf(x+.3627,y+.00270,z+.180);
surf(x+.4100,y+.00380,z+.230);
surf(x+.4400,y+.00380,z+.165);
surf(x+.4600,y+.00380,z+.100);
surf(x+.4700,y+.00380,z+.035);

surf(x-.0605,y+.00020,z+.035);
surf(x-.1210,y+.00030,z+.045);
surf(x-.1815,y+.00065,z+.060);
surf(x-.2420,y+.00110,z+.090);
surf(x-.3024,y+.00180,z+.130);
surf(x-.3627,y+.00270,z+.180);
surf(x-.4100,y+.00380,z+.230);
surf(x-.4400,y+.00380,z+.165);
surf(x-.4600,y+.00380,z+.100);
surf(x-.4700,y+.00380,z+.035);

surf(x-.0605,y+.00020,z-.035);
surf(x-.1210,y+.00030,z-.045);
surf(x-.1815,y+.00065,z-.060);
surf(x-.2420,y+.00110,z-.090);
surf(x-.3024,y+.00180,z-.130);
surf(x-.3627,y+.00270,z-.180);
surf(x-.4100,y+.00380,z-.230);
surf(x-.4400,y+.00380,z-.165);
surf(x-.4600,y+.00380,z-.100);
surf(x-.4700,y+.00380,z-.035);

surf(x+.0605,y+.00020,z-.035);
surf(x+.1210,y+.00030,z-.045);
surf(x+.1815,y+.00065,z-.060);
surf(x+.2420,y+.00110,z-.090);
surf(x+.3024,y+.00180,z-.130);
surf(x+.3627,y+.00270,z-.180);
surf(x+.4100,y+.00380,z-.230);
surf(x+.4400,y+.00380,z-.165);
surf(x+.4600,y+.00380,z-.100);
surf(x+.4700,y+.00380,z-.035);

colormap([.7*230/255 .7*180/255 .7*100/255]);
freezeColors;
shading interp;
end