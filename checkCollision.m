function checkCollision(agents, inx, timeSlot)

action = agents{inx}.parameters(timeSlot);
conn = agents{inx}.connections;
if(action == 1)
    for c = 1:length(conn)
        if(agents{conn(c)}.parameters(timeSlot) == 2)
            conn2 = agents{conn(c)}.connections;
            nonCollision = 1;
            for cc = 1:length(conn2)
                if(s == conn2(cc)), continue; end
                if(agents{conn2(cc)}.parameters(timeSlot) == 1), nonCollision = 0; break; end
            end
            if(nonCollision)
                if(conn(c) == settings.target)
                    numOfPackagesReceived = numOfPackagesReceived + 1;
                end
                agents{s}.fitness = agents{s}.fitness + 1;
                agents{conn(c)}.receivedGenotypeFromRepeated(end+1) = s;
                if(isempty(agents{conn(c)}.receivedGenotypeFrom))
                    agents{conn(c)}.receivedGenotype(end+1,:) = agents{s}.parameters;
                    agents{conn(c)}.receivedGenotypeFrom(end+1) = s;
                else
                    if(sum(agents{conn(c)}.receivedGenotypeFrom == s)==0)
                        agents{conn(c)}.receivedGenotype(end+1,:) = agents{s}.parameters;
                        agents{conn(c)}.receivedGenotypeFrom(end+1) = s;
                    end
                end
            end
        end
    end
end