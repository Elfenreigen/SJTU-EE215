clear 
clc
tic
global Content;
Content = dlmread( 'dataform_train.csv' ) ;
currentIteration = 0;
rand('state',sum(clock));
Dad = zeros (1,90) ;
Tabu = zeros(60,90) ;
TabuNumber = 0;
Solution = zeros(1,90);
chosenPointCost = 1e7;
Cost = [];

for i = 1:90
    if(rand()<0.1)
        Dad(1,i)=1;
    end
end

if (sum(Dad(1,:))<3)
    Pin = randperm(90);
    Dad(1,Pin(1)) = 1;
    Dad(1,Pin(2)) = 1;
    Dad(1,Pin(3)) = 1;
    Dad(1,Pin(4)) = 1;
end	

Iteration = 200;
Dad = zeros (1,90) ;
Dad([1,10,20,40,60,70,85])=1;
Nearby = zeros(50,90) ;

for k = 1 : Iteration
    for i = 1 : 30
        fir = 1 + floor(90*rand(1));
        sec = 1 + floor(90*rand(1));
        
        if(fir < sec)     
            Nearby(i,1:fir) = Dad(1,1:fir);
            Nearby(i,1+fir:sec-1) = Dad(1,sec-1:-1:fir+1);
            Nearby(i,sec) = Dad(1,sec);
            
            if(rand(1) < 0.001)
                for count = 1 : floor(rand()*3+1)
                    PinI = floor(rand(1)*90)+1;
                    if(Nearby(i,PinI) == 1)
                         Nearby(i,PinI) = 0;
                    else
                         Nearby(i,PinI) = 1;
                    end
                end
            end
            
            if(sum(Nearby(i,:)) < 4)
                PinII = randperm(90);
                Nearby(i,PinII(1)) = 1;
                Nearby(i,PinII(2)) = 1;
                Nearby(i,PinII(3)) = 1;
                Nearby(i,PinII(4)) = 1;
            end
            
            if(sum(Nearby(i,:)) > 7)
                Location = find(Nearby(i,:) == 1);
                PinI = floor(rand(1)*7) + 1;
                PinII = floor(rand(1)*7) + 1;
                Nearby(i,PinI) = 0;
                Nearby(i,PinII) = 0;
            end
            
            
        else
            tmp = fir;
            fir = sec;
            sec = tmp;
            Nearby(i,1:fir) = Dad(1,1:fir);
            Nearby(i,1+fir:sec-1) = Dad(1,sec-1:-1:fir+1);
            Nearby(i,sec) = Dad(1,sec);
            
             if(rand(1) < 0.001)
                for count = 1 : floor(rand()*3+1)
                    PinI = floor(rand(1)*90)+1;
                    if(Nearby(i,PinI) == 1)
                        Nearby(i,PinI) = 0;
                    else
                        Nearby(i,PinI) = 1;
                    end
                end
             end
             
             if(sum(Nearby(i,:)) < 4)
                PinII=randperm(90);
                Nearby(i,PinII(1)) = 1;
                Nearby(i,PinII(2)) = 1;
                Nearby(i,PinII(3)) = 1;
                Nearby(i,PinII(4)) = 1;
             end
            
            if(sum(Nearby(i,:)) > 7)
                Location = find(Nearby(i,:)==1);
                PinI = floor(rand(1)*7)+1;
                PinII = floor(rand(1)*7)+1;
                Nearby(i,PinI) = 0;
                Nearby(i,PinII) = 0;
            end
        end
    end
    
    
    for i = 31 : 50
        Location = find(Dad==1);
        Nearby(i,:) = zeros(1,90);
        for count = 1 : size(Location,2)
            RandomNumber = rand();
            if((RandomNumber < 0.1) && Location(count) > 1)
                Nearby(i,Location(count)-1) = 1;
            end
            if((RandomNumber > 0.9) && Location(count) < 90)
                Nearby(i,Location(count)+1) = 1;
            end
             if((RandomNumber <= 0.9) &&(RandomNumber > 0.1))
                Nearby(i,Location(count)) = 1;
            end
        end
    end
    
    
    for j = 1 : 50
        TemResult = costofallsample(Nearby(j,:));
        Temp(j) = TemResult;
    end
    
    [Row,Col] = sort(Temp);
    currentIteration = 1;
    flag = 0;
    
    for i = 1 : TabuNumber
        if(Tabu(i,:) == Nearby(Col(currentIteration),:))
            flag = 1;
            break;
        end
    end
    
    while(flag == 1)
        flag = 0;
        currentIteration = currentIteration + 1;
        for i = 1 : TabuNumber
          if(Tabu(i,:) == Nearby(Col(currentIteration),:))
            flag = 1;
            break;
          end
        end
        if currentIteration == 50
            flag = 0;
            currentIteration = 1;
        end
    end
    
    if(TabuNumber < 60)
        Tabu(TabuNumber+1,:) = Nearby(Col(currentIteration));
    else
        for i = 1:59
            Tabu(i,:) = Tabu(i+1,:);
        end
        Tabu(60,:) = Nearby(Col(currentIteration),:);
    end
    
    Dad = Nearby(Col(currentIteration),:);
    if (chosenPointCost > costofallsample(Nearby(Col(currentIteration),:)))
        chosenPointCost = costofallsample(Nearby(Col(currentIteration),:));
        Solution = Nearby(Col(currentIteration),:);
    end
    Cost = [Cost,costofallsample(Dad(1,:))];
end

toc

chosenPoint = find(Solution(1, :)) - 20   
chosenPointCost
figure;                                                           
plot(1:Iteration,Cost);
title('Relationship between Times And Cost');
xlabel('Times of Iteration');
ylabel('Cost');
axis([1 100 300 900])