function bestNeighbor = findBestNeighbor(agents, x, y, settings)


minFitness = inf;minInx = 0;
xm = -1;ym = -1;
xp = +1;yp = +1;
if(x==1), xm = 0; elseif(x==settings.x), xp = 0; end
if(y==1), ym = 0; elseif(y==settings.y), yp = 0; end
for k=x+xm:x+xp
    for l = y+ym:y+yp
        if(agents{k,l}.fitness <= minFitness)
            minFitness = agents{k,l}.fitness;
            minInx = [k l];
        end
    end
end


bestNeighbor = agents{minInx(1), minInx(2)};

end