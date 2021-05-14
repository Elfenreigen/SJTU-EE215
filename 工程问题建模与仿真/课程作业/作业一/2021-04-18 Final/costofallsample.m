function costofallsample = costofallsample(Input)

global Content;
x = [];
y = [];

for count = -20 : 69
    if(Input(count+21) == 1)
        x = [x, count];
    end
end

Long = size(Content, 1);

costofallsample = 0;

for count = 1 : (Long/2)
    y = [];
    for j = -20 : 69
        if(Input(j+21) == 1)
            y = [y, Content(count*2,j+21)];
        end
    end
    
    yNihe = Content(count*2,:);
    x;
    xNihe = interp1(y,x,yNihe,'spline');
    
    for j = 1 : size(yNihe,2)
        if(abs(Content(count*2-1,j)-xNihe(j))<=0.5)
        elseif(abs(Content(count*2-1,j)-xNihe(j))<=1)
            costofallsample = costofallsample + 1;
        elseif(abs(Content(count*2-1,j)-xNihe(j))<=1.5)
            costofallsample = costofallsample + 6;
        elseif(abs(Content(count*2-1,j)-xNihe(j))<=2)
            costofallsample = costofallsample + 20;
        else
            costofallsample = costofallsample + 10000;
        end
    end
end

costofallsample = costofallsample/(Long/2) + size(x,2) * 50;      

end

