function randNeighbor = findRandNeighbor(agents, x, y, settings)


xm = -1;ym = -1;
xp = +1;yp = +1;
if(x==1), xm = 0; elseif(x==settings.x), xp = 0; end
rx = randi([x+xm,x+xp]);
if(y==1), ym = 0; elseif(y==settings.y), yp = 0; end
ry = randi([y+ym,y+yp]);

while rx == 0 && ry == 0
    rx = randi([x+xm,x+xp]);ry = randi([y+ym,y+yp]);
end

randNeighbor = agents{rx, ry};


end