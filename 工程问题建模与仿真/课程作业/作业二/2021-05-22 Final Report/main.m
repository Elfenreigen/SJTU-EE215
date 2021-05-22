function main()
for n = 5 : 20
    Val = 0;
    ExpectLife = zeros(100000,1);
    for i = 1 : 100000
        [ Life , Cons ] = Record(n);
        ExpectLife(i) = System( n , Life , Cons );
        if ExpectLife(i) >= 25000
            Val = Val + 1;
        end
    end
    
    ExpectLife = mean(ExpectLife);
    Reliablity = Val / 100000;
    fprintf('When the number of node is %d£¬MTTF is %5.2f£¬reliability is %5.4f\n',n , ExpectLife , Reliablity);
end
end


function [ LA , CA ] = SwitchA(  )
LA = exprnd(37000);
if LA < 90000
    thereshold = rand;
    if thereshold <= 0.26
        CA = 1;
    elseif thereshold <= 0.52
        CA = 2;
    else
        CA = 3;
    end
else
    LA = 90000;
    CA = 0;
end
end


function [ LB , CB ] = SwitchB(  )
LB = exprnd(480000);
if LB < 90000
    thereshold = rand;
    if thereshold <= 0.35
        CB = 1;
    else
        CB = 2;
    end
else
    LB = 90000;
    CB = 0;
end
end

function [ Life , Cons ] = Record( n )
Life = zeros(n,2);
Cons = zeros(n,2);
for i = 1 : n
    [Life(i,1),Cons(i,1)] = SwitchA();
    [Life(i,2),Cons(i,2)] = SwitchB();
end

end

function [ Con ] = Node( CA , CB )
if CA==0
    if CB==0
        Con=0;
    elseif CB==1
        Con=3;
    else
        Con=1;
    end
elseif CA==1
    if CB==0
        Con=1;
    elseif CB==1
        Con=5;
    else
        Con=1;
    end
elseif CA==2
    if CB==0
        Con=2;
    elseif CB==1
        Con=3;
    else
        Con=4;
    end
else
    Con=4;
end
end


function [ ExpectLife ] = System( n , Life , Cons )
ExpectLife = 0;
ConSys = 2;
AllNodes = zeros(n,1);

while ConSys ==2 || ConSys == 3
    if sum (Life(:) == +inf) == 2 * n
        ExpectLife = 90000;
        break;
    end
    
    minimum = min(min(Life));
    [x,y] = find(Life == minimum);
     if y == 1
        ConA = Cons(x,y);
        if Life(x,2) == +inf
            ConB = Cons(x,2);
        else
            ConB = 0;
        end
    else
        ConB = Cons(x,y);
        if Life(x,1) == +inf
            ConA = Cons(x,1);
        else
            ConA = 0;
        end
    end

    Life(x,y) = +inf;
    AllNodes(x) = Node(ConA,ConB);
    
    Q0 = sum(AllNodes(:)==0);
    Q1 = sum(AllNodes(:)==1);
    Q2 = sum(AllNodes(:)==2);
    Q3 = sum(AllNodes(:)==3);
    Q4 = sum(AllNodes(:)==4);
    Q5 = sum(AllNodes(:)==5);
    C1 = (Q5 >= 1);
    C2 = (Q3 >= 2);
    C3 = (Q0 + Q3 + Q2 == 0);
    C4 = ((Q0 + Q1 +((Q3 + Q2) > 0)) < 5);
    C5 = (Q5 == 0);
    C6 = (Q3 == 1 && Q0 + Q1 >= 4);
    C71 = (Q3 == 0 && Q0 >= 1 && Q0 + Q1 >= 5);
    C72 = (Q3 == 0 && Q0 == 0 && Q1 >= 4 && Q2 >= 1);
    C7 = (C71 || C72);
    C8 = (Q5 + Q3 == 0);
    C9 = (Q0 >= 1 && Q0 + Q1 == 4 && Q2 >= 1);
    
    if C1 || C2 || C3 || C4
        ConSys = 1;
        
    elseif C5 && (C6 || C7)
        ConSys = 2;
        
    elseif C8 && C9
        P = Q2 / (Q2 + Q0);
        
        if rand <= P
            ConSys = 3;
        else
            ConSys = 4;
        end
    end
    
    if ConSys == 1 || ConSys == 4
        ExpectLife = minimum;
    end
end
end